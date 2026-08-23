local var_0_0 = g.core.model.User.activityPermanentRechargeData
local RechargePermanentBtn = class("RechargePermanentBtn", require("app.fairyGUI.recharge.UI_RechargePermanentBtn"))

function RechargePermanentBtn:ctor()
	return
end

function RechargePermanentBtn:updateProgress()
	local var_2_0, var_2_1 = var_0_0:getAmountOwnAndNeedSize()
	local var_2_2 = var_0_0:getNeedLightSizeById(var_0_0:getLastUnlockId())
	local var_2_3 = var_2_2 - (var_2_1 - var_2_0)

	if g.core.platform.PlatformProxy:matchRegionByRegionKeyList({
		"EN"
	}) then
		var_2_2 = var_2_2 / 100
		var_2_3 = var_2_3 / 100
	end

	local var_2_4 = math.min(var_2_3, var_2_2)

	self.m_progressComp:setValue(var_2_4)
	self.m_progressComp:setMax(var_2_2)
	self.m_progressComp:getChild("value"):setText(var_2_4 .. "/" .. var_2_2, false, true)
end

return RechargePermanentBtn
