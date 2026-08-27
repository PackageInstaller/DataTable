local bs_16004 = class("bs_16004", LuaSkillBase)
local base = LuaSkillBase
bs_16004.config = {}

function bs_16004:ctor()
end

function bs_16004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_16004_2", 1, self.OnSetHurt, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_16004:OnSetHurt(context)
  if context.sender.belongNum == eBattleRoleBelong.enemy and context.skill.isCommonAttack then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
end

function bs_16004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16004
