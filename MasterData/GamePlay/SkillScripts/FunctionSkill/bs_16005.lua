local bs_16005 = class("bs_16005", LuaSkillBase)
local base = LuaSkillBase
bs_16005.config = {
  heal_config = {baseheal_formula = 3022}
}

function bs_16005:ctor()
end

function bs_16005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10065_1", 1, self.OnAfterBattleStart)
end

function bs_16005:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
end

function bs_16005:CallBack()
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local role
  if enemylist.Count > 0 then
    for i = 0, enemylist.Count - 1 do
      if enemylist[i].belongNum == eBattleRoleBelong.enemy then
        if role == nil then
          role = enemylist[i]
        elseif enemylist[i].hp <= role.hp then
          role = enemylist[i]
        end
      end
    end
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
    self.arglist[2]
  }, true)
  skillResult:EndResult()
end

function bs_16005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_16005
