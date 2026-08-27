local PlayerBonus = class("PlayerBonus")
require("Framework.Network.NetworkProto")
local PlayerBonusElem = require("Game.PlayerData.PlayerBonus.PlayerBonusElem")

function PlayerBonus:ctor()
  self.__broadcast = {}
  self.allBunosDataDic = {}
end

function PlayerBonus:InitPlayerBonus()
  for k, v in pairs(ConfigData.init_logic) do
    for i = 1, #v.logic do
      self:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_BaseSystem, 0, v.logic[i], v.para1[i], v.para2[i], v.para3[i])
    end
  end
end

function PlayerBonus:InstallPlayerBonus(module, id, ...)
  local uid = self:__GetUid(module, id)
  local logicTab = {
    ...
  }
  if #logicTab < 2 then
    error("InstallBonus: logic param error")
    return
  end
  local logic = logicTab[1]
  local bonusElem = self.allBunosDataDic[logic]
  if bonusElem == nil then
    bonusElem = PlayerBonusElem.New()
    bonusElem:InitPlayerBonusElem(logic)
    self.allBunosDataDic[logic] = bonusElem
  end
  bonusElem:InstallBonus(uid, logicTab[2], logicTab[3], logicTab[4])
end

function PlayerBonus:UninstallPlayerBonus(module, id, logic)
  local uid = self:__GetUid(module, id)
  local bonusElem = self.allBunosDataDic[logic]
  if bonusElem ~= nil then
    bonusElem:UninstallBonus(uid)
  end
end

function PlayerBonus:CheckPlayerBonusBroadcast()
  if self.__broadcast.warehouse then
    MsgCenter:Broadcast(eMsgEventId.UpdateWarehouse)
    PlayerDataCenter.allEffectorData:OnUpdateItemCeil()
    self.__broadcast.warehouse = false
  end
  PlayerDataCenter.allEffectorData:OnARGItemChnage()
  if self.__broadcast.AutoRecoverItem then
    MsgCenter:Broadcast(eMsgEventId.UpdateAutoRecoverItemSpeed)
    PlayerDataCenter.allEffectorData:OnUpdateItemGenerateSpeed()
    self.__broadcast.AutoRecoverItem = false
  end
end

function PlayerBonus:AddPlayerBonusBroadcast(name)
  self.__broadcast[name] = true
end

function PlayerBonus:__GetUid(module, id)
  return module << 32 | id
end

function PlayerBonus:GetWarehouseCapcity(id)
  local bonusElem = self.allBunosDataDic[eLogicType.ResourceLimit]
  if bonusElem == nil then
    return 0
  end
  local value = bonusElem.totalData[id]
  return value
end

