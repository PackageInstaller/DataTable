_class("FeatureEffectParamTetris", FeatureEffectParamBase)
FeatureEffectParamTetris = FeatureEffectParamTetris

function FeatureEffectParamTetris:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamTetris:_RefreshData(t)
  if not t then
    return
  end
  self._defaultTetris = t.defaultTetris or 1
  self._reRollEnable = t.reRollEnable or false
  self._lockEnable = t.lockEnable or false
  self._powerEnable = t.powerEnable or false
  self._defaultCostPower = t.defaultCostPower or 1
  self._maxShowPower = t.maxShowPower or 99
  self._clickCostPower = t.clickCostPower or 1
  self._mainColorEnable = t.mainColorEnable or false
  self._mainColorMaxCount = t.mainColorMaxCount or 4
  self._dirList = t.dirList or {
    HitBackDirectionType.Up,
    HitBackDirectionType.Right,
    HitBackDirectionType.Down,
    HitBackDirectionType.Left
  }
  self._defaultDir = t.defaultDir or HitBackDirectionType.Up
  self._tetrisList = t.tetrisList or {
    FeatureTetrisType.O,
    FeatureTetrisType.I,
    FeatureTetrisType.T,
    FeatureTetrisType.L,
    FeatureTetrisType.S,
    FeatureTetrisType.Z,
    FeatureTetrisType.J
  }
  self._tetrisIconList = t.tetrisIconList
  self._tetrisSmallIconList = t.tetrisSmallIconList
end

function FeatureEffectParamTetris:GetMaxShowPower()
  return self._maxShowPower
end

function FeatureEffectParamTetris:GetClickCostPower()
  return self._clickCostPower
end

function FeatureEffectParamTetris:GetMainColorMaxCount()
  return self._mainColorMaxCount
end

function FeatureEffectParamTetris:GetDefaultCostPower()
  return self._defaultCostPower
end

function FeatureEffectParamTetris:GetDefaultTetrisDir()
  return self._defaultDir
end

function FeatureEffectParamTetris:GetDefaultTetris()
  return self._defaultTetris
end

function FeatureEffectParamTetris:GetReRollEnable()
  return self._reRollEnable
end

function FeatureEffectParamTetris:GetPowerEnable()
  return self._powerEnable
end

function FeatureEffectParamTetris:GetMainColorEnable()
  return self._mainColorEnable
end

function FeatureEffectParamTetris:GetDirList()
  return self._dirList
end

function FeatureEffectParamTetris:GetTetrisList()
  return self._tetrisList
end

function FeatureEffectParamTetris:GetTetrisSmallIconByIndex(index)
  return self._tetrisSmallIconList[index]
end

function FeatureEffectParamTetris:GetTetrisIconByIndex(index)
  return self._tetrisIconList[index]
end

function FeatureEffectParamTetris:GetTetrisIconList()
  return self._tetrisIconList
end

function FeatureEffectParamTetris:GetLockEnable()
  return self._lockEnable
end

function FeatureEffectParamTetris:GetFeatureType()
  return FeatureType.TetrisGame
end

function FeatureEffectParamTetris:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamTetris:CloneSelf()
  local param = FeatureEffectParamTetris:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamTetris:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

local FeatureTetrisType = {
  O = 1,
  I = 2,
  T = 3,
  L = 4,
  S = 5,
  Z = 6,
  J = 7
}
_enum("FeatureTetrisType", FeatureTetrisType)
