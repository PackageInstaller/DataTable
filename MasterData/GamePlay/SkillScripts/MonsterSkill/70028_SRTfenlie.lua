local bs_70028 = class("70028_SRTfenlie", LuaSkillBase)
local base = LuaSkillBase
bs_70028.config = {
  buffId = 278,
  buffTier = 1,
  effectId = 10264,
  MonsterId1 = 37,
  MonsterId2 = 39,
  powPer = 700,
  intPer = 700,
  defPer = 1000,
  resPer = 1000
}

function bs_70028:ctor()
end

function bs_70028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_70028_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddBeforeAddBuffTrigger("bs_70028_beforeBuff", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, 3010)
  self.flag = true
end

function bs_70028:OnBeforeAddBuff(target, context)
  if target == self.caster then
    context.buff.tier = 0
  end
end

function bs_70028:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp < self.caster.maxHp * self.arglist[1] // 1000 and self.flag then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], arriveCallBack)
    self.flag = false
  end
end

function bs_70028:OnArriveAction()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.caster.roleDataId ~= self.config.MonsterId1 and self.caster.roleDataId ~= self.config.MonsterId2 then
    self:OnSummon()
    self:OnSummon()
    self:OnSummon()
  else
    self:OnSummon()
    self:OnSummon()
  end
  local damage = self.caster.maxHp + 1
  if 1 < self.caster.hp then
    LuaSkillCtrl:RemoveLife(damage, self, self.caster)
  end
end

function bs_70028:OnSummon()
  local gridData = LuaSkillCtrl:FindEmptyGridsWithinRange(self.caster.x, self.caster.y, 3, true)
  if gridData == nil then
    return
  end
  local x = gridData[0].x
  local y = gridData[0].y
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local cskill = self.caster.recordTable.CasterSkill or self.cskill
  local monsterId = self.config.MonsterId1
  if self.caster.roleDataId == 1000025 or self.caster.roleDataId == self.config.MonsterId2 then
    monsterId = self.config.MonsterId2
  end
  local summoner = LuaSkillCtrl:CreateSummonerWithCSkill(cskill, monsterId, x, y)
  local summonerHp = 1
  if 0 < self.caster.hp then
    summonerHp = self.caster.hp
  end
  summoner:SetAttr(eHeroAttr.maxHp, summonerHp)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.intPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.resPer // 1000)
  summoner:SetAsRealEntity(1)
  local table = {CasterSkill = cskill}
  summoner:SetRecordTable(table)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_70028:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_70028
