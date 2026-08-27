local FireBase = class("FireBase", LuaSkillBase)
local base = LuaSkillBase
FireBase.config = {
  defaultFireMaxTier = 10,
  buffMiniFire = 2228,
  dispelBuffPer = 1000,
  effectId = 12092,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  newBuffId_miniFire = 110152
}

function FireBase:ctor()
end

function FireBase:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.FireMaxTier = self.config.defaultFireMaxTier
  self.NowFireBuff = self.config.buffMiniFire
  self.isHaveChain = false
  self.TimesPercent = 1000
end

function FireBase:OnAfterBattleStart()
  local commander = LuaSkillCtrl:GetPlayerRoleEntity()
  if commander.recordTable.FireBaseMaxTier ~= nil then
    self.FireMaxTier = commander.recordTable.FireBaseMaxTier
  end
  if commander.recordTable.FireBaseBuff ~= nil then
    self.NowFireBuff = commander.recordTable.FireBaseBuff
  end
  if commander.recordTable.FireBaseChain ~= nil then
    self.isHaveChain = true
    self.TimesPercent = commander.recordTable.FireBaseChain
  end
end

function FireBase:AddFireMaxTier(num)
  local commander = LuaSkillCtrl:GetPlayerRoleEntity()
  if commander.recordTable.FireBaseMaxTier == nil then
    commander.recordTable.FireBaseMaxTier = self.config.defaultFireMaxTier
  end
  commander.recordTable.FireBaseMaxTier = commander.recordTable.FireBaseMaxTier + num
end

function FireBase:ChangeFireBuff(Id)
  local commander = LuaSkillCtrl:GetPlayerRoleEntity()
  commander.recordTable.FireBaseBuff = Id
end

function FireBase:CallFireBuff(target, tier, oversender)
  local now_tier = target:GetBuffTier(self.NowFireBuff)
  local empty_tier = self.FireMaxTier - now_tier
  if empty_tier < 1 then
    LuaSkillCtrl:CallBuff(self, target, self.NowFireBuff, 1, 120, true)
    LuaSkillCtrl:DispelBuff(target, self.NowFireBuff, 1, true, false)
  elseif tier > empty_tier then
    LuaSkillCtrl:CallBuff(self, target, self.NowFireBuff, empty_tier, 120)
  else
    LuaSkillCtrl:CallBuff(self, target, self.NowFireBuff, tier, 120)
  end
end

function FireBase:ActiveFireBuff(target, args)
  local tier = target:GetBuffTier(self.NowFireBuff)
  LuaSkillCtrl:DispelBuff(target, self.NowFireBuff, 0, true, true)
  if self.isHaveChain then
    local times = tier // self.TimesPercent
    if times < 2 then
      self:HurtFunc(target, args, tier)
    else
      LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      for i = 0, times - 1 do
        self:HurtFunc(target, args, tier, true)
      end
    end
  else
    self:HurtFunc(target, args, tier)
  end
end

function FireBase:HurtFunc(target, args, tier, isNotOneTimes)
  if target == nil then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  local damage = 0
  damage = args * tier
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 38, {damage}, true)
  skillResult:EndResult()
  if isNotOneTimes ~= nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function FireBase:OnCasterDie()
  base.OnCasterDie(self)
end

return FireBase
