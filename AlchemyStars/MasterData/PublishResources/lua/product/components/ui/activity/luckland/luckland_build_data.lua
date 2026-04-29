_class("LuckLandBuildData", Object)
LuckLandBuildData = LuckLandBuildData

function LuckLandBuildData:Constructor(id)
  self._id = id
  self._cfg = Cfg.cfg_luckland_client_build[self._id]
  if not self._cfg then
    Log.error("cfg_luckland_client_build error.", id)
    return
  end
  self._level = self._cfg.ID % 100
end

function LuckLandBuildData:Cfg()
  return self._cfg
end

function LuckLandBuildData:ID()
  return self._id
end

function LuckLandBuildData:Type()
  return self._cfg.BuildType
end

function LuckLandBuildData:Icon()
  return self._cfg.BuildIcon
end

function LuckLandBuildData:Name()
  return self._cfg.BuildName
end

function LuckLandBuildData:Desc()
  return self._cfg.BuildDesc
end

function LuckLandBuildData:MaxLevel()
  return self._cfg.MaxLevel
end

function LuckLandBuildData:UpgradeCost(id)
  local cfg = Cfg.cfg_luckland_client_build[id]
  if cfg then
    return cfg.UpgradeCost
  end
  return nil
end

function LuckLandBuildData:GetLevelTip(id)
  local cfg = Cfg.cfg_luckland_client_build[id]
  if cfg then
    return cfg.BuildLevelTips
  end
  return nil
end

function LuckLandBuildData:GetCurLevel()
  return self._level
end

function LuckLandBuildData:Upgrade()
  local nextID = self._id + 1
  local nextLevel = nextID % 100
  if nextLevel > self:MaxLevel() then
    return
  end
  self._id = nextID
  self._level = nextLevel
  self._cfg = Cfg.cfg_luckland_client_build[self._id]
end
