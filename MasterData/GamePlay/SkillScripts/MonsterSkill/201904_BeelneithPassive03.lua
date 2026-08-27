local bs_201904 = class("bs_201904", LuaSkillBase)
local base = LuaSkillBase
bs_201904.config = {
  buffIdShield = 1148,
  startAnimID = 1022,
  loopAnimID = 1023,
  endAnimID1 = 1026,
  endAnimID2 = 1027,
  effectId_start = 10809,
  effectId_end1 = 10810,
  effectId_end2 = 10811,
  effectId_attack = 10812,
  buffSC = 186,
  aoe_config = {
    effect_shape = 2,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {basehurt_formula = 10080},
  audioId1 = 335,
  audioId2 = 336
}

function bs_201904:ctor()
end

function bs_201904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_201904_2", 1, self.OnBuffDie)
  self.caster.recordTable.buffTime = self.arglist[7]
end

function bs_201904:PlaySkill(data)
  self:CallCasterWait(999)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdShield, 1, self.arglist[4], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimID)
  self.mainEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
end

function bs_201904:OnBuffDie(buff, target, removeType)
  if target == self.caster and buff.dataId == self.config.buffIdShield then
    if removeType == eBuffRemoveType.Timeout then
      self:ClearEffectAndAudio()
      LuaSkillCtrl:ClearShield(self.caster, eShieldType.Beelneith)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimID2)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_attack, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
      skillResult:BuffResult(self.config.buffSC, self.arglist[6])
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      skillResult:EndResult()
      LuaSkillCtrl:StartTimer(nil, 32, function()
        self:CancleCasterWait()
        self:CallNextBossSkill()
      end)
    else
      self:ClearEffectAndAudio()
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimID1)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end1, self)
      LuaSkillCtrl:StartTimer(nil, 32, function()
        self:CancleCasterWait()
        self:CallNextBossSkill()
      end)
    end
  end
end

function bs_201904:OnSkillRemove()
  base.OnSkillRemove(self)
  self.caster:ClearHpTrigger()
end

function bs_201904:ClearEffectAndAudio()
  if self.mainEffect ~= nil then
    self.mainEffect:Die()
    self.mainEffect = nil
  end
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

function bs_201904:OnCasterDie()
  base.OnCasterDie(self)
  self:ClearEffectAndAudio()
end

function bs_201904:LuaDispose()
  base.LuaDispose(self)
  self.mainEffect = nil
  self.loopaudio = nil
end

return bs_201904
