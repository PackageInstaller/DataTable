local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.furnitureData
local FurnitureCharmBubbleComp = class("FurnitureCharmBubbleComp", require("app.fairyGUI.furniture.UI_FurnitureCharmBubbleComp"))

function FurnitureCharmBubbleComp:ctor()
	self._showList = {}

	self.m_showList:setVirtual()
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowList))
end

function FurnitureCharmBubbleComp:playTransition()
	local var_2_0 = var_0_1:getFriendRecordList()

	self._showList = {}

	local var_2_1 = {}

	for iter_2_0 = #var_2_0, 1, -1 do
		local var_2_2 = var_0_0:getZeroClockSeconds(var_2_0[iter_2_0].op_time)

		if not var_2_1[var_2_2] then
			table.insert(self._showList, {
				clientTime = var_2_2
			})

			var_2_1[var_2_2] = true
		end

		table.insert(self._showList, var_2_0[iter_2_0])
	end

	if #self._showList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_showList:setNumItems(#self._showList)
		self.m_showList:getScrollPane():scrollTop()
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function FurnitureCharmBubbleComp:_onRenderShowList(arg_3_1, arg_3_2)
	arg_3_2:updateBubbleCell(self._showList[arg_3_1 + 1])
end

return FurnitureCharmBubbleComp
