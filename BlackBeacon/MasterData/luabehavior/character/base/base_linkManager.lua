local debugConfig = import("common.debug_config")
local linkMgr = {}
linkMgr.__index = linkMgr
local STAGE = Const.LINK_STAGE
local CHILD_STAGE = Const.LINK_CHILD_STAGE
local TIMER_ACTION = Const.LINK_TIMER_ACTION

function linkMgr.setUp(linkMgr)
  local linkMgr = linkMgr
  linkMgr.tool = ComnMgr.RoleTool
  linkMgr.rampMgr = ComnMgr.RampMgr
  linkMgr.debugSwitch = ComnMgr.DebugConfig.role
  linkMgr.STAGE = STAGE
  linkMgr.CHILD_STAGE = CHILD_STAGE
  linkMgr.TIMER_ACTION = TIMER_ACTION
  linkMgr.godNpc = nil
  linkMgr.chance = nil
  linkMgr.smallChance = ComnMgr.LinkChanceSmall
  linkMgr.bigChance = ComnMgr.LinkChanceBig
  linkMgr.energyId = Const.ATTR_TYPE.COMBINE_ENERGY
  linkMgr.maxEnergyId = Const.ATTR_TYPE.COMBINE_ENERGY_MAX
  linkMgr.frontQteBtn = "Btn_skill2"
  linkMgr.backQteUx = "Fx_UI_Lianxie_Qte"
  linkMgr.qteUiStates = {}
  linkMgr.is_front_qte_enable = nil
  linkMgr.isFxOn = false
  linkMgr.isEffectOn = false
  linkMgr.threshold = {
    [1] = get_common_value("LinkStageEnergy"),
    [2] = 0.99999,
    [3] = math.huge
  }
  linkMgr.clear159 = Const.ATTR.CLEAR159
  linkMgr.fill159 = Const.ATTR.FILL159
  linkMgr.stage = STAGE.ONE
  linkMgr.childStage = CHILD_STAGE.CHARGINE
  linkMgr.energyStage = -1
  do
    local LINK_CONFIG = Const.LINK_CONFIG
    linkMgr.chargeFullSound = LINK_CONFIG.CHARGE_FULL_SOUND
    linkMgr.slomo = LINK_CONFIG.SLOMO
    linkMgr.slomoFx = LINK_CONFIG.SLOMO_FX
    linkMgr.custom_trigger_setting = nil
  end
end

function linkMgr.updateGod(mgr)
  local npc = get_god_npc()
  if npc == mgr.godNpc then
    return
  end
  mgr.godNpc = npc
  mgr:updateEnergyStage()
  return listen_attr_change_mq(npc, linkMgr.energyId, mgr.on_god_energy_change, mgr)
end

function linkMgr.on_npc_born(mgr, npc)
  if npc == get_god_npc() then
    return mgr:updateGod()
  end
end

function linkMgr.updateEnergyStage(mgr)
  local godNpc = mgr.godNpc
  if not godNpc then
    return
  end
  local perct = get_npc_attr(godNpc, mgr.energyId) / get_npc_attr(godNpc, mgr.maxEnergyId)
  local newStage = mgr:energyToStage(perct)
  local oldStage = mgr.energyStage
  if newStage ~= oldStage then
    mgr.energyStage = newStage
    mgr:on_energy_stage_change(newStage, oldStage)
    return true
  end
end

function linkMgr.on_god_energy_change(mgr)
  return mgr:updateEnergyStage()
end

function linkMgr.energyToStage(mgr, perct)
  local list = mgr.threshold
  for stage, threshold in ipairs(list) do
    if perct <= threshold then
      return stage - 1
    end
  end
end

linkMgr.do_energy_stage_change = {
  [0] = function(mgr, newStage, oldStage)
    return mgr:setStage(mgr.STAGE.ONE, mgr.CHILD_STAGE.CHARGINE)
  end,
  [1] = function(mgr, newStage, oldStage)
    return mgr:setStage(mgr.STAGE.ONE, mgr.CHILD_STAGE.FULL)
  end,
  [2] = function(mgr, newStage, oldStage)
    local STAGE, CHILD_STAGE = mgr.STAGE, mgr.CHILD_STAGE
    if mgr.stage == STAGE.ONE and mgr:isBurst() then
      return
    end
    return mgr:setStage(mgr.STAGE.TWO, mgr.CHILD_STAGE.FULL)
  end
}

