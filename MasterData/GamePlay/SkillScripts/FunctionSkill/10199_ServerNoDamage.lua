local bs_10199 = class("bs_10199", LuaSkillBase)
local base = LuaSkillBase
bs_10199.config = {effectId = 10634}

function bs_10199:ctor()
end

function bs_10199:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10199_2", 1, self.OnSetHurt, nil, nil, eBattleRoleBelong.neutral, eBattleRoleBelong.player)
end

function bs_10199:OnSetHurt(context)
  if context.sender ~= nil and context.sender.belongNum == eBattleRoleBelong.neutral and context.target.belongNum == eBattleRoleBelong.player then
    local heal = context.hurt * self.arglist[1] // 1000
    if 0 < heal then
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
      LuaSkillCtrl:CallHeal(heal, self, context.target, true)
    end
    context.hurt = 0
    self:PlayChipEffect()
  end
end

function bs_10199:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10199
