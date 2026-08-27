local gs_14 = class("gs_14", LuaGridBase)
local base = LuaGridBase
gs_14.config = {
  effectId = 10482,
  effectId1 = 10484,
  buffId = 1162,
  buffTier = 1
}

function gs_14:ctor()
end

function gs_14:OnGridBattleStart(role)
end

function gs_14:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, nil, true)
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function gs_14:OnGridExitRole(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0, true)
  LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
end

function gs_14:OnGridRoleDead(role)
end

function gs_14:OnGridBeCorvered(role)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0, true)
    LuaSkillCtrl:CallEffect(role, self.config.effectId1, self)
  end
end

function gs_14:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_14:LuaDispose()
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0, true)
  end
  base.LuaDispose(self)
end

return gs_14
