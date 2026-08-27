local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_10335 = class("bs_10335", QiuSkillBase)
local base = QiuSkillBase
bs_10335.config = {}
bs_10335.config = setmetatable(bs_10335.config, {
  __index = base.config
})

function bs_10335:ctor()
end

function bs_10335:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10335_1", 300, self.OnAfterBattleStart)
end

function bs_10335:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillBOOMBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, 21)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, 5)
  end
end

function bs_10335:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10335
