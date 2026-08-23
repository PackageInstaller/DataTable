local AncientsBattleDetailCell = class("AncientsBattleDetailCell", require("app.fairyGUI.ancients.UI_AncientsBattleDetailCell"))

function var_0_0:ctor()
	self.m_List_turn:setVirtual(self)
	self.m_List_turn:setItemRenderer(handler(self, self._onRenderListTurnCell))

	self._compIconArray = {
		self.m_Comp_icon1,
		self.m_Comp_icon2,
		self.m_Comp_icon3
	}
end

function var_0_0:updateCell(arg_2_1)
	self._detail = arg_2_1.detail or {}

	local var_2_0 = self._detail.usersData or {}
	local var_2_1 = 0

	for iter_2_0 = 1, #self._compIconArray do
		self._compIconArray[iter_2_0]:updateView(var_2_0[iter_2_0] or {})

		if var_2_0[iter_2_0] and var_2_0[iter_2_0].userId and var_2_0[iter_2_0].userId ~= 0 then
			var_2_1 = var_2_1 + 1
		end
	end

	self.m_notUserController:setSelectedIndex(var_2_1 == 0 and 1 or 0)
	self.m_posController:setSelectedIndex(self._detail.formatType - 1)

	self._turnsData = self._detail.turnsData or {}

	self.m_List_turn:setNumItems(#self._turnsData)
	self.m_List_turn:resizeToFit(#self._turnsData)
end

function var_0_0:_onRenderListTurnCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell({
		index = arg_3_1,
		turn = self._turnsData[arg_3_1 + 1]
	})
end

return var_0_0
