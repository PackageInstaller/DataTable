require("skill_effect_param_base")
local AddBlood_Type = {
  Percent = 1,
  AbsData = 2,
  Attribute = 3,
  HighestHPOfBoss = 4,
  AttributeList = 5,
  LastCastActiveSkillPet = 6,
  AttributeAndTargetBodyAreaInSkillRangeCount = 7,
  LostHPPercent = 8,
  ByLayerAndAttr = 9,
  PetAliveMultiplyAbsData = 10,
  Max = 99
}
_enum("AddBlood_Type", AddBlood_Type)
local AddBlood_Attribute = {
  START = 0,
  None = 0,
  Attack = 1,
  Defense = 2,
  MaxHP = 3,
  TeamLoseHp = 4,
  LocalTeamLostHP = 5,
  END = 6
}
_enum("AddBlood_Attribute", AddBlood_Attribute)
_class("SkillEffectParam_AddBlood", SkillEffectParamBase)
SkillEffectParam_AddBlood = SkillEffectParam_AddBlood

function SkillEffectParam_AddBlood:Constructor(t)
  self.m_nType = t.type
  self.m_nData = t.data
  self.m_nAttribute = AddBlood_Attribute.None
  if t.Attribute ~= nil and type(t.Attribute) == "number" and t.Attribute > AddBlood_Attribute.START and t.Attribute < AddBlood_Attribute.END then
    self.m_nAttribute = t.Attribute
  end
  self.m_nAttributePer = 0
  if t.AttributePer ~= nil and type(t.AttributePer) == "number" then
    self.m_nAttributePer = t.AttributePer
  end
  self.m_nAddBloodRateByDefender = t.AddBloodByDefender
  self.m_nDataList = t.dataList
  self.m_nAttributeList = t.AttributeList
  self.m_nAttributePerList = t.AttributePerList
  self._buffLayerType = t.buffLayerType
  self._costLayer = t.costLayer
  self._perLayer = t.perLayer
end

function SkillEffectParam_AddBlood:GetBuffLayerType()
  return self._buffLayerType
end

function SkillEffectParam_AddBlood:GetCostLayer()
  return self._costLayer
end

function SkillEffectParam_AddBlood:GetPerLayer()
  return self._perLayer
end

function SkillEffectParam_AddBlood:GetEffectType()
  return SkillEffectType.AddBlood
end

function SkillEffectParam_AddBlood:GetType()
  return self.m_nType
end

function SkillEffectParam_AddBlood:GetData()
  return self.m_nData or 0
end

function SkillEffectParam_AddBlood:GetAttribute()
  return self.m_nAttribute
end

function SkillEffectParam_AddBlood:GetAttributePer()
  return self.m_nAttributePer
end

function SkillEffectParam_AddBlood:GetAddBloodRateByDefender()
  return self.m_nAddBloodRateByDefender
end

function SkillEffectParam_AddBlood:GetDataList()
  return self.m_nDataList
end

function SkillEffectParam_AddBlood:GetAttributeList()
  return self.m_nAttributeList
end

function SkillEffectParam_AddBlood:GetAttributePerList()
  return self.m_nAttributePerList
end
