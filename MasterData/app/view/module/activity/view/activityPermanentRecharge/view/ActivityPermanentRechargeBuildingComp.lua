local var_0_1 = cc.c3b(255, 255, 255)
local var_0_2 = cc.c3b(127, 127, 127)
local ActivityPermanentRechargeBuildingComp = class("ActivityPermanentRechargeBuildingComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeBuildingComp"))

function ActivityPermanentRechargeBuildingComp:ctor()
	return
end

function ActivityPermanentRechargeBuildingComp:updateView(arg_2_1)
	self.m_unlockTransition:stop()
	self.m_normalTransition:play()

	self._buildInfo = arg_2_1.buildInfo

	local var_2_2, var_2_3 = g.core.common.Path:getPermanentRechargeBuilding(arg_2_1.buildInfo.resId)

	self.m_preLoader:setURL(var_2_3)
	self.m_newLoader:setURL(var_2_2)
end

function ActivityPermanentRechargeBuildingComp:playUnlockAnim()
	self.m_preLoader:setVisible(true)
	self.m_newLoader:setVisible(true)
	self.m_unlockTransition:play()
end

return ActivityPermanentRechargeBuildingComp
