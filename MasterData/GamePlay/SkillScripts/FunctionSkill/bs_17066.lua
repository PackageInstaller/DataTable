local bs_17066 = class("bs_17066", LuaSkillBase)
local base = LuaSkillBase
bs_17066.config = {
  buffId = 2098,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  effectId = 10936,
  effectIdAttack = 10936,
  buffTier = 1
}

function bs_17066:ctor()
end

function bs_17066:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_17066_1", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
end

function bs_17066:OnRoleDie(killer, role)
  if role.roleType == eBattleRoleType.realSummoner and role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
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
        end
      end, self, count)
    end
  end
end

function bs_17066:SkillEventFunc(effect, eventId, target)
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, true)
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, self.config.buffTier, 90, false)
  skillResult:EndResult()
end

function bs_17066:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17066
