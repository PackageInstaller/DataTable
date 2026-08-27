local base = require("Game.Sector.Ctrl.SubPlayMode.base.SectorPlayModeCtrlBase")
local SectorDailyDungeonCtrl = class("SectorDailyDungeonCtrl", base)
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local SectorPlayModeData = require("Game.Sector.Data.SectorPlayModeData")
local eSectorState = require("Game.Sector.Enum.eSectorState")

function SectorDailyDungeonCtrl:ctor(sctCtrl)
end

function SectorDailyDungeonCtrl:IsSectorPlayModeUnlock(entranceType)
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon), FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon)
end

function SectorDailyDungeonCtrl:OpenSectorPlayMode(entranceType, openCurDiff, formBattleWin)
  local dailyDungeonTypeData = self.sctCtrl.dungeonCtrl:GetDungeonTypeDataByType(eDungeonEnum.eDungeonType.DailyDungeon)
  if dailyDungeonTypeData == nil then
    dailyDungeonTypeData = self.sctCtrl.dungeonCtrl:GetDungeonTypeDataByType(eDungeonEnum.eDungeonType.DailyDungeon)
  end
  local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
  dailyDgCtrl:ShowDailyDungeonMain(function()
    self.sctCtrl:SetSctState(eSectorState.CorverSector)
  end, function(tohome)
    self.sctCtrl:SetSctState(eSectorState.InNotMainEntrance)
  end, openCurDiff, formBattleWin)
end

function SectorDailyDungeonCtrl:GetSectorPlayModeShowData(entranceType)
  local modeData = SectorPlayModeData.New()
  local isFinish, inDungeon = PlayerDataCenter.dungeonDyncData:GetDailyDungeonState()
  local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleRefreshableDungeon, eDungeonEnum.eMatDungeonGroup.DailyDungeon)
  local netxRefreshTimeStamp
  if counterElem ~= nil then
    netxRefreshTimeStamp = counterElem.nextExpiredTm
  end
  if inDungeon then
    modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.underSearch)
  elseif isFinish then
    modeData:SetGetLeftTimeFunc(function()
      local remaindTime = netxRefreshTimeStamp - PlayerDataCenter.timestamp
      return remaindTime
    end)
  else
    modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.todayLeftTime, {
      tostring(1),
      tostring(1)
    })
  end
  local hasDouble = dungeonDyncElem:DgDyncIsHaveMultReward()
  if hasDouble then
    modeData:SetSPMTagInfo(eSectorEntrance.stateTagType.double)
  end
  return modeData
end

function SectorDailyDungeonCtrl:GetPlayModeReddotNode()
  return nil
end

function SectorDailyDungeonCtrl:GetPlayModeReddotTypeAndNum()
  local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local isNew = dungeonDyncElem.isDailyDungeonNew
  if isNew then
    return true, 1
  end
  return false, 0
end

function SectorDailyDungeonCtrl.IsEntrancetypeDaily(entranceType)
  return entranceType == eSectorEntrance.eEntranceType.daily
end

function SectorDailyDungeonCtrl:OnDelete()
end

return SectorDailyDungeonCtrl