function linkMgr.on_energy_stage_change(mgr, newStage, oldStage)
  mgr.energyStage = newStage
  return mgr.do_energy_stage_change[newStage](mgr, newStage, oldStage)
end

linkMgr.do_set_stage = {
  [STAGE.ONE] = function(mgr, stage, childStage)
    mgr:setChance(mgr.smallChance)
    return mgr.do_set_child_stage[stage][childStage](mgr)
  end,
  [STAGE.TWO] = function(mgr, stage, childStage)
    mgr:setChance(mgr.bigChance)
    return mgr.do_set_child_stage[stage][childStage](mgr)
  end
}

function linkMgr.setChance(mgr, newChance)
  local oldChance = mgr.chance
  if oldChance == newChance then
    return
  end
  if oldChance then
    oldChance:disable()
  end
  if not newChance then
    Util.debugOutput("linkMgr.setChance is called without a new chance")
  else
    newChance:enable()
  end
  mgr.chance = newChance
end

linkMgr.do_set_child_stage = {
  [STAGE.ONE] = {
    [CHILD_STAGE.CHARGINE] = function(mgr)
      mgr:hideLinkTimer()
    end,
    [CHILD_STAGE.FULL] = function(mgr)
      mgr:enableQte()
      mgr:hideLinkTimer()
    end,
    [CHILD_STAGE.BURST] = function(mgr)
      mgr:showLinkTimer()
      mgr:initLinkTimer()
    end
  },
  [STAGE.TWO] = {
    [CHILD_STAGE.CHARGINE] = function(mgr)
      mgr:hideLinkTimer()
    end,
    [CHILD_STAGE.FULL] = function(mgr)
      mgr:enableQte()
      mgr:hideLinkTimer()
    end,
    [CHILD_STAGE.BURST] = function(mgr)
      mgr:showLinkTimer()
      mgr:initLinkTimer()
    end
  }
}

function linkMgr.setStage(mgr, stage, childStage)
  local isSame = true
  stage = stage or mgr.stage
  if stage ~= mgr.stage then
    isSame = false
  end
  local STAGE = mgr.STAGE
  stage = math.max(stage, STAGE.ONE)
  stage = math.min(stage, STAGE.TWO)
  mgr.stage = stage
  childStage = childStage or mgr.childStage
  if childStage ~= mgr.childStage then
    isSame = false
  end
  mgr.childStage = childStage
  local _childStage = childStage
  if _childStage == mgr.CHILD_STAGE.FULL then
    _childStage = mgr.CHILD_STAGE.BURST
  end
  if not isSame and childStage == mgr.CHILD_STAGE.FULL then
    local hero = get_come_on_hero()
    cast_magic(hero, hero, mgr.chargeFullSound)
  end
  set_skill_link_ui_state(stage, _childStage)
  mgr.do_set_stage[stage](mgr, stage, childStage)
  return mgr:updateQteUi()
end

function linkMgr.enableQte(mgr)
  return mgr.chance:enableQte()
end

function linkMgr.enableQteUi(mgr, role)
  local states = mgr.qteUiStates
  if role then
    states[role.npc] = true
  else
    local team = mgr.tool.team.npc
    for _, npc in pairs(team) do
      states[npc] = true
    end
  end
end

function linkMgr.disableQteUi(mgr, role)
  local states = mgr.qteUiStates
  if role then
    states[role.npc] = false
  else
    for npc, _ in pairs(states) do
      states[npc] = false
    end
  end
end

function linkMgr.updateQteUi(mgr)
  local tool = mgr.tool
  local states = mgr.qteUiStates
  local backQteUx = mgr.backQteUx
  for npc, hasQte in pairs(states) do
    set_qte_effect_active(npc, backQteUx, hasQte, 0)
  end
  local enableFront = states[get_come_on_hero()]
  if enableFront ~= mgr.is_front_qte_enable then
    if nil == enableFront then
      enableFront = false
    end
    mgr.is_front_qte_enable = enableFront
    tool:set_ui_visible(mgr.frontQteBtn, enableFront)
  end
end

