local bs_21237 = class("bs_21237", LuaSkillBase)
local base = LuaSkillBase
bs_21237.config = {
  buffId = 1510,
  tipId = {
    3,
    4,
    5
  }
}

function bs_21237:ctor()
end

function bs_21237:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_21237_2", 3, self.OnBuffDie, nil, nil, self.config.buffId)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21237_1", 1, self.OnAfterBattleStart)
  if self.caster.recordTable.tipsCount == nil then
    self.caster.recordTable.tipsCount = 1000
  end
end

function bs_21237:OnBuffDie(buff, target, removeType)
  if buff.dataId ~= self.config.buffId then
    return
  end
end

function bs_21237:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
end

function bs_21237:OnArriveAction()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId, 1, self.arglist[2])
    end
  end
end

function bs_21237:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21237
