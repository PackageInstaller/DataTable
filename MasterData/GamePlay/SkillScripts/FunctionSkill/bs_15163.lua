local bs_15163 = class("bs_15163", LuaSkillBase)
local base = LuaSkillBase
bs_15163.config = {
  hurtConfig = 14,
  effectId_1 = 1,
  effect_hit = 12100,
  effect_trail = 12099
}

function bs_15163:ctor()
end

function bs_15163:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddMoneyInBattle, self.EventFunction)
end

function bs_15163:EventFunction()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local maxRole, baseDamage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  local damage = baseDamage * self.arglist[1] // 1000
  if 1 > targetList.Count then
    return
  end
  for i = 0, targetList.Count - 1 do
    local role = targetList[i]
    if role ~= nil then
      local cb = BindCallback(self, self.hitCB, role, damage)
      LuaSkillCtrl:StartTimer(nil, 30, cb, self)
      LuaSkillCtrl:CallEffect(role, self.config.effect_trail, self)
    end
  end
end

function bs_15163:hitCB(role, damage)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damage}, true)
  skillResult:EndResult()
end

function bs_15163:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15163