function linkMgr.addRole(mgr, role)
  local states = mgr.qteUiStates
  states[role.npc] = false
  if not mgr:hasLinkQte() then
    return
  end
  mgr:enableQteUi(role)
  return mgr:updateQteUi()
end

function linkMgr.removeRole(mgr, role)
  local states = mgr.qteUiStates
  states[role.npc] = nil
  if role:isInControl() then
    return mgr:updateQteUi()
  end
end

function linkMgr.isQteReady(linkMgr, linkQte, event)
  if not linkMgr:check_qte_by_switch(event) then
    return false
  end
  if not linkMgr.chance:isReady(linkQte) then
    return false
  end
  return true
end

function linkMgr.check_qte_by_switch(linkMgr, event)
  if not event or not event.isSwitch then
    return true
  end
  return linkMgr.do_check_qte_by_switch[linkMgr:getTriggerSetting()](linkMgr)
end

function linkMgr.getTriggerSetting(linkMgr)
  return linkMgr.custom_trigger_setting or get_auto_trigger_qte_on_role_out()
end

function linkMgr.setTriggerOption(linkMgr, option)
  linkMgr.custom_trigger_setting = option
end

function linkMgr.clearTriggerOption(linkMgr)
  linkMgr.custom_trigger_setting = nil
end

do
  local options = Const.SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT
  linkMgr.do_check_qte_by_switch = {
    [options.OFF] = Const.FALSE_FUN,
    [options.ON] = Const.TURE_FUN,
    [options.ONLY_LINK] = function(linkMgr)
      return linkMgr:isBurst()
    end
  }
end

function linkMgr.onQteBegin(mgr, linkQte, event)
  local chance = mgr.chance
  if not chance:isReady(linkQte) then
    return
  else
    chance:consumeQte(linkQte)
  end
  if not event then
    Util.debug_output("linkMgr.onQteBegin: event is lost ,linkQte is " .. tostring(linkQte and linkQte.name))
  elseif event.isSwitch then
    local npc = get_come_on_hero()
    cast_magic(npc, npc, mgr.slomo)
    cast_magic(npc, npc, mgr.slomoFx)
  else
    play_front_qte_btn_effect()
  end
  mgr:pauseLinkTimer()
end

function linkMgr.try_link_fx_by_magic(tryQteLink, caster, target)
  local role = tryQteLink.role
  if role.npc ~= caster then
    return
  end
  if not role:isInControl() then
    return
  end
  local roleAct = role.skAct
  if not roleAct or not roleAct:isLinkQte() then
    return
  end
  local mgr = role.linkMgr
  return mgr:tryFx(roleAct)
end

function linkMgr.onQteCastTime(mgr)
  return mgr:tryTimers()
end

function linkMgr.onQteBreak(mgr, linkQte, tarAct)
  if tarAct == linkQte then
    return
  end
  return mgr:tryFx(linkQte, tarAct and (tarAct:isLinkQte() or tarAct:isUlt()))
end

function linkMgr.onQteEnd(mgr, linkQte)
  return mgr:tryFx(linkQte)
end

function linkMgr.try_link_fx_by_switch(mgr, linkQte)
  return mgr:tryFx(linkQte)
end

function linkMgr.tryEffect(mgr, linkQte)
  if not mgr:isBurst() then
    return
  end
  if mgr.isEffectOn then
    return
  end
  mgr.isEffectOn = true
  return mgr.rampMgr:tryEffect(linkQte)
end

function linkMgr.tryFx(mgr, linkQte, ignoreTimers)
  if not mgr.isEffectOn then
    return
  end
  if not mgr:isBurst() then
    return
  end
  return mgr:startFx(linkQte, ignoreTimers)
end

function linkMgr.startFx(mgr, linkQte, ignoreTimers)
  mgr.isFxOn = true
  mgr.rampMgr:tryFx(mgr.stage, linkQte)
  if not ignoreTimers then
    return mgr:tryTimers()
  end
end

function linkMgr.pauseLinkTimer(mgr)
  return set_link_timer_type(mgr.TIMER_ACTION.PAUSE)
end

function linkMgr.tryTimers(mgr)
  if not mgr.isFxOn then
    return
  end
  if not mgr:isBurst() then
    return
  end
  mgr.tool:tryLevelTimer()
  return mgr:tryLinkTimer()
end

