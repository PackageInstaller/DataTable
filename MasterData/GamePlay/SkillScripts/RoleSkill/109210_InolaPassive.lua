local bs_109210 = class("bs_109210", LuaSkillBase)
local base = LuaSkillBase
bs_109210.config = {effect_1 = 109203}

function bs_109210:ctor()
end

function bs_109210:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_109210_01", 1, self.OnAfterBattleStart)
end

function bs_109210:OnAfterBattleStart()
  local caster = LuaSkillCtrl:GetOriginRole(1092)
  if caster == nil then
    return
  end
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local AttrDamageNum
  if caster.roleOnBench then
    AttrDamageNum = caster.skill_intensity * self.caster.recordTable.passiveArg1 // 1000
    for i = 0, list.Count - 1 do
      local role = list[i]
      if role.roleType == eBattleRoleType.character then
        role:AddRoleProperty(eHeroAttr.skill_intensity, AttrDamageNum, eHeroAttrType.Extra)
        LuaSkillCtrl:CallEffect(role, self.config.effect_1, self)
      end
    end
  end
end

function bs_109210:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109210:LuaDispose()
  base.LuaDispose(self)
end

return bs_109210
