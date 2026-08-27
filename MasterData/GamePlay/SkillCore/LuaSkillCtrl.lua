local LuaSkillCtrl = class("LuaSkillCtrl")
local SkillLogicTimerCtrl = require("GamePlay.LogicTime.SkillLogicTimerCtrl")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local SortedMessenger = require("Framework.Common.SortedMessenger")
local SkillTriggerArg = require("GamePlay.SkillCore.SkillTriggerArg")
local cs_RangFunc = CS.RandomUtility.Range
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_TrueSync = CS.TrueSync
local cs_Vector2Point = CS.Vector2Point
local cs_Belong = CS.Belong
local cs_CameraController = CS.CameraController
local cs_SkillSelectType = CS.BattleSkillSelectHandle.SkillSelectType
local cs_EffectPointType = CS.EffectPoint.EffectPointType
local cs_BattleManager = CS.BattleManager
local cs_BattleUtility = CS.BattleUtility

function LuaSkillCtrl:ctor()
  self.logicTimerCtrl = SkillLogicTimerCtrl.New()
  self.skillTriggerArg = SkillTriggerArg.New()
  self.IsInVerify = false
end

function LuaSkillCtrl:InitSkillCtrl(battleCtrl)
  self.battleCtrl = battleCtrl
  self.cluaSkillCtrl = battleCtrl.LuaSkillController
  self.cUltSkillCtrl = battleCtrl.PlayerController.UltSkillHandle
  self.luaTrigger = SortedMessenger.New()
  self.IsInTDBattle = battleCtrl.IsInTDBattle
  self.IsInBrotatoBattle = battleCtrl.IsInBrotatoBattle
  if self.IsInVerify == false then
    self.originalUltHFactor = cs_CameraController.Instance.ultHFactor
    self.originalUltVFactor = cs_CameraController.Instance.ultVFactor
  end
end

function LuaSkillCtrl:GetBattleRoomId()
  return self.cluaSkillCtrl:GetBattleRoomId()
end

function LuaSkillCtrl:AddSkillTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, relativeRole)
  if triggerHandle == nil then
    return
  end
  self.skillTriggerArg:SetArgs(relativeRole)
  self.cluaSkillCtrl:AddTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, self.skillTriggerArg)
end

function LuaSkillCtrl:AddSkillTriggerWithBindArg(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, verifyId, extraArg1, extraArg2)
  if triggerHandle == nil then
    return
  end
  self.skillTriggerArg:SetArgs(sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, verifyId, extraArg1, extraArg2)
  self.cluaSkillCtrl:AddTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, self.skillTriggerArg)
end

function LuaSkillCtrl:AddSkillTriggerWithBindTable(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, args)
  if triggerHandle == nil then
    return
  end
  self.skillTriggerArg:SetArgsForTable(args)
  self.cluaSkillCtrl:AddTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, self.skillTriggerArg)
end

function LuaSkillCtrl:RemoveTrigger(triggerHandle, eventType)
  if triggerHandle == nil then
    return
  end
  self.cluaSkillCtrl:RemoveTrigger(triggerHandle, eventType)
end

function LuaSkillCtrl:RemoveHandleAllTrigger(triggerHandle)
  if triggerHandle == nil then
    return
  end
  self.cluaSkillCtrl:RemoveHandleAllTrigger(triggerHandle)
end

function LuaSkillCtrl:GetSkillTrigger(luaSkill, eventType)
  if luaSkill.cskill == nil then
    return
  end
  luaSkill.cskill:GetTrigger(eventType)
end

function LuaSkillCtrl:GetGridTrigger(gridSkill, eventType)
  gridSkill.cEffectGrid:GetTrigger(eventType)
end

function LuaSkillCtrl:CallBeforSkillPlayTrigger(luaSkill, role)
  self.cluaSkillCtrl:OnBeforePlaySkill(luaSkill.cskill, role)
end

function LuaSkillCtrl:CallAfterSkillPlayTrigger(luaSkill, role)
  self.cluaSkillCtrl:OnAfterPlaySkill(luaSkill.cskill, role)
end

function LuaSkillCtrl:OnUpdateLogic()
  self.logicTimerCtrl:OnUpdateLogic()
end

function LuaSkillCtrl:StartTimer(luaSkill, delay, func, obj, is_loop, start_time)
  local timer = self.logicTimerCtrl:GetTimer(delay, func, obj, is_loop, start_time, luaSkill)
  if luaSkill ~= nil then
    timer:InjectLuaSkill(luaSkill)
  end
  timer:Start()
  return timer
end

function LuaSkillCtrl:GetTimer(delay, func, obj, is_loop, start_time)
  return self.logicTimerCtrl:GetTimer(delay, func, obj, is_loop, start_time):Start()
end

function LuaSkillCtrl:CallRange(min, max)
  return cs_RangFunc(min, max)
end

function LuaSkillCtrl:CallRoleAction(role, id, speed)
  if id == nil or id <= 0 then
    return
  end
  if speed == nil then
    speed = 1
  end
  if self.IsInBrotatoBattle then
    self.cluaSkillCtrl:CallRoleActionForBrotato(role, id, 0, 0)
  else
    self.cluaSkillCtrl:CallRoleAction(role, id, speed)
  end
end

function LuaSkillCtrl:BreakCurrentAction(role)
  self.cluaSkillCtrl:BreakCurrentAction(role)
end

function LuaSkillCtrl:CallRoleActionWithTrigger(luaSkill, role, id, speed, triggerTime, onTrigger, atkId)
  if speed == nil then
    speed = 1
  end
  local timer
  if luaSkill.isDoubleAttack then
    triggerTime = triggerTime // 2
    speed = speed * 2
  end
  if 0 < triggerTime then
    if not luaSkill.isCommonAttack then
      self:StartShowSkillDurationTime(luaSkill, 0)
    end
    self:RecordSkillUncompleted(luaSkill)
    luaSkill:InjectActionTrigger(onTrigger)
    timer = self:StartTimer(luaSkill, triggerTime, luaSkill.TakeActionTrigger, luaSkill)
  else
    onTrigger()
  end
  if id ~= nil and 0 < id then
    if self.IsInBrotatoBattle then
      local orignalTriggerFrame = 0
      local isCommonAttack = luaSkill.cskill.isCommonAttack
      if isCommonAttack then
        local srcId = role.resSrcId
        if srcId ~= 0 then
          if atkId == 2 then
            orignalTriggerFrame = ConfigData.resource_model[srcId].atk2_trigger_frames
          else
            orignalTriggerFrame = ConfigData.resource_model[srcId].atk1_trigger_frames
          end
        end
      else
        triggerTime = 0
      end
      self.cluaSkillCtrl:CallRoleActionForBrotato(role, id, triggerTime, orignalTriggerFrame)
    else
      self.cluaSkillCtrl:CallRoleAction(role, id, speed)
    end
  end
  return timer
end

function LuaSkillCtrl:GetSkillBindBuffId(luaSkill)
  return luaSkill.cskill.parentBuffId
end

