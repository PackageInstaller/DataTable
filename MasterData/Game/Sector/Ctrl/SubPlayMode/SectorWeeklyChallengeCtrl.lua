local base = require("Game.Sector.Ctrl.SubPlayMode.base.SectorPlayModeCtrlBase")
local SectorWeeklyChallengeCtrl = class("SectorWeeklyChallengeCtrl", base)
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local SectorPlayModeData = require("Game.Sector.Data.SectorPlayModeData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local TaskEnum = require("Game.Task.TaskEnum")
local eSectorState = require("Game.Sector.Enum.eSectorState")

function SectorWeeklyChallengeCtrl:ctor(sectorCtrl)
  if PlayerDataCenter.allWeeklyChallengeData:IsOutOfData() then
    NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail()
  end
end

function SectorWeeklyChallengeCtrl:IsSectorPlayModeUnlock(entranceType)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) then
    return false, FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  else
    return self:IsSectorPlayModeExist(entranceType)
  end
end

function SectorWeeklyChallengeCtrl:IsSectorPlayModeExist(entranceType)
  if CS.ClientConsts.IsAudit then
    return false
  end
  return PlayerDataCenter.allWeeklyChallengeData:IsExistChallenge()
end

function SectorWeeklyChallengeCtrl:OpenSectorPlayMode()
  local ishaveRpType, fakeType = PlayerDataCenter.allWeeklyChallengeData:GetWCIsHaveReplaceUIType()
  UIWindowGlobalConfig.fakeDailyChallenge = fakeType
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyChallenge, function(window)
    self.sctCtrl:SetSctState(eSectorState.CorverSector)
    window:InitWeeklyChallenge(function(tohome)
      self.sctCtrl:SetSctState(eSectorState.InNotMainEntrance)
    end)
    NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.weeklyChallenge)
    UIWindowGlobalConfig.fakeDailyChallenge = nil
  end, "fakeDailyChallenge")
end

function SectorWeeklyChallengeCtrl:GetSectorPlayModeShowData(entranceType)
  local modeData = SectorPlayModeData.New()
  local _, _, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  local netxRefreshTimeStamp
  local counterElem = PlayerDataCenter.allWeeklyChallengeData:GetCounterElem()
  if counterElem ~= nil then
    netxRefreshTimeStamp = counterElem.nextExpiredTm
  end
  if isInEp then
    modeData:SetSPMStateInfo(eSectorEntrance.stateInfoType.underSearch)
  else
    modeData:SetGetLeftTimeFunc(function()
      local remaindTime = netxRefreshTimeStamp - PlayerDataCenter.timestamp
      return remaindTime
    end)
  end
  local currentStage, totalStage, isReceiveAll, curStageFullPointNum
  local rewardItemList = {}
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  local peroidDatas = taskCtrl:GetDatas4Peroid(TaskEnum.eTaskPeriodType.WeeklyChallengeTask)
  local pointId = peroidDatas[1].stcData.activeId
  local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
  local totalActiveNum = 0
  local selectPeroidData
  isReceiveAll = false
  totalStage = #peroidDatas
  for i, data in ipairs(peroidDatas) do
    currentStage = i
    totalActiveNum = data.stcData.activeNum
    if currActiveNum < totalActiveNum then
      selectPeroidData = data
      break
    elseif i == #peroidDatas then
      currentStage = i
      selectPeroidData = data
      isReceiveAll = true
    end
  end
  curStageFullPointNum = selectPeroidData.stcData.activeNum
  for i, itemId in ipairs(selectPeroidData.stcData.rewardIds) do
    local itemCount = selectPeroidData.stcData.rewardNums[i]
    table.insert(rewardItemList, {itemId = itemId, itemNum = itemCount})
  end
  modeData:SetSPMRewardProgress(currentStage, totalStage, isReceiveAll, rewardItemList, curStageFullPointNum)
  return modeData
end

function SectorWeeklyChallengeCtrl.IsEntrancetypeWeekly(entranceType)
  return entranceType == eSectorEntrance.eEntranceType.weekly
end

function SectorWeeklyChallengeCtrl:OnDelete()
end

return SectorWeeklyChallengeCtrl
