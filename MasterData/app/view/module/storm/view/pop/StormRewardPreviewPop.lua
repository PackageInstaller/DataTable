local StormRewardPreviewPop = class("StormRewardPreviewPop", require("app.fairyGUI.storm.UI_StormRewardPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "StormRewardPreviewPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	}, ...)
end)

function StormRewardPreviewPop:ctor(arg_2_1)
	self:showAtCenter()

	self._awards = g.core.common.Drops:getGoodsArray(arg_2_1)

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rewardList:setNumItems(#self._awards)
end

function StormRewardPreviewPop:_onRewardItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

return StormRewardPreviewPop
