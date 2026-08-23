local SummerThemeTaskCellEx = class("SummerThemeTaskCellEx", require("app.fairyGUI.summerTheme.UI_SummerThemeTaskCellEx"))

function SummerThemeTaskCellEx:ctor(arg_1_1)
	self._curState = 0
	self._curTaskId = 0
	self._curRouteId = 0
	self._activeThemeValue = 0

	self.m_receiveBtn:addClickListener(handler(self, self._onBtnClick))
	self.m_progComp:setMax(100)
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)

	self._goBtnTrans = self.m_receiveBtn:getTransition("go")
	self._getBtnTrans = self.m_receiveBtn:getTransition("get")
end

function SummerThemeTaskCellEx:refreshTaskCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getBaseInfo()

	self._curState = arg_2_1:getTaskStatus()
	self._curTaskId = var_2_0.id
	self._curRouteId = var_2_0.source_info_id
	self._activeThemeValue = arg_2_2

	self.m_drawStateController:setSelectedIndex(self._curState)

	local var_2_1 = self.m_progComp:getController("type")

	if var_2_1 then
		var_2_1:setSelectedIndex(math.max(0, self._activeThemeValue - 1 <= var_2_1:getPageCount() and self._activeThemeValue - 1 or 1))
	end

	self.m_name:setText(var_2_0.name)
	self.m_descText:setText(var_2_0.des)
	self.m_destinNumText:setText("/" .. var_2_0.reward_number_max)

	local var_2_2 = arg_2_1:getCurDoingNum()

	if var_2_2 > var_2_0.reward_number_max then
		self.m_curProgressText:setText(var_2_0.reward_number_max)
	else
		self.m_curProgressText:setText(var_2_2)
	end

	self.m_progComp:setValue((var_2_0.reward_number_max > 0 or nil) and var_2_2 * 100 / var_2_0.reward_number_max)
	self.m_iconImg:setURL(g.core.common.Goods:convert({
		type = var_2_0.reward_type,
		value = var_2_0.reward_value
	}).icon_mini)
	self._goBtnTrans:stop()

	if self._curState == 1 then
		self._goBtnTrans:play(-1, 0)
	end
end

function SummerThemeTaskCellEx:_onBtnClick()
	if self._curState == 1 and self._curRouteId > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._curRouteId)
	end
end

return SummerThemeTaskCellEx
