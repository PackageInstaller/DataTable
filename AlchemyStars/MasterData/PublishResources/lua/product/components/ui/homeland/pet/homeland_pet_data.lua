_class("HomelandPetData", Object)
HomelandPetData = HomelandPetData

function HomelandPetData:Constructor(tmpID, pstID, level, awake, breakL, skin)
  self._tmpID = tmpID
  self._pstID = pstID
  self._awake = awake
  self._level = level
  self._break = breakL
  self._skin = skin
  self._prefab = HelperProxy:GetInstance():GetPetPrefab(tmpID, awake, skin, PetSkinEffectPath.MODEL_AIRCRAFT)
end

function HomelandPetData:TmpID()
  return self._tmpID
end

function HomelandPetData:PstID()
  return self._pstID
end

function HomelandPetData:Awake()
  return self._awake
end

function HomelandPetData:SkinID()
  return self._skin
end

function HomelandPetData:Prefab()
  return self._prefab
end
