local bs_15106 = class("bs_15106", LuaSkillBase)
local base = LuaSkillBase
bs_15106.config = {buffId = 2070}

function bs_15106:ctor()
end

function bs_15106:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_15106_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15106_2", 1, self.OnAfterBattleStart)
end

function bs_15106:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_15106:OnSetHurt(context)
  if context.isTriggerSet then
    return
  end
  local distance = 0
  if context.target.belongNum == eBattleRoleBelong.enemy and context.sender == self.caster then
    distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, context.target.x, context.target.y)
    context.hurt = context.hurt + context.hurt * distance * self.arglist[3] // 1000
  end
end

function bs_15106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15106
