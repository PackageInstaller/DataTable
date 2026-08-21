_class("FeatureEffectParamAlchemyData", Object)
FeatureEffectParamAlchemyData = FeatureEffectParamAlchemyData

function FeatureEffectParamAlchemyData:Constructor(level, ap, buffList, desc)
  self._level = level
  self._ap = ap
  self._buffList = buffList
  self._desc = desc
end

function FeatureEffectParamAlchemyData:GetLevel()
  return self._level
end

function FeatureEffectParamAlchemyData:GetAP()
  return self._ap
end

function FeatureEffectParamAlchemyData:GetBuffList()
  return self._buffList
end

function FeatureEffectParamAlchemyData:GetDesc()
  return self._desc
end

_class("FeatureEffectParamAlchemy", FeatureEffectParamBase)
FeatureEffectParamAlchemy = FeatureEffectParamAlchemy

function FeatureEffectParamAlchemy:Constructor(t)
  if not t then
    return
  end
  self._dataList = {}
  self:_RefreshData(t)
end

function FeatureEffectParamAlchemy:_RefreshData(t)
  if not t then
    return
  end
  self._dataList = {}
  for i, v in ipairs(t) do
    local data = FeatureEffectParamAlchemyData:New(v.Level, v.AP, v.BuffList, v.Desc)
    self._dataList[v.Level] = data
  end
end

function FeatureEffectParamAlchemy:GetFeatureType()
  return FeatureType.Alchemy
end

function FeatureEffectParamAlchemy:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamAlchemy:CloneSelf()
  local param = FeatureEffectParamAlchemy:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamAlchemy:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamAlchemy:GetLevelData(level)
  return self._dataList[level]
end

function FeatureEffectParamAlchemy:GetAllData()
  return self._dataList
end
