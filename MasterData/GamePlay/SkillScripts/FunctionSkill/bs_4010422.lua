local bs_4010422 = class("bs_4010422", LuaSkillBase)
local base = LuaSkillBase
bs_4010422.config = {
  buffId = 2085,
  duration = 75,
  buffId2 = 195,
  duration2 = 75
}

function bs_4010422:ctor()
end

function bs_4010422:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
  self:AddAfterHurtTrigger("bs_4010422", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
end

function bs_4010422:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleType == eBattleRoleType.realSummoner then
        local targetRole = targetlist[i]
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_4010422:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.roleType == eBattleRoleType.realSummoner and not isMiss and not isTriggerSet then
    local range = LuaSkillCtrl:CallRange(1, 1000)
    if range <= self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, self.config.duration2, true)
    end
  end
end

function bs_4010422:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010422
