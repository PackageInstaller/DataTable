local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_10337 = class("bs_10337", QiuSkillBase)
local base = QiuSkillBase
bs_10337.config = {}
bs_10337.config = setmetatable(bs_10337.config, {
  __index = base.config
})

function bs_10337:ctor()
end

function bs_10337:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10337_1", 300, self.OnAfterBattleStart)
end

function bs_10337:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillSHANBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, 35)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, 9)
  end
end

function bs_10337:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10337
