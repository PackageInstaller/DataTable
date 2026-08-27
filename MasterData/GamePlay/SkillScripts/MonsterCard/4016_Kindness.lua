local bs_4016 = class("bs_4016", LuaSkillBase)
local base = LuaSkillBase
bs_4016.config = {buffSpeed = 210102, buffAttackUp = 40161}

function bs_4016:ctor()
end

function bs_4016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_4016_01", 1, self.OnAfterHurt, {
    extraArg1 = 0,
    extraArg2 = false,
    extraArg3 = false,
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4016_03", 1, self.OnAfterBattleStart)
end

function bs_4016:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  LuaSkillCtrl:CallBuff(self, sender, self.config.buffAttackUp, 1, self.arglist[4])
end

function bs_4016:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffSpeed, 1)
end

function bs_4016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4016
