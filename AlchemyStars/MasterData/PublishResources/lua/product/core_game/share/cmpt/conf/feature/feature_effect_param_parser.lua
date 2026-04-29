_class("FeatureEffectParamParser", Object)
FeatureEffectParamParser = FeatureEffectParamParser

function FeatureEffectParamParser:Constructor()
  self._effectParamClassDict = {}
  self._effectParamClassDict[FeatureType.Sanity] = FeatureEffectParamSan
  self._effectParamClassDict[FeatureType.DayNight] = FeatureEffectParamDayNight
  self._effectParamClassDict[FeatureType.PersonaSkill] = FeatureEffectParamPersonaSkill
  self._effectParamClassDict[FeatureType.Card] = FeatureEffectParamCard
  self._effectParamClassDict[FeatureType.MasterSkill] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.Scan] = FeatureEffectParamScan
  self._effectParamClassDict[FeatureType.MasterSkillRecover] = FeatureEffectParamMasterSkillRecover
  self._effectParamClassDict[FeatureType.MasterSkillTeleport] = FeatureEffectParamMasterSkillTeleport
  self._effectParamClassDict[FeatureType.TrapCount] = FeatureEffectParamTrapCount
  self._effectParamClassDict[FeatureType.PopStar] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.TrapDefence] = FeatureEffectParamTrapDefence
  self._effectParamClassDict[FeatureType.PopStar1] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar2] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar3] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar4] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar5] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar6] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar7] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar8] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar9] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.PopStar10] = FeatureEffectParamPopStar
  self._effectParamClassDict[FeatureType.Shop] = FeatureEffectParamShop
  self._effectParamClassDict[FeatureType.StepPoint] = FeatureEffectParamStepPoint
  self._effectParamClassDict[FeatureType.BanPetSkill] = FeatureEffectParamBanPetSkill
  self._effectParamClassDict[FeatureType.TalentSkill1] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.TalentSkill2] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.TalentSkill3] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.TalentSkill4] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.TalentSkill5] = FeatureEffectParamMasterSkill
  self._effectParamClassDict[FeatureType.AlgorithmUpgrade] = FeatureEffectParamAlgorithmUpgrade
  self._effectParamClassDict[FeatureType.AutoBeadPowerInfo] = FeatureEffectParamAutoBeadPowerInfo
  self._effectParamClassDict[FeatureType.Alchemy] = FeatureEffectParamAlchemy
  self._effectParamClassDict[FeatureType.TetrisGame] = FeatureEffectParamTetris
end

function FeatureEffectParamParser:ParseFeatureEffectParam(featureType, effectParam)
  local classType = self._effectParamClassDict[featureType]
  if classType == nil then
    Log.error("ParseFeatureEffectParam cant find featureType ", featureType)
  end
  local paramDataObj = classType:New(effectParam)
  if paramDataObj then
    paramDataObj:SetFeatureType(featureType)
  end
  return paramDataObj
end
