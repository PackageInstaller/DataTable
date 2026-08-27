local card_20036 = class("card_20036", LuaSkillBase)
local base = LuaSkillBase
card_20036.config = {
  effect = 12095,
  buffId_1 = 1613,
  buffId_2 = 1613
}

function card_20036:ctor()
end

function card_20036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20036", 1, self.AfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.OnSelfAfterMove, "card_20036_2", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self.grid = nil
  self.timer = nil
  self.grid_new = nil
end

function card_20036:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
end

function card_20036:OnAfterMove(role, grid)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  if self.timer ~= nil then
    self.timer.left = self.arglist[1]
    self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  end
end

function card_20036:OnRoleSplash(role)
  if role == self.caster then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
    if self.timer ~= nil then
      self.timer.left = self.arglist[1]
      self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
end

function card_20036:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
    if self.timer ~= nil then
      self.timer.left = self.arglist[1]
      self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    end
  end
end

function card_20036:checkLocation()
  local grid_old = self.grid
  self.grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old == nil or self.grid_new == nil then
    return
  end
  if grid_old ~= self.grid_new then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
    self.grid = self.grid_new
    return
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true, false)
  self.grid = self.grid_new
end

function card_20036:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function card_20036:LuaDispose()
  base.LuaDispose(self)
  self.grid = nil
end

return card_20036
