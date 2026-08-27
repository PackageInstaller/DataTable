local gs_34 = class("gs_34", LuaGridBase)
local base = LuaGridBase
gs_34.config = {
  effectId = 10482,
  effectId1 = 10484,
  buffId = 1126,
  buffTier = 1,
  duration = 90
}

function gs_34:ctor()
end

function gs_34:OnGridBattleStart(role)
end

function gs_34:OnArriveAction(x, y)
  return LuaSkillCtrl:CallCreateEfcGrid(x, y, 15)
end

function gs_34:StartCreatGrid()
  self.growGrid = self.caster.recordTable.growGrid
  if self.growGrid == nil then
    self.growGrid = {}
    self.caster.recordTable.growGrid = self.growGrid
    local callBack = BindCallback(self, self.OnFindEmptyGridAndSetEfc)
    self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, 20, self.config.duration)
  end
end

function gs_34:OnFindEmptyGridAndSetEfc()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local grids = LuaSkillCtrl:CallGetTotalEfcGrid()
  local count = grids.Count
  if 35 <= count and self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
    return
  end
  self.stopFlag = true
  for i = 0, count - 1 do
    if grids[i].dataId == 15 then
      local curGrid = grids[i]
      if self.growGrid == nil or not self.growGrid[curGrid] then
        local emptyGrids = LuaSkillCtrl:FindGridsWithoutEfcGridAroundGrid(grids[i].x, grids[i].y)
        if emptyGrids ~= nil and emptyGrids.Count > 0 then
          for j = 0, emptyGrids.Count - 1 do
            local role = LuaSkillCtrl:GetRoleWithPos(emptyGrids[j].x, emptyGrids[j].y)
            if role ~= nil and role.belongNum == 0 and role.intensity == 0 and (role.roleDataId == 1000 or role.roleDataId == 1004) then
            elseif role ~= nil and role.belongNum == 0 and role.intensity == 0 and (role.roleDataId == 1001 or role.roleDataId == 1005) then
              self.stopFlag = false
            else
              self:OnArriveAction(emptyGrids[j].x, emptyGrids[j].y)
            end
          end
        end
        if self.growGrid ~= nil and self.stopFlag then
          self.growGrid[grids[i]] = true
        end
      end
    end
  end
end

function gs_34:OnGridEnterRole(role)
  local buffTier = role:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    return
  end
  LuaSkillCtrl:CallBuff(self, role, 1126, 1, nil, true)
end

function gs_34:OnGridBeCorvered(role)
  self.growGrid = nil
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil and not role.isDead then
    LuaSkillCtrl:DispelBuff(role, 1126, 1)
  end
end

function gs_34:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_34:OnGridBattleEnd(role)
  self.growGrid = nil
  base.OnGridBattleEnd(self, role)
end

function gs_34:LuaDispose()
  self.growGrid = nil
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil and not role.isDead then
    LuaSkillCtrl:DispelBuff(role, 1126, 1)
  end
  base.LuaDispose(self)
end

return gs_34