function PlayerBonus:GetFactoryPipelieCount()
  local bonusElem = self.allBunosDataDic[eLogicType.FactoryPipelie]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetGlobalExpCeiling()
  local bonusElem = self.allBunosDataDic[eLogicType.GlobalExpCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetStaminaCeiling()
  local bonusElem = self.allBunosDataDic[eLogicType.StaminaCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetStaminaOutput()
  local bonusElem = self.allBunosDataDic[eLogicType.StaminaOutput]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetResOutputEfficiency(id)
  local bonusElem = self.allBunosDataDic[eLogicType.ResOutputEfficiency]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetBuildQueueCount(id)
  local bonusElem = self.allBunosDataDic[eLogicType.BuildQueue]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetBuildSpeed()
  local bonusElem = self.allBunosDataDic[eLogicType.BuildSpeed]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetGlobalExpRatio()
  local bonusElem = self.allBunosDataDic[eLogicType.GlobalExpRatio]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetOverClock(id)
  local bonusElem = self.allBunosDataDic[eLogicType.OverClock]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetOverClockFreeNum()
  local bonusElem = self.allBunosDataDic[eLogicType.OverClockFreeNum]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetFocusPointCeiling()
  local bonusElem = self.allBunosDataDic[eLogicType.FocusPointCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetBattleExpBonus()
  local bonusElem = self.allBunosDataDic[eLogicType.BattleExpBonus]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetDynSkillUpgrade()
  local bonusElem = self.allBunosDataDic[eLogicType.DynSkillUpgrade]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetPlayerAttr(id)
  local bonusElem = self.allBunosDataDic[eLogicType.DynPlayerAttrBuff]
  if bonusElem == nil then
    return 0
  end
  local value = bonusElem.totalData[id]
  return value
end

function PlayerBonus:GetDungeonMultReward(dungeonType, weekNum)
  local numAdd = self:GetDungeonRewardRateNumAdd(dungeonType, weekNum)
  local dgCfg = ConfigData.battle_dungeon_dungeon[dungeonType]
  if dgCfg ~= nil and dgCfg.share_twice > 0 then
    return self:GetDungeonShareMultReward(dgCfg.share_twice, weekNum)
  end
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonRewardRate]
  if bonusElem == nil then
    return 0 + numAdd
  end
  if dungeonType == nil then
    local dungeonTypeList = {}
    
    local function addDungeonFunc(bElem)
      for theDungeonType, weekNumDic in pairs(bElem.totalData) do
        if weekNumDic[weekNum] ~= nil then
          local rate = weekNumDic[weekNum] // 10000
          local num = weekNumDic[weekNum] % 10000
          local addNum = self:GetDungeonRewardRateNumAdd(theDungeonType, weekNum)
          if 0 < rate and 0 < num + addNum then
            table.insert(dungeonTypeList, theDungeonType)
          end
        end
      end
    end
    
    addDungeonFunc(bonusElem)
    bonusElem = self.allBunosDataDic[eLogicType.DungeonShareRewardRate]
    if bonusElem ~= nil then
      addDungeonFunc(bonusElem)
    end
    return 0 < #dungeonTypeList, dungeonTypeList
  end
  if bonusElem.totalData[dungeonType] == nil or bonusElem.totalData[dungeonType][weekNum] == nil then
    return 0 + numAdd
  end
  return bonusElem.totalData[dungeonType][weekNum] + numAdd
end

function PlayerBonus:GetDungeonShareMultReward(shareId, weekNum)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonShareRewardRate]
  if bonusElem == nil then
    return 0
  end
  if bonusElem.totalData[shareId] == nil or bonusElem.totalData[shareId][weekNum] == nil then
    return 0
  end
  return bonusElem.totalData[shareId][weekNum]
end

function PlayerBonus:IsDungeonHasMultReward(dungeonType)
  local dgCfg = ConfigData.battle_dungeon_dungeon[dungeonType]
  if dgCfg ~= nil and dgCfg.share_twice > 0 then
    return self:IsDungeonHasShareMultReward(dgCfg.share_twice)
  end
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonRewardRate]
  if bonusElem == nil then
    return false
  end
  if bonusElem.totalData[dungeonType] == nil then
    return false
  end
  for k, v in pairs(bonusElem.totalData[dungeonType]) do
    if 0 < v then
      return true
    end
  end
  return false
end

function PlayerBonus:IsDungeonHasShareMultReward(shareId)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonShareRewardRate]
  if bonusElem == nil then
    return false
  end
  if bonusElem.totalData[shareId] == nil then
    return false
  end
  for k, v in pairs(bonusElem.totalData[shareId]) do
    if 0 < v then
      return true
    end
  end
  return false
end

function PlayerBonus:GetDungeonMultRewardCurActivityIdDic(dungeonType)
  local dgCfg = ConfigData.battle_dungeon_dungeon[dungeonType]
  if dgCfg ~= nil and dgCfg.share_twice > 0 then
    return self:GetDungeonShareMultRewardCurActivityIdDic(dgCfg.share_twice)
  end
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonRewardRate]
  if bonusElem == nil then
    return table.emptytable
  end
  return bonusElem.dungeonActivityIdDic[dungeonType] or table.emptytable
end

function PlayerBonus:GetDungeonShareMultRewardCurActivityIdDic(shareId)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonShareRewardRate]
  if bonusElem == nil then
    return table.emptytable
  end
  return bonusElem.dungeonActivityIdDic[shareId] or table.emptytable
end

