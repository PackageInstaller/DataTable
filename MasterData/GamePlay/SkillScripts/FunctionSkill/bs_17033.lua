local bs_17033 = class("bs_17033", LuaSkillBase)
local base = LuaSkillBase
bs_17033.config = {
  effectIdAttack = 1006,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17033:ctor()
end

function bs_17033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_17033_1", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.typenum = 1
end

function bs_17033:OnAfterPlaySkill(battleSkill, role)
  if role == self.caster and battleSkill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
    if roleslist.Count > self.arglist[3] then
      for i = 0, self.arglist[3] - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
    if roleslist.Count <= self.arglist[3] then
      for i = 0, roleslist.Count - 1 do
        LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
      end
    end
  end
end

function bs_17033:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
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

function bs_17033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17033
