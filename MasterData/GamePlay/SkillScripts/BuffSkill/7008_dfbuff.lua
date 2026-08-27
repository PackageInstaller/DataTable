local bs_7008 = class("bs_7008", LuaSkillBase)
local base = LuaSkillBase
bs_7008.config = {buffId = 1225}

function bs_7008:ctor()
end

function bs_7008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_7008_1", 10, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_7008_1", 1, self.OnBeforePlaySkill)
end

function bs_7008:OnBeforePlaySkill(role, context)
  if role ~= self.caster then
    return
  end
  if role == self.caster and context.skill.isCommonAttack then
    local moveTarget = context.skill.moveSelectTarget
    if moveTarget ~= nil then
      local curAtkRole = moveTarget.targetRole
      if curAtkRole ~= nil then
        self.caster.recordTable.lastAttackRoleInTd = curAtkRole
      end
    end
  end
end

function bs_7008:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and self.caster.recordTable.lastAttackRoleInTd == role then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, 30, true)
    self.caster.recordTable.lastAttackRoleInTd = nil
  end
end

function bs_7008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_7008
