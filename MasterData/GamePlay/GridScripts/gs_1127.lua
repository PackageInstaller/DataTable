local gs_1127 = class("gs_1127", LuaGridBase)
local base = LuaGridBase
gs_1127.config = {
  effectId = 10482,
  effectId1 = 10484,
  buffId = 1275
}

function gs_1127:ctor()
end

function gs_1127:OnGridBattleStart(role)
  self:StartCreatGrid()
end

function gs_1127:StartCreatGrid()
  self.growGrid = self.caster.recordTable.growGrid
  if self.growGrid == nil then
    self.growGrid = {}
    self.caster.recordTable.growGrid = self.growGrid
  end
end

function gs_1127:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1275, 1, nil, true)
end

function gs_1127:OnGridBeCorvered(role)
  self.growGrid = nil
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, 1275, 1)
  end
end

function gs_1127:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1127:OnGridBattleEnd(role)
  self.growGrid = nil
  base.OnGridBattleEnd(self, role)
end

function gs_1127:LuaDispose()
  self.growGrid = nil
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, 1275, 1)
  end
  base.LuaDispose(self)
end

return gs_1127
