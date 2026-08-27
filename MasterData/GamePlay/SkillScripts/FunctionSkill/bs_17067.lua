local bs_17067 = class("bs_17067", LuaSkillBase)
local base = LuaSkillBase
bs_17067.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  buffId = 2097,
  effectId = 60607,
  effectIdAttack = 60607,
  buffTier = 1
}

function bs_17067:ctor()
end

function bs_17067:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
end

function bs_17067:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10, role)
    local count = roleslist.Count
    if roleslist.Count > self.arglist[2] then
      count = self.arglist[2]
    end
    if 0 < count then
      LuaSkillCtrl:StartTimer(nil, 2, function()
        local tempIndex = roleslist.Count - 1
        if 0 <= tempIndex then
          local role = roleslist[tempIndex]
          roleslist:RemoveAt(tempIndex)
          LuaSkillCtrl:CallEffect(role, self.config.effectIdAttack, self, self.SkillEventFunc)
          LuaSkillCtrl:CallBuff(self, role.targetRole, self.config.buffId, self.config.buffTier, nil, false)
        end
      end, self, count)
    end
  end
end

function bs_17067:SkillEventFunc(effect, eventId, target)
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, true)
  skillResult:EndResult()
end

function bs_17067:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17067
