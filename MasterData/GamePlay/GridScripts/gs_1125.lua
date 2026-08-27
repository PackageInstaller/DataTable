local gs_1125 = class("gs_1125", LuaGridBase)
local base = LuaGridBase
gs_1125.config = {
  effectId = 10482,
  effectId1 = 10484,
  buffId = 1257
}

function gs_1125:ctor()
end

function gs_1125:OnGridBattleStart(role)
  self:StartCreatGrid()
end

function gs_1125:StartCreatGrid()
  self.growGrid = self.caster.recordTable.growGrid
  if self.growGrid == nil then
    self.growGrid = {}
    self.caster.recordTable.growGrid = self.growGrid
  end
end

function gs_1125:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, 1257, 1, nil, true)
end

function gs_1125:OnGridBeCorvered(role, coverGrid)
  self.growGrid = nil
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, 1257, 1)
  end
end

function gs_1125:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1125:OnGridBattleEnd(role)
  self.growGrid = nil
  base.OnGridBattleEnd(self, role)
end

function gs_1125:LuaDispose()
  self.growGrid = nil
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, 1257, 1)
  end
  base.LuaDispose(self)
end

return gs_1125
