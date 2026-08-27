local card_20032 = class("card_20032", LuaSkillBase)
local base = LuaSkillBase
card_20032.config = {
  effect = 12095,
  buffId_1 = 1607,
  buffId_2 = 1608
}

function card_20032:ctor()
end

function card_20032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20032", 1, self.AfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.OnSelfAfterMove, "card_20032_2", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self.grid = nil
  self.timer = nil
  self.grid_new = nil
end

function card_20032:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function card_20032:OnAfterMove(role, grid)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
    self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  end
end

function card_20032:OnRoleSplash(role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
    if self.timer ~= nil then
      self.timer.left = self.arglist[1]
      self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
end

function card_20032:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
    if self.timer ~= nil then
      self.timer.left = self.arglist[1]
      self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
end

function card_20032:checkLocation()
  local grid_old = self.grid
  self.grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old == nil or self.grid_new == nil then
    return
  end
  if grid_old ~= self.grid_new then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
    self.grid = self.grid_new
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  self.grid = self.grid_new
end

function card_20032:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function card_20032:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return card_20032
