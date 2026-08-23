local ActivityWakePreviewCell = class("ActivityWakePreviewCell", require("app.fairyGUI.activity.UI_ActivityWakePreviewCell"))

function ActivityWakePreviewCell:ctor()
	self._previewList = {}

	self.m_itemList:setIniter()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRenderer))
end

function ActivityWakePreviewCell:updateView(arg_2_1, arg_2_2)
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURLNew(arg_2_1))

	self._previewList = arg_2_2

	self.m_itemList:setNumItems(#self._previewList)
	self.m_itemList:resizeToFit(#self._previewList)
end

function ActivityWakePreviewCell:_onItemListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateView(self._previewList[arg_3_1 + 1])
end

return ActivityWakePreviewCell
