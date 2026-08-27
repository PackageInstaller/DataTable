local bs_107902 = class("bs_107902", LuaSkillBase)
local base = LuaSkillBase
bs_107902.config = {
  actionId = 1002,
  start_time = 5,
  skill_time = 18,
  atk_time = 11,
  buffid = 107906,
  effect_trail = 107907,
  effectId_mark = 107909,
  effect_blink = 107905,
  effectId_show = 107906,
  effectId_hit = 107910,
  HurtConfigID = 2,
  monsterId = 83
}

function bs_107902:ctor()
end

function bs_107902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307903 then
    self.monsterId = 831
  else
    self.monsterId = self.config.monsterId
  end
end

function bs_107902:PlaySkill(data)
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_blink, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local skilltime = self.config.skill_time
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_107902:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effect_trail, self)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_mark, self)
  if target ~= nil then
    local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(target)
    if Grid == nil then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, self.config.atk_time, true)
      self:DoDamage(target)
      self:EndDamage()
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, self.config.atk_time, true)
      LuaSkillCtrl:CallEffect(target, self.config.effectId_mark, self)
      local grid = LuaSkillCtrl:GetGridWithRole(self.caster)
      LuaSkillCtrl:SetRolePos(Grid, self.caster)
      self:Summon(grid)
      self:DoDamage(target)
      self:EndDamage()
    end
  end
end

function bs_107902:DoDamage(target)
  self.loopAtker = LuaSkillCtrl:StartTimer(self, 2, function()
    if target.isDead then
      LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[4])
      self.shower.left = 0
      return
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end, nil, -1, 1)
end

function bs_107902:EndDamage()
  self.shower = LuaSkillCtrl:StartTimer(self, self.config.atk_time, function()
    if self.loopAtker ~= nil then
      self.loopAtker:Stop()
      self.loopAtker = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
    self:OnSkillDamageEnd()
  end, nil, 0, 0)
end

function bs_107902:Summon(Grid)
  local summonerEntity
  if Grid ~= nil then
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce)
    summoner:SetAttr(eHeroAttr.resistance, self.caster.resistance)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.dodge, self.dodge)
    summoner:SetAsRealEntity(1)
    local arg1 = self.arglist[3]
    local tab = {arg_1 = arg1}
    summoner:SetRecordTable(tab)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  end
end

function bs_107902:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self:CancleCasterWait()
end

function bs_107902:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107902
