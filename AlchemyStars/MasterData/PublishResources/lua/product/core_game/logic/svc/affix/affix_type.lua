local AffixType = {
  None = 0,
  ChangePetAttr = 1,
  ChangePetChainCount = 2,
  CloseAuroraTime = 3,
  TeamLeadOnlyInElementAttack = 4,
  ChangeMonsterAttr = 5,
  ReplaceMonsterAI = 6,
  ReplaceMonsterSkill = 7,
  ReplaceLevelComplete = 8,
  ChangeTrapAttr = 9,
  PlayerBeHitLimit = 10,
  AddAffixBuff = 11,
  ChangeWaveBeginMonsterID = 12,
  ChangeWaveInternalMonsterID = 13,
  ChangeWaveBeginTrapID = 14,
  ChangeWaveInternalTrapID = 15,
  AddWaveBeginMonsterIDAndPos = 16,
  AddWaveInternalMonsterIDAndPos = 17,
  AddWaveBeginTrapIDAndPos = 18,
  AddWaveInternalTrapIDAndPos = 19,
  ChangeAllMonsterAttr = 20,
  ChangeLevelRound = 21,
  ChangeWaveInternalParam = 22,
  AddWaveInternalParam = 23,
  ReplaceMonsterBuff = 24,
  ReplaceMonsterEliteBuff = 25,
  AddMonsterBuff = 26,
  AddMonsterEliteBuff = 27,
  ReplaceTrapSkill = 28,
  ReplaceTrapBuff = 29,
  AddTrapBuff = 30,
  ReplaceMonsterSpSkill = 31,
  ChangePieceRefreshType = 32,
  ReplaceFeatureModule = 33,
  NoAuroraTimeLimit = 34,
  ReplacePieceGenWeight = 35,
  IncreasePetNoDefenceDamage = 36,
  ChangePetAddBuffMaxRound = 37,
  AddChainPathNum = 38
}
_enum("AffixType", AffixType)
local ChangePetAttrType = {
  AllPetCurHPPercent = 1,
  AllPetMaxHPPercent = 2,
  AllPetDefence = 3
}
_enum("ChangePetAttrType", ChangePetAttrType)
local AffixAttrType = {
  HP = 1,
  Attack = 2,
  Defence = 3
}
_enum("AffixAttrType", AffixAttrType)
local ChangeMonsterAttrType = {
  ReplaceHP = 1,
  ReplaceAttack = 2,
  ReplaceDefence = 3
}
_enum("ChangeMonsterAttrType", ChangeMonsterAttrType)
local ChangeTrapAttrType = {
  ReplaceHP = 1,
  ReplaceAttack = 2,
  ReplaceDefence = 3
}
_enum("ChangeTrapAttrType", ChangeTrapAttrType)
local ReplaceMonsterSpSkillType = {
  Appear = 1,
  Die = 2,
  Drop = 3
}
_enum("ReplaceMonsterSpSkillType", ReplaceMonsterSpSkillType)
local PieceRefreshType = {
  Inplace = 1,
  FallingDown = 2,
  Destroy = 3
}
_enum("PieceRefreshType", PieceRefreshType)
local AffixHideUIType = {None = 0, HideInGame = 1}
_enum("AffixHideUIType", AffixHideUIType)
