local skActBase = {}
skActBase.__index = skActBase
skActBase._skActBase = skActBase
skActBase.skActBase = skActBase
local SKACT_EVT_TYPE = Const.SKACT_EVT_TYPE
local BUTTON_TYPE = Const.BUTTON_TYPE
local vec3 = require("base.vec3")
local searchBase = import("base.role.searchSystem.searchCfg")
local VAR_TYPE = Const.VAR_TYPE

function skActBase.setClass(customSkActBase, newBases)
  if not customSkActBase then
    return skActBase
  end
  if customSkActBase ~= skActBase then
    if getmetatable(customSkActBase) then
      Util.debug_output("自定义技能基类不能携带元表")
    end
    customSkActBase.__index = customSkActBase.__index or customSkActBase
    customSkActBase.skActBase = customSkActBase.skActBase or customSkActBase
    UtilTable.fill_table(skActBase, customSkActBase, true)
  end
  return customSkActBase
end

function skActBase.new(customSkActBase, role, _cfg)
  local act = setmetatable({}, customSkActBase)
  act.base = customSkActBase
  act.type = Const.SKILL_ACTION_TYPE.COMMON
  customSkActBase:_init(act, role, _cfg)
  return act
end

function skActBase._init(customSkActBase, act, role, _cfg)
  local act = act
  act.skActBase = customSkActBase
  act.role = role
  act.debugSwitch = role.debugSwitch
  act.tool = role.tool
  act.inputor = role.inputor
  act.linkMgr = role.linkMgr
  act.qteMgr = role.qteMgr
  act.indiMgr = role.indiMgr
  act.hitId = 0
  act.castId = 0
  act.info = {skAct = act}
  do
    local cfg = _cfg or {}
    act.cfg = cfg
    act.name = cfg.SkActName
    act.id = cfg.Id
    local strSks = {}
    if cfg.StrSkills then
      local skills = role.skills
      for i, skName in ipairs(cfg.StrSkills) do
        strSks[i] = skills[skName]
      end
    end
    act.strSks = strSks
    act.search = searchBase:new(_cfg, "skActs." .. tostring(cfg.SkActName))
    act.trans = {
      prio = cfg.TransPrio or 1,
      inertia = cfg.TransInertia or 1,
      enable = {},
      disable = {}
    }
    act.startDist = cfg.IdealStartDist
  end
  act.atkTarget = nil
  act.isBefOver = false
  act.isCastOver = false
  act.castOverTime = 0
  act.isOver = false
  act._tarPos = vec3:New()
  act.skillCount = 0
end

function skActBase.check(act)
  local cfg = act.cfg.StrSkills
  cfg = cfg and #cfg or 0
  local validNum = #act.strSks
  if validNum ~= cfg then
    act.role:debugOutputB("%s动作缺失，配置动作%d个，实际初始化动作%d个，", act.name, cfg, validNum)
    return false
  end
  return true
end

function skActBase.initCopy(act, copyBase)
  act.copyBase = copyBase
  if not rawget(copyBase, "__index") then
    copyBase.__index = copyBase.indexForCopy
  end
  setmetatable(act, copyBase)
end

function skActBase.doCopy(act)
  local copyBase = act.copyBase
  do
    local VAR_TYPE = VAR_TYPE
    local THREAD = VAR_TYPE.THREAD
    local FUNCTION = VAR_TYPE.FUNCTION
    for key, value in pairs(copyBase) do
      if rawget(act, key) ~= nil then
        return
      end
      local type = type(value)
      if type == FUNCTION then
        return
      elseif type ~= THREAD then
        act[key] = value
      end
    end
  end
end

function skActBase.indexForCopy(tbl, key)
  local copyBase = tbl.copyBase
  local typeBase = tbl.base
  local copyBaseField = rawget(copyBase, key)
  if copyBaseField then
    return copyBaseField
  else
    return typeBase[key]
  end
end

function skActBase.isCommon()
  return true
end

function skActBase.isAtk()
end

function skActBase.isBasic()
end

function skActBase.isBorn()
end

function skActBase.isCounter()
end

function skActBase.isDashIn()
end

function skActBase.isDashOut()
end

function skActBase.isDash()
end

function skActBase.isHeavy()
end

function skActBase.isQte()
end

function skActBase.isExQte()
end

function skActBase.isLinkQte()
end

function skActBase.isSkill()
end

function skActBase.isUlt()
end

function skActBase.isUltEmpty()
end

function skActBase.isUltFast()
end

