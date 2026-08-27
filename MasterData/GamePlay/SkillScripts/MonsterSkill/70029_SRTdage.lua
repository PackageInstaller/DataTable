local bs_70029 = class("bs_70029", LuaSkillBase)
local base = LuaSkillBase
bs_70029.config = {
  monsterId = 38,
  buffId = 1237,
  buffTier = 1,
  effectId = 10264,
  maxHpPer = 250,
  powPer = 1000,
  summonDelay = 30
}

function bs_70029:ctor()
end

function bs_70029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70029_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_70029_11", 10, self.OnRoleDie)
end

function bs_70029:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  self:OnSummon()
  self:OnSummon()
end

function bs_70029:OnRoleDie(killer, role, killSkill)
  if role.roleDataId == self.config.monsterId then
    local damage = self.caster.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:RemoveLife(damage, self, self.caster)
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    LuaSkillCtrl:StartTimer(nil, self.config.summonDelay, arriveCallBack)
  end
end

function bs_70029:OnArriveAction()
  if self.caster.hp > 0 then
    self:OnSummon()
  end
end

function bs_70029:OnSummon()
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return
  end
  local x = gridData.x
  local y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local cskill = self.caster.recordTable.CasterSkill or self.cskill
  local summoner = LuaSkillCtrl:CreateSummonerWithCSkill(cskill, self.config.monsterId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def // 10)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res // 10)
  summoner:SetAsRealEntity(1)
  local table = {CasterSkill = cskill}
  summoner:SetRecordTable(table)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_70029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70029
