local gs_106 = class("gs_106", LuaGridBase)
gs_106.config = {effectGridId = 10830, effectHitId = 10846}

function gs_106:ctor()
end

function gs_106:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_106:OnGridEnterRole(role)
  local targetlist = LuaSkillCtrl.cluaSkillCtrl:CallTargetSelect(self.cskill, role, 43, 10)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return
  end
  if targetlist.Count ~= 0 then
    local targetRole = targetlist[0].targetRole
    if targetRole ~= nil then
      local hp = role.hp * 500 // 1000
      role:SubHp(hp)
      local dmg = hp
      if role.career == 1 then
        dmg = dmg * 130 // 100
      end
      LuaSkillCtrl:RemoveLife(dmg, self, targetRole, false, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:CallEffect(targetRole, self.config.effectHitId, self)
    end
    LuaSkillCtrl:CallEffect(role, self.config.effectGridId, self)
  end
  self:GridLoseEffect()
end

function gs_106:OnGridExitRole(role)
end

function gs_106:OnGridRoleDead(role)
end

return gs_106
