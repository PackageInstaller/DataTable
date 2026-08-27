local bs_25284 = class("bs_25284", LuaSkillBase)
local base = LuaSkillBase
bs_25284.config = {
  SummonnerId = 73,
  maxHpPer = 100,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  effectId_shencheng = 70001,
  effectId_chongji = 12065,
  effectId_up = 501101,
  effectId_down = 501102,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  buffId_hitback = 2066
}

function bs_25284:ctor()
end

function bs_25284:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_25284", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, nil)
  self.hurtSum = 0
end

function bs_25284:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss or target ~= self.caster then
    return
  end
  self.hurtSum = self.hurtSum + hurt
  if self.hurtSum >= self.arglist[1] * self.caster.maxHp // 1000 then
    self.hurtSum = 0
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CreatWall))
  end
end

function bs_25284:CreatWall()
  local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  for i = 0, targetList.Count - 1 do
    if targetList[i].roleType ~= eBattleRoleType.realSummoner then
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_hitback, 1, 10, true)
    end
  end
  local gridList = LuaSkillCtrl:FindAllGridsWithinRange(self.caster, 1, false)
  for i = 0, gridList.Count - 1 do
    local x = gridList[i].x
    local y = gridList[i].y
    if LuaSkillCtrl:GetRoleWithPos(x, y) == nil then
      local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, x, y, eBattleRoleBelong.player)
      summoner:SetAttr(eHeroAttr.maxHp, 2000)
      summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
      summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
      summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
      summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
      summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
      summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
      summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
      summoner:SetAsRealEntity(1)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      local role = LuaSkillCtrl:GetRoleWithPos(x, y)
      LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
    end
  end
end

function bs_25284:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25284
