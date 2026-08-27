local bs_10079 = class("bs_10079", LuaSkillBase)
local base = LuaSkillBase
bs_10079.config = {
  monsterId = 1,
  monsterSkillList = {10046, 1007},
  monsterEffectId = 103
}

function bs_10079:ctor()
end

function bs_10079:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10079_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
  self.caster.recordTable.summonerFlag = true
end

function bs_10079:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and target.hp < target.maxHp * self.arglist[3] // 1000 and self.caster.recordTable.summonerFlag then
    self.caster.recordTable.summonerFlag = false
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, target.x, target.y)
    for k, skillId in pairs(self.config.monsterSkillList) do
      summoner:AddSkill(skillId, self.level)
    end
    summoner:SetAttr(eHeroAttr.maxHp, 1000)
    self.effect = LuaSkillCtrl:CallEffect(target, self.config.monsterEffectId, self)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self:PlayChipEffect()
    LuaSkillCtrl:StartTimer(self, self.arglist[2], function()
      LuaSkillCtrl:RemoveLife(9999, self, summonerEntity)
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
    end, nil)
  end
end

function bs_10079:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10079:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10079
