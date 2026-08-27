local bs_30075 = class("bs_30075", LuaSkillBase)
local base = LuaSkillBase
bs_30075.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0
  }
}

function bs_30075:ctor()
end

function bs_30075:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30075_1", 300, self.OnAfterBattleStart)
end

function bs_30075:OnAfterBattleStart()
  self.RealCastDamage = BindCallback(self, self.RealCastDamage)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.RealCastDamage, nil, -1)
end

function bs_30075:RealCastDamage()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local targetListEnemy = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count == 0 then
    return
  end
  if targetListEnemy.Count == 0 then
    return
  end
  local damage = 0
  for i = targetList.Count - 1, 0, -1 do
    if targetList[i].roleType == eBattleRoleType.character then
      damage = damage + targetList[i].magic_res
      damage = damage + targetList[i].def
    end
  end
  damage = damage * self.arglist[2] // 1000
  for i = targetListEnemy.Count - 1, 0, -1 do
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetListEnemy[i])
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {damage})
  end
end

function bs_30075:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_30075
