local bs_21151 = class("bs_21151", LuaSkillBase)
local base = LuaSkillBase
bs_21151.config = {buffId = 3004}

function bs_21151:ctor()
end

function bs_21151:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_21151_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21151_1", 1, self.OnAfterBattleStart)
  self.Num = 0
end

function bs_21151:OnAfterBattleStart()
  if self.Num == 0 and self.caster.hp * 1000 // self.caster.maxHp < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
    self.Num = 1
  end
end

function bs_21151:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.Num == 0 and not isMiss and self.caster.hp * 1000 // self.caster.maxHp < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
    self.Num = 1
  end
end

function bs_21151:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21151
