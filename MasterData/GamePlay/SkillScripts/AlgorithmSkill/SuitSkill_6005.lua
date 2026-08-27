local bs_6005 = class("bs_6005", LuaSkillBase)
local base = LuaSkillBase
bs_6005.config = {}

function bs_6005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("10136_ShareDamage_14", 80, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_6005:OnSetHurt(context)
  if context.isTriggerSet and context.extraArg == ConfigData.buildinConfig.HurtIgnoreKey and context.target.roleType ~= eBattleRoleType.realSummoner then
    return
  end
  local shieldKey = self.caster.recordTable.shieldKey
  if shieldKey ~= nil and (self.caster.recordTable[shieldKey] ~= nil or self.caster.recordTable[shieldKey] > 0) and (self.caster.recordTable[shieldKey] ~= nil or self.caster.recordTable[shieldKey] > 0) then
    return
  end
  local check_target = LuaSkillCtrl:CallTargetSelect(self, 3, 10)
  if check_target.Count == 0 then
    return
  end
  local res_target = check_target[0].targetRole
  local targetRole = context.target
  if targetRole ~= nil and targetRole ~= self.caster and targetRole.belongNum == self.caster.belongNum and targetRole == res_target and targetRole.roleType ~= eBattleRoleType.realSummoner then
    local selfHurt = math.max(1, self.arglist[1] * context.hurt // 100)
    context.hurt = math.max(1, context.hurt - selfHurt)
    LuaSkillCtrl:RemoveLife(selfHurt, self, self.caster, true, nil, true, true)
  end
end

function bs_6005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6005
