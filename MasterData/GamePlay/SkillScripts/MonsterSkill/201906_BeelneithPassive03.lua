local bs_201906 = class("bs_201906", LuaSkillBase)
local base = LuaSkillBase
bs_201906.config = {
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
  hurt_config = {basehurt_formula = 10080}
}

function bs_201906:ctor()
end

function bs_201906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {
    800,
    600,
    400,
    200
  }, self.OnHpSubCost, false)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_201906s_2", 1, self.OnBuffDie)
  self.caster.recordTable.buffTime = self.arglist[7]
end

function bs_201906:OnHpSubCost(curHp, TargetValue)
  self:CallCasterWait(999)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdShield, 1, self.arglist[4], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
  local buffAction = BindCallback(self, self.OnbuffActionTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, 20, buffAction)
  self.mainEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
end

function bs_201906:OnbuffActionTrigger()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.loopAnimID)
end

function bs_201906:OnBuffDie(buff, target, removeType)
  if target == self.caster and buff.dataId == self.config.buffIdShield then
    if removeType == eBuffRemoveType.Timeout then
      LuaSkillCtrl:StartTimer(nil, 32, function()
        self:CancleCasterWait()
      end)
      if self.mainEffect ~= nil then
        self.mainEffect:Die()
        self.mainEffect = nil
      end
      LuaSkillCtrl:ClearShield(self.caster, eShieldType.Beelneith)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimID2)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_attack, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
      skillResult:BuffResult(self.config.buffSC, self.arglist[6])
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      skillResult:EndResult()
    else
      LuaSkillCtrl:StartTimer(nil, 32, function()
        self:CancleCasterWait()
      end)
      if self.mainEffect ~= nil then
        self.mainEffect:Die()
        self.mainEffect = nil
      end
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimID1)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end1, self)
    end
  end
end

function bs_201906:OnSkillRemove()
  base.OnSkillRemove(self)
  self.caster:ClearHpTrigger()
end

function bs_201906:OnCasterDie()
  base.OnCasterDie(self)
  if self.mainEffect ~= nil then
    self.mainEffect:Die()
    self.mainEffect = nil
  end
end

function bs_201906:LuaDispose()
  base.LuaDispose(self)
  self.mainEffect = nil
end

return bs_201906
