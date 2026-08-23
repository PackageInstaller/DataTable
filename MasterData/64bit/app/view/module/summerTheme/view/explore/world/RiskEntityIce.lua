local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEntityIce = class("RiskEntityIce", (import(".RiskEntity")))

function RiskEntityIce:ctor(arg_1_1, arg_1_2, arg_1_3)
	RiskEntityIce.super.ctor(self, arg_1_1, arg_1_2, arg_1_3)
end

function RiskEntityIce:isHoldCell()
	return self:isActivation() and self:getCurState() == 1
end

function RiskEntityIce:doCheckCanUse()
	return false
end

function RiskEntityIce:_refreshStatusView()
	local var_4_0 = self:getCurState()

	if var_4_0 <= 0 then
		return
	end

	if var_4_0 == 1 then
		if self._visualIns and self._visualIns.playIdleAnim then
			self._visualIns:playIdleAnim()
		end
	elseif var_4_0 == 2 and self._visualIns and self._visualIns.playDeadAnim then
		self._visualIns:playDeadAnim()
	end
end

function RiskEntityIce:_doTriggerUsed()
	if self._visualIns and self._visualIns.playUseAnim then
		self._visualIns:playUseAnim(RiskMapConst.SPECIAL_ITEM.ICE, handler(self, self._superTriggerUsed))
	else
		self:_superTriggerUsed()
	end
end

function RiskEntityIce:_superTriggerUsed()
	if self:getCurState() == 1 then
		self:setCurState(2)
	else
		assert(false, "冰块融化后不能再触摸! id = " .. self:getBindID())
	end

	RiskEntityIce.super._doTriggerUsed(self)
end

return RiskEntityIce
