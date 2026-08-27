local gs_1136 = class("gs_1136", LuaGridBase)
local base = LuaGridBase
gs_1136.config = {buffId = 107402, HurtConfigID = 17}

function gs_1136:ctor()
end

function gs_1136:__OnGridSkillInit()
  base.__OnGridSkillInit(self)
end

function gs_1136:OnGridBattleStart(role)
end

function gs_1136:StartCreatGrid()
end

function gs_1136:OnGridEnterRole(role)
  if self.loop == nil and role.belongNum ~= 1 then
    self.loop = LuaSkillCtrl:StartTimer(nil, 15, function()
      if self.cskill ~= self.cEffectGrid.battleSkill then
        self.cskill = self.cEffectGrid.battleSkill
        self.caster = self.cskill.maker
        self.arglist = {}
        for i = 0, self.cskill.skillFormulaArgs.Length - 1 do
          table.insert(self.arglist, self.cskill.skillFormulaArgs[i])
        end
      end
      if role:GetBuffTier(self.config.buffId) == 0 then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, 75)
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[2]
      })
      skillResult:EndResult()
    end, nil, -1, 15)
  end
end

function gs_1136:OnGridExitRole(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  LuaSkillCtrl:DispelBuff(role, self.config.buffId, 1)
  base.OnGridExitRole(self, role)
end

function gs_1136:OnGridBeCorvered(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId, 1)
  end
end

function gs_1136:OnGridUncorver(role)
  self:OnGridEnterRole(role)
end

function gs_1136:OnGridBattleEnd(role)
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  base.OnGridBattleEnd(self, role)
end

function gs_1136:LuaDispose()
  if self.loop ~= nil then
    self.loop:Stop()
    self.loop = nil
  end
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil then
    LuaSkillCtrl:DispelBuff(role, self.config.buffId, 1)
  end
  base.LuaDispose(self)
end

return gs_1136
