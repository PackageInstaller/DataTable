local StageGroupCfgUtils = {}

function StageGroupCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.StageGroup[tid]
end

function StageGroupCfgUtils.GetCfgField(field, cfgTid)
  local cfg = StageGroupCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function StageGroupCfgUtils.ParseStageGroupAvgInfo(targetDT, stageGroupTid)
  local cfg = StageGroupCfgUtils.GetCfg(stageGroupTid)
  if not cfg then
    return nil
  end
  local rst = {}
  local cfgPopupAvgTids = cfg.PopupAvgTids
  local cfgPopupAvgParams = cfg.PopupAvgParams
  for i = 1, #(cfgPopupAvgTids or {}) do
    local avgTid = cfgPopupAvgTids[i]
    local avgParam = cfgPopupAvgParams[i]
    if targetDT[avgParam] then
      rst[avgParam] = avgTid
    end
  end
  return rst
end

function StageGroupCfgUtils.GetActivityTask2AvgDict(stageGroupTid)
  do return StageGroupCfgUtils.ParseStageGroupAvgInfo, DT.Task end
  return StageGroupCfgUtils.ParseStageGroupAvgInfo, DT.Task, stageGroupTid
end

function StageGroupCfgUtils.GetActivityTid2AvgDict(stageGroupTid)
  do return StageGroupCfgUtils.ParseStageGroupAvgInfo, DT.Activity end
  return StageGroupCfgUtils.ParseStageGroupAvgInfo, DT.Activity, stageGroupTid
end

function StageGroupCfgUtils.GetShowPopupAvgTids(stageGroupTid, fromActivityTid)
  local stageGroupCfg = StageGroupCfgUtils.GetCfg(stageGroupTid)
  if not stageGroupCfg or not stageGroupCfg.PopupAvgTids then
    return {}
  end
  local cfgPopupAvgTids = stageGroupCfg.PopupAvgTids
  if not fromActivityTid or not ActivityManager.Instance:IsActivityOpenedByTid(fromActivityTid) then
    return cfgPopupAvgTids
  end
  local rst = {}
  for i = 1, #cfgPopupAvgTids do
    local avgTid = cfgPopupAvgTids[i]
    local isPlayed = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG_ONCE, avgTid)
    if isPlayed then
      table.insert(rst, avgTid)
    end
  end
  return rst
end

function StageGroupCfgUtils.GetAvgIndex(stageGroupTid, avgTid)
  local cfgPopupAvgTids = StageGroupCfgUtils.GetCfgField("PopupAvgTids", stageGroupTid)
  if not cfgPopupAvgTids then
    return nil
  end
  for i = 1, #cfgPopupAvgTids do
    if cfgPopupAvgTids[i] == avgTid then
      return i
    end
  end
  return nil
end

function StageGroupCfgUtils.GetDisplayStageGroupByType(stageGroupType)
  local rst = {}
  for _, cfg in pairs(DT.StageGroup) do
    if cfg.Type == stageGroupType and (not cfg.StageDisplayDate or TimeUtils.GetServerTime() >= cfg.StageDisplayDate) then
      table.insert(rst, cfg)
    end
  end
  return rst
end

function StageGroupCfgUtils.IsIgnoreFeatureLock(stageGroupTid)
  local isUnlockFreeStageGroupTid = table.contains(DT.GetOriginalConstant("StageGroupUnlockFeature"), stageGroupTid)
  return isUnlockFreeStageGroupTid and ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupTid)
end

return StageGroupCfgUtils
