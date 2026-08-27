local bs_10222 = class("bs_10222", LuaSkillBase)
local base = LuaSkillBase
bs_10222.config = {
  buffId = 195,
  buffTier = 1,
  effectId = 10644,
  effectSId = 10887,
  hurtConfig = {basehurt_formula = 10078}
}

function bs_10222:ctor()
end

function bs_10222:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10222_11", 2, self.OnBeforePlaySkill)
end

function bs_10222:OnBeforePlaySkill(role, context)
  if role == self.caster and not context.skill.isCommonAttack then
    self:OnShout()
  end
end

function bs_10222:OnShout()
  if self.caster.recordTable["30007_arg"] then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList ~= nil and targetList.Count < 1 then
      return
    end
    if targetList == nil then
      return
    end
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      if targetRole.belongNum ~= 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, nil, true)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.arglist[2], 75)
      end
    end
  else
    local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
    if targetList ~= nil and targetList.Count < 1 then
      return
    end
    if targetList == nil then
      return
    end
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectSId, self)
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i]
      if targetRole.belongNum ~= 0 and targetRole.belongNum ~= self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, nil, true)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.arglist[2], 75)
      end
    end
  end
end

function bs_10222:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10222
