local DBGEntryPage = CommonDefine.DBGEntryPage
local DungeonTaskDataModel, Super = NewClass("DungeonTaskDataModel", BaseModel)

function DungeonTaskDataModel:OnReset()
  self.curDBGEntryPage = DBGEntryPage.MaterialPanel
end

function DungeonTaskDataModel:OnInit()
  self:OnReset()
  self.levelData = {}
  self.curLv = 1
  self.curExp = 0
  self.nextExp = 0
  self.maxLv = 0
  self.lvItemId = DT.GetConstant("DailyChallengeExperienceRewardItem")
  self:ParseLevelCfg()
end

function DungeonTaskDataModel:ParseLevelCfg()
  for lvTid, lvCfg in pairs(DT.CareerLevel) do
    if lvCfg.Type == DailyChallengeDataUtils.careerLevelType then
      table.insert(self.levelData, lvTid)
      if not lvCfg.Exp then
        self.maxLv = lvCfg.Level
      end
    end
  end
  table.sort(self.levelData, function(aId, bId)
    local aCfg = DT.CareerLevel[aId]
    local bCfg = DT.CareerLevel[bId]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
end

function DungeonTaskDataModel:GetLevel()
  local levelMO = CareerLevelModel.Instance:GetCareerLevelMO(DailyChallengeDataUtils.careerLevelType)
  local moExp = levelMO and levelMO.exp or 0
  self.curLv = levelMO and levelMO.level or 1
  self.nextExp = DT.CareerLevel[self.levelData[self.curLv]].Exp or DT.CareerLevel[self.levelData[self.curLv - 1] or 1].Exp or 0
  self.curExp = math.min(moExp, self.nextExp)
  if self.curLv == self.maxLv then
    self.curExp = self.nextExp
  end
  return self.curLv, self.curExp, self.nextExp
end

return DungeonTaskDataModel
