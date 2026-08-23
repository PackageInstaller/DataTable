local var_0_0 = {
	QI_QI = 500150,
	SAI_TE = 600080
}
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.sevenDaysSignInData
local SevenDaysSignInBgComp_2 = class("SevenDaysSignInBgComp_2", require("app.fairyGUI.sevenDaysSignIn.UI_SevenDaysSignInBgComp_2"))

function SevenDaysSignInBgComp_2:ctor()
	self._phase = 1

	self.m_checkComp_1_1:addClickListener(handler(self, self._onClickCheckBtn))
	self.m_checkComp_2_1:addClickListener(handler(self, self._onClickCheckBtn))
	self.m_checkComp_2_2:addClickListener(handler(self, self._onClickCheckBtn))

	if g.core.utils.Rule.matchChannelAndLv() then
		self:getChild("n13"):setVisible(false)
		self:getChild("n14"):setVisible(false)
	end
end

function SevenDaysSignInBgComp_2:updateComp(arg_2_1)
	self._phase = arg_2_1

	local var_2_0 = var_0_2:getTodayBigAwardSerialNum(arg_2_1)

	self.m_bigAwardNumController:setSelectedIndex(var_2_0 - 1)

	local var_2_1 = var_0_2:getTodayBigAwardDayInfo(arg_2_1)

	if var_2_0 == 1 then
		local var_2_2 = var_0_1:convert({
			type = var_2_1.reward_type,
			value = var_2_1.reward_value,
			size = var_2_1.reward_size
		})

		self.m_awardDescTxt:setText(g.core.lang:get(400505, {
			day = g.core.lang:get(100 + var_0_2:dayToPhaseDay(var_2_1.day)),
			name = var_2_2.name
		}))
		self.m_checkComp_1_1:setTitle(var_2_2.name)
	else
		self.m_awardDescTxt:setText(g.core.lang:get(400506))
		self.m_checkComp_2_1:setTitle(g.core.config.knight_info.get(var_0_0.SAI_TE).name)
		self.m_checkComp_2_2:setTitle(g.core.config.knight_info.get(var_0_0.QI_QI).name)
	end
end

function SevenDaysSignInBgComp_2:_onClickCheckBtn(arg_3_1)
	local var_3_0 = arg_3_1:getSender()
	local var_3_1

	if var_3_0 == self.m_checkComp_1_1 then
		local var_3_2 = var_0_2:getTodayBigAwardDayInfo(self._phase)

		var_3_1 = {
			type = var_3_2.reward_type,
			value = var_3_2.reward_value,
			size = var_3_2.reward_size
		}
	elseif var_3_0 == self.m_checkComp_2_1 then
		var_3_1 = {
			size = 1,
			type = var_0_1.TYPE_KNIGHT,
			value = var_0_0.SAI_TE
		}
	elseif var_3_0 == self.m_checkComp_2_2 then
		var_3_1 = {
			size = 1,
			type = var_0_1.TYPE_KNIGHT,
			value = var_0_0.QI_QI
		}
	end

	if var_3_1 then
		g.core.common.GlobalFunc.pushInfoPop(var_3_1)
	end
end

return SevenDaysSignInBgComp_2
