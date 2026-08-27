local card_10032 = class("card_10032", LuaSkillBase)
local base = LuaSkillBase
card_10032.config = {
  effect = 10942,
  buffId_1 = 1607,
  buffId_2 = 1608
}

function card_10032:ctor()
end

function card_10032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10032", 1, self.AfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "card_10032_2", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self.grid = nil
  self.timer = nil
  self.grid_new = nil
end

function card_10032:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function card_10032:OnAfterMove()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 0, true, false)
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
    self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  end
end

function card_10032:OnRoleSplash(role)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 0, true, false)
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
    self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  end
end

function card_10032:OnRolePhaseMoveStart(role, luaskill)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 0, true, false)
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
    self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  end
end

function card_10032:checkLocation()
  local grid_old = self.grid
  self.grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old == nil or self.grid_new == nil then
    return
  end
  if grid_old ~= self.grid_new then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_1, 0, true, false)
    self.grid = self.grid_new
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
  self.grid = self.grid_new
end

function card_10032:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function card_10032:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return card_10032
