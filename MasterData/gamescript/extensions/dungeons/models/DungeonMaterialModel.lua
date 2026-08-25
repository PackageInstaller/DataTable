local DungeonMaterialModel, Super = NewClass("DungeonMaterialModel", BaseModel)

function DungeonMaterialModel:OnInit()
  self:OnReset()
end

function DungeonMaterialModel:OnReset()
  self.stageGroupList = {}
  self.stageGroupIds = {}
  self.stageGroupId = nil
  self.stageId = nil
  self.stageGroupType = nil
end

function DungeonMaterialModel:SetStageGroupType(stageGroupType)
  self.stageGroupType = stageGroupType
end

function DungeonMaterialModel:GetStageGroupType()
  return self.stageGroupType
end

function DungeonMaterialModel:GetStageGroupData(stageGroupType)
  return self.stageGroupList[stageGroupType] or {}
end

function DungeonMaterialModel:SetStageGroupData(stageGroupList)
  self.stageGroupList[self.stageGroupType] = {}
  self.stageGroupList[self.stageGroupType] = stageGroupList
end

function DungeonMaterialModel:GetStageGroupId()
  return self.stageGroupIds[self.stageGroupType]
end

function DungeonMaterialModel:SetStageGroupId(stageGroupId)
  self.stageGroupIds[self.stageGroupType] = stageGroupId
end

function DungeonMaterialModel:ResetStageGroupId()
  self.stageGroupIds = {}
end

function DungeonMaterialModel:GetStageData()
  return CopyDataUtils.GetStageList(self.stageGroupIds[self.stageGroupType]) or {}
end

function DungeonMaterialModel:GetStageDataById(stageId)
  local stageData = self:GetStageData()
  for _, data in ipairs(stageData) do
    if data.stageID == stageId then
      return data
    end
  end
  return {}
end

function DungeonMaterialModel:GetStageId()
  return self.stageId
end

function DungeonMaterialModel:SetStageId(stageId)
  self.stageId = stageId
end

function DungeonMaterialModel:GetCoinList()
  local stageGroupId = self.stageGroupIds[self.stageGroupType]
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  if not stageGroupCfg then
    Logger.Warn("[DungeonMaterialModel] GetCoinList: stageGroup config is nil, stageGroupId=" .. tostring(stageGroupId))
    return
  end
  local StageType = stageGroupCfg.Type
  if StageType == CommonDefine.StageGroupType.TrinketCopy then
    return DT.Constant.TrinketCopyPanelCurrencies.Data
  elseif StageType == CommonDefine.StageGroupType.MaterialCopy then
    return DT.Constant.DailyMaterialPanelCurrencies.Data
  end
end

function DungeonMaterialModel:IsLockedStage(stageId)
  local stageData = self:GetStageData()
  for _, data in ipairs(stageData) do
    if data.stageID == stageId then
      return data and not data.unlocked
    end
  end
end

return DungeonMaterialModel
