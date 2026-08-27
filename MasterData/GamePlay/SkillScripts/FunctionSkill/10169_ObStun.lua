local bs_10169 = class("bs_10169", LuaSkillBase)
local base = LuaSkillBase
bs_10169.config = {
  buffId = 66,
  buffTier = 1,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  effectId = 10556
}

function bs_10169:ctor()
end

function bs_10169:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10169_1", 1, self.OnRoleDie)
  self.flag = true
end

function bs_10169:OnRoleDie(killer, role)
  if role.intensity == 0 and role.belongNum == eBattleRoleBelong.neutral and self.flag then
    self.flag = false
    LuaSkillCtrl:CallEffect(role, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10169:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if role.belongNum == 2 then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, self.arglist[1])
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_10169:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10169
