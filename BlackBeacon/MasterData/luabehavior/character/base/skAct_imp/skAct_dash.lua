local skActBase = import("character.base.base_role_skillAction")
local dashBase = Util.create_child_mt(skActBase)
dashBase._dashBase = dashBase
dashBase.dashBase = dashBase
dashBase.magics = Const.DEFEND.DASH
dashBase.intervalThreshold = get_common_value("DashIntervalThreshold")
dashBase.cast_time_delta_threshold = 0.05
dashBase.standard_cast_time = 0.3
dashBase.pDash_toBack_delay = 0.3

function dashBase.setClass(customDashBase, actBases)
  local ret = customDashBase or dashBase
  local newParent = actBases.common
  if newParent ~= skActBase and ret == dashBase then
    ret = {}
  end
  if ret ~= dashBase then
    if getmetatable(ret) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    ret.__index = ret.__index or ret
    ret.dashBase = ret.dashBase or ret
    ret.magics = UtilTable.fill_table(dashBase.magics, ret.magics)
    UtilTable.fill_table(dashBase, ret, true)
    setmetatable(ret, newParent)
  end
  return ret
end

function dashBase.new(customDashBase, role, _cfg)
  local dash = setmetatable({}, customDashBase)
  dash.base = customDashBase
  customDashBase:_init(dash, role, _cfg)
  return dash
end

function dashBase._init(customDashBase, dash, role, _cfg)
  dash.dashBase = customDashBase
  customDashBase.skActBase:_init(dash, role, _cfg)
  dash.pDash_atk_mis = {}
  dash.ipStartTime = 0
  dash:clearPdashInfo()
  local cfg = _cfg or {}
  local trans = dash.trans
  trans.prio = cfg.TransPrio or 4
  trans.inertia = cfg.TransInertia or 4
  dash.magics = UtilTable.fill_table(customDashBase.magics)
end

function dashBase.isCommon()
end

function dashBase.isDash()
  return true
end

function dashBase.check(dash)
  if not dash.skActBase.check(dash) then
    return false
  end
  local role = dash.role
  local motionCfgs = role._motionCfgs
  local standard_cast_time = dash.dashBase.standard_cast_time
  local delta_threshold = dash.dashBase.cast_time_delta_threshold
  local isEmptyTab = UtilTable.is_empty
  local animMotion, animName
  for _, skill in pairs(dash.strSks) do
    if skill.afterTime > 0.01 and delta_threshold < math.abs(skill.befTime + skill.castTime - standard_cast_time) then
      role:debugOutputB("闪避技能castTime与标准值%0.1fs相差超过%0.2fs, act name is %s, skill name is %s, skill id is %s, skill castTime is %0.3f", standard_cast_time, delta_threshold, dash.name, skill.name, skill.id, skill.castTime)
      return false
    end
    animName = skill.animName
    for _, motionCfg in pairs(motionCfgs) do
      animMotion = motionCfg[animName]
      if animMotion and not isEmptyTab(animMotion.OffsetX) then
        role:debugOutputB("闪避技能携带x方向动画位移, act name is %s, skill name is %s, skill id is %s, anim name is %s", dash.name, skill.name, skill.id, skill.animName)
        return false
      end
    end
  end
  return true
end

function dashBase.onBegin(dash)
  local role = dash.role
  local roleNpc = role.npc
  local curTime = get_npc_time(roleNpc)
  if curTime < role.dash_enable_cd_timer then
    role:addMagic(dash.magics.COMMON.CD)
  else
    role.dash_enable_cd_timer = curTime + dash.intervalThreshold
  end
  dash:clearPdashInfo()
  dash:startDodge()
  dash.skActBase.onBegin(dash)
end

function dashBase.transCheck(dash, tarAct)
  if dash.bInputProtect then
    return false
  end
  if dash.bPerfect and not dash.bInputProtect then
    if dash.trans.disable[tarAct.name] then
      return false
    else
      return true
    end
  end
  return dash.skActBase.transCheck(dash, tarAct)
end

function dashBase.onCastTime(dash, retainCache, ignoreIcon)
  local popAct = dash.skActBase.onCastTime(dash, retainCache, ignoreIcon)
  if not popAct then
    dash:tryFixedCounterWin()
  end
  return dash:tryFinCommonDodge(popAct)
end

function dashBase.onBreak(dash, nextAct)
  dash:finCommonDash(nextAct)
  dash:finPdash(nextAct)
  dash.skActBase.onBreak(dash, nextAct)
end

function dashBase.onEnd(dash)
  dash:finCommonDash()
  dash:finPdash()
  dash.skActBase.onEnd(dash)
end

function dashBase.canStay(dash)
  if dash.isPerfect then
    if dash.bInputProtect then
      return true
    else
      return false, true
    end
  else
    return dash.skActBase.canStay(dash)
  end
end

function dashBase.startDodge(dash)
  dash.role:addMagic(dash.magics.COMMON.INVUL)
  dash.bDodge = true
end

