local bs_21239 = class("bs_21239", LuaSkillBase)
local base = LuaSkillBase
bs_21239.config = {
  buffId = 1512,
  tipId = {
    9,
    10,
    11
  }
}

function bs_21239:ctor()
end

function bs_21239:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21239_1", 1, self.OnAfterBattleStart)
  if self.caster.recordTable.tipsCount == nil then
    self.caster.recordTable.tipsCount = 1000
  end
end

function bs_21239:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1, 30)
end

function bs_21239:OnArriveAction()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[3], true)
    end
  end
end

function bs_21239:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21239
