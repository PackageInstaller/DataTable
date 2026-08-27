local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_15316 = class("bs_15316", QiuSkillBase)
local base = QiuSkillBase
bs_15316.config = {}
bs_15316.config = setmetatable(bs_15316.config, {
  __index = base.config
})

function bs_15316:ctor()
end

function bs_15316:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15316_1", 1, self.OnAfterBattleStart)
end

function bs_15316:OnAfterBattleStart()
  self.RealCastSkillCAIBall = BindCallback(self, self.RealCastSkillCAIBall)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.RealCastSkillCAIBall, nil, -1)
end

function bs_15316:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15316
