_class("SkillEffectResult_PickUpGridTogether", SkillEffectResultBase)
SkillEffectResult_PickUpGridTogether = SkillEffectResult_PickUpGridTogether

function SkillEffectResult_PickUpGridTogether:Constructor(newGridDataList)
  self._newGridDataList = newGridDataList
end

function SkillEffectResult_PickUpGridTogether:GetNewGridDataList()
  return self._newGridDataList
end

function SkillEffectResult_PickUpGridTogether:GetEffectType()
  return SkillEffectType.PickUpGridTogether
end

function SkillEffectResult_PickUpGridTogether:GetPosList()
  return self._posList
end

function SkillEffectResult_PickUpGridTogether:GetOldGridTypeList()
  return self._oldGridTypeList
end

function SkillEffectResult_PickUpGridTogether:GetNewGridTypeList()
  return self._newGridTypeList
end
