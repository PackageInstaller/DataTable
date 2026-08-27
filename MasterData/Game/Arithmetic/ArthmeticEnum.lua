local ATHEnum = {}
ATHEnum.AthQualityColor = {
  [eItemQualityType.White] = Color.white,
  [eItemQualityType.Blue] = Color.New(0.164, 0.69, 0.937, 1),
  [eItemQualityType.Purple] = Color.New(0.768, 0.36, 1, 1),
  [eItemQualityType.Orange] = Color.New(1, 0.643, 0.098, 1)
}
ATHEnum.AthColor = {
  [eItemQualityType.White] = Color.New(0.75, 0.68, 0.68, 1),
  [eItemQualityType.Green] = Color.New(0.458, 0.725, 0.364, 1),
  [eItemQualityType.Blue] = Color.New(0.164, 0.69, 0.937, 1),
  [eItemQualityType.Purple] = Color.New(0.768, 0.36, 1, 1),
  [eItemQualityType.Orange] = Color.New(1, 0.643, 0.098, 1)
}
ATHEnum.AthEfccQuickSelectEnum = {
  Blue = 1,
  Purple = 2,
  Orange = 3,
  Material = 4
}
ATHEnum.AthEfccQuickSelectEnumNum = 4
ATHEnum.StrengthenQuality = 5
ATHEnum.AthRfctBetterQualityWeight = {
  [eItemQualityType.White] = 1,
  [eItemQualityType.Blue] = 2,
  [eItemQualityType.Purple] = 4,
  [eItemQualityType.Orange] = 8
}
ATHEnum.AthSuitConflictMax = 3

function ATHEnum.GetAthRfctBetterQualityWeight(quality)
  local weight = ATHEnum.AthRfctBetterQualityWeight[quality]
  if weight == nil then
    error("Unsurpported AthRfctBetterQualityWeight, quality:" .. tostring(quality))
    return 0
  end
  return weight
end

return ATHEnum
