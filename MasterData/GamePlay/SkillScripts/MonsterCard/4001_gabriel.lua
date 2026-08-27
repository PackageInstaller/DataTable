local bs_4001 = class("bs_4001", LuaSkillBase)
local base = LuaSkillBase
bs_4001.config = {buffId = 40011}

function bs_4001:ctor()
end

function bs_4001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTriggerForTable("bs_4001_2", 2, self.OnAfterHurt, {
    target = self.caster,
    extraArg3 = true
  })
end

function bs_4001:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_4001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true and target ~= nil and target.hp > 0 then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[2])
  end
end

function bs_4001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001
