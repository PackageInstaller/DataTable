local bs_15071 = class("bs_15071", LuaSkillBase)
local base = LuaSkillBase
bs_15071.config = {configId = 26, effectIdAttack = 10254}

function bs_15071:ctor()
end

function bs_15071:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_104701_1", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.enemy)
  self.pow_Num = 0
end

function bs_15071:OnSetHurt(context)
  if context.isMiss then
    local damage = self.caster.maxHp
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.sender, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {damage}, true)
    skillResult:EndResult()
  end
end

function bs_15071:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15071
