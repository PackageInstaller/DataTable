local bs_21029 = class("bs_21029", LuaSkillBase)
local base = LuaSkillBase
bs_21029.config = {buffId = 110025}

function bs_21029:ctor()
end

function bs_21029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_21029_5", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_21029_6", 1, self.OnHurtResultEnd)
end

function bs_21029:OnHurtResultStart(skill, context)
  if context.sender == self.caster or context.target == self.caster then
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
    if targetList.Count ~= 0 then
      local Num = 0
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role.belongNum == eBattleRoleBelong.player then
          Num = Num + 1
        end
      end
      if 0 < Num then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_21029:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster or targetRole == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_21029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21029
