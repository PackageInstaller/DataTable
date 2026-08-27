local bs_15154 = class("bs_15154", LuaSkillBase)
local base = LuaSkillBase
bs_15154.config = {buffId = 2067}

function bs_15154:ctor()
end

function bs_15154:InitSkill(isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_15154_1", 10, self.OnRoleDie, nil, nil, nil, nil, nil, eBattleRoleBelong.netural)
end

function bs_15154:OnRoleDie(killer, role)
  if role.belongNum ~= eBattleRoleBelong.netural then
    return
  end
  local role, damage = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1, 1)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:RemoveLife(damage, self, targetList[i].targetRole, true, true, false, eHurtType.RealDmg)
    LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, 1, self.config.arglist[1])
  end
end

function bs_15154:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15154
