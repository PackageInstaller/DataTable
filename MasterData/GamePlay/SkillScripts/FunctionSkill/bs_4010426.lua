local bs_4010426 = class("bs_4010426", LuaSkillBase)
local base = LuaSkillBase
bs_4010426.config = {
  buffId = 2087,
  buffId2 = 195,
  duration = 75
}

function bs_4010426:ctor()
end

function bs_4010426:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
  self:AddAfterHurtTrigger("bs_4010426_1", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum, nil, eBattleRoleType.realSummoner, nil, nil, nil, false)
end

function bs_4010426:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_4010426:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and not isTriggerSet and sender.roleType == eBattleRoleType.realSummoner then
    local tier = sender:GetBuffTier(self.config.buffId)
    if tier ~= nil and 0 < tier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, self.config.duration, false)
    end
  end
end

function bs_4010426:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010426
