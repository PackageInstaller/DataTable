local RankController = NewClass("RankController", BaseController)

function RankController:OnInit()
  self:OnReset()
end

function RankController:OnReset()
end

function RankController:OpenRankWorldBossView(viewData)
  UIManager.Instance:Reopen(Urls.RankWorldBossView, viewData)
end

function RankController:QueryRankData(rankType, subTid, startIndex, count, callback, options, onFail)
  if not startIndex or not count then
    return
  end
  options = options or {}
  local endIndex = startIndex + count - 1
  
  local function onSuccess(svrData)
    local tablePrintLayer = 5
    print("OnQueryRank rankType successful", rankType, table.tostring(svrData, tablePrintLayer))
    RankModel.Instance:ApplyQueryRankResult(rankType, subTid, startIndex, svrData, count)
    if callback then
      callback(svrData)
    end
  end
  
  local function onFailInner(err)
    Logger.Warn("OnQueryRank fail", table.tostring(err))
    if onFail then
      onFail(err)
    end
  end
  
  if options.awakerMap and options.awakerMap.dailyTeamAwaker and table.next(options.awakerMap.dailyTeamAwaker) then
    ProtoManager.Instance:ReqServer("GameRequest", "QueryRankFilter", onSuccess, onFailInner, rankType, startIndex, endIndex, options.extraId, options.awakerMap)
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnQueryRank", onSuccess, onFailInner, rankType, startIndex, endIndex, subTid)
end

function RankController:QueryRankInfoBatch(reqParamList, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "QueryRankInfo", function(svrData)
    Logger.Debug("QueryRankInfo Success", table.tostring(svrData))
    for _, param in ipairs(reqParamList) do
      local rankType = param.type
      local entry = svrData[rankType]
      if entry then
        local subTid = entry.extraId and 0 ~= entry.extraId and entry.extraId or nil
        RankModel.Instance:ApplyOpenRankData(rankType, subTid, entry)
      end
    end
    if callback then
      callback(svrData)
    end
  end, function(err)
    Logger.Warn("QueryRankInfo fail", table.tostring(err))
  end, reqParamList)
end

function RankController:ReqRankingData(rankType, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenRank", function(data)
    Logger.Debug("OnOpenRank Success data", table.tostring(data))
    if callback then
      callback(data)
    end
  end, function(_)
    Logger.Debug("OnOpenRank fail")
  end, rankType)
end

function RankController:ReqRankPrizeData(rankType, subTid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OpenRankPrizeData", function(svrData)
    RankModel.Instance:ApplyOpenRankData(rankType, subTid, svrData)
    if callback then
      callback()
    end
  end, nil, rankType)
end

return RankController
