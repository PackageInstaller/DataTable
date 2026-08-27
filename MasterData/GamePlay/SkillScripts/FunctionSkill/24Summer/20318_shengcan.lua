local bs_20318 = class("bs_20318", LuaSkillBase)
local base = LuaSkillBase
bs_20318.config = {}

function bs_20318:ctor()
end

function bs_20318:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_20318", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_20318:OnAfterPlaySkill(skill, role)
  local target_List = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, target_List.Count - 1 do
    if target_List[i].targetRole.roleType == eBattleRoleType.character then
      local grid = LuaSkillCtrl:GetGridWithRole(target_List[i].targetRole)
      LuaSkillCtrl:CallEffectWithArg(target_List[i], 12215, self, nil, nil, self.SkillEventFunc, grid)
    end
  end
end

function bs_20318:SkillEventFunc(grid, effect, eventId, target, x, y)
  if eventId == eBattleEffectEvent.Trigger then
    local role = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
    if role ~= nil and role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.character then
      LuaSkillCtrl:RemoveLife(role.maxHp // 2, self, role, true, nil, true, true, eHurtType.RealDmg, false)
    end
  end
end

function bs_20318:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20318
