local bs_204302 = class("bs_204302", LuaSkillBase)
local base = LuaSkillBase
bs_204302.config = {
  buff_stun = 66,
  aoe = {
    effect_shape = 1,
    aoe_select_code = 2,
    aoe_range = 10
  }
}

function bs_204302:ctor()
end

function bs_204302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204302:OnCasterDie()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe)
  if skillResult.roleList.Count <= 0 then
    return
  end
  for i = 0, skillResult.roleList.Count - 1 do
    if skillResult.roleList[i].camp == self.caster.camp and skillResult.roleList[i].intensity < self.caster.intensity then
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buff_stun, 1, self.arglist[1])
    end
  end
  base.OnCasterDie(self)
end

return bs_204302
