local FreeTrialModel = NewClass("FreeTrialModel", BaseModel)

function FreeTrialModel:OnInit()
  self:OnReset()
  EventMgr.Instance.FirstSetTime:RegisterEvent(function()
    self:OnReset()
  end)
  EventMgr.Instance.OnDayRefresh:RegisterEvent(function()
    self:OnReset()
  end)
end

function FreeTrialModel:OnReset()
  self.stageListMap = {}
  self.schoolGroupMap = {}
  self.curStageId = nil
  self:InitTrailStageIdList()
  self.trialType = CommonDefine.TrialType.Normal
end

function FreeTrialModel:GetTrialType()
  return self.trialType
end

function FreeTrialModel:InitTrailStageIdList()
  for _, trailType in pairs(cd.TrialType) do
    local schoolGroupDatas = {}
    local stageIdList = {}
    local groupList
    if trailType == cd.TrialType.Normal then
      groupList = CopyDataUtils.GetStageGroupIdList(CommonDefine.StageGroupType.CommonTrial)
    elseif trailType == cd.TrialType.Limit then
      groupList = DT.GetOriginalConstant("StageGroupLimitSummon", {})
    else
      groupList = DT.GetOriginalConstant("StarStageGroupLimitSummon", {})
    end
    local curTime = TimeUtils.GetServerTime()
    for _, groupId in ipairs(groupList) do
      local stageCfgList = CopyDataUtils.GetCfgStageList(groupId)
      for _, cfg in ipairs(stageCfgList) do
        local trialAwakerTid, schoolType = CopyDataUtils.GetAwakerByStageId(cfg.ID)
        if not trialAwakerTid then
        elseif cfg.OpenTime and curTime < cfg.OpenTime then
        else
          local subData = schoolGroupDatas[schoolType]
          if nil == subData then
            subData = {}
            schoolGroupDatas[schoolType] = subData
          end
          table.insert(subData, cfg.ID)
          table.insert(stageIdList, cfg.ID)
        end
      end
    end
    self.stageListMap[trailType] = stageIdList
    self.schoolGroupMap[trailType] = schoolGroupDatas
  end
end

function FreeTrialModel:SetTrialType(type)
  self.trialType = type
end

function FreeTrialModel:GetAllTrailStageIdList()
  if not self.allStageIdList then
    local allList = {}
    for _, stageList in pairs(self.stageListMap) do
      table.merge(allList, stageList)
    end
    self.allStageIdList = allList
  end
  return self.allStageIdList
end

function FreeTrialModel:GetStageIdListByType(type)
  return self.stageListMap[type] or {}
end

function FreeTrialModel:GetSchoolGroupDatas(trialType)
  return self.schoolGroupMap[trialType or self.trialType] or {}
end

function FreeTrialModel:GetTypeAndStageIdByAwakerTid(awakerTid)
  local mTrialType, stageId
  for trlType, stageIdGroup in pairs(self.stageListMap) do
    for _, stgId in pairs(stageIdGroup) do
      local trialAwakerTid, _ = CopyDataUtils.GetAwakerByStageId(stgId)
      if awakerTid == trialAwakerTid then
        stageId = stgId
        mTrialType = trlType
        break
      end
    end
  end
  return mTrialType, stageId
end

return FreeTrialModel
