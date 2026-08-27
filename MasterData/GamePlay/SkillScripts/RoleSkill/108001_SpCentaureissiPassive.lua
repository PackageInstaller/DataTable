local bs_108001 = class("bs_108001", LuaSkillBase)
local base = LuaSkillBase
bs_108001.config = {
  SelectId = 1,
  selectId2 = 6,
  effectTrail = 108003,
  effectFrag = 107605,
  buffXm = 108006,
  buffZZ = 108002,
  buffPowerUp = 108003,
  hurtConfig = 25
}
local blindList = {
  115,
  3012,
  108006,
  108008,
  301201,
  208401,
  1009032,
  450000115,
  450003012
}

function bs_108001:ctor()
end

function bs_108001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_108001_01", 1, self.OnAfterHurt, {
    extraArg3 = false,
    sender = self.caster
  })
  self:AddSetHurtTriggerForTable("bs_108001_06", 1, self.OnSetHurt, {
    extraArg3 = true,
    targetBelongNum = eBattleRoleBelong.player
  })
  self:AddAfterAddBuffTrigger("bs_108001_02", 1, self.OnAfterAddBuff, self.caster, self.caster, nil, nil, self.config.buffZZ)
  self:AddBuffDieTrigger("bs_108001_03", 1, self.OnBuffDie, self.caster, nil, self.config.buffPowerUp)
  self.cdFrame = 0
  self.cdMinFrame = 0
  self.missTime = 0
  self.hurtArgs = {}
  self.ZZTime = 0
end

function bs_108001:Frag(target)
  local isPowerUp = false
  if self.caster:GetBuffTier(self.config.buffPowerUp) > 0 then
    isPowerUp = true
  end
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectTrail, self, nil, nil, self.SkillEventFunc, isPowerUp)
end

function bs_108001:SkillEventFunc(isPowerUp, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(target, self.config.effectFrag, self)
    local enemys = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId2, 1, target.targetRole)
    if enemys.Count > 0 then
      for i = 0, enemys.Count - 1 do
        local enemyRole = enemys[i].targetRole
        if enemyRole.belongNum ~= eBattleRoleBelong.neutral then
          LuaSkillCtrl:CallBuff(self, enemyRole, self.config.buffXm, 1, self.arglist[2])
        end
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, enemyRole)
        if isPowerUp == true then
          local args = LuaSkillCtrl:CreatCacheTable(self.arglist[1] + self.arglist[8], self.hurtArgs)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, args)
        else
          local args = LuaSkillCtrl:CreatCacheTable(self.arglist[1], self.hurtArgs)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, args)
        end
        skillResult:EndResult()
      end
    end
  end
end

function bs_108001:OnSetHurt(context)
  if context.target.roleType ~= eBattleRoleType.realSummoner then
    self.missTime = self.missTime + 1
    if self.missTime >= self.arglist[11] and self.cdFrame > self.cdMinFrame then
      self.missTime = self.missTime - self.arglist[11]
      self.cdFrame = self.cdFrame - self.arglist[3]
      if self.cdFrame < self.cdMinFrame then
        self.cdFrame = self.cdMinFrame
      end
    end
  end
end

function bs_108001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isTriggerSet == false and skill.skillType == eBattleSkillLogicType.Original then
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    local isblind = false
    if buffs ~= nil and buffs.Count > 0 then
      for j = 0, buffs.Count - 1 do
        local buffId = buffs[j].dataId
        for i, v in ipairs(blindList) do
          if v == buffId then
            isblind = true
            break
          end
        end
        if isblind == true then
          break
        end
      end
    end
    if isblind == true and isMiss == false and self.caster:GetBuffTier(self.config.buffPowerUp) ~= 1 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffZZ, 1)
    elseif isblind == true and isMiss == false and self.caster:GetBuffTier(self.config.buffPowerUp) == 1 then
      self.ZZTime = self.ZZTime + 1
    end
    local curFrame = LuaSkillCtrl.battleCtrl.frame
    if curFrame > self.cdFrame then
      self.cdFrame = curFrame + self.arglist[10]
      self.cdMinFrame = curFrame + self.arglist[12]
      self:Frag(target)
    end
  end
end

function bs_108001:OnAfterAddBuff(buff, target)
  local buffTier = self.caster:GetBuffTier(self.config.buffZZ)
  local isPowerUp = false
  if self.caster:GetBuffTier(self.config.buffPowerUp) > 0 then
    isPowerUp = true
  end
  if buffTier >= self.arglist[5] and isPowerUp == false then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffPowerUp, 1, self.arglist[6])
  end
end

function bs_108001:OnBuffDie(buff, target, removeType)
  if removeType == eBuffRemoveType.Timeout and buff.dataId == self.config.buffPowerUp then
    local Tier = self.ZZTime
    if Tier >= self.arglist[5] then
      Tier = self.arglist[5]
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffZZ, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffZZ, Tier)
    self.ZZTime = 0
  end
end

function bs_108001:LuaDispose()
  base.LuaDispose(self)
  self.cdFrame = 0
  self.cdMinFrame = 0
  self.hurtArgs = nil
  self.ZZTime = 0
end

function bs_108001:OnCasterDie()
  base.OnCasterDie(self)
  self.cdFrame = 0
  self.cdMinFrame = 0
  self.ZZTime = 0
end

return bs_108001