function linkMgr.tryLinkTimer(mgr)
  local roleAct = mgr.tool.curRole.skAct
  local needStop = false
  if roleAct then
    _, needStop = roleAct:needStopTimer()
  end
  if not needStop then
    return mgr:startLinkTimer()
  end
end

function linkMgr.startLinkTimer(mgr)
  return set_link_timer_type(mgr.TIMER_ACTION.PLAY)
end

function linkMgr.hideLinkTimer(mgr)
  local ACTION = mgr.TIMER_ACTION
  set_link_timer_type(ACTION.CLEAR)
  return set_link_timer_type(ACTION.HIDE)
end

function linkMgr.showLinkTimer(mgr)
  local ACTION = mgr.TIMER_ACTION
  set_link_timer_type(ACTION.SHOW)
  return set_link_timer_type(ACTION.CLEAR)
end

function linkMgr.initLinkTimer(mgr)
  return set_link_timer_type(mgr.TIMER_ACTION.RESTART)
end

linkMgr.do_finish_link = {
  [STAGE.ONE] = function(mgr)
    local stage = mgr.STAGE.TWO
    local childStage = mgr.CHILD_STAGE.CHARGINE
    if 2 == mgr.energyStage then
      childStage = mgr.CHILD_STAGE.FULL
    elseif 0 == mgr.energyStage then
      stage = mgr.STAGE.ONE
    end
    mgr:setStage(stage, childStage)
  end,
  [STAGE.TWO] = function(mgr)
    local godNpc = mgr.godNpc
    cast_magic(godNpc, godNpc, mgr.clear159)
  end
}

function linkMgr.finishLink(mgr)
  local CHILD_STAGE = mgr.CHILD_STAGE
  if not mgr:isBurst() then
    return
  end
  mgr.isFxOn = false
  mgr.isEffectOn = false
  local oldStage = mgr.stage
  local debugLv = mgr.debugSwitch.forceLinkQte
  if debugLv then
    mgr.energyStage = -1
    mgr.chance = nil
    mgr:resetEnergy(debugLv)
    mgr:updateEnergyStage()
    local childStage = CHILD_STAGE.FULL
    if 0 == debugLv then
      childStage = CHILD_STAGE.CHARGINE
    end
    mgr:setStage(debugLv, childStage)
  else
    mgr.do_finish_link[oldStage](mgr)
  end
  return mgr.rampMgr:finishRamp(oldStage)
end

function linkMgr.reset(mgr)
  NextFrameMgr:add_next_update(mgr.doReset, mgr)
end

function linkMgr.doReset(mgr)
  mgr.chance = nil
  mgr.is_front_qte_enable = nil
  mgr.isFxOn = false
  mgr.isEffectOn = false
  mgr:updateGod()
  local oldStage = mgr.stage
  mgr:resetEnergy()
  if not mgr:updateEnergyStage() then
    mgr:setStage()
  end
  return mgr.rampMgr:finishRamp(oldStage)
end

function linkMgr.resetEnergy(mgr, debugLv)
  local debugLv = debugLv or mgr.debugSwitch.forceLinkQte
  if not debugLv then
    return
  end
  local godNpc = mgr.godNpc
  if not godNpc then
    return
  end
  local magic = 0 == debugLv and mgr.clear159 or mgr.fill159
  return cast_magic(godNpc, godNpc, magic, debugLv)
end

function linkMgr.getLinkStage(mgr)
  return mgr.stage, mgr.childStage
end

function linkMgr.getEnergyStage(mgr)
  return mgr.energyStage
end

function linkMgr.isBurst(mgr)
  return mgr.childStage == mgr.CHILD_STAGE.BURST
end

function linkMgr.isBigBurst(mgr)
  return mgr.stage == mgr.STAGE.TWO and mgr:isBurst()
end

function linkMgr.hasLinkQte(mgr)
  local chance = mgr.chance
  return chance and chance:hasLinkQte()
end

function linkMgr.initUi(mgr)
  mgr.is_front_qte_enable = nil
  if mgr:isBurst() then
    mgr:finishLink()
  else
    mgr:setStage()
  end
end

function linkMgr.on_destroy_mamager()
  linkMgr.tool = nil
  linkMgr.rampMgr = nil
  linkMgr.debugSwitch = nil
  linkMgr.godNpc = nil
end

return linkMgr
