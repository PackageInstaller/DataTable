local bs_108501 = class("bs_108501", LuaSkillBase)
local base = LuaSkillBase
bs_108501.config = {
  buffId_live = 3009,
  buff_id1 = 108501,
  buff_id2 = 108502,
  effect_1 = 108503,
  effect_2 = 108504,
  effect_3 = 108505,
  heal_config = {baseheal_formula = 10101},
  HurtConfigID = 13
}

function bs_108501:ctor()
end

function bs_108501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108501_01", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddSetDeadHurtTrigger("bs_108501_6_1", 950, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, eBattleRoleBelong.player)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBelladonnaAddBuff, self.OnBelladonnaAddBuff)
end

function bs_108501:OnAfterBattleStart()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, list.Count - 1 do
    local role = list[i]
    if role.roleType == eBattleRoleType.character then
      LuaSkillCtrl:CallBuff(self, role, self.config.buff_id1, 1)
    end
  end
  self.caster:AddRoleProperty(eHeroAttr.magic_pen, self.arglist[3] // 10, eHeroAttrType.Extra)
end

function bs_108501:OnRoleSplash(role)
  self:CheckRoleEndSplash(role)
end

function bs_108501:OnRolePhaseMoveStart(role, luaskill)
  self:CheckRoleEndSplash(role)
end

function bs_108501:CheckRoleEndSplash(role)
  if role.roleType ~= eBattleRoleType.character or role.belongNum ~= self.caster.belongNum then
    return
  end
  LuaSkillCtrl:StartTimer(self, 3, function()
    LuaSkillCtrl:CallEffect(role, self.config.effect_3, self)
    local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, 9, 1, role)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local enemyRole = targetList[i].targetRole
        if enemyRole.belongNum ~= eBattleRoleBelong.neutral then
          LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buff_id2, 1, self.arglist[2])
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemyRole)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[5]
          })
          skillResult:EndResult()
        end
      end
    end
  end)
end

function bs_108501:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false and 0 < context.target:GetBuffTier(self.config.buff_id1) then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 10, true)
    LuaSkillCtrl:DispelBuff(context.target, self.config.buff_id1)
    LuaSkillCtrl:CallEffect(context.target, self.config.effect_2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
    skillResult:EndResult()
  end
end

function bs_108501:OnBelladonnaAddBuff(target, buffTier)
  LuaSkillCtrl:CallBuff(self, target, self.config.buff_id2, buffTier, self.arglist[2])
end

function bs_108501:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108501:LuaDispose()
  base.LuaDispose(self)
end

return bs_108501
