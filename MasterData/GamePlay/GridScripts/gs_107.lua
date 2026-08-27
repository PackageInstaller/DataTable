local gs_107 = class("gs_107", LuaGridBase)
gs_107.config = {effectGridId = 10822}

function gs_107:ctor()
end

function gs_107:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_107:OnGridEnterRole(role)
  local targetlist = LuaSkillCtrl.cluaSkillCtrl:CallTargetSelect(self.cskill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local roleDef = role.def * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.def, roleDef, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  self:GridLoseEffect()
end

function gs_107:OnGridExitRole(role)
end

function gs_107:OnGridRoleDead(role)
end

return gs_107
