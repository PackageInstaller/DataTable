local DailyCopyDataUtils = {}

function DailyCopyDataUtils.ResetAll()
  DataCenter.dailyCopyData.relicList = {}
  DataCenter.dailyCopyData.highestStar = nil
  DataCenter.dailyCopyData.stageId = nil
  DataCenter.dailyCopyData.resonanceTagMap = {}
  DataCenter.dailyCopyData.unlockResonanceList = {}
  DataCenter.dailyCopyData.selectResonanceList = {}
  DataCenter.dailyCopyData.isPass = false
end

function DailyCopyDataUtils.GetStageId()
  return DataCenter.dailyCopyData.stageId
end

function DailyCopyDataUtils.GetIsPass()
  return DataCenter.dailyCopyData.isPass
end

function DailyCopyDataUtils.GetHighestStar()
  return DataCenter.dailyCopyData.highestStar
end

function DailyCopyDataUtils.GetRelicList()
  return DataCenter.dailyCopyData.relicList
end

function DailyCopyDataUtils.GetSelectResonanceList()
  return DataCenter.dailyCopyData.selectResonanceList
end

function DailyCopyDataUtils.GetResonanceTagMap()
  return DataCenter.dailyCopyData.resonanceTagMap
end

function DailyCopyDataUtils.GetUnlockResonanceList()
  return DataCenter.dailyCopyData.unlockResonanceList
end

function DailyCopyDataUtils.GetResonanceTagDataByTid(tid)
  return DataCenter.dailyCopyData.resonanceTagMap[tid]
end

function DailyCopyDataUtils.GetResonanceTagCfgByTid(tid)
  return nil
end

function DailyCopyDataUtils.OpenDailyCopyEntryPanel()
end

function DailyCopyDataUtils.PreprocessingDailyCopyData()
  DataCenter.dailyCopyData.highestStar = 0
  DataCenter.dailyCopyData.relicList = {
    [1] = 1,
    [2] = 1
  }
  DataCenter.dailyCopyData.stageId = 33969
  DailyCopyDataUtils.ClearAllChooseTag()
end

DailyCopyDataUtils.haveChallenged = false

function DailyCopyDataUtils.ParseServerData(data)
  for key, value in pairs(data.relic) do
    DataCenter.dailyCopyData.relicList[key] = value
  end
  DataCenter.dailyCopyData.highestStar = data.star
  DataCenter.dailyCopyData.stageId = data.stageId
  DataCenter.dailyCopyData.isPass = data.isPass
  for _, value in pairs(data.talent) do
    if DataCenter.dailyCopyData.resonanceTagMap[value.tid] then
      DataCenter.dailyCopyData.resonanceTagMap[value.tid].state = CommonDefine.ResonanceTagState.UnChoose
    end
  end
  if data.newTalent then
    local showResonanceList = {}
    local isShowUnlock = false
    if #data.newTalent > #DataCenter.dailyCopyData.unlockResonanceList and DailyCopyDataUtils.haveChallenged then
      isShowUnlock = true
    end
    for _, serverTid in pairs(data.newTalent) do
      local isNewTid = true
      for _, clientTid in pairs(DataCenter.dailyCopyData.unlockResonanceList) do
        if serverTid == clientTid then
          isNewTid = false
        end
      end
      if isNewTid then
        table.insert(DataCenter.dailyCopyData.unlockResonanceList, serverTid)
        if isShowUnlock then
          table.insert(showResonanceList, serverTid)
        end
      end
      DataCenter.dailyCopyData.resonanceTagMap[serverTid].isNew = true
    end
  end
end

function DailyCopyDataUtils.AddResonanceTag(tid)
end

function DailyCopyDataUtils.DeleteResonanceTag(tid)
  for key, value in pairs(DataCenter.dailyCopyData.selectResonanceList) do
    if value == tid then
      table.remove(DataCenter.dailyCopyData.selectResonanceList, key)
    end
  end
end

function DailyCopyDataUtils.ClearAllChooseTag()
  for _, value in pairs(DataCenter.dailyCopyData.resonanceTagMap) do
    if value.state ~= CommonDefine.ResonanceTagState.Lock then
      value.state = CommonDefine.ResonanceTagState.UnChoose
    end
  end
  DataCenter.dailyCopyData.selectResonanceList = {}
end

function DailyCopyDataUtils.RequestChooseIsNewTag(tid)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnDailyChallengeChooseTalent", function()
    DailyCopyDataUtils.GetResonanceTagDataByTid(tid).isNew = false
    for key, value in pairs(DataCenter.dailyCopyData.unlockResonanceList) do
      if value == tid then
        table.remove(DataCenter.dailyCopyData.unlockResonanceList, key)
      end
    end
  end, nil, tid)
end

function DailyCopyDataUtils.IsInArray(val, array)
  for _, value in pairs(array) do
    if value == val then
      return true
    end
  end
  return false
end

return DailyCopyDataUtils
