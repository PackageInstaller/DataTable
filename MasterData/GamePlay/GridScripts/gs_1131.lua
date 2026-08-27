local gs_1131 = class("gs_1131", LuaGridBase)
local base = LuaGridBase
gs_1131.config = {buffId = 107101}

function gs_1131:ctor()
end

function gs_1131:__OnGridSkillInit()
  base.__OnGridSkillInit(self)
end

function gs_1131:OnGridBattleStart(role)
end

function gs_1131:StartCreatGrid()
end

function gs_1131:OnGridEnterRole(role)
  if self.loop == nil then
    self.loop = LuaSkillCtrl:StartTimer(nil, 15, function()
      if role.belongNum ~= 1 then
        self.cskill = self.cEffectGrid.battleSkill
        self.caster = self.cskill.maker
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, 120)
      end
    end, nil, -1, 15)
  end
end

function gs_1131:OnGridExitRole(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridExitRole(self, role)
end

function gs_1131:OnGridBeCorvered(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
end

function gs_1131:OnGridUncorver(role)
  self:OnGridEnterRole(role)
end

function gs_1131:OnGridBattleEnd(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridBattleEnd(self, role)
end

function gs_1131:LuaDispose()
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.LuaDispose(self)
end

return gs_1131
