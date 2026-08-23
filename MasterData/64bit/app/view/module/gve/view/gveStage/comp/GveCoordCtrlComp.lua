local GveCoordCtrlComp = class("GveCoordCtrlComp", require("app.fairyGUI.gve.UI_GveCoordCtrlComp"))

function GveCoordCtrlComp:ctor()
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onSiteKnightRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickKnightUp))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmUpKnight))
end

function GveCoordCtrlComp:updateAllKnight(arg_2_1, arg_2_2)
	self._allCanUpKnight = arg_2_1
	self._curSelId = arg_2_2

	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(self._allCanUpKnight) do
		if iter_2_1.knight:getServerId() == arg_2_2 then
			var_2_0 = iter_2_0

			break
		end
	end

	self.m_knightList:setNumItems(#arg_2_1)

	if arg_2_2 then
		self.m_knightList:setSelectedIndex(var_2_0 - 1)
	end

	if #arg_2_1 == 0 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GveCoordCtrlComp:_onSiteKnightRenderer(arg_3_1, arg_3_2)
	arg_3_2:updatePlaceKnight(self._allCanUpKnight[arg_3_1 + 1])
end

function GveCoordCtrlComp:_onClickKnightUp(arg_4_1)
	self:dispatchCompEvent("gve_select_pos_ctrl_knight", {
		pos = arg_4_1:getDataValue() + 1
	})
end

function GveCoordCtrlComp:clearSelect()
	self.m_knightList:clearSelection()
end

function GveCoordCtrlComp:_onConfirmUpKnight()
	self:dispatchCompEvent("gve_select_confirm_ctrl_knight")
end

return GveCoordCtrlComp
