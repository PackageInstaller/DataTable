local var_0_0 = g.core.model.User.activityPermanentRechargeData
local var_0_1 = {
	OPEN = 1,
	NOT_OPEN = 0
}
local ActivityPermanentRechargeStageBtn = class("ActivityPermanentRechargeStageBtn", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeStageBtn"))

function ActivityPermanentRechargeStageBtn:ctor()
	return
end

function ActivityPermanentRechargeStageBtn:updateView(arg_2_1)
	local var_2_0 = var_0_0:getStageDataByIndex(arg_2_1)

	self.m_nameTxt:setText(var_2_0.name)

	if var_0_0:isStageUnlock(var_2_0.openType, var_2_0.openValue) then
		self.m_isOpenController:setSelectedIndex(var_0_1.OPEN)
	else
		self.m_isOpenController:setSelectedIndex(var_0_1.NOT_OPEN)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			groupId = var_2_0.groupId
		}
	})
end

return ActivityPermanentRechargeStageBtn
