local bs_21040 = class("bs_21040", LuaSkillBase)
local base = LuaSkillBase
bs_21040.config = {buffId = 110031}

function bs_21040:ctor()
end

function bs_21040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_21040_14", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_21040_15", 1, self.OnHurtResultEnd)
end

function bs_21040:OnHurtResultStart(skill, context)
  if skill.maker == self.caster then
    local targetlist = LuaSkillCtrl:FindRolesAroundRole(self.caster)
    if targetlist == nil or targetlist.Count == 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    else
      local Num = 0
      for i = 0, targetlist.Count - 1 do
        local role = targetlist[i]
        if role.belongNum == eBattleRoleBelong.enemy and LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
          Num = Num + 1
        end
      end
      if Num == 0 then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_21040:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_21040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21040
