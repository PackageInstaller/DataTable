local bs_15148 = class("bs_15148", LuaSkillBase)
local base = LuaSkillBase
bs_15148.config = {
  buffId1 = 2065,
  buffId2 = 2066,
  buffId3 = 66,
  formula = 10106,
  buffId_Back = 3007,
  effectId = 12065
}

function bs_15148:ctor()
end

function bs_15148:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15148_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
  self.damageNum = 0
end

function bs_15148:OnRoleDie(killer, role)
  self:findMax()
  if role.roleType ~= eBattleRoleType.character then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i].targetRole
      local distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, targetRole.x, targetRole.y)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_Back, 1, 3)
      local realDamageNum = self.damageNum + self.damageNum * distance * self.arglist[3] // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {realDamageNum}, true, true)
      skillResult:EndResult()
    end
  end
end

function bs_15148:findMax()
  local role, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  if role ~= nil then
    self.damageNum = baseDamage * self.arglist[2] // 1000
  end
end

function bs_15148:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15148
