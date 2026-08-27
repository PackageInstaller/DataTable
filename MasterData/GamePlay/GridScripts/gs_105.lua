local gs_105 = class("gs_105", LuaGridBase)
gs_105.config = {effectGridId = 10829}

function gs_105:ctor()
end

function gs_105:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_105:OnGridEnterRole(role)
  local targetlist = LuaSkillCtrl.cluaSkillCtrl:CallTargetSelect(self.cskill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local rolePow = role.pow * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.pow, rolePow, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  self:GridLoseEffect()
end

function gs_105:OnGridExitRole(role)
end

function gs_105:OnGridRoleDead(role)
end

return gs_105
