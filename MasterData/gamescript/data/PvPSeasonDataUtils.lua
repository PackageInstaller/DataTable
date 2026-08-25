local PvPSeasonData = DataCenter.pvpSeasonData
local PvPSeasonDataUtils = {}
local _openPvpCacheValid = false
local _rankId, _star
local _seasonCollectTimesList = {}
local _seasonDetailsMap = {}
local _pvpDetailsNoMoreMap = {}

function PvPSeasonDataUtils.ReqOnOpen(callBack)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenPvp", function(data)
    Logger.Info("========== 请求PvP赛季数据成功 ==========\n", table.tostring(data or {}))
    SeasonRotationController.Instance:SetPvpSeasonData(data and data.seasonData or {})
    PvPSeasonDataUtils.InitBySvrData(data or {})
    PvPMatchDataUtils.SetDraftScoreCond(data and data.draftScoreCond)
    PvPSeasonDataUtils.SetOpenPvpCacheValid(true)
    if callBack then
      callBack()
    end
    UIViewNotificationsMgr:Notify(NotifyId.OnSeasonDataGet)
  end, function(data)
    Logger.Info("========== 请求PvP赛季数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvPSeasonDataUtils.SetOpenPvpCacheValid(isValid)
  _openPvpCacheValid = isValid and true or false
end

function PvPSeasonDataUtils.GetOpenPvpCacheValid()
  return _openPvpCacheValid
end

function PvPSeasonDataUtils.ClearOpenPvpCache()
  PvPSeasonDataUtils.SetOpenPvpCacheValid(false)
end

function PvPSeasonDataUtils.RequestSeasonInfoOrUseCache(callBack)
  if PvPSeasonDataUtils.GetOpenPvpCacheValid() and nil ~= _rankId then
    if callBack then
      callBack()
    end
    return
  end
  PvPSeasonDataUtils.ReqOnOpen(callBack)
end

function PvPSeasonDataUtils.GetGameDetailsListByUid(uid, page, cb)
  if type(page) == "function" then
    cb = page
    page = 1
  end
  page = page or 1
  ProtoManager.Instance:ReqServer("GameRequest", "GetGameDetailsListByUid", function(data)
    Logger.Info("========== 获取PVP对局数据详情列表数据成功 ==========page", page, table.tostring(data or {}))
    PvPSeasonDataUtils.UpdatePvpDetailsList(uid, data, page)
    if cb then
      cb()
    end
  end, function(data)
    if cb then
      cb()
    end
  end, uid, page)
end

function PvPSeasonDataUtils.InitBySvrData(svrData)
  _rankId = svrData.rankTid
  _star = svrData.star
  PvPSeasonData.weekEndTime = svrData.weekEndTime
  local preBuiltSeasonData = SeasonRotationModel.Instance:GetPvpPrebuildSeasonData() or {}
  local draftSeasonData = SeasonRotationModel.Instance:GetPvpDraftSeasonData() or {}
  PvPSeasonData.maxScore = math.max(preBuiltSeasonData.maxScore or 0, draftSeasonData.maxScore or 0)
end

function PvPSeasonDataUtils.GetSeasonData(pvpType)
  if pvpType == PvpDefine.PvpType.PreBuilt then
    do return SeasonRotationModel.Instance.GetPvpPrebuildSeasonData end
    return SeasonRotationModel.Instance.GetPvpPrebuildSeasonData, SeasonRotationModel.Instance
  end
  if pvpType == PvpDefine.PvpType.Draft then
    do return SeasonRotationModel.Instance.GetPvpDraftSeasonData end
    return SeasonRotationModel.Instance.GetPvpDraftSeasonData, SeasonRotationModel.Instance
  end
end

function PvPSeasonDataUtils.InitPvpCollectTimesList(svrData)
  local collectTimesList = svrData.monthlyUseTimesList
  if nil == collectTimesList then
    return
  end
  if not table.next(collectTimesList) then
    _seasonCollectTimesList = {}
    return
  end
  for collectTid, timesData in pairs(collectTimesList) do
    _seasonCollectTimesList[collectTid] = timesData
  end
end

function PvPSeasonDataUtils.GetSeasonCollectTimesData(collectTid)
  return _seasonCollectTimesList[collectTid]
end

function PvPSeasonDataUtils.GetSeasonCollectWinTimes(collectTid)
  return _seasonCollectTimesList[collectTid] and _seasonCollectTimesList[collectTid] or 0
end

function PvPSeasonDataUtils.GetRankId()
  return _rankId
end

function PvPSeasonDataUtils.GetStar()
  return _star
end

function PvPSeasonDataUtils.UpdatePvpDetailsList(uid, svrData, page)
  local list = svrData.gameDetailsList or {}
  page = page or 1
  uid = uid or 0
  if 1 == page then
    _seasonDetailsMap[uid] = list
    _pvpDetailsNoMoreMap[uid] = nil
  else
    _seasonDetailsMap[uid] = _seasonDetailsMap[uid] or {}
    local detailsList = _seasonDetailsMap[uid]
    for i = 1, #list do
      detailsList[#detailsList + 1] = list[i]
    end
    if 0 == #list then
      _pvpDetailsNoMoreMap[uid] = true
    end
  end
end

function PvPSeasonDataUtils.GetPvpDetailsNoMore(uid)
  uid = uid or 0
  return true == _pvpDetailsNoMoreMap[uid]
end

function PvPSeasonDataUtils.GetPvpDetailsList(uid)
  uid = uid or 0
  local seasonDetailsList = _seasonDetailsMap[uid] or {}
  return seasonDetailsList or {}
end

function PvPSeasonDataUtils.GetPvpBattleTimeDesc(timestamp)
  local d, h, m = TimeUtils.GetSocialTime(timestamp)
  if not d then
    return ""
  end
  if d >= 1 then
    do return LT.Textf, "PVPRecordTime_Day", math.floor(d) end
    return LT.Textf, "PVPRecordTime_Day", math.floor(d)
  elseif h >= 1 then
    do return LT.Textf, "PVPRecordTime_Hour", math.floor(h) end
    return LT.Textf, "PVPRecordTime_Hour", math.floor(h)
  end
  do return LT.Textf, "PVPRecordTime_Minute", math.floor(math.max(1, m)) end
  return LT.Textf, "PVPRecordTime_Minute", math.floor(math.max(1, m))
end

return PvPSeasonDataUtils