function skActBase.isAtkInput(act)
  if not act.btn then
    return
  end
  return act.btn.name == BUTTON_TYPE.atk
end

function skActBase.isSkillInput(act)
  if not act.btn then
    return
  end
  local btnName = act.btn.name
  local type = BUTTON_TYPE
  return btnName == type.sk1 or btnName == type.sk2
end

function skActBase.isSk1Input(act)
  if not act.btn then
    return
  end
  local btnName = act.btn.name
  local type = BUTTON_TYPE
  return btnName == type.sk1
end

function skActBase.isSk2Input(act)
  if not act.btn then
    return
  end
  local btnName = act.btn.name
  local type = BUTTON_TYPE
  return btnName == type.sk2
end

function skActBase.isDashInput(act)
  if not act.btn then
    return
  end
  return act.btn.name == BUTTON_TYPE.dash
end

function skActBase.isUltInput(act)
  if not act.btn then
    return
  end
  return act.btn.name == BUTTON_TYPE.ult
end

function skActBase.isQteInput(act)
  if not act.event then
    return
  end
  return act.event.isSwitch
end

function skActBase.deemAtk(act)
  if act:isAtk() then
    return true
  end
  if act:isAtkInput() then
    return true
  end
end

function skActBase.deemSkill(act)
  if act:isSkill() then
    return true
  end
  if act:isSkillInput() then
    return true
  end
end

function skActBase.deemDash(act)
  if act:isDash() then
    return true
  end
  if act:isDashInput() then
    return true
  end
end

function skActBase.deemUlt(act)
  if act:isUlt() then
    return true
  end
  if act:isUltInput() then
    return true
  end
end

function skActBase.deemQte(act)
  if act:isQte() then
    return true
  end
  if act:isQteInput() then
    return true
  end
end

function skActBase.isReady(act)
  local role = act.role
  if not role.skAct:transCheck(act) then
    return false
  end
  if not act:chooseStrSk() then
    return false
  end
  return true
end

function skActBase.transCheck(act, tarAct)
  local role = act.role
  local roleAct = role.skAct
  if roleAct ~= act then
    return nil
  end
  if role:isInMelt() then
    return true
  end
  local trans = act.trans
  local tarName = tarAct.name
  if roleAct.isCastOver or roleAct.isOver then
    return true
  end
  if trans.disable[tarName] then
    return false
  end
  if trans.enable[tarName] then
    return true
  end
  return tarAct.trans.prio > trans.inertia
end

function skActBase.chooseStrSk(act)
  for _, skill in ipairs(act.strSks) do
    if skill:isReady(act) then
      return skill
    end
  end
end

function skActBase.tarPos(act, event, oriPos)
  local role = act.role
  local range = act.search
  local tarPos = act._tarPos
  local icon = event and event.icon
  local indi = icon and icon.indi
  if not (indi and indi.aimSet[act.name]) or event.indiState == "mask" then
    local pos = role:searchTarget(range, oriPos)
    if pos then
      tarPos:SetA(pos)
    else
      tarPos = nil
    end
  elseif indi:isActive() then
    tarPos:SetA(icon.btn:indiPos())
  else
    local target = role.target
    if target then
      tarPos:SetA(target:get_pos_vec3())
    else
      tarPos:SetA(icon.btn:indiPos())
    end
  end
  return tarPos
end

function skActBase.skInfo(act)
  local info = act.info
  info.castId = act.castId
  info.linkStage = act.linkStage
  return info
end

function skActBase.start(act, event)
  local role = act.role
  local roleAct = role.skAct
  if not roleAct.isOver then
    roleAct:onBreak(act)
  end
  act._time = get_time()
  act.skillCount = 0
  local linkMgr = act.linkMgr
  act.linkStage = linkMgr.stage
  act.event = event
  local icon = event and event.icon
  act.icon = icon
  act.btn = event and event.btn
  if icon then
    act.hitId = icon.hitId
  end
  act.castId = act.castId + 1
  act.role:updateAct(act)
  local tarPos = act:tarPos(event)
  act.v_tarPos = tarPos
  act:setAtkTar(role.target)
  if tarPos and tarPos.x and tarPos.z then
    lookat_position(role.npc, tarPos.x, tarPos.z, true)
  end
  local strSk = act:chooseStrSk()
  act:skInfo()
  clear_hit_stop(role.npc)
  strSk:start(act)
  act.isBefOver = false
  act.isCastOver = false
  act.isOver = false
  act.isFront = true
  act:onBegin()
end

