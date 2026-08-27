local HeroSkillUpgradeEnum = {}
HeroSkillUpgradeEnum.SkillType = {
  undefined = -1,
  active = 0,
  passive = 1,
  uSkill = 2
}
HeroSkillUpgradeEnum.SkillAdaptation = {SpecWeapon = 1, Entropization = 2}
HeroSkillUpgradeEnum.SkillColor = {
  [HeroSkillUpgradeEnum.SkillAdaptation.SpecWeapon] = Color.New(1, 0.6, 0, 1),
  [HeroSkillUpgradeEnum.SkillAdaptation.Entropization] = Color.New(0.64, 0.27, 1, 1)
}
return HeroSkillUpgradeEnum
