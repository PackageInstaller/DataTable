local bs_108903 = class("bs_108903", LuaSkillBase)
local base = LuaSkillBase
bs_108903.config = {
  buffId_1 = 108904,
  audioIdStart = 108906,
  audioIdEnd = 108907,
  effcet_hit = 108909,
  HurtConfigId = 2
}

function bs_108903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108903:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(15)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_108903:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= self.caster.belongNum and not role:IsUnSelect(self.caster) then
    self:RealPlaySkill(role)
  end
end

function bs_108903:RealPlaySkill(target)
  local grid = self:FindGrid(target)
  if grid ~= nil then
    LuaSkillCtrl:SetRolePos(grid, self.caster)
  end
  local damageNum = self.caster.pow * self.arglist[2]
  target.recordTable.bleedNum = damageNum // 1000
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1)
  LuaSkillCtrl:CallEffect(target, self.config.effcet_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_108903:FindGrid(role)
  if role ~= nil then
    local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 1)
    if grid_dict == nil or grid_dict.Count <= 0 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      local grid2
      for i = 0, targetList.Count - 1 do
        if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
          local role1 = targetList[i].targetRole
          local grid_dict1 = LuaSkillCtrl:FindEmptyGridsWithinRange(role1.x, role1.y, 1)
          if grid_dict1 == nil or grid_dict1.Count == 0 then
            grid2 = nil
          else
            grid2 = grid_dict1[0]
            return grid2
          end
        end
      end
      local grid7 = LuaSkillCtrl:FindEmptyGrid(nil)
      return grid7
    else
      local dismax = 0
      local grid1 = grid_dict[0]
      for i = 0, grid_dict.Count - 1 do
        local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, grid_dict[i].x, grid_dict[i].y)
        if dismax < dis then
          dismax = dis
          grid1 = grid_dict[i]
        end
      end
      return grid1
    end
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    local grid4
    for i = 0, targetList.Count - 1 do
      if targetList[i] ~= nil and targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum ~= eBattleRoleBelong.neutral then
        local role1 = targetList[i].targetRole
        local grid_dict1 = LuaSkillCtrl:FindEmptyGridsWithinRange(role1.x, role1.y, 1)
        if grid_dict1 == nil or grid_dict1.Count == 0 then
          grid4 = nil
        else
          grid4 = grid_dict1[0]
          return grid4
        end
      end
    end
    local grid7 = LuaSkillCtrl:FindEmptyGrid(nil)
    return grid7
  end
end

function bs_108903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_108903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108903:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108903:LuaDispose()
  base.LuaDispose(self)
  self.targetGrid = nil
end

return bs_108903
