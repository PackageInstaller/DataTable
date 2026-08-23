local ReleaseActivityRecordItem = class("ReleaseActivityRecordItem", require("app.fairyGUI.release.UI_ReleaseActivityRecordItem"))

function ReleaseActivityRecordItem:updateItem(arg_1_1)
	local var_1_0 = g.core.config.activity_release_spinner_prize_info.get(arg_1_1.prize_id)

	self.m_iconComp:updateIcon({
		type = var_1_0.type,
		value = var_1_0.value,
		size = var_1_0.size
	})
	self.m_drawTxt:setText(g.core.lang:get(433001, {
		time = arg_1_1.times
	}))
	self.m_isGetController:setSelectedIndex(var_1_0.grand_prize == 1 and 1 or 0)
end

return ReleaseActivityRecordItem
