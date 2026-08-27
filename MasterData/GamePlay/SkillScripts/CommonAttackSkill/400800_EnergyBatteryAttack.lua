local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_400800 = class("bs_400800", bs_1)
local base = bs_1
bs_400800.config = {
  action1 = 1001,
  action2 = 1004,
  action3 = 1021
}
bs_400800.config = setmetatable(bs_400800.config, {
  __index = base.config
})

function bs_400800:ctor()
end

function bs_400800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_400800:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  local prob = LuaSkillCtrl:CallRange(1, 3)
  if prob == 1 then
    if data.audioId2 ~= nil then
      LuaSkillCtrl:StartTimer(self, data.time2, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = data.action2
    atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
  elseif prob == 2 then
    if data.audioId1 ~= nil then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
    atkActionId = data.action1
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
  else
    if data.audioId1 ~= nil then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
    atkActionId = data.action3
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
end

function bs_400800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_400800
