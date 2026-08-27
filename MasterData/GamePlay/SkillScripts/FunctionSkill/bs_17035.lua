local bs_17035 = class("bs_17035", LuaSkillBase)
local base = LuaSkillBase
bs_17035.config = {
  effectId = 60615,
  effectIdAttack = 60614,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17035:ctor()
end

function bs_17035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17035_1", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
  self.targetLL = nil
  self.typenum = 1
end

function bs_17035:OnAfterPlaySkill(battleSkill, role)
  if role == self.caster and battleSkill.isCommonAttack then
    local targetL = self.caster.recordTable.lastAttackRole
    if targetL ~= nil and self.targetLL ~= nil then
      if targetL == self.targetLL then
        self.attackNum = self.attackNum + 1
      else
        self.attackNum = 0
      end
    end
    self.targetLL = targetL
    if self.attackNum > 0 then
      for i = 0, math.min(self.attackNum, self.arglist[2]) - 1 do
        LuaSkillCtrl:CallEffect(targetL, self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
  end
end

function bs_17035:SkillEventFunc(effect, eventId, target)
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

function bs_17035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17035
