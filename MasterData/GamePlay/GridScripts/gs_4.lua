local gs_4 = class("gs_4", LuaGridBase)
gs_4.config = {
  effectId = 10261,
  buffId = 1032,
  buffTier = 1,
  damageIncreaseBuffId = 3065001
}

function gs_4:ctor()
end

function gs_4:OnGridBattleStart(role)
  if role == nil then
    self:GridLoseEffect()
  end
end

function gs_4:ExtraDamageIncrease(role)
  if role.belongNum ~= eBattleRoleBelong.player then
    return
  end
  local skillCaster = LuaSkillCtrl.battleCtrl.PlayerController.SkillCasterEntity
  if skillCaster == nil then
    return
  end
  local skillCasterAttr = skillCaster.trueDamage
  if skillCasterAttr <= 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, role, self.config.damageIncreaseBuffId, 1, nil, false, skillCaster)
end

function gs_4:OnGridEnterRole(role)
  self:ExtraDamageIncrease(role)
  if role.roleDataId == 1008 then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    self:GridLoseEffect()
    return
  end
  if role.attackRange > 1 then
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    local targetlist = LuaSkillCtrl:CallTargetSelectWithCskill(self.cskill, 21, 10, role)
    if 1 > targetlist.Count then
      return
    end
    role.recordTable.lastAttackRole = targetlist[0].targetRole
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier)
    self:GridLoseEffect()
  else
    self:GridLoseEffect()
  end
end

function gs_4:OnGridExitRole(role)
end

function gs_4:OnGridRoleDead(role)
end

return gs_4
