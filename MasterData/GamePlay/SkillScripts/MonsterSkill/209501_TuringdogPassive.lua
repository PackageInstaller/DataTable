local bs_209501 = class("bs_209501", LuaSkillBase)
local base = LuaSkillBase
bs_209501.config = {
  effectid_1 = 209504,
  effectid_2 = 209505,
  actionId = 1055,
  actionId_time = 64,
  action_speed = 1,
  buffId = 209504
}

function bs_209501:ctor()
end

function bs_209501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnAfterBattleStart)
end

function bs_209501:OnAfterBattleStart(summonerEntity)
  if summonerEntity == self.caster then
    local time = self.config.actionId_time
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectid_1, self, nil)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectid_2, self, nil)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, time)
  end
end

function bs_209501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209501
