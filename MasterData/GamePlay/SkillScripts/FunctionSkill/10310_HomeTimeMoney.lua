local bs_10310 = class("bs_10310", LuaSkillBase)
local base = LuaSkillBase
bs_10310.config = {}

function bs_10310:ctor()
end

function bs_10310:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10310_1", 1, self.OnAfterBattleStart)
  self.timer = nil
end

function bs_10310:OnAfterBattleStart()
  if self.timer ~= nil then
    self.timer:stop()
    self.timer = nil
  else
    self.timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
      LuaSkillCtrl:AddPlayerTowerMp(self.arglist[2])
    end, nil, -1, 0)
  end
end

function bs_10310:OnCasterDie()
  if self.timer ~= nil then
    self.timer:stop()
    self.timer = nil
  end
  base.OnCasterDie(self)
end

return bs_10310
