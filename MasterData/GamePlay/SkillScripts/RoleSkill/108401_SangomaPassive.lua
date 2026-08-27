local bs_108401 = class("bs_108401", LuaSkillBase)
local base = LuaSkillBase
bs_108401.config = {
  buffAtkUp = 108401,
  buffLifeSteal = 108402,
  buffAtkDown = 108403,
  buffBlade = 108404,
  effectRY = 108411,
  buffId_live = 3009
}

function bs_108401:ctor()
end

function bs_108401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_208801_1", 1, self.OnSetHurt, {
    extraArg1 = eSkillTag.commonAttack,
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy,
    extraArg2 = false,
    extraArg3 = false
  })
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddSetDeadHurtTriggerForTable("bs_107501_6_1", 850, self.OnSetDeadHurt, {
    target = self.caster
  })
  self.caster.recordTable[114] = self.caster.pow
  self.isSurvive = true
end

function bs_108401:OnSetHurt(context)
  local num = self.caster:GetBuffTier(self.config.buffBlade)
  if 0 < num then
    num = 1 + num
  else
    num = 1
  end
  local tier = self.caster:GetBuffTier(self.config.buffAtkUp)
  if tier < self.arglist[2] // self.arglist[1] then
    if tier + num > self.arglist[2] // self.arglist[1] then
      num = self.arglist[2] // self.arglist[1] - tier
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffAtkUp, num)
  end
  local summoner = self.caster.recordTable["100_summoner"]
  if summoner ~= nil and context.target == summoner then
    local target = self.caster.recordTable["100_master"]
    if target ~= nil then
      local targetTier = target:GetBuffTier(self.config.buffAtkDown)
      if targetTier < self.arglist[2] // self.arglist[1] then
        if targetTier + num > self.arglist[2] // self.arglist[1] then
          num = self.arglist[2] // self.arglist[1] - targetTier
        end
        LuaSkillCtrl:CallBuff(self, target, self.config.buffAtkDown, num)
      end
    end
  else
    local targetTier = context.target:GetBuffTier(self.config.buffAtkDown)
    if targetTier < self.arglist[2] // self.arglist[1] then
      if targetTier + num > self.arglist[2] // self.arglist[1] then
        num = self.arglist[2] // self.arglist[1] - targetTier
      end
      LuaSkillCtrl:CallBuff(self, context.target, self.config.buffAtkDown, num)
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffLifeSteal, 1)
end

function bs_108401:OnRoleSplash(role)
  self:OnSplashOrPhaseMove()
end

function bs_108401:OnRolePhaseMoveStart(role, luaskill)
  self:OnSplashOrPhaseMove()
end

function bs_108401:OnSplashOrPhaseMove()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectRY, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffBlade, 1, self.arglist[7])
end

function bs_108401:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false and self.isSurvive then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, self.arglist[8], true)
    self.isSurvive = false
  end
end

function bs_108401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108401
