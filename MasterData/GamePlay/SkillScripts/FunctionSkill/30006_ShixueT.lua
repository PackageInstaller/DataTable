local bs_30006 = class("bs_30006", LuaSkillBase)
local base = LuaSkillBase
bs_30006.config = {
  buffId = 195,
  buffTier = 1,
  effectId = 10644,
  effectSId = 10887,
  hurtConfig = {basehurt_formula = 10078}
}

function bs_30006:ctor()
end

function bs_30006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30006_1", 1, self.OnAfterBattleStart)
end

function bs_30006:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.OnShout, self, -1)
end

function bs_30006:OnShout()
  self:PlayChipEffect()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
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

function bs_30006:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_30006
