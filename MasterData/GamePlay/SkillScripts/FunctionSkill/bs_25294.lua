local bs_25294 = class("bs_25294", LuaSkillBase)
local base = LuaSkillBase
bs_25294.config = {
  hurtConfig = 14,
  effectId = 12067,
  effectId_hit = 12068
}

function bs_25294:ctor()
end

function bs_25294:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_25294", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.realSummoner, nil)
end

function bs_25294:OnRoleDie(killer, role)
  if role.role then
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist == nil or targetlist.Count < 1 then
    return
  end
  local range = LuaSkillCtrl:CallRange(0, targetlist.Count - 1)
  local target = targetlist[range]
  local value = role.skill_intensity + role.pow
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
    value * self.arglist[1] // 1000
  }, true)
  skillResult:EndResult()
end

function bs_25294:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25294
