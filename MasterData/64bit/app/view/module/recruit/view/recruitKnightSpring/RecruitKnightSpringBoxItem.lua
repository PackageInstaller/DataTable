local RecruitKnightSpringBoxItem = class("RecruitKnightSpringBoxItem", require("app.fairyGUI.recruitKnightSpring.UI_RecruitKnightSpringBoxItem"))

function RecruitKnightSpringBoxItem:ctor()
	self._data = nil
	self._awardEffect = nil
end

function RecruitKnightSpringBoxItem:updateItem(arg_2_1, arg_2_2, arg_2_3)
	self._data = arg_2_1

	self.m_item:updateIcon(arg_2_1.awards[1])
	self.m_numTxt:setText(g.core.lang:get(108700, {
		num = arg_2_1.awards[1].size
	}))
	self.m_proTxt:setText(self._data.target)

	if arg_2_3 and arg_2_3.state == "match" then
		self.m_showDownController:setSelectedIndex(1)
	else
		self.m_showDownController:setSelectedIndex(0)
	end

	if arg_2_2 and arg_2_1.state == "match" then
		self.m_showUpController:setSelectedIndex(1)
	else
		self.m_showUpController:setSelectedIndex(0)
	end

	self.m_getStateController:setSelectedIndex(0)

	if arg_2_1.state == "match" then
		self.m_getStateController:setSelectedIndex(1)

		self._awardEffect = self._awardEffect or self.m_eff:addEffectSpine({
			name = "eff_ui_recruitKnightSpring_icon",
			remove = false,
			isLoop = true
		})
	elseif arg_2_1.state == "got" then
		self.m_getStateController:setSelectedIndex(2)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = arg_2_1.cfg.id
		}
	})
end

return RecruitKnightSpringBoxItem
