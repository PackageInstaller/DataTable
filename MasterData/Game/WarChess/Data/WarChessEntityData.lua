local WarChessEntityData = class("WarChessEntityData")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local WCMonsterEntity = require("Game.WarChess.Entity.WCMonsterEntity")
local WCCommonEntity = require("Game.WarChess.Entity.WCCommonEntity")
local WarChessFXData = require("Game.WarChess.Data.WarChessFXData")
local WarChessConditionCheck = require("Game.WarChess.ConditionCheck.WarChessConditionCheck")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local WarChessSeasonUtil = require("Game.WarChessSeason.WarChessSeasonUtil")

function WarChessEntityData:ctor(BFId, worldLogicPos, unitCfg)
  self.unitCfg = unitCfg
  self.BFId = BFId
  self.worldLogicPos = worldLogicPos
  self.pos = Vector3.New(worldLogicPos.x, 0, worldLogicPos.y)
  self.isAlive = true
  self.__totalHp = 1
  self.__monsterBattleRoomId = nil
  self.__monsterDropIconList = nil
  self.__monsterRandomRotate = nil
  self.__entity = nil
  self.__FXDataDic = {}
  self.__headIconOverraidId = nil
  self.__alarmCfg = nil
  self.__symbioticId = nil
  self.__wantedMonster = nil
  local entityResCfg = ConfigData.warchess_entity_res[unitCfg.resId]
  if entityResCfg == nil then
    error(string.format("Cant get warchess_entity_res, id = %s", unitCfg.resId))
    return
  end
  self._entityResCfg = entityResCfg
  self:TryReGenWCMonsterHP(self.unitCfg.battleSystemData)
  self:__GenBattleRoomID()
  self:__GenDropIcons()
  self:SetEntityHeadIcon(self.unitCfg.unitUI)
  self:__GenAlarmCfg()
  self:UpdateWCEntityAddParam(self.unitCfg.ohtherParam)
  self:UpdateEntityInteractNumLimit()
end

function WarChessEntityData:InitWCEntity(notWait, bind)
  if self.unitCfg.cat == 1 then
    local entity = WCMonsterEntity.New(self)
    self.__entity = entity
  else
    local entity = WCCommonEntity.New(self)
    self.__entity = entity
  end
  return self.__entity:PreLoadModel(notWait, bind)
end

function WarChessEntityData:SetWCEntityUnitCfg(unit)
  self.unitCfg = unit
  self:__GenBattleRoomID()
  self:__GenDropIcons()
  self:SetEntityHeadIcon(self.unitCfg.unitUI)
  self:__GenAlarmCfg()
  self:UpdateWCEntityAddParam(self.unitCfg.ohtherParam)
  self:UpdateEntityInteractNumLimit()
end

function WarChessEntityData:SetNewPos(x, y)
  local oldLogPos = self.worldLogicPos
  self.worldLogicPos = Vector2.New(x, y)
  self.pos = Vector3.New(x, 0, y)
  self.__entity:WCEntitySetPos(self.pos, true, oldLogPos, self.worldLogicPos)
end

function WarChessEntityData:UpdateWCEntityAddParam(unitParam)
  if unitParam == nil then
    self.__symbioticId = nil
    self.__wantedMonster = nil
    self.__interactNum = nil
    return
  end
  if unitParam.symbiotic ~= nil and unitParam.symbiotic ~= 0 then
    self.__symbioticId = unitParam.symbiotic
  else
    self.__symbioticId = nil
  end
  self.__wantedMonster = unitParam.wantedMonster
  if unitParam.interactNum ~= self.__interactNum then
    self.__interactNum = unitParam.interactNum
  end
end

function WarChessEntityData:WCEntityGetParentGO()
  return self.__entity:WCEntityGetParentGO()
end

function WarChessEntityData:GetWCEntityBFId()
  return self.BFId
end

function WarChessEntityData:GetEntityLogicPos()
  return self.worldLogicPos
end

function WarChessEntityData:GetEntityShowPos()
  return self.__entity:WCEntityGetShowPos()
end

function WarChessEntityData:SetWCEntityIsAlive(bool)
  if bool == false and isGameDev then
    print(tostring(self.pos) .. "的entity死了")
  end
  self.isAlive = bool
end

function WarChessEntityData:GetWCEntityIsAlive()
  return self.isAlive
end

function WarChessEntityData:GetWCEntityCouldPass(isMonster)
  if not self:GetWCEntityIsAlive() then
    return true
  end
  if isMonster then
    return self:GetEntityIsMonster()
  end
  return false
end

