local PvpType = PvpDefine.PvpType
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local SeasonRotationController = NewClass("SeasonRotationController", BaseController)

function SeasonRotationController:OnInit()
end

function SeasonRotationController:OnReset()
  SeasonRotationModel.Instance:SetSeasonDataMap({})
end

function SeasonRotationController:_MapToGameplayType(modeType)
  if modeType == PvpType.PreBuilt then
    return SeasonGameplayType.PvpPreBuilt
  end
  if modeType == PvpType.Draft then
    return SeasonGameplayType.PvpDraft
  end
  if modeType == SeasonGameplayType.ConsciousnessDiving or modeType == SeasonGameplayType.PvpPreBuilt or modeType == SeasonGameplayType.ConsciousnessRailway or modeType == SeasonGameplayType.PvpDraft then
    return modeType
  end
  return nil
end

function SeasonRotationController:SyncSeasonDataMap(seasonDataMap)
  local gameplaySeasonDataMap = {}
  for modeType, seasonData in pairs(seasonDataMap or {}) do
    local gameplayType = self:_MapToGameplayType(modeType)
    if gameplayType and type(seasonData) == "table" then
      gameplaySeasonDataMap[gameplayType] = seasonData
    end
  end
  SeasonRotationModel.Instance:SetSeasonDataMap(gameplaySeasonDataMap)
end

function SeasonRotationController:SetSeasonData(gameplayType, seasonData)
  SeasonRotationModel.Instance:SetSeasonData(gameplayType, seasonData)
end

function SeasonRotationController:SetConsciousnessDivingSeasonData(seasonData)
  self:SetSeasonData(SeasonGameplayType.ConsciousnessDiving, seasonData)
end

function SeasonRotationController:SetConsciousnessRailwaySeasonData(seasonData)
  self:SetSeasonData(SeasonGameplayType.ConsciousnessRailway, seasonData)
end

function SeasonRotationController:SetPvpSeasonData(seasonDataMap)
  self:SetSeasonData(SeasonGameplayType.PvpPreBuilt, seasonDataMap[PvpType.PreBuilt])
  self:SetSeasonData(SeasonGameplayType.PvpDraft, seasonDataMap[PvpType.Draft])
end

function SeasonRotationController:OnPvpRankChange(data)
  self:SyncSeasonDataMap(data and data.seasonData or nil)
end

return SeasonRotationController
