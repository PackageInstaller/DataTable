local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEntityTorch = class("RiskEntityTorch", (import(".RiskEntity")))

function RiskEntityTorch:ctor(arg_1_1, arg_1_2, arg_1_3)
	RiskEntityTorch.super.ctor(self, arg_1_1, arg_1_2, arg_1_3)
end

function RiskEntityTorch:isHoldCell()
	return self:isActivation()
end

function RiskEntityTorch:doCheckCanUse()
	return false
end

function RiskEntityTorch:_refreshStatusView()
	local var_4_0 = self:getCurState()

	if var_4_0 <= 0 then
		return
	end

	if var_4_0 == 1 then
		if self._visualIns and self._visualIns.playIdleAnim then
			self._visualIns:playIdleAnim()
		end
	elseif var_4_0 == 2 and self._visualIns and self._visualIns.playBurnAnim then
		self._visualIns:playBurnAnim()
	end
end

function RiskEntityTorch:_doTriggerUsed()
	if self:getCurState() == 2 then
		return
	end

	if self._visualIns and self._visualIns.playUseAnim then
		self._visualIns:playUseAnim(RiskMapConst.SPECIAL_ITEM.TORCH, handler(self, self._superTriggerUsed))
	else
		self:_superTriggerUsed()
	end
end

function RiskEntityTorch:_superTriggerUsed()
	if self:getCurState() == 1 then
		self:setCurState(2)
	else
		assert(false, "稻草人引燃后不能再触摸! id = " .. self:getBindID())
	end
end

return RiskEntityTorch
