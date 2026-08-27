local bs_15137 = class("bs_15137", LuaSkillBase)
local base = LuaSkillBase
bs_15137.config = {buffId_live = 3009}

function bs_15137:ctor()
end

function bs_15137:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_15137_1", 850, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
  self.Times = 0
end

function bs_15137:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and self.Times == 0 and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, self.arglist[1], true)
    self:OnSkillTake()
    self.Times = 1
  end
end

function bs_15137:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15137