function PlayerBonus:GetHeroLevelCeiling()
  local bonusElem = self.allBunosDataDic[eLogicType.HeroLevelCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetAutoRecoverItemSpeed(id)
  local bonusElem = self.allBunosDataDic[eLogicType.AutoRecoverItem]
  if bonusElem == nil then
    return 0
  end
  local value = bonusElem.totalData[id]
  return value
end

function PlayerBonus:GetDungeonCountAdd(id)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonCountAdd]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetFactoryEfficiency(id)
  local bonusElem = self.allBunosDataDic[eLogicType.FactoryEfficiency]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetResOutputCeiling(id)
  local bonusElem = self.allBunosDataDic[eLogicType.ResOutputCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[id]
end

function PlayerBonus:GetChipCeilingCostReduce()
  local bonusElem = self.allBunosDataDic[eLogicType.ChipCeilingCostReduce]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetEpInitItemAddtion()
  local bonusElem = self.allBunosDataDic[eLogicType.EpInitItemAddtion]
  if bonusElem == nil then
    return nil
  end
  return bonusElem.totalData
end

function PlayerBonus:GetEpBattleRoomGetExr()
  local bonusElem = self.allBunosDataDic[eLogicType.EpBattleRoomGetExr]
  if bonusElem == nil then
    return nil
  end
  return bonusElem.totalData
end

function PlayerBonus:GetSupportCountAddtion()
  local bonusElem = self.allBunosDataDic[eLogicType.SupportCountAddtion]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetHpRecoverInRecoveryRoom()
  local bonusElem = self.allBunosDataDic[eLogicType.HpRecoverInRecoveryRoom]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:GetOverClockCountAddtion()
  local bonusElem = self.allBunosDataDic[eLogicType.OverClockCountAddtion]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

function PlayerBonus:Get_Activity_PointMultRate(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_PointMultRate]
  if bonusElem == nil then
    return table.emptytable
  end
  return bonusElem.totalData[actFrameId] or table.emptytable
end

function PlayerBonus:Get_Activity_Stamina2PointMultRate(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_Stamina2PointMultRate]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[actFrameId] or 0
end

function PlayerBonus:Get_Activity_EffiMultRate(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_EffiMultRate]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[actFrameId] or 0
end

function PlayerBonus:Get_Activity_ChipGroupLevel(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_ChipGroupLevel]
  if bonusElem == nil then
    return {}
  end
  return bonusElem.totalData[actFrameId] or {}
end

function PlayerBonus:Get_Activity_UnlockBuff(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_UnlockBuff]
  if bonusElem == nil then
    return {}
  end
  return bonusElem.totalData[actFrameId] or {}
end

function PlayerBonus:Get_Activity_DeleteBuff(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_DeleteBuff]
  if bonusElem == nil then
    return {}
  end
  return bonusElem.totalData[actFrameId] or {}
end

function PlayerBonus:Get_Activity_PowTestChipGroupLimitAdd(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_PowTestChipGroupLimitAdd]
  if bonusElem == nil then
    return {}
  end
  return bonusElem.totalData[actFrameId] or {}
end

function PlayerBonus:Get_Activity_ChipGroupCarryLimitAdd(actFrameId)
  local bonusElem = self.allBunosDataDic[eLogicType.Activity_ChipGroupCarryLimitAdd]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[actFrameId] or 0
end

function PlayerBonus:GetDungeonDropNumAdd(dropId)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonDropNumAdd]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[dropId]
end

function PlayerBonus:GetDungeonRewardRateNumAdd(dungeonType, weekNum)
  local bonusElem = self.allBunosDataDic[eLogicType.DungeonRewardRateNumAdd]
  if bonusElem == nil or bonusElem.totalData[dungeonType] == nil or bonusElem.totalData[dungeonType][weekNum] == nil then
    return 0
  end
  return bonusElem.totalData[dungeonType][weekNum]
end

function PlayerBonus:GetAllFriendshipAdd()
  local bonusElem = self.allBunosDataDic[eLogicType.AllFriendshipAdd]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData or 0
end

function PlayerBonus:GetResourceGoodBuyNumAdd(shopId, shelfId)
  local bonusElem = self.allBunosDataDic[eLogicType.ResourceGoodBuyNumAdd]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData[shopId] and bonusElem.totalData[shopId][shelfId] or 0
end

function PlayerBonus:GetCtgrCampBuff(camp, attriId)
  local bonusElem = self.allBunosDataDic[eLogicType.CampBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid, data in pairs(bonusElem.categoryDataDic) do
    if data[camp] ~= nil and data[camp][attriId] ~= nil then
      categoryValueDic[uid] = data[camp][attriId]
    end
  end
  return categoryValueDic
end

function PlayerBonus:GetCtgrCareerBuff(career, attriId)
  local bonusElem = self.allBunosDataDic[eLogicType.CareerBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid, data in pairs(bonusElem.categoryDataDic) do
    if data[career] ~= nil and data[career][attriId] ~= nil then
      categoryValueDic[uid] = data[career][attriId]
    end
  end
  return categoryValueDic
end

function PlayerBonus:GetCtgrAllHeroBuff(attriId)
  local bonusElem = self.allBunosDataDic[eLogicType.AllHeroBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid, data in pairs(bonusElem.categoryDataDic) do
    if data[attriId] ~= nil then
      categoryValueDic[uid] = data[attriId]
    end
  end
  return categoryValueDic
end

return PlayerBonus
