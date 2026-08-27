local bs_206603 = class("bs_206603", LuaSkillBase)
local base = LuaSkillBase
bs_206603.config = {
  buffId_judge = 206801,
  buffId_Jianfang = 206603,
  effectId_start = 2066021,
  effectId_hit = 2066022,
  effectId_skillhit = 2066002,
  effectId_xuli = 2066023,
  HurtConfig = {
    hit_formula = 10201,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_206603:ctor()
end

function bs_206603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206603:PlaySkill(data)
  self.isInSkill = true
  local SkillDuration = 25
  local SkillStart = 15
  self:CallCasterWait(SkillDuration)
  LuaSkillCtrl:StartShowSkillDurationTime(self, SkillDuration)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:StartTimer(self, SkillDuration, function()
    self.isInSkill = false
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end)
  local last_target = self.caster.recordTable.lastAttackRole
  local targetRole
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    targetRole = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    targetRole = tempTarget.targetRole
  end
  if targetRole ~= nil then
    self.caster:LookAtTarget(targetRole)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_xuli, self)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
    end)
    LuaSkillCtrl:CallRoleAction(self.caster, 1020, 1)
    LuaSkillCtrl:PlayAuSource(self.caster, 447)
    LuaSkillCtrl:StartTimer(self, SkillStart, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[1]
      })
      if skillResult.roleList.Count > 0 then
        LuaSkillCtrl:CallEffect(skillResult.roleList[0], self.config.effectId_skillhit, self)
        for i = 0, skillResult.roleList.Count - 1 do
          local role = skillResult.roleList[i]
          if 0 < role:GetBuffTier(self.config.buffId_judge) then
            LuaSkillCtrl:DispelBuff(role, self.config.buffId_judge, 1)
            LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
            LuaSkillCtrl:CallBuff(self, role, self.config.buffId_Jianfang, 1, self.arglist[2])
          end
        end
      end
      skillResult:EndResult()
    end)
  end
end

function bs_206603:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster and self.isInSkill then
    self.isInSkill = false
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end
end

return bs_206603
