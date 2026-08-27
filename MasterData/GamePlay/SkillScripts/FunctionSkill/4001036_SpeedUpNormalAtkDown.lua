local bs_4001036 = class("bs_4001036", LuaSkillBase)
local base = LuaSkillBase
bs_4001036.config = {buffId = 2020, buffTier = 1}

function bs_4001036:ctor()
end

function bs_4001036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.flag = false
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001036_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_4010209_2", 90, self.OnSetHurt, self.caster)
end

function bs_4001036:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3])
end

function bs_4001036:OnSetHurt(context)
  local buffTier = context.skill.maker:GetBuffTier(self.config.buffId)
  if context.skill.maker == self.caster and context.isTriggerSet ~= true and context.skill.isCommonAttack and context.extra_arg ~= ConfigData.buildinConfig.HurtIgnoreKey and 0 < buffTier then
    context.hurt = context.hurt // 2
  end
end

function bs_4001036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001036
