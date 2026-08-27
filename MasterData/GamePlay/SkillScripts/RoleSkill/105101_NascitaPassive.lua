local bs_105101 = class("bs_105101", LuaSkillBase)
local base = LuaSkillBase
bs_105101.config = {
  buffId_lowHeal = 3018,
  buffId_claw = 1051012,
  selectId = 9,
  selectRange = 10,
  realHurt = {basehurt_formula = 3000},
  weaponLv = 0
}

function bs_105101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, self.OnNascitaAttack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105101_1", 2, self.OnAfterBattleStart)
end

function bs_105101:OnAfterBattleStart()
  self.caster.recordTable.MaxAttackCount = self.arglist[1]
  self.caster.recordTable.SplashAttackCount = self.arglist[2]
  self.caster.recordTable.SplashAttackLow = self.arglist[6]
end

function bs_105101:OnNascitaAttack(target, sender, skill)
  if sender.hp <= 0 then
    return
  end
  self:MaxHpDownBuff(target)
end

function bs_105101:MaxHpDownBuff(target)
  if target.hp <= 0 or target.recordTable.WillowPic == true then
    return
  end
  LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.realHurt, {
    self.arglist[4]
  }, true)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_lowHeal, 1)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_claw, 1)
end

function bs_105101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105101
