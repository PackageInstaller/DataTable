local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_10333 = class("bs_10333", QiuSkillBase)
local base = QiuSkillBase
bs_10333.config = {}
bs_10333.config = setmetatable(bs_10333.config, {
  __index = base.config
})

function bs_10333:ctor()
end

function bs_10333:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10333_1", 300, self.OnAfterBattleStart)
end

function bs_10333:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillATKBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, 7)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, 1)
  end
end

function bs_10333:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10333
