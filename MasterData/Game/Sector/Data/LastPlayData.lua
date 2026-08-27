local LastPlayData = class("LastPlayData")

function LastPlayData:ctor()
  self.stageCfg = nil
  self.sectorId = nil
  self.seasonId = nil
  self.dungeonLevelType = nil
  self.dungeonType = nil
  self.actId = nil
  self.actData = nil
  self.actSceneLoadoverCallback = nil
  self.extraData = nil
  self.isWin = nil
  self.isLPDEnter = nil
end

function LastPlayData:SetLPDIsEnterOrReturn(isEnter)
  self.isLPDEnter = isEnter
end

function LastPlayData:IsLPDIsEnterOrReturn()
  return self.isLPDEnter
end

function LastPlayData:SetLPDStageCfg(stageCfg)
  self.stageCfg = stageCfg
  return self
end

function LastPlayData:SetLPDSectorId(sectorId)
  self.sectorId = sectorId
  return self
end

function LastPlayData:SetLPDSeasonId(seasonId, towerId, seasonLevelIndex)
  self.seasonId = seasonId
  return self
end

function LastPlayData:SetLPDIsWin(isWin)
  self.isWin = isWin
  return self
end

function LastPlayData:SetLPDDngeonLevelType(dungeonLevelType)
  self.dungeonLevelType = dungeonLevelType
  return self
end

function LastPlayData:SetLPDDngeonType(dungeonType)
  self.dungeonType = dungeonType
  return self
end

function LastPlayData:SetLPDActId(actId)
  self.actId = actId
  return self
end

function LastPlayData:SetLPDActData(actData)
  self.actData = actData
  return self
end

function LastPlayData:SetLPDActSceneLoadoverCallback(callback)
  self.actSceneLoadoverCallback = callback
  return self
end

function LastPlayData:SetLPDExtraData(extraData)
  self.extraData = extraData
  return self
end

function LastPlayData:GetLPDStageCfg()
  return self.stageCfg
end

function LastPlayData:GetLPDSectorId()
  return self.sectorId
end

function LastPlayData:GetLPDSeasonId()
  return self.seasonId
end

function LastPlayData:GetLPDIsWin()
  return self.isWin
end

function LastPlayData:GetLPDDngeonLevelType()
  return self.dungeonLevelType
end

function LastPlayData:GetLPDDngeonType()
  return self.dungeonType
end

function LastPlayData:GetLPDActId()
  return self.actId
end

function LastPlayData:GetLPDActData()
  return self.actData
end

function LastPlayData:GetLPDActSceneLoadoverCallback(callback)
  return self.actSceneLoadoverCallback
end

function LastPlayData:GetLPDExtraData()
  return self.extraData
end

function LastPlayData:GetLastSectorId()
  local stage = self:GetLPDStageCfg()
  if stage ~= nil then
    return stage.sector
  end
  local sectorId = self:GetLPDSectorId()
  if sectorId ~= nil then
    return sectorId
  end
end

return LastPlayData
