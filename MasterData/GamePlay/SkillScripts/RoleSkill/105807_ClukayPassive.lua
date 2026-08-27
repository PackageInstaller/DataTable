local bs_105807 = class("bs_105807", LuaSkillBase)
local base = LuaSkillBase
bs_105807.config = {Role_id = 1058, effectid = 105834}

function bs_105807:ctor()
end

function bs_105807:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105807_1", 1, self.OnAfterBattleStart)
end

function bs_105807:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
  if caster ~= nil and caster.roleOnBench then
    local role
    local targets = LuaSkillCtrl:CallTargetSelect(self, 64, 10)
    if targets.Count > 0 then
      role = targets[0].targetRole
    end
    role:AddRoleProperty(eHeroAttr.crit, caster.crit * self.arglist[1] // 1000, eHeroAttrType.Extra)
    LuaSkillCtrl:CallEffect(role, self.config.effectid, self)
  end
end

function bs_105807:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_105807:LuaDispose()
  base.LuaDispose(self)
end

return bs_105807
