local var_0_0 = g.core.config.dead_tower_card_info
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.wushTowerData
local WushTowerCardBagPop = class("WushTowerCardBagPop", require("app.fairyGUI.wushTower.UI_WushTowerCardBagPop"), function()
	return fgui.GComponent:create({
		resName = "WushTowerCardBagPop",
		pkgName = "wushTower",
		pkgPath = "ui/wushTower/wushTower"
	}, ...)
end)

function WushTowerCardBagPop:ctor()
	self._selectedCppIdx = 0
	self._cardArr = var_0_2:getCards()

	var_0_2:sortCardArr(self._cardArr)
	self:showAtCenter()
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onCardListItemClicked))
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onCardListRenderer))
end

function WushTowerCardBagPop:onLoad()
	if #self._cardArr > 0 then
		self.m_cardList:setNumItems(#self._cardArr)
		self.m_emptyController:setSelectedIndex(0)
		self:_updateSelectedCardInfo(self._selectedCppIdx)
	else
		self.m_emptyController:setSelectedIndex(1)
	end
end

function WushTowerCardBagPop:_onCardListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._cardArr[self:_cppIdx2LuaIdx(arg_4_1)], self._selectedCppIdx == arg_4_1)
end

function WushTowerCardBagPop:_onCardListItemClicked(arg_5_1)
	self:_setSelectedCppIdx((arg_5_1:getDataValue()))
end

function WushTowerCardBagPop:_setSelectedCppIdx(arg_6_1)
	if self._selectedCppIdx == arg_6_1 then
		return
	end

	local var_6_0 = self:_getCardItem(self._selectedCppIdx)

	if var_6_0 then
		var_6_0:setSelected(false)
	end

	local var_6_1 = self:_getCardItem(arg_6_1)

	if var_6_1 then
		var_6_1:setSelected(true)
	end

	self._selectedCppIdx = arg_6_1

	self:_updateSelectedCardInfo(arg_6_1)
end

function WushTowerCardBagPop:_getCardItem(arg_7_1)
	local var_7_0 = self.m_cardList:itemIndexToChildIndex(arg_7_1)

	if var_7_0 >= 0 and var_7_0 < self.m_cardList:numChildren() then
		return self.m_cardList:getChildAt(var_7_0)
	end

	return nil
end

function WushTowerCardBagPop:_updateSelectedCardInfo(arg_8_1)
	local var_8_0 = self._cardArr[self:_cppIdx2LuaIdx(arg_8_1)]
	local var_8_1 = var_0_0.get(var_8_0.id)

	self.m_cardLoader:setURL((var_0_1:getWushCardIconById(var_8_1.icon)))
	self.m_cardNameTxt:setText(var_8_1.name)
	self.m_cardNumTxt:setText(var_8_0.num)
	self.m_cardDescTxt:setText(var_8_1.description)
end

function WushTowerCardBagPop:_cppIdx2LuaIdx(arg_9_1)
	return arg_9_1 + 1
end

function WushTowerCardBagPop:_luaIdx2CppIdx(arg_10_1)
	return arg_10_1 - 1
end

return WushTowerCardBagPop
