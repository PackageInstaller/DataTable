local MapDataUtils = {}

function MapDataUtils.ResetAll()
  DataCenter.mapData.MapArticleInfos = {}
end

function MapDataUtils.AddArticleInfo(uid, tid, state)
  local info = {}
  info.uid = uid
  info.tid = tid
  info.state = state
  DataCenter.mapData.MapArticleInfos[uid] = info
end

function MapDataUtils.RemoveArticleInfo(uid)
  if DataCenter.mapData.MapArticleInfos[uid] then
    DataCenter.mapData.MapArticleInfos[uid] = nil
  end
end

function MapDataUtils.SetArticleState(uid, state)
  if DataCenter.mapData.MapArticleInfos[uid] then
    DataCenter.mapData.MapArticleInfos[uid].state = state
  end
end

function MapDataUtils.GetArticle(uid)
  if DataCenter.mapData.MapArticleInfos[uid] then
    return DataCenter.mapData.MapArticleInfos[uid]
  end
  return nil
end

function MapDataUtils.GetArticleTid(uid)
  if DataCenter.mapData.MapArticleInfos[uid] then
    return DataCenter.mapData.MapArticleInfos[uid].tid
  end
  return nil
end

function MapDataUtils.GetArticleState(uid)
  if DataCenter.mapData.MapArticleInfos[uid] then
    return DataCenter.mapData.MapArticleInfos[uid].state
  end
  return nil
end

function MapDataUtils.SetMoveSpeed(speed)
  DataCenter.mapData.MoveSpeed = speed
end

return MapDataUtils
