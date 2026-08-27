local bs_108901 = class("bs_108901", LuaSkillBase)
local base = LuaSkillBase
bs_108901.config = {
  effect_go = 108904,
  effect_in = 108905,
  buff_1 = 108901
}

function bs_108901:ctor()
end

function bs_108901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108901_01", 1, self.OnAfterBattleStart)
end

function bs_108901:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, 2, 1)
  local enmeyList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  local target = enmeyList[0].targetRole
  local powNum = self.caster.pow * self.arglist[1] // 1000
  if targetList ~= nil or 0 < targetList.Count then
    for i = targetList.Count - 1, 0, -1 do
      local v = targetList[i].targetRole
      LuaSkillCtrl:CallBuff(self, v, self.config.buff_1, 1, self.arglist[2])
      v:AddRoleProperty(eHeroAttr.pow, powNum, eHeroAttrType.Extra)
      LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
        v:AddRoleProperty(eHeroAttr.pow, -powNum, eHeroAttrType.Extra)
      end, nil)
      if target ~= nil and 0 < target.hp then
        LuaSkillCtrl:CallEffect(v, self.config.effect_go, self)
        do
          local resultGrid = self:FindFlashGrid(target)
          if resultGrid ~= nil then
            LuaSkillCtrl:SetRolePos(resultGrid, v)
          end
          LuaSkillCtrl:CallEffect(v, self.config.effect_in, self)
        end
      end
    end
  end
end

function bs_108901:FindFlashGrid(target)
  if target == nil then
    return
  end
  local tempTable = {}
  local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(target.x, target.y, 1)
  if grids ~= nil and grids.Count > 0 then
    local resultGrid = grids[0]
    return resultGrid
  else
    local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(target.x, target.y, 10)
    for i = 0, grids.Count - 1 do
      local grid = grids[i]
      local pos = BattleUtil.XYCoord2Pos(grid.x, grid.y)
      if tempTable[pos] == nil then
        tempTable[pos] = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, target.x, target.y)
      end
    end
    local resultGridPos
    local minDis = 99
    for k, v in pairs(tempTable) do
      if v ~= nil then
        if v == 2 then
          resultGridPos = k
          minDis = v
          break
        elseif resultGridPos == nil or v < minDis then
          resultGridPos = k
          minDis = v
        end
      end
    end
    if resultGridPos ~= nil then
      local coordX, coordY = BattleUtil.Pos2XYCoord(resultGridPos)
      local resultGrid = LuaSkillCtrl:GetGridWithPos(coordX, coordY)
      return resultGrid
    end
  end
end

function bs_108901:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108901:LuaDispose()
  base.LuaDispose(self)
end

return bs_108901
