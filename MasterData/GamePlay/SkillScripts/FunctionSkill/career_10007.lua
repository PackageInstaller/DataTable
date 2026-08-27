local career_10007 = class("career_10007", LuaSkillBase)
local base = LuaSkillBase
career_10007.config = {
  summoner1 = 5,
  summoner2 = 4,
  effectId_down = 10111,
  maxHp = 15,
  speed = 100,
  pow = 300,
  skill_intensity = 300,
  crit = 0,
  critDamage = 0,
  def = 1000,
  sunder = 1000,
  magic_res = 1000,
  magic_pen = 1000,
  maxHp2 = 10,
  speed2 = 100,
  pow2 = 300,
  skill_intensity2 = 300,
  crit2 = 0,
  critDamage2 = 0,
  def2 = 1000,
  sunder2 = 1000,
  magic_res2 = 1000,
  magic_pen2 = 1000
}

function career_10007:ctor()
end

function career_10007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10007_2", 1, self.OnAfterBattleStart)
end

function career_10007:OnAfterBattleStart()
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid == nil then
    return
  end
  local targetGridlist = LuaSkillCtrl:FindEmptyGridsWithinRange(targetGrid.x, targetGrid.y, 10, false)
  local targetGrid2 = targetGridlist[1]
  if targetGrid2 == nil then
    return
  end
  if self.arglist[1] == 1 or self.arglist[1] == 3 then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summoner1, targetGrid.x, targetGrid.y, eBattleRoleBelong.player)
    summoner:SetAttr(eHeroAttr.maxHp, self.config.maxHp)
    summoner:SetAttr(eHeroAttr.pow, self.config.pow)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.config.skill_intensity)
    summoner:SetAttr(eHeroAttr.speed, self.config.speed)
    summoner:SetAttr(eHeroAttr.def, self.config.def)
    summoner:SetAttr(eHeroAttr.sunder, self.config.sunder)
    summoner:SetAttr(eHeroAttr.magic_res, self.config.magic_res)
    summoner:SetAttr(eHeroAttr.magic_pen, self.config.magic_pen)
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:AddSummonerRole(summoner)
    local target = LuaSkillCtrl:GetTargetWithGrid(targetGrid.x, targetGrid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  end
  if self.arglist[1] == 2 or self.arglist[1] == 3 then
    local summoner2 = LuaSkillCtrl:CreateSummoner(self, self.config.summoner2, targetGrid2.x, targetGrid2.y, eBattleRoleBelong.player)
    summoner2:SetAttr(eHeroAttr.maxHp, self.config.maxHp2)
    summoner2:SetAttr(eHeroAttr.pow, self.config.pow2)
    summoner2:SetAttr(eHeroAttr.skill_intensity, self.config.skill_intensity2)
    summoner2:SetAttr(eHeroAttr.speed, self.config.speed2)
    summoner2:SetAttr(eHeroAttr.def, self.config.def2)
    summoner2:SetAttr(eHeroAttr.sunder, self.config.sunder2)
    summoner2:SetAttr(eHeroAttr.magic_res, self.config.magic_res2)
    summoner2:SetAttr(eHeroAttr.magic_pen, self.config.magic_pen2)
    summoner2:SetAsRealEntity(1)
    LuaSkillCtrl:AddSummonerRole(summoner2)
    local target2 = LuaSkillCtrl:GetTargetWithGrid(targetGrid2.x, targetGrid2.y)
    LuaSkillCtrl:CallEffect(target2, self.config.effectId_down, self)
  end
end

function career_10007:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10007
