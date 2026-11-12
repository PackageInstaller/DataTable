local AttrConfig = {}
local CharAttrList = {
  Hp = {
    sKey = "Hp",
    nConfigType = AllEnum.CharConfigType.Attr,
    bDifferentiate = true,
    bAllEffectSub = true
  },
  Atk = {
    sKey = "Atk",
    nConfigType = AllEnum.CharConfigType.Attr,
    bDifferentiate = true,
    bAllEffectSub = true
  },
  Def = {
    sKey = "Def",
    nConfigType = AllEnum.CharConfigType.Attr,
    bDifferentiate = true,
    bAllEffectSub = true
  },
  CritRate = {
    sKey = "CritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true,
    bDifferentiate = true
  },
  CritPower = {
    sKey = "CritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true,
    bDifferentiate = true
  },
  Suppress = {
    sKey = "Suppress",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  UltraEnergy = {
    sKey = "UltraEnergy",
    nConfigType = AllEnum.CharConfigType.Skill,
    bIntFloat = true
  },
  EnergyEfficiency = {
    sKey = "EnergyEfficiency",
    nConfigType = AllEnum.CharConfigType.Char,
    bIntFloat = true,
    bPercent = true
  },
  EnergyConvRatio = {
    sKey = "EnergyConvRatio",
    nConfigType = AllEnum.CharConfigType.Char,
    bIntFloat = true,
    bPercent = true
  },
  DefPierce = {
    sKey = "DefPierce",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  DefIgnore = {
    sKey = "DefIgnore",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  WEE = {
    sKey = "WEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  WEP = {
    sKey = "WEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  WEI = {
    sKey = "WEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  FEE = {
    sKey = "FEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  FEP = {
    sKey = "FEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  FEI = {
    sKey = "FEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  SEE = {
    sKey = "SEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  SEP = {
    sKey = "SEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  SEI = {
    sKey = "SEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  AEE = {
    sKey = "AEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  AEP = {
    sKey = "AEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  AEI = {
    sKey = "AEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  LEE = {
    sKey = "LEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  LEP = {
    sKey = "LEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  LEI = {
    sKey = "LEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  DEE = {
    sKey = "DEE",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  DEP = {
    sKey = "DEP",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  DEI = {
    sKey = "DEI",
    nConfigType = AllEnum.CharConfigType.Attr,
    bIntFloat = true,
    bPercent = true
  },
  AtkSpd = {
    sKey = "AtkSpd",
    nConfigType = AllEnum.CharConfigType.Char,
    bIntFloat = true,
    bPercent = true
  },
  WER = {
    sKey = "WER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  SER = {
    sKey = "SER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  AER = {
    sKey = "AER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  FER = {
    sKey = "FER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  LER = {
    sKey = "LER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  DER = {
    sKey = "DER",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  WEERCD = {
    sKey = "WEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  FEERCD = {
    sKey = "FEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SEERCD = {
    sKey = "SEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  AEERCD = {
    sKey = "AEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  LEERCD = {
    sKey = "LEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  DEERCD = {
    sKey = "DEERCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  GENDMGRCD = {
    sKey = "GENDMGRCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  DMGPLUSRCD = {
    sKey = "DMGPLUSRCD",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  NORMALDMG = {
    sKey = "NORMALDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SKILLDMG = {
    sKey = "SKILLDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  ULTRADMG = {
    sKey = "ULTRADMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  OTHERDMG = {
    sKey = "OTHERDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  MARKDMG = {
    sKey = "MARKDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDNORMALDMG = {
    sKey = "RCDNORMALDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDSKILLDMG = {
    sKey = "RCDSKILLDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDULTRADMG = {
    sKey = "RCDULTRADMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDOTHERDMG = {
    sKey = "RCDOTHERDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDMARKDMG = {
    sKey = "RCDMARKDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  GENDMG = {
    sKey = "GENDMG",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  DMGPLUS = {
    sKey = "DMGPLUS",
    nConfigType = AllEnum.CharConfigType.Attr
  },
  FINALDMG = {
    sKey = "FINALDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  FINALDMGPLUS = {
    sKey = "FINALDMGPLUS",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SUMMONDMG = {
    sKey = "SUMMONDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDSUMMONDMG = {
    sKey = "RCDSUMMONDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  PROJECTILEDMG = {
    sKey = "PROJECTILEDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  RCDPROJECTILEDMG = {
    sKey = "RCDPROJECTILEDMG",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  NormalCritRate = {
    sKey = "NormalCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SkillCritRate = {
    sKey = "SkillCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  UltraCritRate = {
    sKey = "UltraCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  MarkCritRate = {
    sKey = "MarkCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SummonCritRate = {
    sKey = "SummonCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  ProjectileCritRate = {
    sKey = "ProjectileCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  OtherCritRate = {
    sKey = "OtherCritRate",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  NormalCritPower = {
    sKey = "NormalCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SkillCritPower = {
    sKey = "SkillCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  UltraCritPower = {
    sKey = "UltraCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  SummonCritPower = {
    sKey = "SummonCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  MarkCritPower = {
    sKey = "MarkCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  OtherCritPower = {
    sKey = "OtherCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  },
  ProjectileCritPower = {
    sKey = "ProjectileCritPower",
    nConfigType = AllEnum.CharConfigType.Attr,
    bPercent = true
  }
}
local EffectTypeToAttr = {
  [GameEnum.effectType.ATTR_FIX] = {
    [GameEnum.effectAttributeType.ATK] = CharAttrList.Atk,
    [GameEnum.effectAttributeType.DEF] = CharAttrList.Def,
    [GameEnum.effectAttributeType.MAXHP] = CharAttrList.Hp,
    [GameEnum.effectAttributeType.HITRATE] = nil,
    [GameEnum.effectAttributeType.EVD] = nil,
    [GameEnum.effectAttributeType.CRITRATE] = CharAttrList.CritRate,
    [GameEnum.effectAttributeType.CRITRESIST] = nil,
    [GameEnum.effectAttributeType.CRITPOWER_P] = CharAttrList.CritPower,
    [GameEnum.effectAttributeType.PENETRATE] = CharAttrList.DefPierce,
    [GameEnum.effectAttributeType.DEF_IGNORE] = CharAttrList.DefIgnore,
    [GameEnum.effectAttributeType.WER] = CharAttrList.WER,
    [GameEnum.effectAttributeType.FER] = CharAttrList.FER,
    [GameEnum.effectAttributeType.SER] = CharAttrList.SER,
    [GameEnum.effectAttributeType.AER] = CharAttrList.AER,
    [GameEnum.effectAttributeType.LER] = CharAttrList.LER,
    [GameEnum.effectAttributeType.DER] = CharAttrList.DER,
    [GameEnum.effectAttributeType.WEE] = CharAttrList.WEE,
    [GameEnum.effectAttributeType.FEE] = CharAttrList.FEE,
    [GameEnum.effectAttributeType.SEE] = CharAttrList.SEE,
    [GameEnum.effectAttributeType.AEE] = CharAttrList.AEE,
    [GameEnum.effectAttributeType.LEE] = CharAttrList.LEE,
    [GameEnum.effectAttributeType.DEE] = CharAttrList.DEE,
    [GameEnum.effectAttributeType.WEP] = CharAttrList.WEP,
    [GameEnum.effectAttributeType.FEP] = CharAttrList.FEP,
    [GameEnum.effectAttributeType.SEP] = CharAttrList.SEP,
    [GameEnum.effectAttributeType.AEP] = CharAttrList.AEP,
    [GameEnum.effectAttributeType.LEP] = CharAttrList.LEP,
    [GameEnum.effectAttributeType.DEP] = CharAttrList.DEP,
    [GameEnum.effectAttributeType.WEI] = CharAttrList.WEI,
    [GameEnum.effectAttributeType.FEI] = CharAttrList.FEI,
    [GameEnum.effectAttributeType.SEI] = CharAttrList.SEI,
    [GameEnum.effectAttributeType.AEI] = CharAttrList.AEI,
    [GameEnum.effectAttributeType.LEI] = CharAttrList.LEI,
    [GameEnum.effectAttributeType.DEI] = CharAttrList.DEI,
    [GameEnum.effectAttributeType.WEERCD] = CharAttrList.WEERCD,
    [GameEnum.effectAttributeType.FEERCD] = CharAttrList.FEERCD,
    [GameEnum.effectAttributeType.SEERCD] = CharAttrList.SEERCD,
    [GameEnum.effectAttributeType.AEERCD] = CharAttrList.AEERCD,
    [GameEnum.effectAttributeType.LEERCD] = CharAttrList.LEERCD,
    [GameEnum.effectAttributeType.DEERCD] = CharAttrList.DEERCD,
    [GameEnum.effectAttributeType.WEIGHT] = nil,
    [GameEnum.effectAttributeType.TOUGHNESS_MAX] = nil,
    [GameEnum.effectAttributeType.TOUGHNESS_DAMAGE_ADJUST] = nil,
    [GameEnum.effectAttributeType.SHIELD_MAX] = nil,
    [GameEnum.effectAttributeType.SHIELD_MAX] = nil,
    [GameEnum.effectAttributeType.MOVESPEED] = nil,
    [GameEnum.effectAttributeType.ATKSPD_P] = CharAttrList.AtkSpd,
    [GameEnum.effectAttributeType.INTENSITY] = nil,
    [GameEnum.effectAttributeType.GENDMG] = CharAttrList.GENDMG,
    [GameEnum.effectAttributeType.DMGPLUS] = CharAttrList.DMGPLUS,
    [GameEnum.effectAttributeType.FINALDMG] = CharAttrList.FINALDMG,
    [GameEnum.effectAttributeType.FINALDMGPLUS] = CharAttrList.FINALDMGPLUS,
    [GameEnum.effectAttributeType.GENDMGRCD] = CharAttrList.GENDMGRCD,
    [GameEnum.effectAttributeType.DMGPLUSRCD] = nil,
    [GameEnum.effectAttributeType.SUPPRESS] = CharAttrList.Suppress,
    [GameEnum.effectAttributeType.NORMALDMG] = CharAttrList.NORMALDMG,
    [GameEnum.effectAttributeType.SKILLDMG] = CharAttrList.SKILLDMG,
    [GameEnum.effectAttributeType.ULTRADMG] = CharAttrList.ULTRADMG,
    [GameEnum.effectAttributeType.OTHERDMG] = CharAttrList.OTHERDMG,
    [GameEnum.effectAttributeType.RCDNORMALDMG] = CharAttrList.RCDNORMALDMG,
    [GameEnum.effectAttributeType.RCDSKILLDMG] = CharAttrList.RCDSKILLDMG,
    [GameEnum.effectAttributeType.RCDULTRADMG] = CharAttrList.RCDULTRADMG,
    [GameEnum.effectAttributeType.RCDOTHERDMG] = CharAttrList.RCDOTHERDMG,
    [GameEnum.effectAttributeType.MARKDMG] = CharAttrList.MARKDMG,
    [GameEnum.effectAttributeType.RCDMARKDMG] = CharAttrList.RCDMARKDMG,
    [GameEnum.effectAttributeType.SUMMONDMG] = CharAttrList.SUMMONDMG,
    [GameEnum.effectAttributeType.RCDSUMMONDMG] = CharAttrList.RCDSUMMONDMG,
    [GameEnum.effectAttributeType.PROJECTILEDMG] = CharAttrList.PROJECTILEDMG,
    [GameEnum.effectAttributeType.RCDPROJECTILEDMG] = CharAttrList.RCDPROJECTILEDMG,
    [GameEnum.effectAttributeType.NORMALCRITRATE] = CharAttrList.NormalCritRate,
    [GameEnum.effectAttributeType.SKILLCRITRATE] = CharAttrList.SkillCritRate,
    [GameEnum.effectAttributeType.ULTRACRITRATE] = CharAttrList.UltraCritRate,
    [GameEnum.effectAttributeType.MARKCRITRATE] = CharAttrList.MarkCritRate,
    [GameEnum.effectAttributeType.SUMMONCRITRATE] = CharAttrList.SummonCritRate,
    [GameEnum.effectAttributeType.PROJECTILECRITRATE] = CharAttrList.ProjectileCritRate,
    [GameEnum.effectAttributeType.OTHERCRITRATE] = CharAttrList.OtherCritRate,
    [GameEnum.effectAttributeType.NORMALCRITPOWER] = CharAttrList.NormalCritPower,
    [GameEnum.effectAttributeType.SKILLCRITPOWER] = CharAttrList.SkillCritPower,
    [GameEnum.effectAttributeType.ULTRACRITPOWER] = CharAttrList.UltraCritPower,
    [GameEnum.effectAttributeType.MARKCRITPOWER] = CharAttrList.MarkCritPower,
    [GameEnum.effectAttributeType.SUMMONCRITPOWER] = CharAttrList.SummonCritPower,
    [GameEnum.effectAttributeType.PROJECTILECRITPOWER] = CharAttrList.ProjectileCritPower,
    [GameEnum.effectAttributeType.OTHERCRITPOWER] = CharAttrList.OtherCritPower,
    [GameEnum.effectAttributeType.ENERGY_MAX] = nil
  },
  [GameEnum.effectType.PLAYER_ATTR_FIX] = {
    [GameEnum.playerAttributeType.FRONT_ADD_ENERGY] = CharAttrList.EnergyEfficiency,
    [GameEnum.playerAttributeType.ADD_ENERGY] = CharAttrList.EnergyConvRatio
  }
}

function AttrConfig.GetAttrByEffectType(nEffectType, nEffectSubType)
  return EffectTypeToAttr[nEffectType][nEffectSubType]
end

function AttrConfig.GetCharAttrList()
  return CharAttrList
end

return AttrConfig
