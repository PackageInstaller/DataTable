local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_207300 = class("bs_207300", bs_1)
local base = bs_1
bs_207300.config = {
  effectId_trail = 207300,
  action1 = 1001,
  action2 = 1001,
  effectId_action_1 = 207304,
  effectId_action_2 = 207304
}
bs_207300.config = setmetatable(bs_207300.config, {
  __index = base.config
})

function bs_207300:ctor()
end

function bs_207300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_207300:PlaySkill(passdata)
  if self.caster.recordTable.onAction2 ~= nil then
    self.config.action1 = 1004
    self.config.action2 = 1004
  else
    self.config.action1 = 1001
    self.config.action2 = 1001
  end
  self:CheckAndRecordIsDoubleAttack(passdata)
  local data
  if passdata ~= nil then
    data = setmetatable(passdata, {
      __index = self.config
    })
  else
    data = self.config
  end
  self:SetAttackRole(data)
  if self.lastAttackRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + self.caster.attackRange, true) and LuaSkillCtrl:IsWorthAttacking(self, self.lastAttackRole) then
    self.caster:LookAtTarget(self.lastAttackRole)
    if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, self.config.atkDirectionRange) then
      self.rotateWaited = true
      LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
    else
      self.rotateWaited = false
      self:RealPlaySkill(self.lastAttackRole, data)
    end
  else
    self.lastAttackRole = nil
    self.caster.recordTable.lastAttackRole = nil
    self:ClearDoubleAttackNum()
    self:CancleCasterWait()
  end
end

function bs_207300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207300
