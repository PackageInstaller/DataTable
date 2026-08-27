local bs_10244 = class("bs_10244", LuaSkillBase)
local base = LuaSkillBase
bs_10244.config = {effectId = 10636}

function bs_10244:ctor()
end

function bs_10244:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10244_2", 100, self.OnSetHurt, self.caster)
end

function bs_10244:OnSetHurt(context)
  if context.sender == self.caster and LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 0 and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if targetRole ~= context.target and LuaSkillCtrl:GetRoleEfcGrid(targetRole) ~= 0 then
        local damageNum = math.max(1, context.hurt * self.arglist[1] // 1000)
        LuaSkillCtrl:RemoveLife(damageNum, self, targetRole, true)
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self, nil, context.target)
      end
    end
  end
end

function bs_10244:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10244
