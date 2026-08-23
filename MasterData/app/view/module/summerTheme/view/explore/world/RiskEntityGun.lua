local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEntityGun = class("RiskEntityGun", (import(".RiskEntity")))

function RiskEntityGun:ctor(arg_1_1, arg_1_2, arg_1_3)
	RiskEntityGun.super.ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self._direction = arg_1_2.param_1
end

function RiskEntityGun:isHoldCell()
	return self:isActivation()
end

function RiskEntityGun:getDirection()
	return self._direction
end

function RiskEntityGun:doCheckCanUse()
	return true
end

function RiskEntityGun:_refreshStatusView()
	if self:getCurState() <= 0 then
		return
	end

	if self._visualIns and self._visualIns.playIdleAnim then
		self._visualIns:playIdleAnim()
	end
end

function RiskEntityGun:_doTriggerUsed()
	if self._visualIns and self._visualIns.playUseAnim then
		self._visualIns:playUseAnim(RiskMapConst.SPECIAL_ITEM.GUN)
	end
end

return RiskEntityGun
