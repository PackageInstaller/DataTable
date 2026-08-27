local gs_1137 = class("gs_1137", LuaGridBase)
local base = LuaGridBase
gs_1137.config = {
  buff_id_locked = 214102,
  startime = 225,
  HurtConfigID = 2
}

function gs_1137:ctor()
end

function gs_1137:__OnGridSkillInit()
  base.__OnGridSkillInit(self)
end

function gs_1137:OnGridBattleStart(role)
end

function gs_1137:StartCreatGrid()
end

function gs_1137:OnGridEnterRole(role)
  if role.belongNum == eBattleRoleBelong.player and role.roleType ~= 5 and self.loop == nil then
    self.loop = LuaSkillCtrl:StartTimer(nil, self.config.startime, function()
      self.cskill = self.cEffectGrid.battleSkill
      self.caster = self.cskill.maker
      LuaSkillCtrl:CallBuffRepeated(self, role, self.config.buff_id_locked, 1, 45, false, false, self.OnBuffExecute)
    end, self, -1)
  end
end

function gs_1137:OnBuffExecute(buff, targetRole)
  if self.caster == nil then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {1000}, true)
  skillResult:EndResult()
end

function gs_1137:OnGridBeCorvered(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  self:GridLoseEffect()
end

function gs_1137:OnGridExitRole(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridExitRole(self, role)
end

function gs_1137:OnGridBattleEnd(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridBattleEnd(self, role)
end

function gs_1137:OnGridRoleDead(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridRoleDead(self, role)
end

function gs_1137:LuaDispose()
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.LuaDispose(self)
end

return gs_1137
