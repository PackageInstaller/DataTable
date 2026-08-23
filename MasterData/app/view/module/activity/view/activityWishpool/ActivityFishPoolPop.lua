local var_0_0 = g.core.model.User.activityWishpoolData
local ActivityFishPoolPop = class("ActivityFishPoolPop", require("app.fairyGUI.activity.UI_ActivityFishPoolPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityFishPoolPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivityFishPoolPop:ctor()
	self.m_allFishList:setVirtual()
	self.m_allFishList:setItemRenderer(handler(self, self._onFishListRenderer))
	self.m_allFishList:doFairyBatching(false)
	self:showAtCenter()
	self:initView()
end

function ActivityFishPoolPop:initView()
	self._allFishData = var_0_0:getPreviewData()

	self.m_allFishList:setNumItems(#self._allFishData)
end

function ActivityFishPoolPop:_onFishListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateFishInfoCell(self._allFishData[arg_4_1 + 1], arg_4_1)
end

return ActivityFishPoolPop
