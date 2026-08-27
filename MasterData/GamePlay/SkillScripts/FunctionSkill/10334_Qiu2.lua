local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_10334 = class("bs_10334", QiuSkillBase)
local base = QiuSkillBase
bs_10334.config = {}
bs_10334.config = setmetatable(bs_10334.config, {
  __index = base.config
})

function bs_10334:ctor()
end

function bs_10334:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10334_1", 300, self.OnAfterBattleStart)
end

function bs_10334:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillDEFBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, 15)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, 3)
  end
end

function bs_10334:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10334
