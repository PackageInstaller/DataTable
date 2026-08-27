local bs_108403 = class("bs_108403", LuaSkillBase)
local base = LuaSkillBase
bs_108403.config = {
  buffId_198 = 198,
  summonerId = 100,
  effectStart = 108419,
  effectTrail = 108420,
  actionId = 1005,
  HurtConfigId = 25,
  HurtConfigId2 = 14,
  buffId_3024 = 3024,
  audioIdStart = 108416,
  audioIdMovie = 108417,
  audioIdEnd = 108418
}
local SyncAttrList = {
  eHeroAttr.pow,
  eHeroAttr.skill_intensity,
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.speed,
  eHeroAttr.crit,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.return_damage,
  eHeroAttr.life_steal,
  eHeroAttr.spell_life_steal,
  eHeroAttr.resistance
}

function bs_108403:ctor()
end

function bs_108403:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSangomaSummonerDead, self.OnSummonerDead)
  self:AddAfterHurtTriggerForTable("bs_209701_1", 1, self.OnAfterHurt, {extraArg3 = false})
end

function bs_108403:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectStart, self)
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  self.gridTarget = LuaSkillCtrl:GetTargetWithGrid(self.targetGrid.x, self.targetGrid.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_108403:CallSelectExecute(role)
  LuaSkillCtrl:CallEffect(self.gridTarget, self.config.effectTrail, self, nil, role, nil, true)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[4]
  })
  skillResult:EndResult()
  self:SummonTar(role)
  self:ResetSkill(self.caster)
end

function bs_108403:SummonTar(role)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, self.targetGrid.x, self.targetGrid.y, eBattleRoleBelong.enemy)
  local def = role.def * self.arglist[2] // 1000
  local MagicRes = role.magic_res * self.arglist[2] // 1000
  local hpAndMaxHp = role.maxHp * self.arglist[6] // 1000
  summoner:SetAttr(eHeroAttr.magic_res, MagicRes)
  summoner:SetAttr(eHeroAttr.def, def)
  summoner:SetAttr(eHeroAttr.maxHp, hpAndMaxHp)
  summoner:SetAttr(eHeroAttr.hp, hpAndMaxHp)
  local hostEntity = role
  if hostEntity == nil or hostEntity.hp <= 0 then
    return over
  end
  for i, v in ipairs(SyncAttrList) do
    local curValue = role:GetRealProperty(v)
    summoner:SetAttr(v, curValue)
  end
  summoner:SetAsRealEntity(1)
  local arg1 = role
  local arg2 = self.arglist[3]
  local tab = {arg_1 = arg1, arg_2 = arg2}
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  self.caster.recordTable["100_summoner"] = summonerEntity
  self.caster.recordTable["100_master"] = role
end

function bs_108403:OnSummonerDead(master)
  if master.isDead == false then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, master)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
      self.arglist[5]
    })
    skillResult:EndResult()
  end
end

function bs_108403:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local role = self.caster.recordTable["100_master"]
  local sunmmoner = self.caster.recordTable["100_summoner"]
  if sunmmoner ~= nil and sunmmoner.isDead == false and target == sunmmoner then
    local num = hurt * self.arglist[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId2, {num}, true, false, nil, 105)
    skillResult:EndResult()
  end
end

function bs_108403:ResetSkill(role)
  LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buffId_3024, 0, true)
end

function bs_108403:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_108403:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108403
