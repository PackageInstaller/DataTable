local var_0_0 = g.core.model.User.activityCelebrationLoginData
local ActivityWakePreviewPop = class("ActivityWakePreviewPop", require("app.fairyGUI.activity.UI_ActivityWakePreviewPop"), function()
	return fgui.GComponent:create({
		pkgName = "activity",
		pkgPath = "ui/activity/activity",
		resName = "ActivityWakePreviewPop"
	}, ...)
end)

function ActivityWakePreviewPop:ctor(arg_2_1)
	self._knightPreviewData = var_0_0:getKnightPreviewData(arg_2_1.activityId)

	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs(self._knightPreviewData) do
		var_2_0 = var_2_0 + 1
	end

	self._maxQuality = g.core.const.ConstMgr.QUALITY_TYPE.MAX_QUALITY + 1

	self:showAtCenter()
	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onShowListRenderer))
	self.m_showList:setNumItems(var_2_0)
end

function ActivityWakePreviewPop:_onShowListRenderer(arg_3_1, arg_3_2)
	self._maxQuality = self._maxQuality - 1

	while true do
		if self._knightPreviewData[self._maxQuality] then
			arg_3_2:updateView(self._maxQuality, self._knightPreviewData[self._maxQuality])

			break
		else
			self._maxQuality = self._maxQuality - 1
		end
	end
end

return ActivityWakePreviewPop