function WarChessEntityData:GetResModelName()
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId ~= nil then
      local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
      if monsterGroupCfg == nil then
        error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
      else
        local monsterGroupId = monsterGroupCfg.team_id
        local monsterTeamList = ConfigData.warchess_monster_team_data[monsterGroupId]
        if monsterTeamList == nil then
          error("warchess_room_monster表怪物组ID不满足条件 >3000000 and <4000000 monsterGroupId:" .. tostring(monsterGroupId))
        elseif monsterTeamList[1] == nil then
          error("warchess_room_monster表怪物组 不存在一号怪物 monsterGroupId:" .. tostring(monsterGroupId))
        else
          local monsterId = monsterTeamList[1].monster_id
          local monsterCfg = ConfigData.monster[monsterId]
          if monsterCfg ~= nil then
            local resId = monsterCfg.src_id
            local specSign = monsterCfg.is_shadow
            local resCfg = ConfigData.resource_model[resId]
            local firstMonsterRes = resCfg.res_Name
            if isGameDev then
              print("monsterId:" .. tostring(monsterId) .. " battleRoomId:" .. tostring(battleRoomId))
            end
            return firstMonsterRes, specSign
          end
        end
      end
    end
  end
  return self._entityResCfg.prefeb
end

function WarChessEntityData:AutoAddFx()
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId == nil then
      return
    end
    local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
    if monsterGroupCfg == nil then
      error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
      return
    end
    local fxId = monsterGroupCfg.special_effect
    if fxId ~= nil and fxId ~= 0 then
      self:UpdateEntityMonsterFX(true, fxId)
      return
    end
  end
end

function WarChessEntityData:GetMonsterMatConfig()
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId == nil then
      return nil
    end
    local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
    if monsterGroupCfg == nil then
      error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
      return nil
    end
    return monsterGroupCfg.outline_enable, monsterGroupCfg.outline_color, monsterGroupCfg.outiline_hdr, monsterGroupCfg.outline_wider, monsterGroupCfg.outline_scale
  end
  return nil
end

function WarChessEntityData:GetIsEmptyEntity()
  return self._entityResCfg.is_effect
end

function WarChessEntityData:GetInteractShowOffset()
  return self._entityResCfg.height
end

function WarChessEntityData:GetEntityUnit()
  return self.unitCfg
end

function WarChessEntityData:GetEntityUnitId()
  return self.unitCfg.id
end

function WarChessEntityData:GetEntityInteractions()
  return self.unitCfg.interactions
end

function WarChessEntityData:GetEntityCouldInteract()
  if #self:GetEntityInteractions() < 1 then
    return false
  end
  local isHaveCouldUseOne = false
  for _, interaction in pairs(self:GetEntityInteractions()) do
    if WarChessConditionCheck.CheckGridConditionTree(self:GetEntityUnit(), interaction) then
      isHaveCouldUseOne = true
      break
    end
  end
  return isHaveCouldUseOne
end

function WarChessEntityData:GetEntityInteractionRange()
  return self.unitCfg.opRange
end

function WarChessEntityData:GetEntityIsMonster()
  return self._entityResCfg.is_monster
end

function WarChessEntityData:IsWCUnitMonster()
  return self:GetEntityIsMonster()
end

function WarChessEntityData:GetFirstEntityInertactWithCat(specificCat)
  for _, interactCfg in pairs(self.unitCfg.interactions) do
    if interactCfg.cat == specificCat then
      return interactCfg
    end
  end
  return nil
end

function WarChessEntityData:SaveEnitityAnimArg(nameHash, animaId)
  self.__saveAnimData = {nameHash = nameHash, animaId = animaId}
end

function WarChessEntityData:GetEnitityAnimArg()
  return self.__saveAnimData
end

function WarChessEntityData:PlayEntityAnimation(animaId, trigger, callback)
  if self._entityResCfg.is_monster then
    self.__entity:PlayWCMonsterAnimation(animaId, trigger, callback)
  else
    self.__entity:PlayWCEntityAnimation(animaId, trigger)
    if callback ~= nil then
      callback()
    end
  end
end

function WarChessEntityData:ReapplyEntityAnimation(saveAnim)
  if self._entityResCfg.is_monster then
  else
    self.__entity:SetWCEntityAnimation(saveAnim.nameHash, saveAnim.animaId)
  end
end

function WarChessEntityData:PlayMonsetAttackAnimation(teamData, callback)
  local attack_animation_play_rate = 1.5
  if self._entityResCfg.is_monster then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    local index = teamData:GetWCTeamIndex()
    local heroEntity = wcCtrl.teamCtrl:GetWCHeroEntity(index, nil, nil)
    local showPos = heroEntity:WCHeroEntityGetShowPos()
    self.__entity:PlayAttackAnimation(showPos, attack_animation_play_rate)
    self.__monsterAttackTimerId = TimerManager:StartTimer(1 / attack_animation_play_rate, function()
      self.__entity:EndPlayAttackAnimation()
      if callback ~= nil then
        callback()
      end
      self.__monsterAttackTimerId = nil
    end, self, true)
  elseif callback ~= nil then
    callback()
  end
