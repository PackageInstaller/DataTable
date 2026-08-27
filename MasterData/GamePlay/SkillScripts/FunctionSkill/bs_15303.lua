local bs_15303 = class("bs_15303", LuaSkillBase)
local base = LuaSkillBase
bs_15303.config = {effectId = 12083}

function bs_15303:ctor()
end

function bs_15303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
end

function bs_15303:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 15, 10)
    if targetList.Count > 0 then
      local targetRole = targetList[0].targetRole
      local value = role.maxHp * self.arglist[1] // 1000
      LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(targetRole, self.config.effectId, self, role, 1, false, false, self.SkillEventFunc, value)
    end
  end
end

function bs_15303:SkillEventFunc(value, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, 14, {value}, true, true)
    skillResult1:EndResult()
  end
end

function bs_15303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15303
