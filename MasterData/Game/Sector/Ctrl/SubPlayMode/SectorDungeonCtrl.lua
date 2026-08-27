local base = require("Game.Sector.Ctrl.SubPlayMode.base.SectorPlayModeCtrlBase")
local SectorDungeonCtrl = class("SectorDungeonCtrl", base)
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local cs_MessageCommon = CS.MessageCommon
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")
local SectorPlayModeData = require("Game.Sector.Data.SectorPlayModeData")
local eSectorState = require("Game.Sector.Enum.eSectorState")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
SectorDungeonCtrl.uiType4ungeonType = {
  [eDungeonEnum.eDungeonType.fragDungeon] = UIWindowTypeID.FriendShipPlotDungeon,
  [eDungeonEnum.eDungeonType.matDungeon] = UIWindowTypeID.MaterialDungeon,
  [eDungeonEnum.eDungeonType.ATHDungeon] = UIWindowTypeID.ATHDungeon
}

function SectorDungeonCtrl:ctor(sectorCtrl)
  self.dungeonTypeDataDic = {}
  self:CheckAndSetDungeonUnlock()
end

function SectorDungeonCtrl:CheckAndSetDungeonUnlock()
  for dungeonType, systemFuncId in pairs(eDungeonEnum.systemFunctionID4DungeonType) do
    local dungeonTypeData
    if self.dungeonTypeDataDic[dungeonType] ~= nil then
      dungeonTypeData = self.dungeonTypeDataDic[dungeonType]
      dungeonTypeData:Update()
    else
      dungeonTypeData = DungeonTypeData.CreateDungeonTypeData(dungeonType)
      self.dungeonTypeDataDic[dungeonType] = dungeonTypeData
    end
  end
end

function SectorDungeonCtrl:IsSectorPlayModeUnlock(entranceType)
  local dunTypeData = self:GetDungeonTypeDataByEmtranceType(entranceType)
  return dunTypeData:GetDungeonTypeIsUnlock(), dunTypeData:GetDungeonTypeUnlockDes()
end

function SectorDungeonCtrl:OpenSectorPlayMode(entranceType, jumpTargetTypeId, openCallback)
  local dunType = eSectorEntrance.entranceType2DungeonType[entranceType]
  self:OpenSectorDungeon(dunType, jumpTargetTypeId, openCallback)
end

function SectorDungeonCtrl:GetSectorPlayModeShowData(entranceType, dunCfg)
  local dunTypeData = self:GetDungeonTypeDataByEmtranceType(entranceType)
  local isHaveMultReward = dunTypeData:GetIsDungeonTypeHaveMultReward()
  local isDouble = dunTypeData:GetDungeonTypeMultRewardIsOnlyDouble()
  local modeData = SectorPlayModeData.New()
  if entranceType == eSectorEntrance.eEntranceType.frageDungeon then
    local leftNum, totaleLimit, playedNums = dunTypeData:GetDungeonTypePlayLeftLimitNum()
    modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.todayLeftTime, {
      tostring(leftNum),
      tostring(totaleLimit)
    })
  elseif entranceType == eSectorEntrance.eEntranceType.resDungeon then
  elseif entranceType == eSectorEntrance.eEntranceType.athDungeon then
    local remainNum, totalNum = self:__GetAthDunBuffRemaindTime(dunTypeData)
    if remainNum ~= nil then
      modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.thisWeekBuffTime, {
        tostring(remainNum),
        tostring(totalNum)
      })
    end
  end
  if PlayerDataCenter.dailySignInData:IsHaveCard(EPeriodicCardType.StaminaCard) and dunCfg.privilege_id > 0 then
    modeData:SetSPMUp()
    local infoStr = PlayerDataCenter.dailySignInData:GetMonthCardPrivilegeDes(dunCfg.privilege_id)
    modeData:SetSPMUpInfo(infoStr)
  end
  if isHaveMultReward then
    if isDouble then
      modeData:SetSPMTagInfo(eSectorEntrance.stateTagType.double)
    else
      modeData:SetSPMTagInfo(eSectorEntrance.stateTagType.buffButNotDouble)
    end
  end
  return modeData
