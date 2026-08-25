local CopyVindicateModel, Super = NewClass("CopyVindicateModel", CopyStagesModel)

function CopyVindicateModel:ResetData()
  self:ResetStageList()
  self:ResetSelectStageTid()
end

function CopyVindicateModel:ResetStageList()
  self.stageGroupId = nil
  local stageGroupId = self:GetVindicateStageGroup()
  self:SetStageGroupID(stageGroupId)
  self.stageList = self:GetStageList()
  self:SortStageList(self.stageList)
end

function CopyVindicateModel:ResetSelectStageTid()
  self:SetSelectStageTid(self.stageList[1])
end

function CopyVindicateModel:SetSelectStageTid(stageTid)
  self.selectStageTid = stageTid
  self:LocalNotify(NotifyId.OnVindicateStageSelected, stageTid)
end

function CopyVindicateModel:GetVindicateStageGroup()
  for groupId, groupInfo in pairs(DT.StageGroup) do
    if groupInfo.Type == CommonDefine.StageGroupType.Vindicate then
      return groupId
    end
  end
end

function CopyVindicateModel:GetStageList()
  local curGroupData = self:GetGroupData(self.stageGroupId)
  local list = curGroupData and curGroupData.stageList or {}
  local stageList = {}
  for _, stageData in ipairs(list) do
    if CopyDataUtils.CheckStageIsInOpenTime(stageData.stageID) then
      table.insert(stageList, stageData.stageID)
    end
  end
  return stageList
end

function CopyVindicateModel:GetUnlockItems()
  local stageCfg = CopyDataUtils.GetStageConfig(self.selectStageTid)
  do return table.keys end
  return table.keys, stageCfg and stageCfg.OpenItem or {}
end

function CopyVindicateModel:SortStageList(stageList)
  local sortData = {}
  for _, stageTid in ipairs(stageList) do
    local stageData = self:GetStageData(stageTid)
    local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageTid)
    local awakerConfig = DT.AwakerConfig[awakerTid]
    local likeValue = AwakerAffectDataUtils.GetAwakerLikeLv(awakerTid)
    sortData[stageTid] = {
      isUnlocked = self:IsStageUnlock(stageTid),
      firstRewardDraw = stageData.firstRewardDraw,
      likeValue = likeValue,
      SortID = awakerConfig.SortID
    }
  end
  table.sort(stageList, function(a, b)
    local sortA = sortData[a]
    local sortB = sortData[b]
    return sortA.SortID < sortB.SortID
  end)
end

function CopyVindicateModel:GetAwakerTidByStage(stageTid)
  local awakerTid = FreeTrialController.Instance:GetAwakerByStageId(stageTid)
  return awakerTid
end

return CopyVindicateModel
