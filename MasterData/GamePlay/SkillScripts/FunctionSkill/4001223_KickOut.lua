local bs_4001223 = class("bs_4001223", LuaSkillBase)
local base = LuaSkillBase
bs_4001223.config = {
  buffId_fly = 130,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_4001223:ctor()
end

function bs_4001223:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4001223_1", 1, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_4001223_2", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.flag = false
end

function bs_4001223:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.skillTag == eSkillTag.normalSkill then
    self.flag = true
  end
end

function bs_4001223:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and self.flag == true then
    self.flag = false
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
    local random = LuaSkillCtrl:CallRange(1, 100)
    if random <= self.arglist[1] then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if role.belongNum == eBattleRoleBelong.enemy then
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_fly, 1, self.arglist[2], true)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_4001223:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001223
