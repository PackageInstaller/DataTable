local bs_92080 = class("bs_92080", LuaSkillBase)
local base = LuaSkillBase
bs_92080.config = {buffId = 2073, buffId2 = 2075}

function bs_92080:ctor()
end

function bs_92080:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92080", 1, self.AfterBattleStart)
end

function bs_92080:AfterBattleStart()
  local target = self:findMaxPow()
  LuaSkillCtrl:StartTimer(self, 4, BindCallback(self, self.eventFunc, target))
end

function bs_92080:eventFunc(target)
  if target == nil then
    return
  end
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, 1, nil, false)
  local roleList = LuaSkillCtrl:FindRolesAroundRole(target.targetRole)
  if roleList == nil or 1 > roleList.Count then
    return
  end
  for i = 0, roleList.Count - 1 do
    if roleList[i].belongNum == eBattleRoleBelong.player then
      LuaSkillCtrl:CallBuff(self, roleList[i], self.config.buffId2, 1, nil, true)
    end
  end
end

function bs_92080:findMaxPow()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  local target
  local i = 0
  while target == nil or target.targetRole.roleType ~= eBattleRoleType.character do
    target = targetList[i]
    i = i + 1
  end
  return target
end

function bs_92080:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92080
