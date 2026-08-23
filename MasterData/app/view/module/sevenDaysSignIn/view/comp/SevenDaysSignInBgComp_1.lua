local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.sevenDaysSignInData
local SevenDaysSignInBgComp_1 = class("SevenDaysSignInBgComp_1", require("app.fairyGUI.sevenDaysSignIn.UI_SevenDaysSignInBgComp_1"))

function SevenDaysSignInBgComp_1:ctor()
	self._phase = 1

	self.m_checkBtn:addClickListener(handler(self, self._onClickCheckBtn))

	if g.core.utils.Rule.matchChannelAndLv() then
		self:getChild("n4"):setVisible(false)
		self:getChild("n8"):setVisible(false)
	end
end

function SevenDaysSignInBgComp_1:updateComp(arg_2_1)
	self._phase = arg_2_1

	self.m_bigAwardNumController:setSelectedIndex(var_0_1:getTodayBigAwardSerialNum(arg_2_1) - 1)

	local var_2_0 = var_0_1:getTodayBigAwardDayInfo(arg_2_1)

	self.m_awardDescTxt:setText(g.core.lang:get(400502, {
		day = g.core.lang:get(100 + var_0_1:dayToPhaseDay(var_2_0.day))
	}))
	self.m_knightNameTxt:setText(var_0_0:convert({
		type = var_2_0.reward_type,
		value = var_2_0.reward_value,
		size = var_2_0.reward_size
	}).name)
end

function SevenDaysSignInBgComp_1:_onClickCheckBtn()
	local var_3_0 = var_0_1:getTodayBigAwardDayInfo(self._phase)

	g.core.common.GlobalFunc.pushInfoPop({
		type = var_3_0.reward_type,
		value = var_3_0.reward_value,
		size = var_3_0.reward_size
	})
end

return SevenDaysSignInBgComp_1
