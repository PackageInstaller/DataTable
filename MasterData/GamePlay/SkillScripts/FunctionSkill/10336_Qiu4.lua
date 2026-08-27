local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_10336 = class("bs_10336", QiuSkillBase)
local base = QiuSkillBase
bs_10336.config = {}
bs_10336.config = setmetatable(bs_10336.config, {
  __index = base.config
})

function bs_10336:ctor()
end

function bs_10336:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10336_1", 300, self.OnAfterBattleStart)
end

function bs_10336:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillWUDUBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1, 28)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1, 7)
  end
end

function bs_10336:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10336
