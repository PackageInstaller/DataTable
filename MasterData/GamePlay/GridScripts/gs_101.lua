local gs_101 = class("gs_101", LuaGridBase)
gs_101.config = {effectGridId = 10825}

function gs_101:ctor()
end

function gs_101:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_101:OnGridEnterRole(role)
  local targetlist = LuaSkillCtrl.cluaSkillCtrl:CallTargetSelect(self.cskill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local roleIntensity = role.skill_intensity * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.skill_intensity, roleIntensity, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  self:GridLoseEffect()
end

function gs_101:OnGridExitRole(role)
end

function gs_101:OnGridRoleDead(role)
end

return gs_101
