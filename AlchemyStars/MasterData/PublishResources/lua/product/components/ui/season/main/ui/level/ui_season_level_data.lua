_class("UISeasonLevelData", Object)
UISeasonLevelData = UISeasonLevelData

function UISeasonLevelData:Constructor(group, point, lineCpt)
  self._groupID = group
  local levelCfg = point:GetMissionCfg()
  self._lineCpt = lineCpt
  self._missionID = levelCfg.ID
  if levelCfg.OrderID == UISeasonLevelDiff.Normal then
    self._normalLevel = levelCfg
  elseif levelCfg.OrderID == UISeasonLevelDiff.Hard then
    self._hardLevel = levelCfg
  else
    self._normalLevel = levelCfg
    Log.fatal("赛季玩法战斗关难度配置错误:", levelCfg.ID, levelCfg.OrderID)
  end
  self._awards = {}
end

function UISeasonLevelData:AddDiffLevel(point)
  local levelCfg = point:GetMissionCfg()
  if levelCfg.OrderID == UISeasonLevelDiff.Normal then
    if self._normalLevel then
      Log.exception("赛季玩法战斗关难度配置错误,普通难度重复:", levelCfg.ID)
    end
    self._normalLevel = levelCfg
  elseif levelCfg.OrderID == UISeasonLevelDiff.Hard then
    if self._hardLevel then
      Log.exception("赛季玩法战斗关难度配置错误,高难难度重复:", levelCfg.ID)
    end
    self._hardLevel = levelCfg
  else
    Log.exception("赛季玩法战斗关难度配置错误Add:", levelCfg.ID, levelCfg.OrderID)
  end
end

function UISeasonLevelData:GetCurMissionID()
  return self._missionID
end

function UISeasonLevelData:GetMissionCfgByDiff(diff)
  if diff == UISeasonLevelDiff.Normal then
    return self._normalLevel
  elseif diff == UISeasonLevelDiff.Hard then
    return self._hardLevel
  else
    return self._normalLevel
  end
end

function UISeasonLevelData:GetStarByDiff(diff)
  local id = self:GetMissionCfgByDiff(diff).ID
  return self._lineCpt:GetPassStar(id)
end

function UISeasonLevelData:GetAwardsByDiff(diff)
  local cfg = self:GetMissionCfgByDiff(diff)
  if not self._awards[diff] then
    local awardCfg = {
      FirstDropId = cfg.FirstDropId and cfg.FirstDropId[1],
      PassFixDropId = cfg.PassFixDropId and cfg.PassFixDropId[1],
      CPassRandomAward = nil,
      ThreeStarDropId = cfg.ThreeStarDropId and cfg.ThreeStarDropId[1]
    }
    self._awards[diff] = UICommonHelper:GetInstance():GetDropByAwardType(AwardType.Pass, awardCfg, true)
  end
  return self._awards[diff]
end

function UISeasonLevelData:IsPassDiff(diff)
  local cfg = self:GetMissionCfgByDiff(diff)
  if not cfg then
    return true
  end
  return self._lineCpt:IsPassCamMissionID(cfg.ID)
end

function UISeasonLevelData:CheckUnlock()
  self._isUnlock = self:_FitPreCondition(self._normalLevel.NeedMission)
  if self._hardLevel then
    self._isUnlock = self._isUnlock and self:_FitPreCondition(self._hardLevel.NeedMission)
  end
end

function UISeasonLevelData:IsUnlock()
  return self._isUnlock
end

function UISeasonLevelData:_FitPreCondition(cond)
  if string.isnullorempty(cond) then
    return true
  end
  if string.find(cond, "|") then
    local subConds = string.split(cond, "|")
    for _, c in ipairs(subConds) do
      local missionID = tonumber(c)
      if self._lineCpt:IsPassCamMissionID(missionID) then
        return true
      end
    end
    return false
  elseif string.find(cond, "&") then
    local subConds = string.split(cond, "&")
    for _, c in ipairs(subConds) do
      local missionID = tonumber(c)
      if not self._lineCpt:IsPassCamMissionID(missionID) then
        return false
      end
    end
    return true
  else
    local missionID = tonumber(cond)
    return self._lineCpt:IsPassCamMissionID(missionID)
  end
end

function UISeasonLevelData:GroupID()
  return self._groupID
end

function UISeasonLevelData:SetIndex(idx)
  self._index = idx
end

function UISeasonLevelData:Index()
  return self._index
end