end

function SectorDungeonCtrl:GetPlayModeReddotNode(entranceType)
  local dunType = eSectorEntrance.entranceType2DungeonType[entranceType]
  local ok, dotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun, dunType)
  return dotNode
end

function SectorDungeonCtrl:GetPlayModeReddotTypeAndNum(entranceType)
  local dunType = eSectorEntrance.entranceType2DungeonType[entranceType]
  local ok, dotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun, dunType)
  if ok then
    return true, dotNode:GetBlueDotCount()
  end
  return false, 0
end

function SectorDungeonCtrl:__GetAthDunBuffRemaindTime(dunTypeData)
  local remainNum = 0
  local totalNum = 0
  local dunTypeDic = {}
  local addSaveIdDic = {}
  for _, dungeonData in pairs(dunTypeData:GetDungeonDataList()) do
    local dunType = dungeonData:GetDungeonCfg().dungeon_type
    dunTypeDic[dunType] = true
  end
  for dunType, _ in pairs(dunTypeDic) do
    local dropId = ConfigData.battle_dungeon_period_drop.dgTypeDic[dunType]
    if dropId ~= nil then
      local dropCfg = ConfigData.battle_dungeon_period_drop[dropId]
      local numAdd = PlayerDataCenter.playerBonus:GetDungeonDropNumAdd(dropId)
      local useNum = ControllerManager:GetController(ControllerTypeId.TimePass):GetDungeonPeriodDropTimes(dropCfg.save_id)
      if not addSaveIdDic[dropCfg.save_id] then
        addSaveIdDic[dropCfg.save_id] = true
        remainNum = remainNum + (dropCfg.drop_times + numAdd - useNum)
        totalNum = totalNum + dropCfg.drop_times + numAdd
      end
    end
  end
  if totalNum <= 0 then
    return nil
  end
  return remainNum, totalNum
end

function SectorDungeonCtrl:GetDungeonTypeDataByEmtranceType(entranceType)
  local dunType = eSectorEntrance.entranceType2DungeonType[entranceType]
  return self.dungeonTypeDataDic[dunType]
end

function SectorDungeonCtrl:GetDungeonTypeDataByType(dunType)
  return self.dungeonTypeDataDic[dunType]
end

function SectorDungeonCtrl:OpenSectorDungeon(type, jumpTargetTypeId, openCallback)
  local dungeonTypeData = self.dungeonTypeDataDic[type]
  if dungeonTypeData == nil then
    self:CheckAndSetDungeonUnlock()
    dungeonTypeData = self.dungeonTypeDataDic[type]
  end
  if not dungeonTypeData:GetDungeonTypeIsUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(dungeonTypeData:GetDungeonTypeUnlockDes())
    return
  end
  local uiType = SectorDungeonCtrl.uiType4ungeonType[type]
  if uiType == nil then
    return
  end
  UIUtil.AddOneCover("EnterDungeon")
  UIManager:ShowWindowAsync(uiType, function(window)
    if window == nil then
      UIUtil.CloseOneCover("EnterFriendshipDungeon")
      return
    end
    self.sctCtrl:SetSctState(eSectorState.CorverSector)
    window:InitDungeonType(dungeonTypeData, jumpTargetTypeId, function(tohome)
      self.sctCtrl:SetSctState(eSectorState.InNotMainEntrance)
    end)
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.FragDungeonRefresh)
    UIUtil.CloseOneCover("EnterDungeon")
    if openCallback ~= nil then
      openCallback()
    end
  end)
end

function SectorDungeonCtrl.IsEntrancetypeDungeon(entranceType)
  return eSectorEntrance.entranceType2DungeonType[entranceType] ~= nil
end

function SectorDungeonCtrl:OnDelete()
end

return SectorDungeonCtrl