function dashBase.onCollideMis(dash, atkMis)
  if not dash.bDodge then
    return
  end
  if not dash.role:isInControl() then
    return
  end
  if atkMis then
    local misList = dash.pDash_atk_mis
    local uuid = atkMis.id
    if misList[uuid] then
      return
    else
      misList[uuid] = atkMis
    end
  end
  return dash:tryPdash(atkMis)
end

function dashBase.tryPdash(dash, atkMis)
  if not dash.bDodge then
    return
  end
  if not dash.role:isInControl() then
    return
  end
  if not dash.pDashTriggerMis then
    dash.pDashTriggerMis = atkMis
  end
  if not dash.bPerfect then
    dash.bPerfect = true
  end
  if not dash.fxFrame_has_passed then
    dash:tryIp()
    return dash:tryExtraCounterWin()
  elseif not dash.bPdashStarted then
    return dash:startPdash(atkMis)
  end
end

function dashBase.tryFinCommonDodge(dash, nextAct)
  if not dash.bDodge then
    return
  end
  if dash.bPerfect then
    return
  end
  if nextAct and nextAct:isDash() then
    if nextAct ~= dash then
      dash.bDodge = false
    end
    return
  end
  return dash:finishDodge()
end

function dashBase.finCommonDash(dash, nextAct)
  return dash:tryFinCommonDodge(nextAct)
end

function dashBase.onCdMagicBegin(cd, caster)
  local role = cd.unit
  if role.npc ~= caster then
    return
  end
  set_btn_charging_type(cd.dashOut.id, 2, true, 1.5)
end

function dashBase.onCdMagicEnd(cd, caster)
  local role = cd.unit
  if role.npc ~= caster then
    return
  end
  set_btn_charging_type(cd.dashOut.id, 2, false)
end

function dashBase.onTryMagicBegin(tryPdash, caster)
  local role = tryPdash.unit
  if role.npc ~= caster then
    return
  end
  local dash = role.skAct
  if not dash:isDash() then
    role:debugOutput("闪避特效启动magic在闪避动作之外被调用，当前动作为" .. dash.name)
  end
  dash.fxFrame_has_passed = true
  if dash.bPerfect then
    return dash:tryPdash(dash.pDashTriggerMis)
  end
end

function dashBase.clearPdashInfo(dash)
  local dash = dash
  dash.bDodge = false
  dash.bPerfect = false
  dash.fxFrame_has_passed = false
  dash.bPdashStarted = false
  dash.bInputProtect = false
  dash.bMoveIp = false
  dash.bCanCounter = false
  dash.pDashTriggerMis = nil
  UtilTable.clear_map(dash.pDash_atk_mis)
end

function dashBase.tryIp(dash, startTimer)
  if not dash.bPerfect then
    return
  end
  if not startTimer and dash.bInputProtect then
    return
  end
  return dash:startIp(startTimer)
end

function dashBase.tryExtraCounterWin(dash, startTimer)
  if not dash.bPerfect then
    return
  end
  if not startTimer and dash.bCanCounter then
    return
  end
  return dash:startExtraCounterWin(startTimer)
end

function dashBase.startPdash(dash, atkMis)
  if not dash.bPerfect then
    return
  end
  local role = dash.role
  dash.bPdashStarted = true
  dash:pDashFx()
  dash:startSlomo()
  dash:startIp(true)
  dash:startExtraCounterWin(true)
  dash:startPinvul()
  local counterSound = role.magics.counterSound
  if counterSound then
    cast_magic(role.npc, role.npc, counterSound.id)
  else
    role:debugOutput(" 完美闪避语音丢失，请检查单位表初始属性配置")
  end
  local notify = role.onPdashSlomo
  if notify then
    notify(role, dash, atkMis)
  end
end

function dashBase.pDashFx(dash)
  return dash.role:addMagic(dash.magics.PERFECT.FX)
end

function dashBase.startSlomo(dash)
  dash.bSlomo = true
  local role = dash.role
  local magics = dash.magics.PERFECT
  role:addMagic(magics.SLOMO_SELF)
  role:addMagic(magics.SLOMO_OTHERS)
end

function dashBase.startIp(dash, startTimer)
  dash.bInputProtect = true
  dash.bMoveIp = true
  dash.ipStartTime = Global.time
  local role = dash.role
  dash.inputor:setIPtype(Const.INPUT_PROTECT_TYPE.BLOCK_OUTPUT, true)
  role:enable_move_ip()
  role:set_switch_hero_enable(false)
  if startTimer then
    local magics = dash.magics.PERFECT
    role:addMagic(magics.INPUT_PROTECT_MOVE)
    role:addMagic(magics.INPUT_PROTECT)
  end
end

function dashBase.startExtraCounterWin(dash, startTimer)
  dash.bCanCounter = true
  if startTimer then
    return dash.role:addMagic(dash.magics.PERFECT.EXTRA_COUNTER_WINDOW)
  end
end

function dashBase.startPinvul(dash)
  return dash.tool:castMagicToTeam(dash.magics.PERFECT.INVUL, nil, dash.role.npc)
end

function dashBase.tryFixedCounterWin(dash)
  if not dash.bPerfect then
    return
  end
  dash.bCanCounter = true
  return dash.role:addMagic(dash.magics.PERFECT.FIXED_COUNTER_WINDOW)
