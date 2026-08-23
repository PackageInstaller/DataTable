local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityRecordCell = class("ReleaseActivityRecordCell", require("app.fairyGUI.release.UI_ReleaseActivityRecordCell"))

function ReleaseActivityRecordCell:ctor()
	self._itemData = {}

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRendererAsync1(handler(self, self._onAwardItemRender), 0.1, false)
end

function ReleaseActivityRecordCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateItem(self._itemData[arg_2_1 + 1])
end

function ReleaseActivityRecordCell:updateRecordCell(arg_3_1)
	self.m_title:setText(g.core.config.activity_release_spinner_info.get(arg_3_1[1].spinner_id).name .. arg_3_1[1].spinner_number)

	self._itemData = var_0_0:getReleaseRecordByNumber(arg_3_1[1].spinner_number)

	table.sort(self._itemData, function(arg_4_0, arg_4_1)
		return arg_4_0.times > arg_4_1.times
	end)
	self.m_itemList:setNumItems(#arg_3_1)
end

return ReleaseActivityRecordCell
