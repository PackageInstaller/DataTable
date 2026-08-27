local XinghuanUltChange = {}
XinghuanUltChange.config = {}

function XinghuanUltChange:changeback()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local grid_boom = LuaSkillCtrl:GetGridWithRole(self.caster)
  local grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGrid(self.caster, 10)
  end
  local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local showgrid = LuaSkillCtrl:GetTargetWithGrid(grid_boom.x, grid_boom.y)
  LuaSkillCtrl:CallEffect(showgrid, self.config.effectId_cast2, self)
  LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, false)
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      if role ~= self.caster then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[3], self.config.time_buff)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_casthit2, self)
      end
    end
  end
  LuaSkillCtrl:RecoverRoleBody(self.caster)
  self.caster.recordTable.changebody = false
  self.caster:LookAtTarget(Targetgrid)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_invisibility, 1, 2)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_jump_off, self)
end

return XinghuanUltChange