end

function dashBase.finPdash(dash, nextAct)
  if not dash.bPerfect then
    return
  end
  dash:tryFinPdodge()
  dash:tryFinCounterWin(true)
  dash:tryFinIp()
  dash:tryFinMoveIp()
  dash:finPfx(nextAct)
  dash:finSlomoSelf()
  dash:tryFinSlomoOther()
end

function dashBase.tryFinPdodge(dash)
  if not dash.bPerfect then
    return
  end
  if not dash.bDodge then
    return
  end
  return dash:finishDodge()
end

function dashBase.finPfx(dash, nextAct)
  if not nextAct or not nextAct.bIsWander then
    return dash.role:abortMagic(dash.magics.PERFECT.FX)
  end
end

function dashBase.finSlomoSelf(dash)
  return dash.role:abortMagic(dash.magics.PERFECT.SLOMO_SELF)
end

function dashBase.finishDodge(dash, nextAct)
  dash.role:abortMagic(dash.magics.COMMON.INVUL)
  dash.bDodge = false
  return dash:tryConsumeMisCd()
end

function dashBase.tryFinSlomoOther(dash, nextAct)
  if not dash.bSlomo then
    return
  end
  dash.bSlomo = false
  dash.role:abortMagic(dash.magics.PERFECT.SLOMO_OTHERS)
end

function dashBase.tryFinIp(dash, nextAct)
  if not dash.bInputProtect then
    return
  end
  dash.bInputProtect = false
  dash.inputor:setIPtype()
  dash:tryPop(Const.INPUTOR_POP_TYPE.TRY, nil, math.min(0.5, Global.time - dash.ipStartTime))
  dash.role:set_switch_hero_enable(true)
end

function dashBase.tryFinMoveIp(dash, nextAct)
  if not dash.bMoveIp then
    return
  end
  dash.bMoveIp = false
  return dash.role:disable_move_ip()
end

function dashBase.tryConsumeMisCd(dash)
  if not dash.bPerfect then
    return
  end
  local misList = dash.pDash_atk_mis
  local consume = add_missile_atk_cd
  local team = dash.tool.team.npc
  for uuid, missile in pairs(misList) do
    for _, npc in pairs(team) do
      if not is_judg_missile(missile) then
        consume(missile, npc)
      end
    end
    misList[uuid] = nil
  end
end

function dashBase.tryFinCounterWin(dash, abortMagic)
  if not dash.bCanCounter then
    return
  end
  if not abortMagic then
    local role = dash.role
    local magics = dash.magics.PERFECT
    if role:checkMagic(magics.FIXED_COUNTER_WINDOW) then
      return
    end
    if role:checkMagic(magics.EXTRA_COUNTER_WINDOW) then
      return
    end
  end
  return dash:finCounterWin()
end

function dashBase.finCounterWin(dash)
  dash.bCanCounter = false
  local magics = dash.magics.PERFECT
  local role = dash.role
  role:abortMagic(magics.FIXED_COUNTER_WINDOW)
  role:abortMagic(magics.EXTRA_COUNTER_WINDOW)
end

function dashBase.onSlomoMagicEnd(slomoOther, caster)
  local role = slomoOther.unit
  if caster ~= role.npc then
    return
  end
  local dash = role.skAct
  if dash and dash:isDash() then
    return dash:tryFinSlomoOther()
  end
end

function dashBase.onIpMagicEnd(inputProtect, caster)
  local role = inputProtect.unit
  if caster ~= role.npc then
    return
  end
  local dash = role.skAct
  if dash and dash:isDash() then
    return dash:tryFinIp()
  end
end

function dashBase.onMoveIpMagicEnd(moveIp, caster)
  local role = moveIp.unit
  if caster ~= role.npc then
    return
  end
  local dash = role.skAct
  if dash and dash:isDash() then
    return dash:tryFinMoveIp()
  end
end

function dashBase.onFixCoutWinEnd(inputProtect, caster)
  local role = inputProtect.unit
  if caster ~= role.npc then
    return
  end
  local dash = role.skAct
  if dash and dash:isDash() then
    return dash:tryFinCounterWin()
  end
end

function dashBase.onExCoutWinEnd(inputProtect, caster)
  local role = inputProtect.unit
  if caster ~= role.npc then
    return
  end
  local dash = role.skAct
  if dash and dash:isDash() then
    return dash:tryFinCounterWin()
  end
end

function dashBase.isPerfect(dash)
  return dash.bPerfect
end

function dashBase.isPdashSlomo(dash)
  return dash.bSlomo
end

function dashBase.canCounter(dash)
  return dash.bCanCounter
end

function dashBase.canPop(dash)
  return not dash.bInputProtect
end

function dashBase.clearCd(customDashBase, role)
  role:abortMagic(customDashBase.magics.COMMON.CD)
  role.dash_enable_cd_timer = role:now()
  local btn = role.btns.dash
  local icon = btn.icon
  if icon then
    icon:updateEnable()
  end
  return btn:drawEnable()
end

return dashBase
