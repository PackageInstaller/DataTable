local var_0_0 = g.core.model.User.furnitureData
local FurnitureSelectSuitComp = class("FurnitureSelectSuitComp", require("app.fairyGUI.furniture.UI_FurnitureSelectSuitComp"))

function FurnitureSelectSuitComp:ctor(arg_1_1)
	self._curSelectSuitId = 0

	self.m_selectBtn:addClickListener(handler(self, self._onSelectMainBtnClick))
	self.m_suitList:setVirtual()
	self.m_suitList:setItemRenderer(handler(self, self._onSubItemListItemRenderer))
	self:addListen(self.m_suitList)
end

function FurnitureSelectSuitComp:onLoad()
	self.m_expandSuitController:setSelectedIndex(0)

	self._suitData = var_0_0:getAllFurnitureSuit()

	self:_setTabName()
end

function FurnitureSelectSuitComp:showSuitComp(arg_3_1)
	self.m_expandSuitController:setSelectedIndex(0)

	if arg_3_1 then
		self.m_expandSuitController:setSelectedIndex(1)
	end
end

function FurnitureSelectSuitComp:_setTabName(arg_4_1)
	if arg_4_1 then
		self._curSelectSuitId = arg_4_1
	end

	if self._curSelectSuitId ~= 0 then
		local var_4_0 = var_0_0:getSuitInfoById(self._curSelectSuitId)

		if var_4_0 then
			self.m_selectBtn:setTitle(var_4_0.bookInfo.name)
		end
	else
		self.m_selectBtn:setTitle(g.core.lang:get(112552))
	end
end

function FurnitureSelectSuitComp:_onSelectMainBtnClick()
	local var_5_0 = self.m_expandSuitController:getSelectedIndex() ~= 1

	self.m_expandSuitController:setSelectedIndex(var_5_0 and 1 or 0)

	if var_5_0 then
		self.m_suitList:setNumItems(#self._suitData)

		if #self._suitData <= 9 then
			self.m_suitList:resizeToFit(#self._suitData)
		end
	end
end

function FurnitureSelectSuitComp:_onSubItemListItemRenderer(arg_6_1, arg_6_2)
	if self._suitData[arg_6_1 + 1] then
		arg_6_2:updateSuitCell(self._suitData[arg_6_1 + 1])
	end
end

function FurnitureSelectSuitComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "CHOOSE_FURNITURE_SUIT" then
		if arg_7_2.suitId then
			self:_setTabName(arg_7_2.suitId)
			self:_onSelectMainBtnClick()
			self:dispatchCompEvent("UPDATE_FURNITURE_LIST", {
				suitId = arg_7_2.suitId
			})
		end
	end
end

return FurnitureSelectSuitComp
