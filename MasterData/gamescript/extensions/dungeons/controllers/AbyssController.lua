local AbyssController = NewClass("AbyssController", BaseController)

function AbyssController:OnInit()
end

function AbyssController:OnReset()
end

function AbyssController:ReqAbyssData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenAbyss", function(data)
    Logger.Info("========== 请求融蚀深渊数据成功 ==========\n", table.tostring(data or {}, 4))
    AbyssExtModel.Instance:UpdateAbyssDataByServer(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求融蚀深渊数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function AbyssController:ReqAbyssTeamDetail(stageGroupTid, isExtra, callback)
  if not stageGroupTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenAbyssTeamDetail", function(data)
    Logger.Info("========== 请求融蚀深渊队伍详情成功 ==========\n", table.tostring(data or {}))
    data.hasDetail = true
    AbyssExtModel.Instance:UpdateTeamDataByServer(stageGroupTid, data, isExtra)
    if callback then
      callback(stageGroupTid)
    end
  end, function(data)
    Logger.Info("========== 请求融蚀深渊队伍详情失败 ==========\n", table.tostring(data or {}))
  end, stageGroupTid, isExtra)
end

function AbyssController:ReqGainAbyssPrize(index)
  if not index then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainAbyssPrize", function(data)
    Logger.Info("========== 请求获取融蚀深渊奖励成功 ==========\n", table.tostring(data or {}))
    AbyssExtModel.Instance:UpdateScorePrize(index, CommonDefine.TaskCommonState.Finish)
  end, function(data)
    Logger.Info("========== 请求获取融蚀深渊奖励失败 ==========\n", table.tostring(data or {}))
  end, index)
end

function AbyssController:ReqGainPrizeAll(indexList, callback)
  if not indexList then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainPrizeAll", function(data)
    Logger.Info("========== 请求一键获取融蚀深渊奖励成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求一键获取融蚀深渊奖励失败 ==========\n", table.tostring(data or {}))
  end, indexList)
end

local RESET_NORMAL = 1
local RESET_EXTRA = 2
local RESET_ALL = 3

function AbyssController:ReqResetAbyssChallenge(stageGroupTid, isExtra, callback)
  if not stageGroupTid then
    return
  end
  local resetType = RESET_ALL
  if nil == isExtra then
    resetType = RESET_ALL
  else
    resetType = isExtra and RESET_EXTRA or RESET_NORMAL
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnResetAbyssStageGroup", function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战成功 ==========\n", table.tostring(data or {}))
    self:ReqAbyssData()
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战失败 ==========\n", table.tostring(data or {}))
  end, stageGroupTid, resetType)
end

function AbyssController:ReqAbyssRankData(seasonTid, startIndex, count, onSuccess, onFail)
  startIndex = startIndex or 1
  count = count or AbyssExtModel.Instance:GetRankReqInterval()
  RankController.Instance:QueryRankData(RankDefine.RankType.AbyssChallenge, seasonTid, startIndex, count, onSuccess, nil, onFail)
end

function AbyssController:ReqAbyssRankRecordData(playerUid, activityTid, stageGroupTid)
  local paramTable = {
    Type = "abyssChallenge",
    param = {activityTid = activityTid, stageGroupId = stageGroupTid}
  }
  SocialDataUtils.ReqQueryFacadeFields(playerUid, paramTable)
end

function AbyssController:GetBattleFinishJumper(stageGroupTid)
  if not stageGroupTid then
    return
  end
  return function()
    AbyssController.Instance:ReqAbyssData(function()
      AbyssExtModel.Instance:GetStageGroupTidList()
      local stageGroupData = AbyssExtModel.Instance:GetStageGroupData(stageGroupTid)
      UIManager.Instance:Reopen(Urls.AbyssChallengeView, stageGroupData)
    end)
  end
end

function AbyssController:OpenAbyssRankView(activityTid)
  UIManager.Instance:Reopen(Urls.AbyssRankView, activityTid)
end

return AbyssController
