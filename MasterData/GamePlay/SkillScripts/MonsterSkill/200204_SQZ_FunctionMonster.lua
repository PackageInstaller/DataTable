local bs_40039 = class("bs_40039", LuaSkillBase)
local base = LuaSkillBase
bs_40039.config = {
  hurt_config = {
    basehurt_formula = 9988,
    hit_formula = 10201,
    crit_formula = 0,
    correct_formula = 9989
  },
  hpBuffId = 1003,
  atkBuffId = 1030,
  fqBuffId = 1064,
  mAtkBuufId = 1038,
  mFQBuffId = 1073,
  effectId = 10170,
  startAnimID = 1020,
  audioId1 = 56
}

function bs_40039:ctor()
end

function bs_40039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_40039_2", 1, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40039_1", 1, self.OnAfterBattleStart)
end

function bs_40039:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.atkBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.fqBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.mAtkBuufId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.mFQBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.hpBuffId, 900)
  LuaSkillCtrl:CallHeal(self.caster.maxHp, self, self.caster)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 600, arriveCallBack)
end

function bs_40039:OnArriveAction()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:RemoveLife(99999, self, targetList[i].targetRole, true, nil, true, false, eHurtType.RealDmg)
  end
end

function bs_40039:PlaySkill(data)
  self.attackTime = 6
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallRoleAction(self.caster, 1020)
  self:CallCasterWait(28)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, 1, 13, moveAttackTrigger)
end

function bs_40039:OnMoveAttackTrigger()
  if self.config.audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return
  end
  while self.attackTime ~= 0 do
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole ~= nil then
        LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId, self, self.SkillEventFunc)
        self.attackTime = self.attackTime - 1
      end
      if 0 >= self.attackTime then
        break
      end
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.atkBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.fqBuffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.mAtkBuufId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.mFQBuffId, 0)
end

function bs_40039:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_40039:OnSetHurt(context)
  if context.sender == self.caster then
    if context.target.attackRange > 1 then
      context.hurt = context.hurt * 800 // 1000
    else
      context.hurt = context.hurt * 1200 // 1000
    end
  end
end

function bs_40039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40039
