local bs_204806 = class("bs_204806", LuaSkillBase)
local base = LuaSkillBase
bs_204806.config = {
  buff_superman = 204801,
  aoe = {
    effect_shape = 1,
    aoe_select_code = 2,
    aoe_range = 10
  },
  buff_bati = 196,
  timeDuration = 15
}

function bs_204806:ctor()
end

function bs_204806:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_204806_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_204801", 10, self.OnRoleDie)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_bati, 1)
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_204806:OnRoleDie(killer, role)
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

function bs_204806:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function bs_204806:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_204806:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_204806
