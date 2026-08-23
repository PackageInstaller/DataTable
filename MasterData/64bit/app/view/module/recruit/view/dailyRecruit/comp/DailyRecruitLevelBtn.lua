local DailyRecruitLevelBtn = class("DailyRecruitLevelBtn", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLevelBtn"))

function DailyRecruitLevelBtn:updateLevelBtnView(arg_1_1, arg_1_2, arg_1_3)
	self:setTitle(g.core.lang:get(100535, {
		lv = arg_1_1
	}))
	self.m_curNum:setText(arg_1_2)
	self.m_maxNum:setText(g.core.lang:get(201028, {
		num = arg_1_3.time_max - arg_1_3.time_min
	}))
	self.m_itemLoader:setURL(g.core.common.Path:getIconByTypeValue(arg_1_3.reward_type, arg_1_3.reward_value))
	self.m_numText:setText(arg_1_3.reward_size)
end

function DailyRecruitLevelBtn:setProgress(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.m_progressComp:getMax() ~= arg_2_2 then
		self.m_progressComp:setMax(arg_2_2)
	end

	self.m_progressComp:setValue(arg_2_1)
end

return DailyRecruitLevelBtn
