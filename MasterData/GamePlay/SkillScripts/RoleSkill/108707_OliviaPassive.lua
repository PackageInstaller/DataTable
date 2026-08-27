local bs_108707 = class("bs_108707", LuaSkillBase)
local base = LuaSkillBase
bs_108707.config = {effect_1 = 108703}

function bs_108707:ctor()
end

function bs_108707:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108707_01", 1, self.OnAfterBattleStart)
end

function bs_108707:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetOriginRole(1087)
  if caster == nil then
    return
  end
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local critDamageNum, powNum
  if caster.roleOnBench then
    critDamageNum = caster.critDamage * self.caster.recordTable.passiveArg9 // 1000
    powNum = caster.pow * self.caster.recordTable.passiveArg8 // 1000
  else
    critDamageNum = self.caster.recordTable.passiveArg2
    powNum = caster.pow * self.caster.recordTable.passiveArg1 // 1000
  end
  for i = 0, list.Count - 1 do
    local role = list[i]
    role:AddRoleProperty(eHeroAttr.critDamage, critDamageNum, eHeroAttrType.Extra)
    if role.roleType == eBattleRoleType.character then
      role:AddRoleProperty(eHeroAttr.pow, powNum, eHeroAttrType.Extra)
      LuaSkillCtrl:CallEffect(role, self.config.effect_1, self)
    end
  end
end

function bs_108707:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108707:LuaDispose()
  base.LuaDispose(self)
end

return bs_108707