function skActBase.try(act, event, ...)
  if not act:isReady() then
    return false
  end
  act:start(event, ...)
  return true
end

function skActBase.onBegin(act)
  return call_custom_event_mq(SKACT_EVT_TYPE.ON_BEGIN, act.role.npc, act)
end

function skActBase.befDamage(skAct, casterNpc, hitTarget, damageSign, damageType, targetCamp, changeLevel, magicLevel, misInst, magicId)
end

function skActBase.onHit(act, casterNpc, hitTarget, hitType, skill, missile, part_npc)
end

function skActBase.tick(act)
  act.curSk:tick()
end

function skActBase.onBefTime(act)
  act.isBefOver = true
end

function skActBase.onCastTime(act, retainCache, ignoreIcon)
  local role = act.role
  act.isCastOver = true
  act.castOverTime = get_npc_time(role.npc)
  local popAct = act:tryPop(retainCache, ignoreIcon)
  if role:isInStay() and not popAct then
    role:toMelt()
  end
  act.indiMgr:on_act_cast_time()
  return popAct
end

function skActBase.onKill(skAct, caster, target, skInfo)
end

function skActBase.onBreak(act, tarAct)
  if act ~= tarAct then
    act.isOver = true
  end
  local role = act.role
  if not role:isInStay() or not can_change_hero_state() then
  elseif not tarAct or tarAct:isBasic() then
    role:toBack()
  end
  return call_custom_event_mq(SKACT_EVT_TYPE.ON_BREAK, act.role.npc, act)
end

function skActBase.onEnd(act)
  act.isOver = true
  local role = act.role
  if role.skAct ~= act then
    return
  end
  role.baseActs.wander:try()
  return call_custom_event_mq(SKACT_EVT_TYPE.ON_END, act.role.npc, act)
end

function skActBase.onStay(act)
  act.isFront = false
end

function skActBase.onBackground(act)
  act.isFront = false
end

function skActBase.insertFun(act, funName, newFun)
  act.tool.insert(act, funName, newFun)
end

function skActBase.removeFun(act, funName, newFun)
  act.tool.remove(act, funName, newFun)
end

function skActBase.tryPop(act, retainCache, ignoreIcon, timeOffset)
  if act.canPop and not act:canPop() then
    return
  end
  return act.inputor:pop(retainCache, ignoreIcon, timeOffset)
end

function skActBase.isRunning(act)
  return act.role.skAct == act
end

function skActBase.needTar(skAct)
  if skAct.search then
    return true
  else
    return false
  end
end

function skActBase.getSearchCfg(skAct)
  return skAct.search
end

function skActBase.setAtkTar(skAct, newTarget, newTargetPos)
  skAct.atkTarget = newTarget
  if not skAct:isRunning() then
    return
  end
  local role = skAct.role
  role.atkTarget = newTarget
  local curSk = skAct.curSk
  if not curSk then
    return
  end
  curSk.atkTarget = newTarget
  set_skill_target(role.npc, curSk.id, newTarget, newTargetPos)
end

function skActBase.searchTar(skAct, oriPos, btn, param)
  return skAct.role:searchNpc(skAct.search, oriPos, btn, param)
end

function skActBase.updateAtkTar(skAct, config, oriPos, btn, param)
  local target, tarPos = skAct.role:searchNpc(config or skAct.search, oriPos, btn, param)
  skAct:setAtkTar(target, tarPos)
  return target, tarPos
end

function skActBase.canStay(act)
  if not act.tool.target then
    return false, true
  end
  if act.isCastOver then
    if get_npc_time(act.role.npc) - act.castOverTime > 0.75 then
      return false, true
    else
      return false, false
    end
  else
    return true
  end
end

function skActBase.showUpFx(act, event)
  local role = act.role
  local facePos = get_npc_offset_position(role.npc, nil, 0, 10)
  local chestPos = get_npc_pos(role.npc, "Bip001 Chest")
  chestPos.y = chestPos.y - 0.15
  local roleNpc = role.npc
  if not role:isInRealStay() then
    cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK1_TIMER)
    cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK2_TIMER)
  end
  cast_magic(roleNpc, roleNpc, Const.SWITCH_CONFIG.BLINK_OUTLINE)
  create_scene_effect(Const.SWITCH_CONFIG.TO_FRONT_FLASH_QTE, chestPos, 5, nil, facePos)
end

function skActBase.needStopTimer(act)
  return false, false
end

function skActBase.ignoreCost(act)
end

function skActBase.restoreCost(act)
end

do return skActBase end

function skActBase.canPop(act)
  return true
end
