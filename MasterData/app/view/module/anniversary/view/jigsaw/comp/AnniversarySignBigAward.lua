local AnniversarySignBigAward = class("AnniversarySignBigAward", require("app.fairyGUI.anniversary.UI_AnniversarySignBigAward"))

function AnniversarySignBigAward:updateBigAward(arg_1_1)
	self.m_iconComp:updateIcon((g.core.common.Goods:convert({
		type = arg_1_1.reward_type,
		value = arg_1_1.reward_value
	})))
	self.m_numTxt:setText(g.core.lang:get(109066, {
		num = arg_1_1.reward_size
	}))
	self.m_isGetController:setSelectedIndex(g.core.model.User.anniversaryData:getCurSignDay() >= arg_1_1.num and 1 or 0)
end

return AnniversarySignBigAward
