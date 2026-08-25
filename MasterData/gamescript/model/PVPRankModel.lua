local seasonCfgs = {}
for _, cfg in pairs(DT.PVPSeason) do
  table.insert(seasonCfgs, cfg)
end
table.sort(seasonCfgs, function(a, b)
  return a.BaseSortID < b.BaseSortID
end)

local function createState()
  local state = {}
  state.seasonTid = 0
  state.numRankEntries = 0
  state.numEntriesPerPage = 4
  state.currPageIdx = 1
  state.currPageEntries = {}
  state.selfRankIdx = -1
  state.dailyPVPRankData = {}
  
  function state.maxPages()
    local maxPages = math.ceil(state.numRankEntries / state.numEntriesPerPage)
    return maxPages > 0 and maxPages or 1
  end
  
  state.rankStartIndexMap = {}
  state.pvpDailyRankIndex = 1
  state.reqRankCount = 20
  return state
end

local function createViews(_)
  local views = {}
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:SetSeasonTid(tid)
    data.seasonTid = tid
    data:QueryPVPRank()
    data:QueryDraftPVPRank()
  end
  
  function actions:_RequestRankData()
    EventMgr.Instance.OpenReqMask:Dispatch()
  end
  
  function actions:QueryDailyPVPRank(startIndex, count)
    startIndex = startIndex or self.rankStartIndexMap[RankDefine.RankType.WeeklyPVP] or 1
    count = count or self.reqRankCount
    RankController.Instance:QueryRankData(RankDefine.RankType.WeeklyPVP, nil, startIndex, count)
  end
  
  function actions:QueryDailyDraftPVPRank(startIndex, count)
    startIndex = startIndex or self.rankStartIndexMap[RankDefine.RankType.WeeklyDraftPVP] or 1
    count = count or self.reqRankCount
    RankController.Instance:QueryRankData(RankDefine.RankType.WeeklyDraftPVP, nil, startIndex, count)
  end
  
  function actions:QueryPVPRank(startIndex, count)
    local key = RankDataUtils.GetRankKey(RankDefine.RankType.PVP, data.seasonTid)
    startIndex = startIndex or self.rankStartIndexMap[key] or 1
    count = count or self.reqRankCount
    RankController.Instance:QueryRankData(RankDefine.RankType.PVP, data.seasonTid, startIndex, count)
  end
  
  function actions:QueryDraftPVPRank(startIndex, count)
    local key = RankDataUtils.GetRankKey(RankDefine.RankType.DraftPVP, data.seasonTid)
    startIndex = startIndex or self.rankStartIndexMap[key] or 1
    count = count or self.reqRankCount
    RankController.Instance:QueryRankData(RankDefine.RankType.DraftPVP, data.seasonTid, startIndex, count)
  end
  
  function actions:OnUpdateRank(targetType, subTid)
    if targetType == RankDefine.RankType.WeeklyPVP then
      local rankList = RankModel.Instance:GetRankListData(targetType)
      self.rankStartIndexMap[targetType] = #rankList + 1
    end
    if targetType == RankDefine.RankType.WeeklyDraftPVP then
      local rankList = RankModel.Instance:GetRankListData(targetType)
      self.rankStartIndexMap[targetType] = #rankList + 1
    end
    if targetType == RankDefine.RankType.PVP then
      local key = RankDataUtils.GetRankKey(targetType, subTid)
      local rankList = RankModel.Instance:GetRankListData(targetType, subTid)
      self.rankStartIndexMap[key] = #rankList + 1
    end
    if targetType == RankDefine.RankType.DraftPVP then
      local key = RankDataUtils.GetRankKey(targetType, subTid)
      local rankList = RankModel.Instance:GetRankListData(targetType, subTid)
      self.rankStartIndexMap[key] = #rankList + 1
    end
  end
  
  function actions:_OnRequestRankDataResponse(svrData)
    data.numRankEntries = svrData.len
    data.selfRankIdx = svrData.rankIndex
    data:SetPageIdx(1)
  end
  
  function actions:_OnGetDailyPVPRank(svrData)
    data.dailyPVPRankData = table.deepclone(svrData)
  end
  
  function actions:GetHistSeasonCfgList(endSeasonTid, beginSeasonTid)
    local seasonCfgsToShow = {}
    local endSeasonStartTime = PvpSeasonCfgUtils.GetCfgField("StartTime", endSeasonTid)
    local beginSeasonStartTime = PvpSeasonCfgUtils.GetCfgField("StartTime", beginSeasonTid)
    if nil == endSeasonStartTime then
      return seasonCfgsToShow
    end
    for _, cfg in ipairs(seasonCfgs) do
      if endSeasonStartTime < cfg.StartTime then
      elseif beginSeasonStartTime and beginSeasonStartTime > cfg.StartTime then
      else
        table.insert(seasonCfgsToShow, cfg)
      end
    end
    return seasonCfgsToShow
  end
  
  function actions:SetPageIdx(idx)
    if idx < 1 or idx > data.maxPages then
      return
    end
    data.currPageIdx = idx
    local entryIdxBegin = (data.currPageIdx - 1) * data.numEntriesPerPage + 1
    local entryIdxEnd = entryIdxBegin + data.numEntriesPerPage - 1
    data:_RequestPageData(entryIdxBegin, entryIdxEnd)
  end
  
  function actions:_RequestPageData(idxBegin, idxEnd)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnQueryRank", function(svrData)
      data:_OnRequestPageDataResponse(svrData)
    end, function()
    end, RankDefine.RankType.PVP, idxBegin, idxEnd, data.seasonTid)
  end
  
  function actions:_OnRequestPageDataResponse(svrData)
    data.currPageEntries = {}
    for _, entry in ipairs(svrData.data) do
      table.insert(data.currPageEntries, {
        rankIdx = entry.rank,
        name = entry.name,
        gender = entry.gender,
        icon = entry.icon,
        uid = entry.uid,
        score = entry.score
      })
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindEvent(EventMgr.Instance.RankUpdate, function(type, subTid)
    model:OnUpdateRank(type, subTid)
  end)
end

local PVPRankModel = Vue.model("PVPRankModel", createState):views(createViews):actions(createActions):setup(onSetup)
return PVPRankModel
