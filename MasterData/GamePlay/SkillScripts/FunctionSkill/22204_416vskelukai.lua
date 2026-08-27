local bs_22204 = class("bs_22204", LuaSkillBase)
local base = LuaSkillBase
bs_22204.config = {}

function bs_22204:ctor()
end

function bs_22204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_22204_4", 1, self.OnHurtResultStart)
  self:AddSetDeadHurtTrigger("bs_22204_2", 99, self.OnSetDeadHurt, nil, nil, nil, nil, nil, 1)
end

function bs_22204:OnHurtResultStart(skill, context)
  if context.target.roleDataId == 1021059 then
    context.active = false
  end
end

function bs_22204:OnSetDeadHurt(context)
  if context.target.roleDataId == 1058 then
    LuaSkillCtrl:ForceEndBattle(true)
  end
end

function bs_22204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22204
