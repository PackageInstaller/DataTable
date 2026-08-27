local card_10003 = class("card_10003", LuaSkillBase)
local base = LuaSkillBase
card_10003.config = {}

function card_10003:ctor()
end

function card_10003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10003_1", 1, self.OnAfterBattleStart)
end

function card_10003:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.doFun)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1)
end

function card_10003:doFun()
  local playList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playList.Count > 0 then
    for i = playList.Count - 1, 0, -1 do
      local targetRole = playList[i]
      if 0 < targetRole.intensity then
        LuaSkillCtrl:RemoveLife(math.max(1, targetRole.maxHp * self.arglist[2] // 1000), self, targetRole, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
  local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if enemyList.Count > 0 then
    for i = enemyList.Count - 1, 0, -1 do
      local targetRole = enemyList[i]
      if 0 < targetRole.intensity then
        LuaSkillCtrl:RemoveLife(math.max(1, targetRole.maxHp * self.arglist[2] // 1000), self, targetRole, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
  local neutralList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if neutralList.Count > 0 then
    for i = neutralList.Count - 1, 0, -1 do
      local targetRole = neutralList[i]
      if 0 < targetRole.intensity then
        LuaSkillCtrl:RemoveLife(math.max(1, targetRole.maxHp * self.arglist[2] // 1000), self, targetRole, true, nil, true, true, eHurtType.RealDmg)
      end
    end
  end
end

function card_10003:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10003
