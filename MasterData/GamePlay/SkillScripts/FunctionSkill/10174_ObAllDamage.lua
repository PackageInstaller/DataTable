local bs_10174 = class("bs_10174", LuaSkillBase)
local base = LuaSkillBase
bs_10174.config = {}

function bs_10174:ctor()
end

function bs_10174:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10174_2", 1, self.OnSetHurt, self.caster)
end

function bs_10174:OnSetHurt(context)
  if not context.isMiss and context.target.intensity == 0 and not context.isTriggerSet and context.sender.roleType ~= eBattleRoleType.skillCaster and context.sender == self.caster then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if 0 >= targetlist.Count then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if targetRole ~= context.target and targetRole.intensity == 0 then
        local damage = context.hurt * self.arglist[1] // 1000
        LuaSkillCtrl:RemoveLife(damage, self, targetRole, true)
      end
    end
  end
end

function bs_10174:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10174
