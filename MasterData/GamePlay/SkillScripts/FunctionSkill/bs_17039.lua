local bs_17039 = class("bs_17039", LuaSkillBase)
local base = LuaSkillBase
bs_17039.config = {
  effectId = 60617,
  effectIdAttack = 60616,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  }
}

function bs_17039:ctor()
end

function bs_17039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_17039_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy)
  self.typenum = 2
end

function bs_17039:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.enemy and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
    local targetL = LuaSkillCtrl:CallTargetSelect(self, 55, 22, role)
    local role_count = self.arglist[2]
    if targetL ~= nil and targetL.Count > 0 then
      for i = 0, targetL.Count - 1 do
        local targetRole = targetL[i].targetRole
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectIdAttack, self, self.SkillEventFunc, role)
        role_count = role_count - 1
        if role_count <= 0 then
          break
        end
      end
    end
  end
end

function bs_17039:SkillEventFunc(effect, eventId, target)
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

function bs_17039:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17039
