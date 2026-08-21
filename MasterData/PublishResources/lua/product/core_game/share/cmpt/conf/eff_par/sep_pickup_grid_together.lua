_class("SkillEffectParam_PickUpGridTogether", SkillEffectParamBase)
SkillEffectParam_PickUpGridTogether = SkillEffectParam_PickUpGridTogether

function SkillEffectParam_PickUpGridTogether:Constructor(t)
  self._gridType = t.gridType
end

function SkillEffectParam_PickUpGridTogether:GetGridType()
  return self._gridType
end

function SkillEffectParam_PickUpGridTogether:GetEffectType()
  return SkillEffectType.PickUpGridTogether
end

_class("PickUpGridTogetherData", Object)
PickUpGridTogetherData = PickUpGridTogetherData

function PickUpGridTogetherData:Constructor(gridType, gridPos, canConvert)
  self._gridType = gridType
  self._gridPos = gridPos
  self._canConvert = canConvert
end

function PickUpGridTogetherData:SetGridPos(pos)
  self._gridPos = pos
end

function PickUpGridTogetherData:GetGridType()
  return self._gridType
end

function PickUpGridTogetherData:GetGridPos()
  return self._gridPos
end

function PickUpGridTogetherData:IsCanConvert()
  return self._canConvert
end
