local bs_301102 = class("bs_301102", LuaSkillBase)
local base = LuaSkillBase
bs_301102.config = {
  deathRoleId = 40027,
  monsterId = 34,
  effectId = 10264,
  selfDeathTime = 45,
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198
}

function bs_301102:ctor()
end

function bs_301102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_301102_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_301102_1", 10, self.OnAfterBattleStart)
end

function bs_301102:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
end

function bs_301102:OnRoleDie(killer, role)
  if role.roleDataId == self.config.deathRoleId then
    local cback = BindCallback(self, self.CallBack, role.x, role.y)
    LuaSkillCtrl:StartTimer(nil, 15, cback)
  end
end

function bs_301102:CallBack(x, y)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * 2)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:StartTimer(nil, self.config.selfDeathTime, self.Death, self)
end

function bs_301102:Death()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_301102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301102
