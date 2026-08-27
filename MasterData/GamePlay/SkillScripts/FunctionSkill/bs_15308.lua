local bs_15308 = class("bs_15308", LuaSkillBase)
local base = LuaSkillBase
bs_15308.config = {buffId = 110128, buffId1 = 110129}

function bs_15308:ctor()
end

function bs_15308:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15308_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_15308_3", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, eBattleRoleType.character, nil, nil, eSkillTag.commonAttack)
end

function bs_15308:OnAfterBattleStart()
  if self.caster.career ~= 5 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
  end
end

function bs_15308:OnAfterPlaySkill(skill, role)
  if self.caster.career == 5 then
    return
  end
  if skill.isCommonAttack then
    local buffTier = self.arglist[3] // self.arglist[2]
    if buffTier > self.caster:GetBuffTier(self.config.buffId1) then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil)
    end
  end
end

function bs_15308:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15308