function LuaSkillCtrl:CallBuff(luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
  if buffId == nil or buffId <= 0 then
    return nil
  end
  local towerAbandomBuffIdConfig = ConfigData.buildinConfig.TowerAbandomBuffId
  if self.IsInTDBattle and towerAbandomBuffIdConfig ~= nil and table.contain(towerAbandomBuffIdConfig, buffId) then
    return
  end
  if role == nil or 0 >= role.hp and role.roleType ~= eBattleRoleType.skillCaster then
    return
  end
  if luaSkill == nil or luaSkill.cskill == nil then
    if isGameDev then
      error("error to add buff id:" .. tostring(buffId))
    end
    return
  end
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if isTriggerSet == nil then
    isTriggerSet = false
  end
  local battleBuff
  if duration == nil then
    battleBuff = self.cluaSkillCtrl:CallBuff(luaSkill.cskill, role, buffId, buffTier, isIgnoreTrigger, overridSender, isTriggerSet)
  else
    battleBuff = self.cluaSkillCtrl:CallTimeBuff(luaSkill.cskill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
  end
  local sender = luaSkill.caster
  if overridSender ~= nil then
    sender = overridSender
  end
  self:OnCallBuff(sender, role, buffId, battleBuff ~= nil)
  return battleBuff
end

function LuaSkillCtrl:CallBuffWithOriginSkill(cSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if isTriggerSet == nil then
    isTriggerSet = false
  end
  local battleBuff
  if duration == nil then
    battleBuff = self.cluaSkillCtrl:CallBuff(cSkill, role, buffId, buffTier, isIgnoreTrigger, overridSender, isTriggerSet)
  else
    battleBuff = self.cluaSkillCtrl:CallTimeBuff(cSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
  end
  local sender = cSkill.caster
  if overridSender ~= nil then
    sender = overridSender
  end
  self:OnCallBuff(sender, role, buffId, battleBuff ~= nil)
  return battleBuff
end

function LuaSkillCtrl:CallBuffWithOriginSkillAfterReplaceChecked(cSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
  if ConfigData.battle_buff_replace[buffId] ~= nil then
    buffId = ConfigData.battle_buff_replace[buffId].id
  end
  return self:CallBuffWithOriginSkill(cSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender, isTriggerSet)
end

function LuaSkillCtrl:CallBuffRepeated(luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger, isTriggerSet, onRepeated, ...)
  if role == nil or role.hp <= 0 and role.roleType ~= eBattleRoleType.skillCaster then
    return
  end
  local repeatedFun
  if onRepeated ~= nil then
    repeatedFun = BindCallback(luaSkill, onRepeated, ...)
  end
  local battleBuff
  if duration == nil then
    battleBuff = self.cluaSkillCtrl:CallBuffRepeated(luaSkill.cskill, role, buffId, buffTier, repeatedFun, isIgnoreTrigger or false, isTriggerSet or false)
  else
    battleBuff = self.cluaSkillCtrl:CallTimeBuffRepeated(luaSkill.cskill, role, buffId, buffTier, duration, repeatedFun, isIgnoreTrigger or false, isTriggerSet or false)
  end
  self:OnCallBuff(luaSkill.caster, role, buffId, battleBuff ~= nil)
  return battleBuff
end

function LuaSkillCtrl:CallBuffLifeEvent(luaSkill, role, buffId, buffTier, duration, lifeEvent, isIgnoreTrigger, isTriggerSet)
  if role == nil or role.hp <= 0 and role.roleType ~= eBattleRoleType.skillCaster then
    return
  end
  local battleBuff
  if duration == nil then
    battleBuff = self.cluaSkillCtrl:GenBuff(luaSkill.cskill, role, buffId, buffTier)
  else
    battleBuff = self.cluaSkillCtrl:GenTimeBuff(luaSkill.cskill, role, buffId, buffTier, duration)
  end
  if battleBuff == nil then
    return nil
  end
  battleBuff:BindBuffLifeEvent(lifeEvent)
  self.cluaSkillCtrl:AddBattleBuff(role, battleBuff, isIgnoreTrigger or false, isTriggerSet or false)
  return battleBuff
end

function LuaSkillCtrl:OnCallBuff(sender, target, buffId, bResult)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnCallBuff, sender, target, buffId, bResult)
end

function LuaSkillCtrl:ForceDispelBuff(role, buffId, buffTier, isIgnoreTrigger, isIgnoreAudio)
  self.cluaSkillCtrl:ForceDispelBuff(role, buffId, buffTier, isIgnoreTrigger or false, isIgnoreAudio or false)
end

function LuaSkillCtrl:DispelBuff(role, buffId, buffTier, isIgnoreTrigger, isIgnoreAudio)
  self.cluaSkillCtrl:DispelBuff(role, buffId, buffTier, isIgnoreTrigger or false, isIgnoreAudio or false)
end

function LuaSkillCtrl:DispelBuffByMaker(buffMaker, role, buffId, buffTier, isIgnoreTrigger, isIgnoreAudio)
  self.cluaSkillCtrl:DispelBuffByMaker(buffMaker, role, buffId, buffTier, isIgnoreTrigger or false, isIgnoreAudio or false)
end

function LuaSkillCtrl:GetRoleBuffs(role)
  if role == nil or role.hp <= 0 then
    return nil
  end
  return self.cluaSkillCtrl:GetRoleBuffs(role)
end

function LuaSkillCtrl:GetRoleShowBuffsNeedShow(role)
  if role == nil or role.hp <= 0 then
    return nil
  end
  return self.cluaSkillCtrl:GetRoleShowBuffsNeedShow(role)
end

function LuaSkillCtrl:GetRoleBuffById(role, buffId)
  return role:GetRoleBuffById(buffId)
end

function LuaSkillCtrl:GetRoleBuffMakeById(role, buffId)
  local buff = role:GetRoleBuffById(buffId)
  if buff ~= nil and buff.battleSkill ~= nil then
    return buff.battleSkill.maker
  end
  return nil
end

function LuaSkillCtrl:GetRoleAllBuffsByFeature(role, buffFeature)
  return role:GetAllBuffsByFeature(buffFeature)
end

function LuaSkillCtrl:RoleContainsBuffFeature(role, buffFeature)
  return self.cluaSkillCtrl:RoleContainsBuffFeature(role, buffFeature)
end

function LuaSkillCtrl:RoleContainsCtrlBuff(role)
  local buffMgr = role:GetBuffComponent()
  if buffMgr == nil then
    return false
  end
  local buffs = buffMgr._buffs
  if buffs == nil or buffs.Count <= 0 then
    return false
  end
  for k, v in pairs(buffs) do
    if v.buffCfg.IsControl then
      return true
    end
  end
  return false
end

function LuaSkillCtrl:RoleRemoveBuffsByFeature(role, buffFeature)
  local buffs = self:GetRoleAllBuffsByFeature(role, buffFeature)
  if buffs ~= nil then
    for j = buffs.Count - 1, 0, -1 do
      self:DispelBuff(role, buffs[j].dataId, 0)
    end
  end
end

function LuaSkillCtrl:CallTargetSelect(luaSkill, targetSelectId, rangeOffset, overrideSelf, CareerConditionLag)
  if overrideSelf == nill then
    overrideSelf = luaSkill.caster
  end
  return self.cluaSkillCtrl:CallTargetSelect(luaSkill.cskill, overrideSelf, targetSelectId, rangeOffset or 0, CareerConditionLag or false)
end

function LuaSkillCtrl:CallTargetSelectWithRange(luaSkill, targetSelectId, range, overrideSelf, CareerConditionLag)
  if overrideSelf == nill then
    overrideSelf = luaSkill.caster
  end
  return self.cluaSkillCtrl:CallTargetSelectWithRange(luaSkill.cskill, overrideSelf, targetSelectId, range or 0, CareerConditionLag or false)
end

function LuaSkillCtrl:CallTargetSelectWithCskill(cskill, targetSelectId, rangeOffset, caster)
  return self.cluaSkillCtrl:CallTargetSelect(cskill, caster, targetSelectId, rangeOffset or 0)
end

function LuaSkillCtrl:CallRightMaxDirEnemy(role, ignoreNeutral, ignoreCrtlImmunity)
  if ignoreNeutral == nil then
    ignoreNeutral = true
  end
  if ignoreCrtlImmunity == nil then
    ignoreCrtlImmunity = true
  end
  return self.cluaSkillCtrl:CallRightMaxDirEnemy(role, ignoreNeutral, ignoreCrtlImmunity)
end

function LuaSkillCtrl:CallLeftMaxDirEnemy(role, ignoreNeutral, ignoreCrtlImmunity)
  if ignoreNeutral == nil then
    ignoreNeutral = true
  end
  if ignoreCrtlImmunity == nil then
    ignoreCrtlImmunity = true
  end
  local tempTargetGridList = {}
  local rowArg = role.curCoord.y & 1
  local maxXCount = self.battleCtrl.battleFieldData.mapSizeXCount - 1
  local coord = cs_Vector2Point(maxXCount - rowArg, role.curCoord.y)
  local ofsCoord = cs_Vector2Point(-1, 0)
  for i = 0, maxXCount do
    coord = coord + ofsCoord
    if coord ~= role.curCoord then
      local battleGridData = self.battleCtrl:TryGetGridData(coord)
      if battleGridData ~= nil and battleGridData.role ~= nil and battleGridData.role.belong == cs_BattleUtility.GetInverseBelong(role.belong, cs_Belong.enemy) and (not ignoreNeutral or battleGridData.role.belong ~= cs_Belong.neutral) and not battleGridData.role:IsUnSelect(role) and (not ignoreCrtlImmunity or not self:RoleContainsBuffFeature(battleGridData.role, eBuffFeatureType.CtrlImmunity)) and battleGridData ~= battleGridData.role.lastPreSetGrid then
        table.insert(tempTargetGridList, battleGridData)
      end
    end
  end
  if #tempTargetGridList <= 0 then
    return nil
  end
  table.sort(tempTargetGridList, function(g1, g2)
    return math.abs(g2.x - role.x) < math.abs(g1.x - role.x)
  end)
  local result = tempTargetGridList[1].role
  return result
end

function LuaSkillCtrl:GetSelectTeamRoles(belongNum)
  if belongNum == eBattleRoleBelong.player then
    return self.battleCtrl.PlayerTeamController.battleRoleList
  elseif belongNum == eBattleRoleBelong.enemy then
    return self.battleCtrl.EnemyTeamController.battleRoleList
  elseif belongNum == eBattleRoleBelong.neutral then
    return self.battleCtrl.NeutralTeamController.battleRoleList
  end
  return nil
end

function LuaSkillCtrl:GetAllFriendRolesRelative(selfBelongNum)
  if selfBelongNum == eBattleRoleBelong.player then
    return self.battleCtrl.PlayerTeamController.battleRoleList
  elseif selfBelongNum == eBattleRoleBelong.enemy then
    return self.battleCtrl.EnemyTeamController.battleRoleList
  elseif selfBelongNum == eBattleRoleBelong.neutral then
    return self.battleCtrl.NeutralTeamController.battleRoleList
  end
  return nil
end

function LuaSkillCtrl:GetAllFriendRoles()
  local tempTargetList = {}
  local playerList = self.battleCtrl.PlayerTeamController.battleRoleList
  local neturalList = self.battleCtrl.NeutralTeamController.battleRoleList
  if playerList ~= nil then
    for i = 0, playerList.Count - 1 do
      table.insert(tempTargetList, playerList[i])
    end
  end
  if neturalList ~= nil then
    for i = 0, neturalList.Count - 1 do
      table.insert(tempTargetList, neturalList[i])
    end
  end
  return tempTargetList
end

function LuaSkillCtrl:GetAllEnmyRoles()
  local tempTargetList = {}
  local enmyList = self.battleCtrl.EnemyTeamController.battleRoleList
  local neturalList = self.battleCtrl.NeutralTeamController.battleRoleList
  if enmyList ~= nil then
    for i = 0, enmyList.Count - 1 do
      table.insert(tempTargetList, enmyList[i])
    end
  end
  if neturalList ~= nil then
    for i = 0, neturalList.Count - 1 do
      table.insert(tempTargetList, neturalList[i])
    end
  end
  return tempTargetList
end

function LuaSkillCtrl:GetGuardProfession()
  if self.guardProEntity ~= nil then
    return self.guardProEntity
  end
  local pDugeonList = self.cluaSkillCtrl:CallGetAllPlayerDungeonRoles()
  if pDugeonList ~= nil then
    for i = 0, pDugeonList.Count - 1 do
      if pDugeonList[i].recordTable.IsGuardPro then
        self.guardProEntity = pDugeonList[i]
        return self.guardProEntity
      end
    end
  end
  return nil
end

function LuaSkillCtrl:CallEffect(target, effectId, luaSkill, func, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  if func ~= nil then
    return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  else
    return self:CallEffectInCs(target, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  end
end

function LuaSkillCtrl:CallEffectWithEmission(emission, effectId, luaSkill, func, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  if func ~= nil then
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  else
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  end
end

function LuaSkillCtrl:CallEffectWithArg(target, effectId, luaSkill, isBreakKill, isIgnoreHideInUlt, func, ...)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), nil, 1, isBreakKill, isIgnoreHideInUlt)
end

function LuaSkillCtrl:CallEffectWithArgAndSpeed(target, effectId, luaSkill, speed, isBreakKill, isIgnoreHideInUlt, func, ...)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), nil, speed, isBreakKill, isIgnoreHideInUlt)
end

function LuaSkillCtrl:CallEffectWithArgOverride(target, effectId, luaSkill, overrideSelf, isBreakKill, isIgnoreHideInUlt, func, ...)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, nil, isBreakKill, isIgnoreHideInUlt)
end

function LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(target, effectId, luaSkill, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt, func, ...)
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
end

function LuaSkillCtrl:CallEffectInCs(target, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  if target == nil then
    return nil
  end
  if speed == nil then
    speed = 1
  end
  if luaSkill.cskill == nil then
    return nil
  end
  local effect = self.cluaSkillCtrl:CallEffect(target, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed, isIgnoreHideInUlt)
  if isBreakKill then
    luaSkill:AddEffect(effect)
  end
  return effect
end

function LuaSkillCtrl:CallSelectTargetEffect(luaSkill, targetRole)
  return self.cluaSkillCtrl:CallSelectTargetEffect(luaSkill.cskill.maker, targetRole)
end

function LuaSkillCtrl:CallEffectDoScale(effect, scaleValue, duration)
  if self.IsInVerify then
    return
  end
  if effect == nil or effect.lsObject == nil then
    return
  end
  duration = duration or 0
  local newVector = Vector3.Temp(scaleValue, scaleValue, scaleValue)
  effect.lsObject:StartLocalScale(newVector, duration)
end

function LuaSkillCtrl:ResizeEffectScale(effect)
  if self.IsInVerify then
    return
  end
  if effect == nil or effect.lsObject == nil then
    return
  end
  effect.lsObject:ResetScaleTween()
end

function LuaSkillCtrl:CallEffectWithEmissionInCs(emission, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  if emission == nil then
    return nil
  end
  if speed == nil then
    speed = 1
  end
  local effect = self.cluaSkillCtrl:CallEffectWithEmission(emission, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed, isIgnoreHideInUlt)
  if isBreakKill then
    luaSkill:AddEffect(effect)
  end
  return effect
end

function LuaSkillCtrl:CallAddCircleColliderForEffect(effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
  return self.cluaSkillCtrl:CallAddCircleColliderForEffect(effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
end

function LuaSkillCtrl:SetCircleColliderAndEffectRadius(circleCollider, radius, effect)
  self.cluaSkillCtrl:SetCircleColliderAndEffectRadius(circleCollider, radius, effect)
end

function LuaSkillCtrl:GetTargetWithGrid(gridX, gridY)
  return self.cluaSkillCtrl:GetTargetWithGrid(gridX, gridY)
end

function LuaSkillCtrl:GetGridWithRole(role)
  if role == nil then
    error("GetGridWithRole::传入的角色为空，请检查")
    return
  end
  return self.cluaSkillCtrl:GetGridWithRole(role)
end

function LuaSkillCtrl:GetGridWithPos(x, y)
  return self.cluaSkillCtrl:GetGridWithPos(x, y)
end

function LuaSkillCtrl:GetRoleWithPos(x, y)
  return self.cluaSkillCtrl:GetRoleWithPos(x, y)
end

function LuaSkillCtrl:ClearColliderOrEmission(collider)
  self.cluaSkillCtrl:ClearColliderOrEmission(collider)
end

function LuaSkillCtrl:CallRealDamage(luaSkill, target, effect, config, configArg, isTriggerSet, isIgnoreTrigger)
  local skillResult
  if effect ~= nil then
    skillResult = self:CallSkillResult(effect, target)
  else
    skillResult = self:CallSkillResultNoEffect(luaSkill, target)
  end
  if skillResult == nil then
    return
  end
  if config == nil then
    config = realDamageConfig
  end
  if config ~= realDamageConfig then
    setmetatable(config, metaRealDamageConfig)
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger or false)
  skillResult:EndResult()
end

function LuaSkillCtrl:CallRepeatedHurtWithFormula(isEndOnRoleDie, luaSkill, targetRole, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield, duration, hurtInterval, formulaId, ...)
  local hurt = self:CallFormulaNumber(formulaId, luaSkill.caster, targetRole, ...)
  if hurt <= 0 then
    return nil
  end
  local skillId = luaSkill.cskill.dataId
  local skillTag = luaSkill.cskill.skillTag
  local skillRange = luaSkill.cskill.SkillRange
  local bindObj = isEndOnRoleDie and luaSkill or nil
  local times = duration
  if -1 < duration then
    times = duration // hurtInterval - 1
  end
  local timer = self:StartTimer(bindObj, hurtInterval, BindCallback(self, function()
    self:RemoveLifePure(hurt, luaSkill, skillId, skillTag, skillRange, targetRole, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  end), self, times, hurtInterval)
  return timer
end

function LuaSkillCtrl:RemoveLife(hurt, luaSkill, target, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  if isShowText == nil then
    isShowText = true
  end
  if hurtType == nil then
    hurtType = luaSkill.cskill.skillCfg.HurtType
  end
  return self.battleCtrl:SetRoleHurt(hurt, luaSkill.cskill, hurtType, luaSkill.caster, target, false, false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false, -1, ignoreShield or false)
end

function LuaSkillCtrl:RemoveLifePure(hurt, luaSkill, skillDataId, skillTag, skillRange, target, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  if isShowText == nil then
    isShowText = true
  end
  if hurtType == nil and luaSkill.cskill ~= nil then
    hurtType = luaSkill.cskill.skillCfg.HurtType
  end
  return self.battleCtrl:SetRoleHurtPure(hurt, luaSkill.cskill, skillTag, skillRange, skillDataId, hurtType, luaSkill.caster, target, false, false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false, -1, ignoreShield or false)
end

function LuaSkillCtrl:RemoveLifeWithCSkill(hurt, cskill, target, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  if isShowText == nil then
    isShowText = true
  end
  if hurtType == nil then
    hurtType = cskill.skillCfg.HurtType
  end
  return self.battleCtrl:SetRoleHurt(hurt, cskill, hurtType, cskill.maker, target, false, false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false, nil, nil, ignoreShield or false)
end

function LuaSkillCtrl:CallHeal(heal, luaSkill, target, isTriggerSet, overridSender, isIgnoreGobalFactor, isIgnoreTrigger)
  local sender = luaSkill.caster
  if overridSender ~= nil then
    sender = overridSender
  end
  return self.battleCtrl:SetRoleHeal(heal, luaSkill.cskill, sender, target, false, nil, false, isTriggerSet or false, isIgnoreTrigger or false, isIgnoreGobalFactor or false)
end

function LuaSkillCtrl:CallHealWithCSkill(heal, cskill, target, isTriggerSet, overridSender, isIgnoreGobalFactor, isIgnoreTrigger)
  local sender = cskill.maker
  if overridSender ~= nil then
    sender = overridSender
  end
  return self.battleCtrl:SetRoleHeal(heal, cskill, sender, target, false, nil, false, isTriggerSet or false, isIgnoreTrigger or false, isIgnoreGobalFactor or false)
end

function LuaSkillCtrl:CallFloatText(role, floatTextId, damage, skillHurtType)
  skillHurtType = skillHurtType or eHurtType.None
  if damage == nil then
    self.cluaSkillCtrl:CallFloatText(role, floatTextId, skillHurtType)
  else
    self.cluaSkillCtrl:CallFloatText(role, floatTextId, skillHurtType, damage)
  end
end

function LuaSkillCtrl:AddRoleShield(role, shieldType, shieldValue, formulaId, isIgnoreTrigger)
  local tempConfig = {}
  tempConfig.role = role
  tempConfig.shieldValue = shieldValue
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnBeforeAddShield, tempConfig)
  shieldValue = tempConfig.shieldValue
  role:AddShield(shieldValue, shieldType, formulaId)
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if isIgnoreTrigger == true then
    return
  end
  local finalValue = self:GetShield(role, shieldType)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddShield, role, shieldType, finalValue, shieldValue)
end

function LuaSkillCtrl:ReduceRoleShield(role, shieldType, shieldValue, formulaId, isIgnoreTrigger)
  role:AddShield(-1 * shieldValue, shieldType, formulaId)
end

function LuaSkillCtrl:GetShield(role, shieldType)
  return role:GetShield(shieldType)
end

function LuaSkillCtrl:GetRoleAllShield(role)
  local sum = 0
  for i = 0, eShieldType.MaxShieldCount do
    sum = sum + role:GetShield(i)
  end
  return sum
end

function LuaSkillCtrl:ClearShield(role, shieldType)
  role:ClearShield(shieldType)
end

function LuaSkillCtrl:ClearAllShield(role)
  role:ClearAllShield()
end

function LuaSkillCtrl:CallSkillResult(effect, target, config)
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return self.cluaSkillCtrl:GetSkillResult(effect, target, config)
end

function LuaSkillCtrl:CallSkillResultNoEffect(luaSkill, target, config)
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return self.cluaSkillCtrl:GetSkillResultNoEffect(luaSkill.cskill, target, config)
end

function LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(cskill, target, config)
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return self.cluaSkillCtrl:GetSkillResultNoEffect(cskill, target, config)
end

function LuaSkillCtrl:HurtResult(luaSkill, skillResult, config, configArg, isTriggerSet, isIgnoreTrigger, extraArg, overriderRecordDamgeName)
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if luaSkill.caster ~= nil and luaSkill.caster.isRealDmgForAtack and luaSkill.cskill.isCommonAttack then
    if config == nil then
      config = realDamageConfig
    end
    if config ~= realDamageConfig then
      config = self:ModifyRealDmgConfig(config)
    end
  else
    if config == nil then
      config = generalHurtConfig
    end
    if config ~= generalHurtConfig then
      setmetatable(config, metaGeneralHurtConfig)
    end
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  if extraArg ~= nil then
    config.extra_arg = extraArg
  end
  if overriderRecordDamgeName then
    config.overrideRecordName = overriderRecordDamgeName
  end
  local isInSpecialTdDungeon = false
  local dungeonId = 0
  if not self.IsInVerify then
    dungeonId = ExplorationManager.dungeonId
  end
  if ConfigData.buildinConfig.SpecialDungeon ~= nil and dungeonId ~= nil and 0 < dungeonId and table.contain(ConfigData.buildinConfig.SpecialDungeon, ExplorationManager.dungeonId) then
    isInSpecialTdDungeon = true
  end
  if self.IsInTDBattle and not isInSpecialTdDungeon then
    local targetRoles = skillResult.roleList
    if targetRoles ~= nil and 0 < targetRoles.Count then
      for i = targetRoles.Count - 1, 0, -1 do
        local tempRole = targetRoles[i]
        if tempRole.roleType == eBattleRoleType.DungeonRole then
          targetRoles:RemoveAt(i)
        end
      end
    end
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger)
  config.isTriggerSet = false
  setmetatable(config, nil)
end

function LuaSkillCtrl:HurtResultWithConfig(luaSkill, skillResult, configId, configArg, isTriggerSet, isIgnoreTrigger, extraArg, overriderRecordDamgeName)
  if luaSkill == nil or configId == nil then
    return
  end
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  local config = luaSkill:GetHurtResultConfig(configId)
  if config == nil then
    return
  end
  if luaSkill.caster.isRealDmgForAtack and luaSkill.cskill.isCommonAttack then
    config = self:ModifyRealDmgConfig(config)
  end
  if extraArg ~= nil then
    config.extra_arg = extraArg
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  if overriderRecordDamgeName then
    config.overrideRecordName = overriderRecordDamgeName
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger)
  config.isTriggerSet = false
end

function LuaSkillCtrl:HurtResultWithConfigOverrideCSkill(luaSkill, overrideCSkill, skillResult, configId, configArg, isTriggerSet, isIgnoreTrigger, extraArg)
  if luaSkill == nil or configId == nil then
    return
  end
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  local config = luaSkill:GetHurtResultConfig(configId)
  if config == nil then
    return
  end
  if extraArg ~= nil then
    config.extra_arg = extraArg
  end
  if overrideCSkill.maker.isRealDmgForAtack and overrideCSkill.isCommonAttack then
    config = self:ModifyRealDmgConfig(config)
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger)
  config.isTriggerSet = false
end

function LuaSkillCtrl:ModifyRealDmgConfig(config)
  local realDmgConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = config.basehurt_formula or realDamageConfig.basehurt_formula,
    minhurt_formula = config.minhurt_formula or realDamageConfig.minhurt_formula,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = config.correct_formula or realDamageConfig.correct_formula,
    lifesteal_formula = config.lifesteal_formula or realDamageConfig.lifesteal_formula,
    spell_lifesteal_formula = config.spell_lifesteal_formula or realDamageConfig.spell_lifesteal_formula,
    returndamage_formula = config.returndamage_formula or realDamageConfig.returndamage_formula,
    hurt_type = eHurtType.RealDmg,
    hurt_tag = config.hurt_tag
  }
  return realDmgConfig
end

function LuaSkillCtrl:HealResult(skillResult, config, configArg, isTriggerSet, isIgnoreTrigger, isIgnoreGobalFactor)
  if config == nil then
    config = generalHealConfig
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  if config ~= generalHealConfig then
    setmetatable(config, {
      __index = generalHealConfig
    })
  end
  skillResult:HealResult(config, configArg, isIgnoreTrigger or false, isIgnoreGobalFactor or false)
  config.isTriggerSet = false
  setmetatable(config, nil)
end

function LuaSkillCtrl:HealResultWithConfig(luaSkill, skillResult, configId, configArg, isTriggerSet, isIgnoreTrigger, isIgnoreGobalFactor)
  if luaSkill == nil or configId == nil then
    return
  end
  local config = luaSkill:GetHealResultConfig(configId)
  if config == nil then
    return
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HealResult(config, configArg, isIgnoreTrigger or false, isIgnoreGobalFactor or false)
  config.isTriggerSet = false
end

function LuaSkillCtrl:CallNewSkill(skillId, skillLevel, skillType, itemId)
  return self.cluaSkillCtrl:CallNewSkill(skillId, skillLevel or 1, skillType or 0, itemId or 0)
end

function LuaSkillCtrl:CallFormulaNumber(formual, role, targetRole, ...)
  return self.cluaSkillCtrl:CallFormulaNumber(formual, role, targetRole, table.unpack({
    ...
  }))
end

function LuaSkillCtrl:CallFormulaBool(formual, role, target, ...)
  return self.cluaSkillCtrl:CallFormulaBool(formual, role, target, table.unpack({
    ...
  }))
end

function LuaSkillCtrl:CallFormulaNumberWithSkill(formual, role, target, luaSkill, ...)
  return self.cluaSkillCtrl:CallFormulaNumberWithSkill(formual, role, target, luaSkill.cskill, table.unpack({
    ...
  }))
end

function LuaSkillCtrl:CallFormulaBoolWithSkill(formual, role, target, luaSkill, ...)
  return self.cluaSkillCtrl:CallFormulaBoolWithSkill(formual, role, target, luaSkill.cskill, table.unpack({
    ...
  }))
end

function LuaSkillCtrl:CallReFillSkillCd(cskill)
  self.cluaSkillCtrl:CallReFillSkillCd(cskill)
end

function LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  self.cluaSkillCtrl:CallReFillMainSkillCdForRole(role)
end

function LuaSkillCtrl:CallResetCDForSingleSkill(battleSkill, offset)
  battleSkill:ResetCDTimeOffsetNum(offset)
end

function LuaSkillCtrl:CallResetCDRatioForRole(role, ofsPercent)
  self.cluaSkillCtrl:CallResetCDRatioForRole(role, ofsPercent)
end

function LuaSkillCtrl:CallResetCDNumForRole(role, offset)
  self.cluaSkillCtrl:CallResetCDNumForRole(role, offset)
end

function LuaSkillCtrl:CallResetComAtkCDRatioForRole(role, ratio)
  self.cluaSkillCtrl:CallResetComAtkCDRatioForRole(role, ratio)
end

function LuaSkillCtrl:CallResetCDForTeam(belongNum, ofsPercent)
  self.cluaSkillCtrl:CallResetCDForTeam(belongNum, ofsPercent)
end

function LuaSkillCtrl:CallResetCDForTeamSingleSkill(belongNum, luaSkill, ofsPercent)
  self.cluaSkillCtrl:CallResetCDForTeamSingleSkill(belongNum, luaSkill.cskill.dataId, ofsPercent)
end

function LuaSkillCtrl:CallResetMainSkillCDRatioForTeam(belongNum, ofsPercent)
  self.cluaSkillCtrl:CallResetMainSkillCDForTeam(belongNum, ofsPercent)
end

function LuaSkillCtrl:CallResetMainSkillCDNumForTeam(belongNum, offset)
  self.cluaSkillCtrl:CallResetMainSkillCDNumForTeam(belongNum, offset)
end

function LuaSkillCtrl:SetResetCdByReturnConfigOnce(luaSkill)
  luaSkill.cskill:SetResetCdByReturnConfigOnce()
end

function LuaSkillCtrl:CallBreakAllSkill(role, resetState)
  self.cluaSkillCtrl:CallBreakAllLuaSkill(role)
  if resetState then
    role:ResetRoleState()
  end
end

function LuaSkillCtrl:RecordSkillCompleted(luaSkill)
  luaSkill.isSkillUncompleted = false
end

function LuaSkillCtrl:RecordSkillUncompleted(luaSkill)
  luaSkill.isSkillUncompleted = true
end

function LuaSkillCtrl:GetRoleCommonAttack(role)
  return role:GetCommonAttack()
end

function LuaSkillCtrl:GetRoleComAtkSkillMoveSelectTarget(role)
  local csAtkSkill = role:GetCommonAttack()
  if csAtkSkill == nil then
    return nil
  end
  return csAtkSkill.moveSelectTarget
end

function LuaSkillCtrl:IsAbleAttackTarget(role, target, attack_range, isNeedCheckRemote)
  if isNeedCheckRemote == nil then
    isNeedCheckRemote = false
  end
  return self.cluaSkillCtrl:IsAbleAttackTarget(role, target, attack_range, isNeedCheckRemote)
end

function LuaSkillCtrl:IsAbleAttackTargetWithDir(role, targetRole, atk_range, dir_range, isNeedCheckRemote)
  if isNeedCheckRemote == nil then
    isNeedCheckRemote = false
  end
  return self.cluaSkillCtrl:IsAbleAttackTargetWithDir(role, targetRole, atk_range, dir_range, isNeedCheckRemote)
end

function LuaSkillCtrl:IsAbleAttackCheckExcludedDir(role, targetRole, dir_range, isNeedCheckRemote)
  if isNeedCheckRemote == nil then
    isNeedCheckRemote = false
  end
  return self.cluaSkillCtrl:IsAbleAttackCheckExcludedDir(role, targetRole, dir_range, isNeedCheckRemote)
end

function LuaSkillCtrl:IsWorthAttacking(luaSkill, role)
  local onFireRole = luaSkill.caster:TryToGetFocusFiringRole()
  if onFireRole == role then
    return true
  end
  if role:ContainBuffFeature(eBuffFeatureType.Bewitch) then
    if self.battleCtrl:IsAllMemberBewitched(role.belong) then
      return true
    else
      return false
    end
  end
  return true
end

function LuaSkillCtrl:CreateSummoner(luaSkill, monsterId, coordx, coordy, belongNum)
  return self.cluaSkillCtrl:CreateSummoner(luaSkill.cskill, monsterId, coordx, coordy, belongNum or -1)
end

function LuaSkillCtrl:CreateSummonerWithCSkill(cskill, monsterId, coordx, coordy, belongNum)
  return self.cluaSkillCtrl:CreateSummoner(cskill, monsterId, coordx, coordy, belongNum or -1)
end

local summonerAdapterList = {}

function LuaSkillCtrl:CreateSummonerWithChip(luaSkill, monsterId, coordx, coordy, belongNum)
  local csDynmonner = self.cluaSkillCtrl:CreateSummoner(luaSkill.cskill, monsterId, coordx, coordy, belongNum or -1)
  local player = self.battleCtrl.PlayerController.playerData
  if player == nil then
    return csDynmonner
  end
  if not self.IsInVerify then
    if self.DynSummonerAdapter == nil then
      self.DynSummonerAdapter = require("Game.Exploration.Data.DynSummonerAdapter")
    end
    table.removeall(summonerAdapterList)
    local dynSummoner = self.DynSummonerAdapter.New()
    dynSummoner:InitSummonerAdapter(csDynmonner.career, csDynmonner.camp, csDynmonner.attackRange)
    table.insert(summonerAdapterList, dynSummoner)
    player:ExecuteAllChip2NewHeroList(summonerAdapterList)
    table.removeall(summonerAdapterList)
    local skillList = dynSummoner:GetItemSkillList()
    for _, skill in pairs(skillList) do
      csDynmonner.equipSkillIDList:Add(skill)
    end
    for attrId, value in pairs(dynSummoner.baseAttr) do
      if value ~= 0 then
        csDynmonner:SetBaseAttr(attrId, value)
      end
    end
    for attrId, value in pairs(dynSummoner.ratioAttr) do
      if value ~= 0 then
        csDynmonner:SetRatioAttr(attrId, value)
      end
    end
    for attrId, value in pairs(dynSummoner.extraAttr) do
      if value ~= 0 then
        csDynmonner:SetExtraAttr(attrId, value)
      end
    end
  else
    player:AdapterAllChipDynSummoner(csDynmonner)
  end
  return csDynmonner
end

function LuaSkillCtrl:AddSummonerRole(summoner)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnBeforeCallSummoner, summoner)
  local summonerEntity = self.cluaSkillCtrl:AddSummonerRole(summoner)
  if summoner.ableMove and summonerEntity ~= nil then
    self:BroadcastLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, summonerEntity)
  end
  return summonerEntity
end

function LuaSkillCtrl:GetSummonerCamp(summonerEntity)
  return summonerEntity.summoner.summonerCfg.Camp
end

function LuaSkillCtrl:CallFocusTimeLine(role)
  self.cUltSkillCtrl:PlayFocusTimeLine(role)
end

function LuaSkillCtrl:CallBackViewTimeLine(role, isEndUltEffect)
  self.cUltSkillCtrl:PlayBackViewTimeLine(role, isEndUltEffect)
end

function LuaSkillCtrl:CallSpecViewTimeLine(role)
  self.cUltSkillCtrl:PlaySpecViewTimeLine(role)
end

function LuaSkillCtrl:CallEndUltEffect(role)
  self.cUltSkillCtrl:EndUltEffect(role)
end

function LuaSkillCtrl:EndUltEffectAndUnFreeze()
  self.battleCtrl:SetUltSkillUnFreeze()
end

function LuaSkillCtrl:CallPlayUltMovie()
  if self.cUltSkillCtrl ~= nil then
    self.cUltSkillCtrl:PlayUltMovie()
  end
end

function LuaSkillCtrl:GetPlayUltMoviePath()
  if self.cUltSkillCtrl ~= nil then
    return self.cUltSkillCtrl:GetPlayUltMoviePath()
  end
  return nil
end

function LuaSkillCtrl:CallSetUltSkipBtnActive(rayCastEnable)
  local skillMoudleUI = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillMoudleUI ~= nil then
    skillMoudleUI:SetUltSkipBtnActive(false)
  end
end

function LuaSkillCtrl:ResetUltFactor()
  if self.IsInVerify == false then
    cs_CameraController.Instance.ultHFactor = self.originalUltHFactor
    cs_CameraController.Instance.ultVFactor = self.originalUltVFactor
  end
end

function LuaSkillCtrl:SetUltHFactor(hFactor)
  if self.IsInVerify == false then
    cs_CameraController.Instance.ultHFactor = hFactor
  end
end

function LuaSkillCtrl:SetUltVFactor(vFactor)
  if self.IsInVerify == false then
    cs_CameraController.Instance.ultVFactor = vFactor
  end
end

function LuaSkillCtrl:CallUltSkillScreenEffect(role)
  if self.cUltSkillCtrl ~= nil then
    self.cUltSkillCtrl:ScreenEffect(role)
  end
end

function LuaSkillCtrl:CallBattleCamShake(level)
end

function LuaSkillCtrl:CallBattleCamShakeByParam(level, during, sterngth, vibrato)
  if level == eCamShakeLevel.Light then
    self.cluaSkillCtrl:CallBattleVcamShakeLightByParam(during, sterngth, vibrato)
  elseif level == eCamShakeLevel.Strong then
    self.cluaSkillCtrl:CallBattleVcamShakeStrongByParam(during, sterngth, vibrato)
  elseif level == eCamShakeLevel.None then
    self.cluaSkillCtrl:CallBattleVcamShakeByParam(during, sterngth, vibrato)
  end
end

function LuaSkillCtrl:StartTimerInUlt(luaSkill, delay, func, obj)
  local onDelayAction = BindCallback(luaSkill, func, obj)
  if self.IsInVerify then
    return
  end
  self.cUltSkillCtrl:StartTimer(delay, onDelayAction)
end

function LuaSkillCtrl:GetUltHMp()
  if self.cUltSkillCtrl ~= nil then
    return self.cUltSkillCtrl:GetCurUltMp()
  end
end

function LuaSkillCtrl:CallAddPlayerHmp(value)
  if self.cUltSkillCtrl ~= nil then
    self.cUltSkillCtrl:AddUltMp(value)
  end
end

function LuaSkillCtrl:SetCurUltMovieFileName(ultName)
  if self.IsInVerify then
    return
  end
  self.battleCtrl.PlayerController.UltSkillHandle.curUltMovieFileName = ultName
end

function LuaSkillCtrl:GetPlayerSkillCostMp(luaSkill)
  return luaSkill.cskill.skillCfg.PlayerMpCost
end

function LuaSkillCtrl:GetPlayerRoleEntity()
  return self.battleCtrl.PlayerController.SkillCasterEntity
end

function LuaSkillCtrl:GetPlayerRealAttribute(attrId)
  if attrId <= 0 or attrId > eHeroAttr.max_property_count then
    return 0
  end
  local skillCasterEntity = self:GetPlayerRoleEntity()
  if skillCasterEntity == nil then
    return 0
  end
  return skillCasterEntity:GetRealProperty(attrId)
end

function LuaSkillCtrl:CallAddPlayerMp(value)
  return self.cluaSkillCtrl:CallAddPlayerMp(value)
end

function LuaSkillCtrl:CallAddPlayerMpWithSkillCost(luaSkill)
  local value = luaSkill.cskill.skillCfg.PlayerMpCost
  return self:CallAddPlayerMp(value)
end

function LuaSkillCtrl:RegisterRoleHpCostEvent(luaSkill, realRoleEntity, config, action, isOnce)
  if action == nil then
    return
  end
  local cb = BindCallback(luaSkill, action)
  self.cluaSkillCtrl:RegisterRoleHpCostEvent(realRoleEntity, config, cb, isOnce)
end

function LuaSkillCtrl:CallCircledEmissionStraightly(luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  if effect ~= nil and effect.startPoint ~= nil then
    local point = effect.startPoint
    if point.pointType == cs_EffectPointType.Transform then
      effect.lsObject.localPosition = caster.lsObject.localPosition
    end
  end
  return self.cluaSkillCtrl:CallCircledEmissionStraightly(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

function LuaSkillCtrl:CallCircledEmissionStraightlyWithBornTarget(luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole, overrideBornTarget)
  if effect ~= nil and effect.startPoint ~= nil then
    local point = effect.startPoint
    if point.pointType == cs_EffectPointType.Transform then
      effect.lsObject.localPosition = overrideBornTarget:GetLogicPos()
    end
  end
  return self.cluaSkillCtrl:CallCircledEmissionStraightly(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive, overrideBornTarget)
end

function LuaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, subAngle, isDir, isArriveKill, onArrive, bindRole)
  if effect ~= nil and effect.startPoint ~= nil then
    local point = effect.startPoint
    if point.pointType == cs_EffectPointType.Transform then
      effect.lsObject.localPosition = caster.lsObject.localPosition
    end
  end
  self.cluaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, subAngle, isDir, isArriveKill, onArrive)
end

function LuaSkillCtrl:CallSectorEmissionStraightly(luaSkill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  if effect ~= nil and effect.startPoint ~= nil then
    local point = effect.startPoint
    if point.pointType == cs_EffectPointType.Transform then
      effect.lsObject.localPosition = caster.lsObject.localPosition
    end
  end
  return self.cluaSkillCtrl:CallSectorEmissionStraightly(luaSkill.cskill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

function LuaSkillCtrl:CallSectorEmissionStraightlyWithDir(luaSkill, caster, target, radius, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  if effect ~= nil and effect.startPoint ~= nil then
    local point = effect.startPoint
    if point.pointType == cs_EffectPointType.Transform then
      effect.lsObject.localPosition = caster.lsObject.localPosition
    end
  end
  return self.cluaSkillCtrl:CallSectorEmissionStraightlyWithDir(luaSkill.cskill, caster, target, radius, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

function LuaSkillCtrl:CallRectEmissionStraightly(luaSkill, caster, halfWidth, halfHeight, dirTarget, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isAriveKill, onArrive, overrideBornTarget, isFixedFromBornTarget)
  return self.cluaSkillCtrl:CallRectEmissionStraightly(luaSkill.cskill, caster, halfWidth, halfHeight, dirTarget, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isAriveKill, onArrive, overrideBornTarget, isFixedFromBornTarget)
end

function LuaSkillCtrl:CallRestartEmit(luaSkill, skillEmission, speed, target, isToBorder, isArriveKill, onArrive)
  if isToBorder then
    return skillEmission:ReStartEmitToBorder(self.battleCtrl, speed, skillEmission.skill, target, isArriveKill, onArrive)
  else
    return skillEmission:ReStartEmit(speed, luaSkill.skill, target, isArriveKill, onArrive)
  end
end

function LuaSkillCtrl:CallGetCircleSkillCollider(luaSkill, radius, influenceType, onEnter, onStay, onExit)
  return self.cluaSkillCtrl:CallGetCircleSkillCollider(luaSkill.caster, radius, influenceType, onEnter, onStay, onExit)
end

function LuaSkillCtrl:CallGetCircleSkillColliderByGrid(luaSkill, grid, radius, influenceType, onEnter, onStay, onExit)
  return self.cluaSkillCtrl:CallGetCircleSkillCollider(luaSkill.caster, grid, radius, influenceType, false, onEnter, onStay, onExit)
end

function LuaSkillCtrl:CallGetSectorSkillCollider(luaSkill, startGrid, radius, arcAngleRange, endTarget, influenceType, isManulMode, onEnter, onStay, onExit)
  return self.cluaSkillCtrl:CallGetSectorSkillCollider(luaSkill.caster, startGrid, radius, arcAngleRange, endTarget, influenceType, isManulMode, onEnter, onStay, onExit)
end

function LuaSkillCtrl:CallGetRectSkillCollider(luaSkill, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
  return self.cluaSkillCtrl:CallGetRectSkillCollider(luaSkill.caster, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
end

function LuaSkillCtrl:GetOnCollisionRole(collider)
  return self.cluaSkillCtrl:GetOnCollisionRole(collider)
end

function LuaSkillCtrl:CallGetRoleCurDir(role)
  return role:GetRoleForwardAngle()
end

function LuaSkillCtrl:CallStartLocalScale(role, scale, duration)
  if role.lsObject.gameObject ~= nil then
    role.lsObject:StartLocalScale(scale, duration)
  end
end

function LuaSkillCtrl:CallAddRoleProperty(role, attrName, value, attrType)
  role:AddRoleProperty(attrName, value, attrType)
end

function LuaSkillCtrl:FindEmptyGrid(ruleFunc)
  return self.cluaSkillCtrl:CallFindEmptyGrid(ruleFunc)
end

function LuaSkillCtrl:FindEmptyGridWithinRange(role, range)
  return self.cluaSkillCtrl:CallFindEmptyGridWithinRange(role, range)
end

function LuaSkillCtrl:FindEmptyGridsWithinRange(x, y, range, isFurthest)
  return self.cluaSkillCtrl:CallFindEmptyGridsWithinRange(x, y, range, isFurthest)
end

function LuaSkillCtrl:FindRandomEmptyGridsWithinRange(x, y, range, isFurthest)
  local gridList = self.cluaSkillCtrl:CallFindEmptyGridsWithinRange(x, y, range, isFurthest)
  if gridList ~= nil and gridList.Count > 0 then
    local randNum = self:CallRange(0, gridList.Count - 1)
    return gridList[randNum]
  end
  return nil
end

function LuaSkillCtrl:FindAllRolesWithinRange(target, range, isIncludeSelf)
  return self.cluaSkillCtrl:FindAllRolesWithinRange(target, range, isIncludeSelf)
end

function LuaSkillCtrl:FindAllGridsWithinRange(target, range, isIncludeSelf)
  return self.cluaSkillCtrl:FindAllGridsWithinRange(target, range, isIncludeSelf)
end

function LuaSkillCtrl:FindEmptyGridAroundRole(role)
  return self.cluaSkillCtrl:CallFindEmptyGridAroundRole(role)
end

function LuaSkillCtrl:FindEmptyGridWithoutEfcGridAroundRole(role)
  return self.cluaSkillCtrl:CallFindEmptyGridWithoutEfcGridAroundRole(role)
end

function LuaSkillCtrl:FindEmptyGridWithoutEfcGridOfTypeAroundRole(role, abandonGridType)
  return self.cluaSkillCtrl:CallFindEmptyGridWithoutEfcGridAroundRole(role, abandonGridType)
end

function LuaSkillCtrl:FindEmptyGridWithoutEfcGridAroundGrid(x, y)
  return self.cluaSkillCtrl:CallFindEmptyGridWithoutEfcGridAroundGrid(x, y)
end

function LuaSkillCtrl:FindGridsWithoutEfcGridAroundGrid(x, y)
  return self.cluaSkillCtrl:CallFindGridsWithoutEfcGridAroundGrid(x, y)
end

function LuaSkillCtrl:FindRoleRightEmptyGrid(role, range)
  return self.cluaSkillCtrl:CallFindRoleRightEmptyGrid(role, range or 1)
end

function LuaSkillCtrl:FindRoleLeftEmptyGrid(role, range)
  local coord = role.curCoord
  local ofsCoord = cs_Vector2Point(-1, 0)
  for i = 0, range - 1 do
    coord = coord + ofsCoord
    if 0 > coord.x then
      return nil
    end
    local battleGridData = self.battleCtrl:TryGetGridData(coord)
    if battleGridData ~= nil and battleGridData:IsGridEmpty() then
      return battleGridData
    end
  end
  return nil
end

function LuaSkillCtrl:FindRolesAroundRole(role)
  return self.cluaSkillCtrl:FindRolesAroundRole(role)
end

function LuaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
  return self.cluaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
end

function LuaSkillCtrl:CallFindEmptyGridNearest(role)
  return self.cluaSkillCtrl:CallFindEmptyGridNearest(role)
end

function LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
  return self.cluaSkillCtrl:CallFindGridMostRolesArounded(belongNum, false)
end

function LuaSkillCtrl:GetRoleBehindGrid(role)
  local grid_dict = self:FindEmptyGridsWithinRange(role.x, role.y, 1)
  if grid_dict == nil or grid_dict.Count <= 0 then
    return nil
  end
  local resultGrid
  local maxAngle = 0
  local lsObject = role.lsObject
  local CS_TrueSync = CS.TrueSync
  for j = 0, grid_dict.Count - 1 do
    local grid = grid_dict[j]
    local tempdir = CS_TrueSync.TSVector3.Subtract(grid.fixLogicPosition, lsObject.localPosition).normalized
    local qua = CS_TrueSync.TSQuaternion.LookRotation(tempdir)
    if qua.eulerAngles ~= lsObject.localRotation.eulerAngles then
      local angle = CS_TrueSync.TSQuaternion.Angle(qua, lsObject.localRotation):AsInt()
      if 110 < angle and maxAngle < angle then
        resultGrid = grid
        maxAngle = angle
      end
    end
  end
  return resultGrid
end

function LuaSkillCtrl:SetRolePos(grid, role, isIgnoreTrigger)
  if self.IsInTDBattle then
    return
  end
  if role == nil then
    return
  end
  role.lsObject:ResetBeatBack()
  local lastCoordX = role.x
  local lastCoordY = role.y
  self.cluaSkillCtrl:SetPosForce(grid, role)
  if isIgnoreTrigger ~= true then
    self:BroadcastLuaTrigger(eSkillLuaTrigger.OnRoleSplash, role, grid, lastCoordX, lastCoordY)
  end
end

function LuaSkillCtrl:PreSetRolePos(grid, role)
  self.cluaSkillCtrl:PreSetPosForce(grid, role)
end

function LuaSkillCtrl:PreSetRolePosWithCoord(x, y, role)
  return self.cluaSkillCtrl:PreSetPosForceWithCoord(x, y, role)
end

function LuaSkillCtrl:CanclePreSetPos(role)
  self.cluaSkillCtrl:CanclePreSetPos(role)
end

function LuaSkillCtrl:MoveRoleToTarget(luaSkill, grid, role, isOneStep, onfinish)
  local onFinish
  if onfinish ~= nil then
    onFinish = BindCallback(luaSkill, onfinish, grid, role)
  end
  if self.IsInTDBattle then
    onFinish(role.x, role.y)
    return
  end
  self.cluaSkillCtrl:MoveToTarget(grid, role, isOneStep, onFinish)
end

function LuaSkillCtrl:CallPhaseMove(luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier, isIgnoreTrigger)
  notBeSelectBuffId = notBeSelectBuffId or 0
  buffTier = buffTier or 1
  if self.IsInTDBattle then
    if 0 < notBeSelectBuffId or self:RoleContainsBuffFeature(role, eBuffFeatureType.BeatBack) then
      self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
    end
    return
  end
  local lastCoordX = role.x
  local lastCoordY = role.y
  self.cluaSkillCtrl:CallPhaseMove(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
  if isIgnoreTrigger ~= true then
    self:BroadcastOnStartPhaseMove(role, luaSkill, lastCoordX, lastCoordY)
  end
end

function LuaSkillCtrl:InInPhaseMove(role)
  if role == nil or role.lsObject == nil then
    return false
  end
  return role.lsObject.IsStartPhaseMove
end

function LuaSkillCtrl:CallPhaseMoveWithoutTurn(luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier, isIgnoreTrigger)
  notBeSelectBuffId = notBeSelectBuffId or 0
  buffTier = buffTier or 1
  if self.IsInTDBattle or self:RoleContainsBuffFeature(role, eBuffFeatureType.BeatBack) then
    if 0 < notBeSelectBuffId then
      self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
    end
    return
  end
  local lastCoordX = role.x
  local lastCoordY = role.y
  self.cluaSkillCtrl:CallPhaseMoveWithoutTurn(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
  if isIgnoreTrigger ~= true then
    self:BroadcastOnStartPhaseMove(role, luaSkill, lastCoordX, lastCoordY)
  end
end

function LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier, isIgnoreTrigger)
  notBeSelectBuffId = notBeSelectBuffId or 0
  buffTier = buffTier or 1
  if self.IsInTDBattle or self:RoleContainsBuffFeature(role, eBuffFeatureType.BeatBack) then
    if 0 < notBeSelectBuffId then
      self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
    end
    return
  end
  local lastCoordX = role.x
  local lastCoordY = role.y
  self.cluaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
  if isIgnoreTrigger ~= true then
    self:BroadcastOnStartPhaseMove(role, luaSkill, lastCoordX, lastCoordY)
  end
end

function LuaSkillCtrl:BroadcastOnStartPhaseMove(role, luaSkill, lastCoordX, lastCoordY)
  if not self:InInPhaseMove(role) then
    return
  end
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, role, luaSkill, lastCoordX, lastCoordY)
end

function LuaSkillCtrl:IsRoleAdjacent(roleA, roleB)
  return self.cluaSkillCtrl:IsRoleAdjacent(roleA, roleB)
end

function LuaSkillCtrl:GetGridsDistance(x1, y1, x2, y2)
  return self.cluaSkillCtrl:GetGridsDistance(x1, y1, x2, y2)
end

function LuaSkillCtrl:GetRoleGridsDistance(role1, role2)
  return self.cluaSkillCtrl:GetGridsDistance(role1, role2)
end

function LuaSkillCtrl:CallFindEmptyGridWithinRangeAndMostClosed(x, y, range, role)
  return self.cluaSkillCtrl:CallFindEmptyGridClosedToTarget(x, y, role)
end

function LuaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(x, y, role)
  return self.cluaSkillCtrl:CallFindEmptyGridClosedToTargetInRange(x, y, role)
end

function LuaSkillCtrl:GetMapBorder()
  return self.cluaSkillCtrl:GetMapBorder()
end

function LuaSkillCtrl:GetMapCenterPos()
  local vector2 = self.cluaSkillCtrl:GetMapBorder()
  local posX = math.ceil((vector2.x - 1) * 0.5)
  local posY = math.ceil((vector2.y - 1) * 0.5)
  local gridData = self.battleCtrl:TryGetGridData(posX, posY)
  return gridData
end

function LuaSkillCtrl:GetFurthestRightEmptyGrid(x, y)
  return self.cluaSkillCtrl:GetFurthestRightEmptyGrid(x, y)
end

function LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(belongNum)
  return self.cluaSkillCtrl:CallFindGridMostRolesArounded(belongNum, true)
end

function LuaSkillCtrl:CallFindXLineGrid(grid, range)
  return self.cluaSkillCtrl:CallFindXLineGrid(grid, range)
end

function LuaSkillCtrl:CallFindGridsInDirSectorRange(role, targetRole)
  if not self:IsRoleAdjacent(role, targetRole) then
    return nil
  end
  local grids = {}
  local arg = role.y & 1
  local neighborGrids = HexagonNeighbor[arg]
  local deltaX = targetRole.x - role.x
  local deltaY = targetRole.y - role.y
  for i = 1, 6 do
    local coordData = neighborGrids[i]
    if coordData.x == deltaX and coordData.y == deltaY then
      local csGrid = self:GetGridWithRole(targetRole)
      table.insert(grids, csGrid)
      local preIndex = i - 1
      if preIndex < 1 then
        preIndex = 6
      end
      coordData = neighborGrids[preIndex]
      csGrid = self:GetGridWithPos(role.x + coordData.x, role.y + coordData.y)
      if csGrid ~= nil then
        table.insert(grids, csGrid)
      end
      local nextIndex = i + 1
      if 6 < nextIndex then
        nextIndex = 1
      end
      coordData = neighborGrids[nextIndex]
      csGrid = self:GetGridWithPos(role.x + coordData.x, role.y + coordData.y)
      if csGrid ~= nil then
        table.insert(grids, csGrid)
      end
      return grids
    end
  end
  return grids
end

function LuaSkillCtrl:FindAllGridsWithUnityRange(pos, range)
  local grids = {}
  local borderX = self.battleCtrl.battleFieldData.mapSizeXCount - 1
  local borderY = self.battleCtrl.battleFieldData.mapSizeYCount - 1
  for y = 0, borderY do
    local arg = y & 1
    local curRow = borderX - arg
    for x = 0, curRow do
      local gridData = self.battleCtrl:TryGetGridData(x, y)
      local titlePos = gridData.fixLogicPosition
      local titleRadius = 0.5
      local sumRadius = range + titleRadius
      local sqrRadius = sumRadius * sumRadius
      local sqrDistance = (pos.x - titlePos.x) * (pos.x - titlePos.x) + (pos.y - titlePos.z) * (pos.y - titlePos.z)
      if sqrRadius > sqrDistance:AsFloat() then
        table.insert(grids, gridData)
      end
    end
  end
  return grids
end

function LuaSkillCtrl:GetRandomGrid()
  local mapBoardX = self:GetMapBorder().x - 1
  local mapBoardY = self:GetMapBorder().y - 1
  local curX = self:CallRange(0, mapBoardX)
  local curY = self:CallRange(0, mapBoardY)
  local tempBool = curY & 1
  if tempBool == 1 and curX == mapBoardX then
    curX = curX - 1
  end
  local gridData = self:GetGridWithPos(curX, curY)
  return gridData
end

function LuaSkillCtrl:CallFindFurthestGridInDirRangeWithoutRole(startX, startY, targetX, targetY, range)
  local dist = self:GetGridsDistance(startX, startY, targetX, targetY)
  if 1 < dist or dist <= 0 then
    return nil
  end
  local deltaX = targetX - startX
  local deltaY = targetY - startY
  local arg = startY & 1
  local dirIndex = self:GetHexagonNeighborIndexForCoord(deltaX, deltaY, arg)
  local mapBoardX = self:GetMapBorder().x - 1
  local mapBoardY = self:GetMapBorder().y - 1
  local curY = targetY
  local curX = targetX
  range = range or -1
  local rangeStep = range
  if range == -1 then
    rangeStep = 1
  end
  local grid = self:GetGridWithPos(curX, curY)
  local lastGrid = grid
  while mapBoardX >= curX and 0 <= curX and mapBoardY >= curY and 0 <= curY and 0 < rangeStep do
    lastGrid = grid
    local arg = curY & 1
    local _deltaDta = HexagonNeighbor[arg][dirIndex + 1]
    curY = curY + _deltaDta.y
    curX = curX + _deltaDta.x
    grid = self:GetGridWithPos(curX, curY)
    if -1 < range then
      rangeStep = rangeStep - 1
    end
    if grid == nil or grid.role ~= nil then
      grid = lastGrid
    end
  end
  return grid
end

function LuaSkillCtrl:CallFindFurthestGridInDirRangeWithoutObstacle(startX, startY, targetX, targetY, range)
  local dist = self:GetGridsDistance(startX, startY, targetX, targetY)
  if 1 < dist or dist <= 0 then
    return nil
  end
  local deltaX = targetX - startX
  local deltaY = targetY - startY
  local arg = startY & 1
  local dirIndex = self:GetHexagonNeighborIndexForCoord(deltaX, deltaY, arg)
  local mapBoardX = self:GetMapBorder().x - 1
  local mapBoardY = self:GetMapBorder().y - 1
  local curY = targetY
  local curX = targetX
  range = range or -1
  local rangeStep = range
  if range == -1 then
    rangeStep = 1
  end
  local grid = self:GetGridWithPos(curX, curY)
  local lastGrid = grid
  while mapBoardX >= curX and 0 <= curX and mapBoardY >= curY and 0 <= curY and 0 < rangeStep do
    lastGrid = grid
    local arg = curY & 1
    local _deltaDta = HexagonNeighbor[arg][dirIndex + 1]
    curY = curY + _deltaDta.y
    curX = curX + _deltaDta.x
    grid = self:GetGridWithPos(curX, curY)
    if -1 < range then
      rangeStep = rangeStep - 1
    end
    if grid == nil or grid.role ~= nil and self:IsObstacle(grid.role) then
      grid = lastGrid
    end
  end
  return grid
end

function LuaSkillCtrl:GetHexagonNeighborIndexForCoord(ofsX, ofsY, colArg)
  local pos = ofsX + 1 << 16 | ofsY + 1
  return CoordNeighbor[colArg][pos]
end

function LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  local role = self.cluaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role == nil then
    return nil, nil
  end
  if role.skill_intensity > role.pow then
    return role, role.skill_intensity
  else
    return role, role.pow
  end
end

function LuaSkillCtrl:PlaySkillCv(roleId)
  if ControllerManager == nil then
    return nil
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.ultSkill, nil, roleId)
  return cvCtr:PlayCv(roleId, voiceId)
end

function LuaSkillCtrl:PlayAuSource(role, audioId, completeAction)
  if role.auSource ~= nil then
    return role.auSource:PlayAudioById(audioId, completeAction)
  end
end

function LuaSkillCtrl:PlayAuHit(luaSkill, target)
  if self.IsInVerify or target.auSource == nil or luaSkill.cskill == nil then
    return nil
  end
  local skillId = luaSkill.cskill.dataId
  local skillCfg = ConfigData.battle_skill[skillId]
  if skillCfg == nil then
    error("cant get the skill cfg,id" .. tostring(skillId))
    return nil
  end
  if skillCfg.hit_skill_type <= 0 then
    return nil
  end
  local hitType
  if target.recordTable ~= nil then
    hitType = target.recordTable[eHitAuRecordHint]
  end
  if hitType == nil then
    local resId = target.resSrcId
    local resCfg = ConfigData.resource_model[resId]
    if resCfg == nil then
      error("cant get the resource_model cfg,id" .. tostring(resId))
      return nil
    end
    hitType = resCfg.hit_target_type
  end
  if hitType == nil or hitType <= 0 then
    return nil
  end
  return AudioManager:PlayHitSelectorAudio(target.auSource, skillCfg.hit_skill_type, hitType)
end

function LuaSkillCtrl:SetRoleHitAudioHint(role, eHitAuRoleType)
  if role == nil or role.recordTable == nil then
    return
  end
  role.recordTable[eHitAuRecordHint] = eHitAuRoleType
end

function LuaSkillCtrl:StopAudioByBack(audio)
  if AudioManager == nil or audio == nil then
    return
  end
  AudioManager:StopAudioByBack(audio)
end

function LuaSkillCtrl:GetEfcGridWithPos(x, y)
  return self.battleCtrl.EfcGridController:GetEffectGrid(x, y)
end

function LuaSkillCtrl:GetRoleEfcGrid(role)
  return self.cluaSkillCtrl:GetRoleEfcGrid(role)
end

function LuaSkillCtrl:GetNearestEfcGrid(role, gridId)
  return self.cluaSkillCtrl:GetNearestEfcGrid(role, gridId)
end

function LuaSkillCtrl:GetNearestEmptyEfcGrid(role, gridId)
  return self.cluaSkillCtrl:GetNearestEfcEmptyGrid(role, gridId)
end

function LuaSkillCtrl:FindEmptyEfcGrid()
  return self.cluaSkillCtrl:FindEmptyEfcGrid()
end

function LuaSkillCtrl:CallCreateEfcGrid(x, y, gridId)
  local coord = BattleUtil.XYCoord2Pos(x, y)
  local effectGrid
  if not self.IsInVerify then
    effectGrid = DynEffectGrid.New(coord, gridId)
  else
    effectGrid = self.cluaSkillCtrl:CreateDynEfcGridDataInVerify(coord, x, y, gridId)
  end
  local grid = self.battleCtrl.EfcGridController:AddEffectGridInBattle(effectGrid)
  if grid ~= nil then
    self:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddEfcGrid, grid)
  end
  return grid
end

function LuaSkillCtrl:CallGetTotalEfcGridCount()
  return self.battleCtrl.EfcGridController:GetAllActiveGridCount()
end

function LuaSkillCtrl:CallGetTotalEfcGrid()
  return self.battleCtrl.EfcGridController:GetGridList()
end

function LuaSkillCtrl:CallLoseAllGridEffect()
  local grids = self.battleCtrl.EfcGridController:GetGridList()
  if grids ~= nil and grids.Count > 0 then
    for i = grids.Count - 1, 0, -1 do
      grids[i]:GridLoseEffect()
    end
  end
end

function LuaSkillCtrl:GetRoleInBattle(isHero, index)
  local role
  if isHero then
    role = self.battleCtrl.PlayerTeamController.battleOriginRoleList[index]
  else
    role = self.battleCtrl.EnemyTeamController.battleOriginRoleList[index]
  end
  if role.isDead then
    role = nil
  end
  return role
end

function LuaSkillCtrl:CallDoodad(sender, targetRole)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnDoodad, sender, targetRole)
end

function LuaSkillCtrl:CallChipSuitInvoke(sender, targetRole)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnChipSuitInvoke, sender, targetRole)
end

function LuaSkillCtrl:CallHurtPool(luaSkill, typeId, posX, posY)
  self:BroadcastLuaTrigger(eSkillLuaTrigger.CallHurtPool, luaSkill, typeId, posX, posY)
end

function LuaSkillCtrl:RegisterLuaTrigger(luaTriggerId, action, priority)
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return
  end
  if type(priority) ~= "number" then
    priority = nil
  end
  self.luaTrigger:AddListener(luaTriggerId, action, priority)
end

function LuaSkillCtrl:UnRegisterLuaTrigger(luaTriggerId, action)
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return
  end
  self.luaTrigger:RemoveListener(luaTriggerId, action)
end

function LuaSkillCtrl:UnRegisterLuaTriggerById(luaTriggerId)
  if self.luaTrigger == nil then
    return
  end
  if luaTriggerId ~= nil then
    self.luaTrigger:RemoveListenerByType(luaTriggerId)
  end
end

function LuaSkillCtrl:RemoveAllLuaTrigger()
  if self.luaTrigger ~= nil then
    self.luaTrigger:Clear()
    self.luaTrigger = nil
  end
end

function LuaSkillCtrl:BroadcastLuaTrigger(luaTriggerId, ...)
  if self.luaTrigger == nil or luaTriggerId == nil then
    return
  end
  self.luaTrigger:Broadcast(luaTriggerId, ...)
end

function LuaSkillCtrl:StartShowSkillDurationTime(luaSkill, time)
  if self.IsInVerify then
    return
  end
  self.cluaSkillCtrl:StartShowSkillDurationTime(luaSkill.caster, luaSkill.cskill, time)
end

function LuaSkillCtrl:StopShowSkillDurationTime(luaSkill)
  if self.IsInVerify then
    return
  end
  self.cluaSkillCtrl:StopShowSkillDurationTime(luaSkill.caster)
end

function LuaSkillCtrl:SetGameScoreAcitve(typeId, active)
  MsgCenter:Broadcast(eMsgEventId.ChangeBattleScoreActive, typeId, active)
end

function LuaSkillCtrl:SetGameScoreValue(typeId, value)
  MsgCenter:Broadcast(eMsgEventId.ChangeBattleScoreValue, typeId, value)
end

function LuaSkillCtrl:SetFinalScoreValue(id, value)
  self.cluaSkillCtrl:SetFinalGamePlayScore(id, value)
end

function LuaSkillCtrl:ForceEndBattle(isWin)
  self.cluaSkillCtrl:ForceEndBattle(isWin)
end

function LuaSkillCtrl:BattlegroundDrop(Vector2Point, num, fxName)
  if self.IsInVerify then
    return
  end
  self.battleCtrl.PropDropController:RandomDrop(Vector2Point, num, fxName)
end

function LuaSkillCtrl:RecordLimitTime(limitTime)
  limitTime = limitTime + self.battleCtrl.frame
  self.cluaSkillCtrl:RecordLimitTime(limitTime)
end

function LuaSkillCtrl:IsFixedObstacle(role)
  return role.belongNum == eBattleRoleBelong.neutral and role.career == 1 and role.intensity == 0
end

function LuaSkillCtrl:IsObstacle(role)
  return role.belongNum == eBattleRoleBelong.neutral and role.intensity == 0
end

function LuaSkillCtrl:CallRedisplayInSkillInputCtrl(role)
  if role.hp <= 0 or role.unableSelect or role:IsUnselectAbleExceptSameBelong(eBattleRoleBelong.player) then
    return
  end
  local playerCtrl = self.battleCtrl.PlayerController
  if playerCtrl == nil then
    return
  end
  local skillInputCtrl = playerCtrl.battleSkillInputController
  if not (skillInputCtrl ~= nil and skillInputCtrl:IsActive()) or skillInputCtrl.selectfirstType ~= cs_SkillSelectType.eSingleAndSelectRole then
    return
  end
  skillInputCtrl:CancleWaitSelectRoleTiles()
  skillInputCtrl:CancleLastSelectTiles()
  skillInputCtrl:CheckAndSetSelectRolesTiles()
end

function LuaSkillCtrl:ShowCounting(role, count, maxCount)
  role:ShowCounting(count, maxCount)
end

function LuaSkillCtrl:UpdateCounting(role, count)
  role:UpdateCounting(count)
end

function LuaSkillCtrl:HideCounting(role)
  role:HideCounting()
end

function LuaSkillCtrl:SetCountingColor(role, r, g, b, a)
  role:SetCountingColor(r, g, b, a)
end

function LuaSkillCtrl:CreateTDMonster(luaDynMonster, luaSkill, followTarget)
  return self.cluaSkillCtrl:CreateTDMonster(luaDynMonster, luaSkill.cskill, followTarget)
end

function LuaSkillCtrl:CallSetPlayerTowerMpIncreasedSpeed(value)
  self.cluaSkillCtrl:CallSetPlayerTowerMpIncreasedSpeed(value)
end

function LuaSkillCtrl:GetPlayerTowerMpIncreasedSpeed()
  return self.cluaSkillCtrl:GetPlayerTowerMpIncreasedSpeed()
end

function LuaSkillCtrl:AddPlayerTowerMp(value)
  return self.cluaSkillCtrl:AddPlayerTowerMp(value)
end

function LuaSkillCtrl:GetPlayerTowerMp()
  return self.cluaSkillCtrl:GetPlayerTowerMp()
end

function LuaSkillCtrl:GetAllWaitToCasteMonsters()
  return self.battleCtrl.CurBattleMapCfg.waitToCasterMonsterList
end

function LuaSkillCtrl:GetAllPlayerDungeonRoles()
  return self.cluaSkillCtrl:CallGetAllPlayerDungeonRoles()
end

function LuaSkillCtrl:GetRoleTag(role)
  return role:GetRoleTag()
end

function LuaSkillCtrl:GetTDMosterDieReward(role)
  return role:GetTDRoleDieReward()
end

function LuaSkillCtrl:GetTowerCastCost(role)
  return role:GetTDRoleCastCost()
end

function LuaSkillCtrl:ResetTowerCastCd(role, value)
  local tdCharaComp = role:GetTowerCharaComponent()
  if tdCharaComp == nil then
    warn("不是防御塔！！！")
    return nil
  end
  tdCharaComp.towerCastCd = value
end

function LuaSkillCtrl:GetTowerCastCd(role)
  return role:GetTDRoleCastCd()
end

function LuaSkillCtrl:LoadOffTowerCharacter(role, needReturnCost)
  local tdCharaComp = role:GetTowerCharaComponent()
  if tdCharaComp == nil then
    warn("不是防御塔，不能进行下塔操作")
    return
  end
  if not tdCharaComp.isOnStage then
    return
  end
  self.cluaSkillCtrl:CallLoadOffTowerInBattle(role)
  tdCharaComp:OnTowerLoadOff()
  tdCharaComp:SetTowerCharacterOnStage(false)
  local cost = needReturnCost and tdCharaComp.towerCastCost or 0
  MsgCenter:Broadcast(eMsgEventId.TDUpdateTowerList, role, false, cost)
  role:RefreshFromLuaData()
end

function LuaSkillCtrl:MakeUpSceneData()
  if self.hasCheckSceneRoot then
    return
  end
  self.hasCheckSceneRoot = true
  if self.IsInVerify then
    return
  end
  if self.battleCtrl == nil then
    self.battleCtrl = cs_BattleManager.Instance.CurBattleController
  end
  local borderX = self.battleCtrl.battleFieldData.mapSizeXCount - 1
  local borderY = self.battleCtrl.battleFieldData.mapSizeYCount - 1
  self.sceneRoot = CS.UnityEngine.GameObject.Find(ConfigData.buildinConfig.DynamicSceneRoot)
  if IsNull(self.sceneRoot) then
    return
  end
  self.sceneDummyExist = true
  self.sceneDummyDict = {}
  local rowCount = borderX + 1
  for y = 0, borderY do
    local arg = y & 1
    local curRow = borderX - arg
    for x = 0, curRow do
      if self.sceneDummyDict[x] == nil then
        self.sceneDummyDict[x] = {}
      end
      local index = y * rowCount - y // 2 - arg + borderX - x
      self.sceneDummyDict[x][y] = index
    end
  end
end

function LuaSkillCtrl:ChangeSceneMap(x, y)
  if self.IsInVerify then
    return
  end
  if not self.sceneDummyExist then
    return
  end
  local tempYs = self.sceneDummyDict[x]
  if tempYs == nil then
    return
  end
  local index = tempYs[y]
  if index == nil then
    return
  end
  local tempTrans = self.sceneRoot.transform:GetChild(index)
  if self.sceneTween ~= nil then
    self.sceneTween:Kill(true)
    self.sceneTween = nil
  end
  self.sceneTween = cs_DoTween.To(function()
    return tempTrans
  end, function(x)
    tempTrans:SetLocalZ(x)
  end, ConfigData.buildinConfig.DynamicSceneMapHeight, ConfigData.buildinConfig.DynamicSceneMapDuration)
end

function LuaSkillCtrl:RecoverSceneMap(x, y)
  if self.IsInVerify then
    return
  end
  if not self.sceneDummyExist then
    return
  end
  local tempYs = self.sceneDummyDict[x]
  if tempYs == nil then
    return
  end
  local index = tempYs[y]
  if index == nil then
    return
  end
  local tempTrans = self.sceneRoot.transform:GetChild(index)
  tempTrans:SetLocalZ(0)
end

function LuaSkillCtrl:ClearSpecialSceneData()
  self.sceneRoot = nil
  self.sceneDummyDict = nil
  self.hasCheckSceneRoot = false
  self.sceneDummyExist = false
  if self.sceneTween ~= nil then
    self.sceneTween:Kill(true)
    self.sceneTween = nil
  end
end

function LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  local key = ConfigData.buildinConfig.EquipmentSummonerKey
  if role == nil or role.recordTable == nil then
    return nil
  end
  return role.recordTable[key]
end

function LuaSkillCtrl:CheckReletionWithRoleBelong(roleA, roleB, reletionArg)
  local curReletion = eBelongReletionSetting[roleA.belongNum][roleB.belongNum]
  return 0 < curReletion & reletionArg
end

function LuaSkillCtrl:GetRelationBelong(srcBelong, belongNumTag)
  return eBelongNumRelation[srcBelong][belongNumTag]
end

function LuaSkillCtrl:GetDynPlayerChipCountAndLevelSum()
  local player = self.battleCtrl.PlayerController.playerData
  if player == nil then
    return 0, 0
  end
  if not self.IsInVerify then
    return player:GetChipCountAndLevelSum()
  else
    return player.chipDataCount, player.chipLevelSum
  end
end

function LuaSkillCtrl:GetEquipmentSummonerOrHostEntity(role)
  local key = ConfigData.buildinConfig.EquipmentSummonerKey
  if role == nil or role.recordTable == nil then
    return nil
  end
  return role.recordTable[key]
end

function LuaSkillCtrl:PreCreatSummoner(luaSkill, monsterId)
  return self.cluaSkillCtrl:PreCreatSummoner(luaSkill.cskill, monsterId)
end

function LuaSkillCtrl:GetCasterSkinId(role)
  if role == nil then
    return -1
  end
  if self.IsInVerify then
    return self.cluaSkillCtrl:GetHeroRoleSkinID(role.roleDataId)
  else
    local dynPlayer = BattleUtil.GetCurDynPlayer(true)
    if dynPlayer == nil then
      return nil
    end
    return dynPlayer:GetRoleSkinId(role.roleDataId)
  end
end

function LuaSkillCtrl:CallTSVec2Angle(vec2A, vec2B)
  local angel = self.cluaSkillCtrl:CallTSVec2Angle(vec2A, vec2B)
  return angel
end

function LuaSkillCtrl:IsOriginalSkill(luaSkill)
  if luaSkill == nil or luaSkill.cskill == nil then
    return false
  end
  return luaSkill.cskill.skillType == eBattleSkillLogicType.Original
end

function LuaSkillCtrl:EffectSetCountValue(effect, value)
  if self.IsInVerify or effect == nil then
    return
  end
  effect:SetCountValue(value)
end

function LuaSkillCtrl:EffectSetCountActive(effect, index, active)
  if self.IsInVerify then
    return
  end
  effect:SetCountActive(index, active)
end

function LuaSkillCtrl:EffectSetCountAllActive(effect, active)
  if self.IsInVerify then
    return
  end
  effect:SetCountAllActive(active)
end

function LuaSkillCtrl:SetGameObjectActive(lsObject, active)
  if self.IsInVerify then
    return
  end
  local trans = lsObject.transform
  if trans ~= nil then
    if active then
      trans.localScale = Vector3.Temp(1, 1, 1)
    else
      trans.localScale = Vector3.Temp(0, 0, 0)
    end
  end
end

function LuaSkillCtrl:StartAvgWithPauseGame(chapterName, avgId, completeFunc)
  if self.IsInVerify then
    return
  end
  if string.IsNullOrEmpty(chapterName) and avgId == nil then
    error("Avg chapterName IsNullOrEmpty:" .. tostring(chapterName) .. " " .. tostring(avgId))
    return
  end
  if ControllerManager == nil then
    return
  end
  local battleCtrl = cs_BattleManager.Instance.CurBattleController
  battleCtrl:TrySetBattlePause(true)
  ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(chapterName, avgId, function()
    if battleCtrl.fsm:IsCurrentState(CS.eBattleState.End) then
      Time.unity_time.timeScale = 1
    else
      battleCtrl:TrySetBattlePause(false)
    end
    if completeFunc ~= nil then
      completeFunc()
    end
  end)
end

function LuaSkillCtrl:ChangeRoleBody(role, resName, moveSpeed, resID)
  self.cluaSkillCtrl:ChangeRoleBody(role, resName, moveSpeed, resID)
  if self.IsInBrotatoBattle and not self.IsInVerify then
    local customMoveCtrl = BattleUtil.GetCustoMoveCtrl()
    if customMoveCtrl ~= nil then
      customMoveCtrl:ChangeEntityAnimator()
    end
  end
  role.lsObject.localRotation = role.lsObject.localRotation
  role.lsObject:SetPositionForce(role.lsObject.localPosition)
end

function LuaSkillCtrl:RecoverRoleBody(role)
  self.cluaSkillCtrl:RecoverRoleBody(role)
  role.lsObject.localRotation = role.lsObject.localRotation
  role.lsObject:SetPositionForce(role.lsObject.localPosition)
end

function LuaSkillCtrl:DisactiveCharacter(role, killer, battleSkill, isNeedBroadcast, deadTime)
  if deadTime == nil then
    deadTime = 0
  end
  self.cluaSkillCtrl:DisactiveCharacter(role, killer, battleSkill, isNeedBroadcast, deadTime)
end

function LuaSkillCtrl:ResurrectionCharacter(role, Vector2Point, hpPer, skillCD, isNeedCapture)
  if isNeedCapture == nil then
    isNeedCapture = false
  end
  self.cluaSkillCtrl:ResurrectionCharacter(role, Vector2Point, hpPer, skillCD, isNeedCapture)
end

function LuaSkillCtrl:ChangeRoleHeadInfoWorldOffest(role, worldOffestY)
  if not self.IsInVerify then
    self.cluaSkillCtrl:ChangeRoleHeadInfoWorldOffest(role, worldOffestY)
  end
end

function LuaSkillCtrl:CreateMonster(luaDynMonster, luaSkill, followTarget)
  return self.cluaSkillCtrl:CreateMonster(luaDynMonster, luaSkill.cskill, followTarget)
end

function LuaSkillCtrl:GetCacheGold()
  if self.IsInVerify then
    return self.cluaSkillCtrl:GetCacheGoldNumForVertiy()
  elseif ExplorationManager:IsInExploration() then
    return ExplorationManager:GetDynPlayer():GetMoneyCount()
  elseif BattleDungeonManager:InBattleDungeon() then
    return BattleDungeonManager:GetDungeonDynPlayer():GetMoneyCount()
  elseif WarChessManager:GetIsInWarChess() then
    return WarChessManager:GetWCCoinNum()
  end
  return 0
end

function LuaSkillCtrl:AddCacheGold(goldCount)
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      ExplorationManager:GetDynPlayer():AddCacheMoneyCount(goldCount)
    elseif BattleDungeonManager:InBattleDungeon() then
      BattleDungeonManager:GetDungeonDynPlayer():AddCacheMoneyCount(goldCount)
    elseif WarChessManager:GetIsInWarChess() then
      WarChessManager:AddWCCacheCoinNum(goldCount)
    end
  end
  local curGoldCount = self:GetCacheGold()
  self:SetFinalScoreValue(eScoreType.cacheGoldNum, curGoldCount)
end

function LuaSkillCtrl:SetCacheGold(goldCount)
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      ExplorationManager:GetDynPlayer():SetCacheMoneyCount(goldCount)
    elseif BattleDungeonManager:InBattleDungeon() then
      BattleDungeonManager:GetDungeonDynPlayer():SetCacheMoneyCount(goldCount)
    elseif WarChessManager:GetIsInWarChess() then
      WarChessManager:SetWCCacheCoinNum(goldCount)
    end
  end
  self:SetFinalScoreValue(eScoreType.cacheGoldNum, goldCount)
end

function LuaSkillCtrl:GetNotPickupGold(goldCount)
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      return ExplorationManager:GetDynPlayer():GetNotPickupMoneyCount()
    elseif BattleDungeonManager:InBattleDungeon() then
      return BattleDungeonManager:GetDungeonDynPlayer():GetNotPickupMoneyCount()
    elseif WarChessManager:GetIsInWarChess() then
    end
  end
  return 0
end

function LuaSkillCtrl:SetNotPickupGold(goldCount)
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      ExplorationManager:GetDynPlayer():SetNotPickupMoneyCount(goldCount)
    elseif BattleDungeonManager:InBattleDungeon() then
      BattleDungeonManager:GetDungeonDynPlayer():SetNotPickupMoneyCount(goldCount)
    elseif WarChessManager:GetIsInWarChess() then
    end
  end
  self:SetFinalScoreValue(eScoreType.notPickupGoldNum, goldCount)
end

function LuaSkillCtrl:AddDropBuff(dropBuffId)
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      ExplorationManager:GetDynPlayer():AddDropBuff(dropBuffId)
    elseif BattleDungeonManager:InBattleDungeon() then
      BattleDungeonManager:GetDungeonDynPlayer():AddDropBuff(dropBuffId)
    elseif WarChessManager:GetIsInWarChess() then
    end
  end
end

function LuaSkillCtrl:CleanDropBuff()
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      ExplorationManager:GetDynPlayer():ClearDropBuffs()
    elseif BattleDungeonManager:InBattleDungeon() then
      BattleDungeonManager:GetDungeonDynPlayer():ClearDropBuffs()
    elseif WarChessManager:GetIsInWarChess() then
    end
  end
end

function LuaSkillCtrl:AddChipChipConsumeSkill(skillId, skillLevel, bindHeroId)
  if not self.IsInVerify then
    if self.DynBattleSkill == nil then
      self.DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
    end
    local skillData = self.DynBattleSkill.New(skillId, skillLevel, eBattleSkillLogicType.ChipConsume)
    local dynPlayer = BattleUtil.GetCurDynPlayer(true)
    if dynPlayer ~= nil then
      dynPlayer:AddItemSkill(skillData)
      local dynHero = dynPlayer.heroDic[bindHeroId]
      if dynHero ~= nil then
        dynHero:AddBindItemSkillData(skillData)
      end
    end
  else
    self.cluaSkillCtrl:AddItemSkill(skillId, skillLevel, eBattleSkillLogicType.ChipConsume)
  end
end

function LuaSkillCtrl:AddExtraAddSkill(skillId, skillLevel)
  if not self.IsInVerify then
    if self.DynBattleSkill == nil then
      self.DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
    end
    local skillData = self.DynBattleSkill.New(skillId, skillLevel, eBattleSkillLogicType.ExtraAdd)
    local dynPlayer = BattleUtil.GetCurDynPlayer(true)
    if dynPlayer ~= nil then
      dynPlayer:AddItemSkill(skillData)
    end
  else
    self.cluaSkillCtrl:AddItemSkill(skillId, skillLevel, eBattleSkillLogicType.ExtraAdd)
  end
end

function LuaSkillCtrl:OnBattleStartWithTriggerHandle(battleSkill, isMidWay)
  self.cluaSkillCtrl:OnBattleStartWithTriggerHandle(battleSkill, isMidWay)
end

function LuaSkillCtrl:ShowCameraEffectFunction(effectSceenID, ...)
  if self.IsInVerify then
    return
  end
  if self.CameraEffectUtil == nil then
    self.CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
  end
  self.CameraEffectUtil.CameraEffectFunction[effectSceenID](...)
end

function LuaSkillCtrl:CloseCameraEffectFunction(effectSceenID, needDispose)
  if self.IsInVerify then
    return
  end
  if self.CameraEffectUtil == nil then
    self.CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
  end
  self.CameraEffectUtil.CloseCameraEffectFunction[effectSceenID](needDispose)
end

function LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(effectSceenID, priority)
  if self.LastCameraEffectId == effectSceenID then
    return
  end
  local isCanCreatEffect = false
  if self.LastCameraEffectId == nil then
    isCanCreatEffect = true
  elseif priority >= self.LastCameraEffectPriority then
    self:CloseCameraEffectFunction(self.LastCameraEffectId)
    isCanCreatEffect = true
  end
  if isCanCreatEffect then
    self:ShowCameraEffectFunction(effectSceenID)
    self.LastCameraEffectId = effectSceenID
    self.LastCameraEffectPriority = priority
  end
end

function LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(effectSceenID)
  if self.LastCameraEffectId == effectSceenID then
    self:CloseCameraEffectFunction(self.LastCameraEffectId)
    self.LastCameraEffectId = nil
    self.LastCameraEffectPriority = nil
  end
end

function LuaSkillCtrl:GetAllUltSkills()
  return self.battleCtrl.PlayerController.charaEntityUltSkills
end

function LuaSkillCtrl:BattleFailButContionueEP()
  if not self.IsInVerify then
    if ExplorationManager:IsInExploration() then
      local epCtrl = ExplorationManager.epCtrl
      if epCtrl ~= nil then
        epCtrl.battleCtrl:TryFinishBattleButNotFailure()
      end
    else
      error("BattleFailButContionueEP only can used in EP!")
    end
  else
    self.cluaSkillCtrl:ForceEndBattle(true)
  end
end

function LuaSkillCtrl:GetRoleBattleSkillWithRoleEntity(role, skillDataId)
  return self.cluaSkillCtrl:GetRoleBattleSkillWithRoleEntity(role, skillDataId)
end

function LuaSkillCtrl:GetRoleBattleSkillWithDataId(roleDataId, skillDataId)
  return self.cluaSkillCtrl:GetRoleBattleSkillWithDataId(roleDataId, skillDataId)
end

function LuaSkillCtrl:GetOriginRole(roleDataId)
  return self.cluaSkillCtrl:GetOriginRole(roleDataId)
end

function LuaSkillCtrl:SetConsumeSkillItemCanUse(skillId, bVlaue, tipId)
  if not self.IsInVerify then
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window == nil then
      return
    end
    window.playerSkillNode:SetConsumeSkillItemCanUse(skillId, bVlaue, tipId)
  end
end

function LuaSkillCtrl:DestoryBindSummonerGo()
  if self.IsInVerify then
    return
  end
  local playerList = self:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = playerList.Count - 1, 0, -1 do
    local role = playerList[i]
    if role.roleType == 1 then
      local bindSummoner = self:GetEquipmentSummonerOrHostEntity(role)
      if bindSummoner ~= nil then
        self.battleCtrl.PlayerTeamController:RemoveBattleRole(bindSummoner, true)
        bindSummoner.lsObject:DestroyGameOject()
      end
    end
  end
end

function LuaSkillCtrl:ReqStartBattleForSkill()
  local mp = self.battleCtrl.PlayerController.CurMp:AsInt()
  local hMp = self:GetUltHMp()
  local playerList = self:GetSelectTeamRoles(eBattleRoleBelong.player)
  local buffs = {}
  for i = 0, playerList.Count - 1 do
    local role = playerList[i]
    local buffList = role:GetAllBuffsWithRestartRetain()
    for j = 0, buffList.Count - 1 do
      local battleBuff = buffList[j]
      local buff = {}
      buff.buffId = battleBuff.dataId
      buff.dataId = role.roleDataId
      buff.num = battleBuff.tier
      table.insert(buffs, buff)
    end
  end
  self.battleCtrl.LuaBattleCtrl:ReqRestartBattleForSkill(self.battleCtrl, buffs, mp, hMp)
end

function LuaSkillCtrl:GetReStartSkillCacheInfo()
  local dynPlayer = BattleUtil.GetCurDynPlayer(true)
  if dynPlayer ~= nil then
    return dynPlayer:GetRestartSkillPlayerDync()
  end
end

function LuaSkillCtrl:SetRoleUltSkillUseable(roleDataId, bValue)
  if not self.IsInVerify then
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window ~= nil then
      window:DisableHeroUltSkill(roleDataId, bValue)
    end
  end
end

function LuaSkillCtrl:CallPlayEpTipDialogInBattle(epTipId)
  if self.IsInVerify then
    return
  end
  local epTalkCfg = ConfigData.exploration_tip[epTipId]
  if epTalkCfg == nil then
    error("epTalkCfg error,epTipId:" .. tostring(epTipId))
    return
  end
  local battleCtrl = CS.BattleManager.Instance.CurBattleController
  local win = UIManager:ShowWindow(UIWindowTypeID.EPTalkDialog)
  if win == nil then
    error("CallPlayEpTipDialogInBattle error")
    return
  end
  win:StartTalkDialogInBattle(epTalkCfg, function()
    battleCtrl:TrySetBattlePause(true)
  end, function()
    if battleCtrl.fsm:IsCurrentState(CS.eBattleState.End) then
      Time.unity_time.timeScale = 1
    else
      battleCtrl:TrySetBattlePause(false)
    end
  end)
end

function LuaSkillCtrl:CreatCacheTable(arg, table)
  local result = table[arg]
  if table == nil then
    table = {}
  end
  if table[arg] == nil then
    result = {arg}
    table[arg] = result
  end
  return result
end

function LuaSkillCtrl:SetRoleVisible(role, bValue)
  if not self.IsInVerify then
    role.battleRoleView:SetRoleVisible(bValue)
  end
end

function LuaSkillCtrl:OnDelete()
  if file ~= nil then
    file:write("战斗结束，持续帧数： " .. tostring(self.battleCtrl.frame) .. [[






]])
    file:close()
  end
  self:RemoveAllLuaTrigger()
  self:ClearSpecialSceneData()
  self.IsInBrotatoBattle = false
  self.DynSummonerAdapter = nil
  self.IsInTDBattle = false
  self.cUltSkillCtrl = nil
  self.battleCtrl = nil
  self.cluaSkillCtrl = nil
  self.guardProEntity = nil
  self.logicTimerCtrl:StopAllTimer()
  self.DynBattleSkill = nil
  self.CameraEffectUtil = nil
end

function LuaSkillCtrl:CallRecoverHeal(role, luaSkill, hpvalue, powkvalue, time, effectId)
  if role == nil or role.hp < 0 then
    return
  end
  local curFrame = self.battleCtrl.frame
  local nextFrame = role.recordTable.RecoverHealTime
  if nextFrame == nil then
    nextFrame = 0
  end
  if curFrame < nextFrame then
    return
  end
  if powkvalue == 0 or powkvalue == nil then
    powkvalue = 250
  end
  if hpvalue == 0 or hpvalue == nil then
    hpvalue = 50
  end
  local healNum = (role.pow * powkvalue + role.maxHp * hpvalue) // 1000
  self:CallHeal(healNum, luaSkill, role)
  if effectId ~= nil then
    self:CallEffect(role, effectId, luaSkill)
  else
    self:CallEffect(role, 107605, luaSkill)
  end
  role.recordTable.RecoverHealTime = curFrame + time
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnRecoverHeal, role)
end

return LuaSkillCtrl
