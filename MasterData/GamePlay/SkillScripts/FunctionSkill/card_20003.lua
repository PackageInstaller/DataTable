local card_20003 = class("card_20003", LuaSkillBase)
local base = LuaSkillBase
card_20003.config = {}

function card_20003:ctor()
end

function card_20003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_20003_1", 1, self.OnAfterBattleStart)
end

function card_20003:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.doFun)
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1)
end

function card_20003:doFun()
  local playList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if playList.Count > 0 then
    for i = 0, playList.Count - 1 do
      local targetRole = playList[i]
      local healnum = targetRole.maxHp * self.arglist[2] // 1000
      if 0 < targetRole.intensity then
        LuaSkillCtrl:CallHeal(healnum, self, targetRole, true)
      end
    end
  end
  local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local targetRole = enemyList[i]
      local healnum = targetRole.maxHp * self.arglist[2] // 1000
      if 0 < targetRole.intensity then
        LuaSkillCtrl:CallHeal(healnum, self, targetRole, true)
      end
    end
  end
end

function card_20003:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20003
