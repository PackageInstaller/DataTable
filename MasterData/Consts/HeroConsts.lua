eHeroCardRareType = {
  SSR = 3,
  SR = 2,
  R = 1
}
HeroRareColor = {
  [eHeroCardRareType.SSR] = Color.New(1, 0.545, 0.031, 1),
  [eHeroCardRareType.SR] = Color.New(0.701, 0.411, 0.952, 1),
  [eHeroCardRareType.R] = Color.New(0.172, 0.6, 1, 1)
}
HeroRareString = {
  [eHeroCardRareType.SSR] = "SSR",
  [eHeroCardRareType.SR] = "SR",
  [eHeroCardRareType.R] = "R"
}
eHeroShowAttrList = {
  2,
  3,
  4,
  12,
  5,
  7,
  9,
  10,
  13,
  11
}
eHeroShowTag = {
  [1] = "tag_dps_1",
  [2] = "tag_assassin_2",
  [3] = "tag_healing_3",
  [4] = "tag_control_4",
  [5] = "tag_defense_5",
  [6] = "tag_assist_6"
}
eHeroSkillType = {
  BattleSkill = 1,
  LifeSkill = 2,
  UltimateSkill = 3
}
eBattleSkillType = {
  Attack = 1,
  Recovery = 2,
  Defense = 3,
  Special = 4
}
eBattleSkillTypeColor = {
  [eBattleSkillType.Attack] = Color.New(0.82, 0.14, 0.14, 1),
  [eBattleSkillType.Recovery] = Color.New(0.57, 0.82, 0.16, 1),
  [eBattleSkillType.Defense] = Color.New(0.11, 0.63, 0.85, 1),
  [eBattleSkillType.Special] = Color.New(0.49, 0.54, 0.63, 1)
}
