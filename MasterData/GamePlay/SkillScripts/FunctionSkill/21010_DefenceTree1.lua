local bs_21010 = class("bs_21010", LuaSkillBase)
local base = LuaSkillBase
bs_21010.config = {
  effectId_line = 100103,
  effectId_PassHit = 100104,
  effectId = 10813,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  heal_config = {baseheal_formula = 3022},
  selectId = 20,
  selectRange = 10
}

function bs_21010:ctor()
end

function bs_21010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_21010_1", 949, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
  self.Times = 0
end

function bs_21010:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and self.Times == 0 and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[1]
      }, true, false)
      skillResult:EndResult()
    end)
    self:OnSkillTake()
    self.Times = 1
  end
end

function bs_21010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21010
