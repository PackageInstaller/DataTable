local bs_50006 = class("bs_50006", LuaSkillBase)
local base = LuaSkillBase
bs_50006.config = {
  sheildBuffId = 174,
  shieldKeyYuan = "50002_HuDun",
  shieldKeyJin = "50003_HuDun",
  buffIdYuan = 1047,
  effectIdYuan = 10371,
  buffIdJin = 1048,
  effectIdJin = 10373,
  fakeYuanId = 1055,
  fakeJinId = 1056
}

function bs_50006:ctor()
end

function bs_50006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_50006_1", 1, self.OnAfterShieldHurt)
end

function bs_50006:OnAfterShieldHurt(context)
  if context.shield_cost_hurt > 0 and context.target ~= self.caster and context.sender == self.caster and context.target.belongNum ~= self.caster.belongNum and (context.shield_type == 1 or context.shield_type == 2) then
    local hurtType = context.hurt_type or context.skill.skillCfg.HurtType
    LuaSkillCtrl:RemoveLife(context.shield_cost_hurt, self, context.target, true, nil, true, false, hurtType, true)
  end
end

function bs_50006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50006
