local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEntityMonster = class("RiskEntityMonster", (import(".RiskEntity")))

function RiskEntityMonster:ctor(arg_1_1, arg_1_2, arg_1_3)
	RiskEntityMonster.super.ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self._monsterID = arg_1_2.param_1
end

function RiskEntityMonster:isHoldCell()
	return self:isActivation()
end

function RiskEntityMonster:getFightID()
	return self._monsterID
end

function RiskEntityMonster:playDeadAnim()
	if self._visualIns and self._visualIns.playUseAnim then
		self._visualIns:playUseAnim(RiskMapConst.SPECIAL_ITEM.MONSTER, handler(self, self.triggerUsed))
	end
end

return RiskEntityMonster