end

function WarChessEntityData:GetFxDataDic()
  return self.__FXDataDic
end

function WarChessEntityData:GetBattleRoomID()
  return self.__monsterBattleRoomId
end

function WarChessEntityData:__GenBattleRoomID()
  if self.unitCfg == nil then
    self.__monsterBattleRoomId = nil
    return
  end
  local interactions = self.unitCfg.interactions
  if interactions == nil then
    self.__monsterBattleRoomId = nil
    return
  end
  for _, interactionCfg in pairs(interactions) do
    local triggers = interactionCfg.triggers
    if triggers ~= nil then
      for _, trigger in pairs(triggers) do
        if trigger.cat == eWarChessEnum.eTriggerConditionType.openSubSystem and trigger.pms ~= nil and trigger.pms[1] == proto_object_WarChessSystemCat.WarChessSystemCatBattleV2 then
          self.__monsterBattleRoomId = trigger.pms[2]
          self.__monsterBattleRoomId = WarChessSeasonUtil.TryReplaceBattleRoomId(self.__monsterBattleRoomId)
          return
        end
      end
    end
  end
  self.__monsterBattleRoomId = nil
end

function WarChessEntityData:__GenDropIcons()
  if self.__monsterBattleRoomId == nil then
    self.__monsterDropIconList = nil
    return
  end
  local monsterGroupCfg = ConfigData.warchess_room_monster[self.__monsterBattleRoomId]
  if monsterGroupCfg == nil then
    error("warchess_room_monster not exist battleRoomId:" .. tostring(self.__monsterBattleRoomId))
    self.__monsterDropIconList = nil
    return
  end
  self.__monsterDropIconList = monsterGroupCfg.dorp_icon
end

function WarChessEntityData:GetDropIcons()
  return self.__monsterDropIconList
end

function WarChessEntityData:__GenAlarmCfg()
  if self.unitCfg == nil then
    self.__alarmCfg = {isAlarm = false, distance = 0}
    return
  end
  if self:GetEntityIsMonster() then
    local triggers = self.unitCfg.triggers
    if triggers then
      for i, v in pairs(triggers) do
        if v.cond then
          local pms = WarChessHelper.DFSCondUnit(v.cond, eWarChessEnum.eConditionCat.checkIsHaveTeamInRange)
          if pms then
            self.__alarmCfg = {
              isAlarm = true,
              distance = pms[1]
            }
            return
          end
        end
      end
    end
  end
  self.__alarmCfg = {isAlarm = false, distance = 0}
end

function WarChessEntityData:GetAlarmCfg()
  return self.__alarmCfg
end

function WarChessEntityData:TryReGenWCMonsterHP(battleSystemData)
  if battleSystemData == nil then
    return
  end
  local hpDic = {}
  for uid, monsterMsg in pairs(battleSystemData.monsters) do
    if monsterMsg.stc.cat == ExplorationEnum.EnemyRoleType.monster then
      hpDic[uid] = monsterMsg.dyc.hpPer
    end
  end
  self:GenWCMonsterHP(hpDic)
end

function WarChessEntityData:GenWCMonsterHP(hpDic)
  local count = 0
  local totalRate = 0
  for _, hpPer in pairs(hpDic) do
    totalRate = totalRate + hpPer
    count = count + 1
  end
  self.__totalHp = totalRate / count / 10000
end

function WarChessEntityData:GetWCMonsterHP()
  if self.unitCfg.monsterHurtHpRecord ~= nil then
    return self.__totalHp - self.unitCfg.monsterHurtHpRecord / 10000
  end
  return self.__totalHp
end

function WarChessEntityData:GetWCUnitInterActIcon()
  local iconId = self._entityResCfg.icon
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId ~= nil then
      local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
      if monsterGroupCfg == nil then
        error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
      else
        iconId = monsterGroupCfg.icon
      end
    end
  end
  local iconCfg = ConfigData.warchess_Interact_icon[iconId]
  if iconCfg == nil then
    return nil
  end
  return iconCfg.icon_name
end

function WarChessEntityData:IsBossMonster()
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId == nil then
      return false
    end
    local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
    if monsterGroupCfg == nil then
      error("表怪物组不存在 battleRoomId:" .. tostring(battleRoomId))
      return false
    end
    return monsterGroupCfg.type == eWarChessEnum.BattleRoomTypeBoss
  end
  return false
