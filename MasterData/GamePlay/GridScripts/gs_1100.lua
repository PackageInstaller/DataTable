local gs_1100 = class("gs_1100", LuaGridBase)
local base = LuaGridBase
gs_1100.config = {effectId = 12017}

function gs_1100:ctor()
end

function gs_1100:OnGridBattleStart(role)
end

function gs_1100:OnGridEnterRole(role)
  if self.AddPower ~= nil then
    self.AddPower:Stop()
    self.Addpower = nil
  end
  if role ~= nil and role.belongNum == eBattleRoleBelong.player then
    self.AddPower = LuaSkillCtrl:StartTimer(nil, 30, function()
      LuaSkillCtrl:AddPlayerTowerMp(1)
      LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    end, -1, 30)
  end
end

function gs_1100:OnGridBeCorvered(role)
  if self.AddPower ~= nil then
    self.AddPower:Stop()
    self.Addpower = nil
  end
end

function gs_1100:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_1100:LuaDispose()
  if self.AddPower ~= nil then
    self.AddPower:Stop()
    self.Addpower = nil
  end
  base.LuaDispose(self)
end

function gs_1100:OnGridExitRole(role)
  if self.AddPower ~= nil then
    self.AddPower:Stop()
    self.Addpower = nil
  end
end

function gs_1100:OnGridRoleDead(role)
  if self.AddPower ~= nil then
    self.AddPower:Stop()
    self.Addpower = nil
  end
end

return gs_1100
