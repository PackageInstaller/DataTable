local bs_204502 = class("bs_204502", LuaSkillBase)
local base = LuaSkillBase
bs_204502.config = {
  restBuffId = 204503,
  select_id = 6,
  select_range = 10,
  HealConfig = {baseheal_formula = 3021}
}

function bs_204502:ctor()
end

function bs_204502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204502_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_204502_2", 90, self.OnSetHurt, nil, nil, nil, nil, eBattleRoleType.character)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallBuffForSameCamp)
end

function bs_204502:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole ~= nil then
        self:CallBuffForSameCamp(targetList[i].targetRole)
      end
    end
  end
end

function bs_204502:CallBuffForSameCamp(role)
  local camp = role.camp
  if role.roleType == eBattleRoleType.realSummoner then
    camp = LuaSkillCtrl:GetSummonerCamp(role)
  end
  if camp == self.caster.camp then
    LuaSkillCtrl:CallBuff(self, role, self.config.restBuffId, 1, nil)
    local heal = role.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:CallHeal(heal, self, role, true)
  end
end

function bs_204502:OnSetHurt(context)
  if context.target:GetBuffTier(self.config.restBuffId) ~= 0 and context.sender ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and context.sender.roleType == 1 and context.skill.isCommonAttack and self:IsReadyToTake() and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    self:OnSkillTake()
    local finalHurt = context.hurt * (1000 - self.arglist[4]) // 1000
    context.hurt = finalHurt
    local skilltarget = context.target
    self:onOverHeal(skilltarget)
  end
end

function bs_204502:onOverHeal(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if target.career == 1 then
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {
      self.arglist[3] * 2
    })
  else
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {
      self.arglist[3]
    })
  end
  skillResult:EndResult()
end

function bs_204502:OnCasterDie()
  base.OnCasterDie(self)
  local teamMates = LuaSkillCtrl:GetSelectTeamRoles(self.caster.belongNum)
  if teamMates.Count > 0 then
    for i = 0, teamMates.Count - 1 do
      local buffrole = teamMates[i]
      if 0 < buffrole.hp then
        LuaSkillCtrl:DispelBuff(buffrole, self.config.restBuffId, 1, true)
        if buffrole.hp > buffrole.maxHp then
          buffrole._curHp = buffrole.maxHp
        end
      end
    end
  end
end

return bs_204502
