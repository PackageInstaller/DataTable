local card_10031 = class("card_10031", LuaSkillBase)
local base = LuaSkillBase
card_10031.config = {buffId1 = 1605, buffId2 = 1606}

function card_10031:ctor()
end

function card_10031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "card_10031_1", 1, self.OnAfterBattleStart)
end

function card_10031:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
end

function card_10031:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local role
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 69, 10)
  if targetlist.Count > 0 then
    role = targetlist[0].targetRole
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    local gridid = LuaSkillCtrl:GetRoleEfcGrid(role)
    if gridid == 0 then
      LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.y, 2)
    end
  end
end

function card_10031:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10031
