local DailyRecruitPreviewItem = class("DailyRecruitPreviewItem", require("app.fairyGUI.recruitDaily.UI_DailyRecruitPreviewItem"))

function DailyRecruitPreviewItem:updateItemByInfo(arg_1_1)
	if arg_1_1.isNull then
		self.m_showStateController:setSelectedIndex(2)
		self.m_iconComp:setTouchEnable(false)

		return
	end

	local var_1_0 = arg_1_1.info

	arg_1_1.good.hideNum = arg_1_1.good.size == 1

	self.m_iconComp:setTouchEnable(true)
	self.m_iconComp:updateIcon(arg_1_1.good)

	if arg_1_1.isLock then
		self.m_showStateController:setSelectedIndex(1)
		self.m_lockTip:setText(g.core.lang:get(410002, {
			level = var_1_0.unlock_level
		}))
	else
		self.m_showStateController:setSelectedIndex(0)
	end
end

return DailyRecruitPreviewItem
