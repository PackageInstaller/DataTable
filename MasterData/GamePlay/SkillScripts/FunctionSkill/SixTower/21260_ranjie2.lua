local sixtower_ranjie2 = class("sixtower_ranjie2", LuaSkillBase)
local base = LuaSkillBase
sixtower_ranjie2.config = {
  effectId_line = 100103,
  effectId_PassHit = 100104,
  effectId = 10813,
  buffId_live = 3009,
  nanaka_buffId = 102603,
  heal_configId = 4,
  buffId = 2258
}

function sixtower_ranjie2:ctor()
end

function sixtower_ranjie2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTriggerForTable("sixtower_ranjie2", 1, self.OnSetDeadHurt, {
    target = self.caster
  })
  self.times = self.arglist[1]
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "sixtower_ranjie2", 1, self.OnAfterBattleStart)
end

function sixtower_ranjie2:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil)
end

function sixtower_ranjie2:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and 0 < self.caster:GetBuffTier(self.config.buffId) and NoDeath == false then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if context.target == nil or context.target.hp <= 0 then
        return
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_configId, {
        self.arglist[2]
      }, true, false)
      skillResult:EndResult()
    end)
    self:OnSkillTake()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
end

function sixtower_ranjie2:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_ranjie2
