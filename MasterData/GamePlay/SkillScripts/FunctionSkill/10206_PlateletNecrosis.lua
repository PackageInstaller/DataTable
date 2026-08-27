local bs_10206 = class("bs_10206", LuaSkillBase)
local base = LuaSkillBase
bs_10206.config = {
  buffId = 195,
  effectId = 134,
  realDamageConfig = {basehurt_formula = 10072},
  nEffectId = 10756,
  nEffectId2 = 10757
}

function bs_10206:ctor()
end

function bs_10206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10206_3", 3, self.OnAfterPlaySkill)
  self.time = 0
end

function bs_10206:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isCommonAttack then
    if self.time >= self.arglist[2] - 1 then
      self.time = 0
      LuaSkillCtrl:CallBuff(self, self.caster.recordTable.lastAttackRole, self.config.buffId, self.arglist[1], 75)
    else
      self.time = self.time + 1
    end
  end
end

function bs_10206:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10206:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10206
