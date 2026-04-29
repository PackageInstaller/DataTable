local TrailLevelLayerType = {Normal = 0, Final = 1}
_enum("TrailLevelLayerType", TrailLevelLayerType)
_class("UITrailLevelLayerData", Object)
UITrailLevelLayerData = UITrailLevelLayerData

function UITrailLevelLayerData:Constructor(cfg)
  self._layerId = cfg.ID
  self._layerName = StringTable.Get(cfg.LayerName)
  self._layerType = cfg.LayerType
  self._layerIcon = cfg.LayerIcon
  local levelCfgs = Cfg.cfg_tale_stage({
    Type = 2,
    Tier = self._layerId
  })
  self._levelDatas = {}
  if levelCfgs then
    for i = 1, #levelCfgs do
      local data = UITrailLevelData:New(levelCfgs[i])
      self._levelDatas[#self._levelDatas + 1] = data
    end
  end
end

function UITrailLevelLayerData:GetLayerId()
  return self._layerId
end

function UITrailLevelLayerData:GetLayerName()
  return self._layerName
end

function UITrailLevelLayerData:GetLayerIcon()
  return self._layerIcon
end

function UITrailLevelLayerData:GetLayerType()
  return self._layerType
end

function UITrailLevelLayerData:GetLevelDatas()
  return self._levelDatas
end

_class("UITrailLevelData", Object)
UITrailLevelData = UITrailLevelData

function UITrailLevelData:Constructor(cfg)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  self._id = cfg.ID
  self._type = cfg.Type
  self._levelLayer = cfg.Tier
  self._fightLevelId = cfg.FightLevelid
  self._firstDropId = cfg.FirstDropId
  self._levelBg = cfg.LevelBg
  self._icon = cfg.Icon
  self._name = StringTable.Get(cfg.Name)
  self._elementIcon1 = cfg.ElementIcon1
  self._elementIcon2 = cfg.ElementIcon2
  self._hasComplete = talePetModule:HasCompletLevel(self._id)
end

function UITrailLevelData:GetId()
  return self._id
end

function UITrailLevelData:GetType()
  return self._type
end

function UITrailLevelData:GetLevelLayer()
  return self._levelLayer
end

function UITrailLevelData:GetFightLevelId()
  return self._fightLevelId
end

function UITrailLevelData:GetFirstDropId()
  return self._firstDropId
end

function UITrailLevelData:GetLevelBg()
  return self._levelBg
end

function UITrailLevelData:GetIcon()
  return self._icon
end

function UITrailLevelData:GetName()
  return self._name
end

function UITrailLevelData:GetElementIcon1()
  return self._elementIcon1
end

function UITrailLevelData:GetElementIcon2()
  return self._elementIcon2
end

function UITrailLevelData:IsComplete()
  return self._hasComplete
end
