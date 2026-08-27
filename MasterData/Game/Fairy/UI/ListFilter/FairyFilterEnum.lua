local FairyFilterEnum = {}
FairyFilterEnum.eKindType = {
  Rank = 1,
  Quality = 2,
  Type = 3
}
FairyFilterEnum.eKindMaxCount = {
  [FairyFilterEnum.eKindType.Rank] = #ConfigData.fairy_star_new,
  [FairyFilterEnum.eKindType.Quality] = #ConfigData.fairy_skill_weight,
  [FairyFilterEnum.eKindType.Type] = #ConfigData.fairy_data
}
return FairyFilterEnum