end

function WarChessEntityData:GetWcEntitySuccessAudio()
  return self._entityResCfg.successAudio
end

function WarChessEntityData:GetWcEntityAniAudioDic()
  return self._entityResCfg.aniAudioDic
end

function WarChessEntityData:GetWCEntityRotate(isNum)
  if self.unitCfg == nil then
    return
  end
  local entityCatCfg = ConfigData.warchess_entity_cat[self.unitCfg.cat]
  if entityCatCfg ~= nil and entityCatCfg.rotate then
    local p = self.unitCfg.pms[entityCatCfg.rotate_index + 1]
    if p == nil then
      return
    end
    if isNum then
      return p
    end
    local rotate = WarChessHelper.rotateValue[p]
    return rotate
  end
end

function WarChessEntityData:GetWCEntityBindPoint(name)
  if self.__entity ~= nil then
    return self.__entity.entityGo:FindComponent(name, eUnityComponentID.Transform)
  end
end

function WarChessEntityData:CleanTimerAndTween()
  if self.__monsterAttackTimerId ~= nil then
    TimerManager:StopTimer(self.__monsterAttackTimerId)
    self.__monsterAttackTimerId = nil
  end
end

function WarChessEntityData:WCDeleteEntityGo()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  self:CleanTimerAndTween()
  wcCtrl.animaCtrl:RemoveSingleWCFX(self)
  if self.__entity ~= nil then
    self.__entity:Delete()
  end
end

function WarChessEntityData:GetCouldWalkLength()
  if not self:GetEntityIsMonster() then
    error("common entity not have move abiliity")
    return nil
  end
  local isOK, maxPathLength = WarChessHelper.CheckEnemyCanMove(self)
  if isOK then
    return maxPathLength
  end
  return nil
end

function WarChessEntityData:GetFxCount()
  if self.unitCfg.cat == eWarChessEnum.eEntityCat.counterDownChest then
    return self.unitCfg.pms[1]
  end
  return nil
end

function WarChessEntityData:SetEntityHeadIcon(unitUI)
  if unitUI == nil or unitUI.off == 0 then
    self.__headIconOverraidId = nil
    return
  end
  local headId = unitUI.id
  self.__headIconOverraidId = headId
end

function WarChessEntityData:GetEntityHeadIcon()
  return self.__headIconOverraidId
end

function WarChessEntityData:GetEntitySymbioticId()
  return self.__symbioticId
end

function WarChessEntityData:UpdateEntityMonsterFX(isAdd, fxid)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if fxid == nil or fxid == 0 then
    error("wanted fx not exist")
    return
  end
  if isAdd and self:GetFxDataDic()[fxid] == nil then
    wcCtrl.animaCtrl:UpdateClientFxData(self, fxid, true, false, true, nil)
  end
  if not isAdd and self:GetFxDataDic()[fxid] ~= nil then
    wcCtrl.animaCtrl:UpdateClientFxData(self, fxid, false, false, true, nil)
  end
end

function WarChessEntityData:UpdateEntityWantedMonsterFX()
  local fxid = ConfigData.game_config.wcWantedMonsterId
  self:UpdateEntityMonsterFX(self.__wantedMonster, fxid)
end

function WarChessEntityData:UpdateEntityInteractNumLimit()
  if self.__headIconOverraidId == nil or self.__headIconOverraidId >= 7 and self.__headIconOverraidId <= 11 then
    if 0 < (self.__interactNum or 0) then
      self:SetEntityHeadIcon({
        off = 1,
        id = self.__interactNum + 6
      })
    else
      self:SetEntityHeadIcon(nil)
    end
  end
end

function WarChessEntityData:GetEntityRandonRotate()
  if self:GetEntityIsMonster() then
    local battleRoomId = self:GetBattleRoomID()
    if battleRoomId == nil then
      return nil
    end
    local monsterGroupCfg = ConfigData.warchess_room_monster[battleRoomId]
    if monsterGroupCfg.random_rotate == nil or #monsterGroupCfg.random_rotate < 2 then
      return nil
    end
    local min = monsterGroupCfg.random_rotate[1]
    local max = monsterGroupCfg.random_rotate[2]
    if self.__monsterRandomRotate == nil then
      self.__monsterRandomRotate = WarChessHelper.GetRandomRotate(min, max)
    end
    return self.__monsterRandomRotate
  end
  return nil
end

function WarChessEntityData:WCEntityDataOnSceneUnload()
  self:CleanTimerAndTween()
  if self.__entity ~= nil then
    self.__entity:EntityOnSceneUnload()
  end
end

return WarChessEntityData
