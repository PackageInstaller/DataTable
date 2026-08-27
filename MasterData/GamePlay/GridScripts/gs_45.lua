local gs_45 = class("gs_45", LuaGridBase)
local base = LuaGridBase
gs_45.config = {buffId = 1292}

function gs_45:ctor()
end

function gs_45:OnGridBattleStart(role)
end

function gs_45:OnGridEnterRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil)
end

function gs_45:OnGridExitRole(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0)
end

function gs_45:OnGridRoleDead(role)
end

function gs_45:OnGridUncorver(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil)
end

function gs_45:OnGridBeCorvered(role, coverGrid)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0)
end

function gs_45:LuaDispose()
  base.LuaDispose(self)
end

return gs_45
