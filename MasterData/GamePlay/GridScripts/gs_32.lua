local gs_32 = class("gs_32", LuaGridBase)
local base = LuaGridBase
gs_32.config = {
  effectId = 10482,
  effectId1 = 10484,
  buffId = 1274,
  buffTier = 1,
  duration = 45
}

function gs_32:ctor()
end

function gs_32:OnGridBattleStart(role)
  self:StartCreatGrid()
end

function gs_32:__OnGridSkillInit()
  LuaGridBase.__OnGridSkillInit(self)
  self:StartCreatGrid()
end

function gs_32:OnArriveAction(x, y)
  return LuaSkillCtrl:CallCreateEfcGrid(x, y, 32)
end

function gs_32:StartCreatGrid()
  if self.caster == nil then
    return
  end
  self.growGrid = self.caster.recordTable.growGrid32
  if self.growGrid == nil then
    self.growGrid = {}
    self.caster.recordTable.growGrid32 = self.growGrid
    local callBack = BindCallback(self, self.OnFindEmptyGridAndSetEfc)
    self.timer = LuaSkillCtrl:StartTimer(nil, self.config.duration, callBack, nil, 20, 0)
  end
end

function gs_32:OnFindEmptyGridAndSetEfc()
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
    if grids[i].dataId == 32 then
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

function gs_32:OnGridEnterRole(role)
  local buffTier = role:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    return
  end
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, nil, true)
end

function gs_32:OnGridUncorver(role)
  if role ~= nil then
    self:OnGridEnterRole(role)
  end
end

function gs_32:OnGridBeCorvered(role)
  self.growGrid = nil
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil and not role.isDead then
    LuaSkillCtrl:DispelBuff(role, 1274, 1)
  end
end

function gs_32:OnGridBattleEnd(role)
  self.growGrid = nil
  base.OnGridBattleEnd(self, role)
end

function gs_32:LuaDispose()
  self.growGrid = nil
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  local role = LuaSkillCtrl:GetRoleWithPos(self.x, self.y)
  if role ~= nil and not role.isDead then
    LuaSkillCtrl:DispelBuff(role, 1274, 1)
  end
  base.LuaDispose(self)
end

return gs_32
