local BattlePerformanceLevel = {}
local MatchingLevel = {
  Low = "Low",
  Middle = "Middle",
  High = "High"
}
local GraphicQualityToLevel = {
  VeryLow = MatchingLevel.Low,
  Low = MatchingLevel.Low,
  Middle = MatchingLevel.Middle,
  High = MatchingLevel.High,
  VeryHigh = MatchingLevel.High
}
local LevelParams = {
  [MatchingLevel.Low] = {
    FloatTextMergeLimit = 999,
    HitEffectDedupEnabled = false,
    HitEffectDedupWindow = 0,
    TentacleDedupEnabled = false,
    TentacleDedupWindow = 0
  },
  [MatchingLevel.Middle] = {
    FloatTextMergeLimit = 999,
    HitEffectDedupEnabled = false,
    HitEffectDedupWindow = 0,
    TentacleDedupEnabled = false,
    TentacleDedupWindow = 0
  },
  [MatchingLevel.High] = {
    FloatTextMergeLimit = 999,
    HitEffectDedupEnabled = false,
    HitEffectDedupWindow = 0,
    TentacleDedupEnabled = false,
    TentacleDedupWindow = 0
  }
}

local function _GetLevel()
  local quality = SettingManager.Instance:GetSettingData(CommonDefine.SettingUniqueName.GraphicQuality)
  if quality then
    local level = GraphicQualityToLevel[quality]
    if level and LevelParams[level] then
      return level
    end
  end
  local fpsLimit = tonumber(SettingManager.Instance:GetSettingData(CommonDefine.SettingUniqueName.FPSLimit))
  if fpsLimit and fpsLimit >= 60 then
    return MatchingLevel.High
  end
  return MatchingLevel.Middle
end

local function _GetParams()
  local level = _GetLevel()
  return LevelParams[level]
end

function BattlePerformanceLevel.GetFloatTextMergeLimit()
  return _GetParams().FloatTextMergeLimit
end

function BattlePerformanceLevel.IsHitEffectDedupEnabled()
  return _GetParams().HitEffectDedupEnabled
end

function BattlePerformanceLevel.GetHitEffectDedupWindow()
  return _GetParams().HitEffectDedupWindow
end

function BattlePerformanceLevel.IsTentacleDedupEnabled()
  return _GetParams().TentacleDedupEnabled
end

function BattlePerformanceLevel.GetTentacleDedupWindow()
  return _GetParams().TentacleDedupWindow
end

return BattlePerformanceLevel
