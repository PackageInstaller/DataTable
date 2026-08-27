local SectorIISectorLevelData = class("SectorIISectorLevelData")

function SectorIISectorLevelData.CreateSectorIIEpLevelData(sectorId, stageCfg, stageExtrCfg)
  local data = SectorIISectorLevelData.New()
  data.sectorId = sectorId
  data.isBattle = true
  data.stageCfg = stageCfg
  data.stageId = stageCfg.id
  data.isClear = PlayerDataCenter.sectorStage:IsStageComplete(data.stageId)
  data.isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(data.stageId)
  data.stageExtrCfg = stageExtrCfg
  if data.stageExtrCfg == nil then
    error(string.format("can't get winter activity sector stage extrCfg with sectorId:%s stageId:%s", tostring(sectorId), tostring(data.stageId)))
    return
  end
  local posCfg = data.stageExtrCfg.stage_pos
  data.pos = Vector2.New(posCfg[1], posCfg[2])
  data.linePos = Vector2.New(posCfg[1], posCfg[2] - 81.60000000000001)
  return data
end

function SectorIISectorLevelData.CreateSectorIIStoryLevelData(sectorId, avgCfg, avgExtrCfg)
  local data = SectorIISectorLevelData.New()
  data.sectorId = sectorId
  data.isBattle = false
  data.avgCfg = avgCfg
  data.avgId = avgCfg.id
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  data.isClear = avgPlayCtrl:IsAvgPlayed(data.avgId)
  data.isUnlock = avgPlayCtrl:IsAvgUnlock(data.avgId)
  data.avgExtrCfg = avgExtrCfg
  if data.avgExtrCfg == nil then
    error(string.format("can't get winter activity sector story extrCfg with sectorId:%s stroyId:%s", tostring(sectorId), tostring(data.avgId)))
    return
  end
  local posCfg = data.avgExtrCfg.story_pos
  data.pos = Vector2.New(posCfg[1], posCfg[2])
  data.linePos = data.pos
  return data
end

function SectorIISectorLevelData:ctor()
  self.sectorId = nil
  self.isBattle = nil
  self.isUnlock = nil
  self.isClear = nil
  self.pos = nil
  self.linePos = nil
  self.parentLevelList = {}
  self.childLevelList = nil
  self.stageId = nil
  self.stageCfg = nil
  self.stageExtrCfg = nil
  self.isSideStage = nil
  self.avgId = nil
  self.avgCfg = nil
  self.avgExtrCfg = nil
end

function SectorIISectorLevelData:GetLevelSectorId()
  return self.sectorId
end

function SectorIISectorLevelData:GetLevelSageId()
  return self.stageId
end

function SectorIISectorLevelData:GetIsBattle()
  return self.isBattle
end

function SectorIISectorLevelData:GetIsLevelClaer()
  return self.isClear
end

function SectorIISectorLevelData:GetIsLevelUnlock()
  return self.isUnlock
end

function SectorIISectorLevelData:GetIsLevelPos()
  return self.pos
end

function SectorIISectorLevelData:GetIsLevelLinePos()
  return self.linePos
end

function SectorIISectorLevelData:RefreshSIILevelState()
  if self.isBattle then
    self.isClear = PlayerDataCenter.sectorStage:IsStageComplete(self.stageId)
    self.isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(self.stageId)
  else
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    self.isClear = avgPlayCtrl:IsAvgPlayed(self.avgId)
    self.isUnlock = avgPlayCtrl:IsAvgUnlock(self.avgId)
  end
end

function SectorIISectorLevelData:GetLevelEpStageCfg()
  return self.stageCfg
end

function SectorIISectorLevelData:GetLevelAvgCfg()
  return self.avgCfg
end

function SectorIISectorLevelData:GetLevelTitle()
  if self.isBattle and self.stageCfg ~= nil then
    return LanguageUtil.GetLocaleText(self.stageCfg.name)
  end
end

function SectorIISectorLevelData:GetLevelSubTitle()
  if self.isBattle and self.stageExtrCfg ~= nil then
    return string.format(ConfigData:GetTipContent(13006), "", tostring(self.stageCfg.num))
  end
end

function SectorIISectorLevelData:HasSectorIILevelChallengeTask()
  if not self.isBattle then
    return
  end
  local hasChallenge = PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(self.stageId)
  local isOpen = PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(self.stageId)
  return hasChallenge and isOpen
end

function SectorIISectorLevelData:GetSectorIILevelChallengeTaskNum()
  if not self.isBattle then
    return
  end
  local totalNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskNum(self.stageId)
  local passedNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(self.stageId)
  return totalNum, passedNum
end

function SectorIISectorLevelData:GetSectroIILevelIconName()
  if self.isBattle then
    return self.stageCfg.icon
  else
    return self.avgExtrCfg.icon
  end
end

function SectorIISectorLevelData:GetSectroIILevelIsHard()
  if not self.isBattle then
    return
  end
  return self.stageExtrCfg.is_hard
end

function SectorIISectorLevelData:GetSectroIILevelIsSide()
  if not self.isBattle then
    return
  end
  return self.isSideStage
end

function SectorIISectorLevelData:AddAParentSIILevel(levelData)
  table.insert(self.parentLevelList, levelData)
end

function SectorIISectorLevelData:SwiftParent2SIILevel(levelData)
  levelData.parentLevelList = self.parentLevelList
  for _, mapLevelData in pairs(self.parentLevelList) do
    mapLevelData:AddAChildSIILevel(levelData)
    table.removebyvalue(mapLevelData.childLevelList, self)
  end
  self.parentLevelList = {}
end

function SectorIISectorLevelData:GetSIILevelParentList()
  return self.parentLevelList
end

function SectorIISectorLevelData:ReplaceSIILevelParent(curParent, targetParent)
  local index = table.indexof(self.parentLevelList, curParent)
  if index == nil then
    return
  end
  self.parentLevelList[index] = targetParent
end

function SectorIISectorLevelData:AddAChildSIILevel(levelData)
  if self.childLevelList == nil then
    self.childLevelList = {}
  end
  table.insert(self.childLevelList, levelData)
end

function SectorIISectorLevelData:GetSIILevelChildList()
  return self.childLevelList
end

function SectorIISectorLevelData:CleanSIILevelChildList()
  self.childLevelList = nil
end

return SectorIISectorLevelData
