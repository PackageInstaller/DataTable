local var_0_0 = g.core.const.ConstMgr.KnightSoulConst
local KnightSoulCardListComp = class("KnightSoulCardListComp", require("app.fairyGUI.knightSoul.UI_KnightSoulCardListComp"))

function KnightSoulCardListComp:ctor()
	self._bookStruct = nil
	self._bookStatus = var_0_0.BOOK_STATUS.ACTIVATE_UNABLE
	self._knightList = {}
end

function KnightSoulCardListComp:updateKnightCard(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._bookStruct = arg_2_1
	self._bookStatus = arg_2_2
	self._knightList = self._bookStruct:getNeedKnightSoulList()

	self.m_cardNumController:setSelectedIndex(#self._knightList)

	for iter_2_0, iter_2_1 in ipairs(self._knightList) do
		local var_2_0 = self["m_card" .. iter_2_0]

		self["m_card" .. iter_2_0]:updateCard({
			kSoulId = iter_2_1
		})
		var_2_0:playActivateStarUpAnim(self._bookStatus, self._bookStruct)
		var_2_0:getController("isOwn"):setSelectedIndex(arg_2_1:isActivate() and 1 or 0)
	end
end

function KnightSoulCardListComp:playSwitchAnim(arg_3_1)
	if arg_3_1 > 0 then
		self[string.format("m_switch%dTransition", arg_3_1)]:play()
	end
end

function KnightSoulCardListComp:playActivateAnim(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self._knightList) do
		self["m_card" .. iter_4_0]:playActivateAnim(arg_4_1)

		arg_4_1 = nil
	end
end

return KnightSoulCardListComp
