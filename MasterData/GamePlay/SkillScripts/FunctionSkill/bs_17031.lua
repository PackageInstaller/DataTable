local bs_17031 = class("bs_17031", LuaSkillBase)
local base = LuaSkillBase
bs_17031.config = {
  effectId = 60615,
  effectIdAttack = 60614,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17031:ctor()
end

function bs_17031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("107031_after_hurt", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
  self.typenum = 1
end

function bs_17031:OnAfterPlaySkill(battleSkill, role)
  if self:IsReadyToTake() then
    local targetL = self.caster.recordTable.lastAttackRole
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(role, targetL)
  end
end

function bs_17031:CheckAndAddBuffToTarget(sender, target)
  if target ~= nil and target.hp > 0 and sender ~= nil and sender.hp > 0 and self.attackNum >= self.arglist[2] then
    local loopTime = self.arglist[3] - 1
    local loopJiange = self.arglist[4] // self.arglist[3]
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    self.timer = LuaSkillCtrl:StartTimer(nil, loopJiange, arriveCallBack, self, loopTime, loopJiange)
    self.attackNum = 0
  end
end

function bs_17031:OnArriveAction(role)
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  if role.hp == 0 or role:IsUnSelect(self.caster) then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetlist.Count < 1 then
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
      end
      return
    end
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectIdAttack, self, self.SkillEventFunc)
  else
    LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_17031:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil)
    local tar = target.targetRole
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.Callthrows, tar, self.typenum, self.arglist[1], true)
    if self.caster.recordTable["25211_Flag"] == true then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.caster.recordTable["25211_arg"] + self.arglist[1]
      }, true)
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[1]
      }, true)
    end
    skillResult:EndResult()
  end
end

function bs_17031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17031
