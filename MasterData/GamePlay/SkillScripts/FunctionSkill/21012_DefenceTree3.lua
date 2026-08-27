local bs_21012 = class("bs_21012", LuaSkillBase)
local base = LuaSkillBase
bs_21012.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10187,
    crit_formula = 0
  },
  effectId = 10945
}

function bs_21012:ctor()
end

function bs_21012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_21012_1", 1, self.OnAfterHeal, self.caster)
end

function bs_21012:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and not isTriggerSet then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    local role
    if targetlist.Count > 0 then
      for i = 0, targetlist.Count - 1 do
        if targetlist[i].belongNum == eBattleRoleBelong.enemy then
          if role == nil then
            role = targetlist[i]
          elseif targetlist[i].hp <= role.hp then
            role = targetlist[i]
          end
        end
      end
    end
    local value = heal * self.arglist[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {value}, true)
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self)
    skillResult:EndResult()
  end
end

function bs_21012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21012
