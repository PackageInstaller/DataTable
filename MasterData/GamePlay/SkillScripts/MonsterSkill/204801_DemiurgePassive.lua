local bs_204801 = class("bs_204801", LuaSkillBase)
local base = LuaSkillBase
bs_204801.config = {
  buff_superman = 204801,
  aoe = {
    effect_shape = 1,
    aoe_select_code = 2,
    aoe_range = 10
  },
  buff_bati = 196
}

function bs_204801:ctor()
end

function bs_204801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_204801", 10, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204801_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.Demiurge = true
end

function bs_204801:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_bati, 1, nil, true)
  end
end

function bs_204801:OnRoleDie(killer, role)
  local role1 = role
  local camp = role.camp
  if role.roleType == eBattleRoleType.realSummoner then
    camp = LuaSkillCtrl:GetSummonerCamp(role)
  end
  if camp == self.caster.camp and role1.hp == 0 and role1 ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe)
    if 0 >= skillResult.roleList.Count then
      return
    end
    for i = 0, skillResult.roleList.Count - 1 do
      if skillResult.roleList[i].camp == self.caster.camp then
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buff_superman, 1, self.arglist[1])
      end
    end
  end
end

function bs_204801:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204801
