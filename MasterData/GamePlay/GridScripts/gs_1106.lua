local gs_1106 = class("gs_1106", LuaGridBase)
gs_1106.config = {buffId = 110001, buffId2 = 1221}

function gs_1106:ctor()
end

function gs_1106:__OnGridSkillInit()
  LuaGridBase.__OnGridSkillInit(self)
  self.timer = LuaSkillCtrl:StartTimer(nil, 75, BindCallback(self, self.OnGridLoseEffect))
end

function gs_1106:OnGridLoseEffect()
  if self.influenceRole ~= nil then
    LuaSkillCtrl:DispelBuff(self.influenceRole, self.config.buffId, 0, true, true)
    LuaSkillCtrl:DispelBuff(self.influenceRole, self.config.buffId2, 0, true, true)
    self.influenceRole = nil
  end
  self.timer = nil
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.KillWaveEffect, self.x, self.y)
  self:GridLoseEffect()
end

function gs_1106:OnGridBattleStart(role)
end

function gs_1106:OnGridEnterRole(role)
  if role.recordTable["10302_arg"] ~= nil and role.recordTable["10302_arg"] > 0 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId2, role.recordTable["10302_arg"], nil, true)
  end
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
  self.influenceRole = role
end

function gs_1106:OnGridExitRole(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0, true, true)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId2, 0, true, true)
  if self.influenceRole == role then
    self.influenceRole = nil
  elseif self.influenceRole ~= nil then
    LuaSkillCtrl:DispelBuff(self.influenceRole, self.config.buffId, 0, true, true)
    LuaSkillCtrl:DispelBuff(self.influenceRole, self.config.buffId2, 0, true, true)
    self.influenceRole = nil
  end
end

function gs_1106:OnGridRoleDead(role)
end

function gs_1106:LuaDispose()
  LuaGridBase.LuaDispose(self)
  self.influenceRole = nil
end

return gs_1106
