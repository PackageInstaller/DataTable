local bs_21238 = class("bs_21238", LuaSkillBase)
local base = LuaSkillBase
bs_21238.config = {
  buffId = 1511,
  tipId = {
    6,
    7,
    8
  },
  effectId = 12121
}

function bs_21238:ctor()
end

function bs_21238:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21238_1", 1, self.OnAfterBattleStart)
  if self.caster.recordTable.tipsCount == nil then
    self.caster.recordTable.tipsCount = 1000
  end
end

function bs_21238:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1, 15)
end

function bs_21238:OnArriveAction()
  local target_grid = LuaSkillCtrl:CallFindGridMostRolesArounded(eBattleRoleBelong.player)
  local target = LuaSkillCtrl:GetTargetWithGrid(target_grid.x, target_grid.y)
  local roles = LuaSkillCtrl:FindRolesAroundGrid(target_grid, eBattleRoleBelong.player)
  if roles ~= nil and roles.Count > 0 then
    for i = 0, roles.Count - 1 do
      if roles[i] ~= nil and 0 < roles[i].hp then
        LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffId, 1, self.arglist[3], true)
      end
    end
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
end

function bs_21238:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21238
