local var_0_0 = g.core.model.User.wushTowerData
local WushTowerBattleComp = class("WushTowerBattleComp", require("app.fairyGUI.wushTower.UI_WushTowerBattleComp"))

function WushTowerBattleComp:ctor()
	self._cardsData = {}

	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRender))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCardItem))
	self.m_card1:addClickListener(handler(self, self._onClickCard1))
	self.m_card2:addClickListener(handler(self, self._onClickCard2))
end

function WushTowerBattleComp:updateBattleComp(arg_2_1)
	self._parcelInfo = arg_2_1
	self._cardsData = clone((var_0_0:getCards()))

	var_0_0:resetUsingCards()
	self:_updateCardList()
end

function WushTowerBattleComp:_updateCardList()
	if #self._cardsData > 0 then
		self._cardsData = var_0_0:sortCardByParcelInfo(self._parcelInfo, self._cardsData)

		self.m_isEmptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(#self._cardsData)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self:_updateSelectCard()
end

function WushTowerBattleComp:_updateSelectCard()
	local var_4_0 = var_0_0:getUsingCards()

	for iter_4_0 = 1, 2 do
		if var_4_0[iter_4_0] then
			self["m_card" .. var_4_0[iter_4_0].pos]:updateChooseCard(var_4_0[iter_4_0].useCard, self._parcelInfo)
		end
	end
end

function WushTowerBattleComp:_onCardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateTowerCardCell(self._cardsData[arg_5_1 + 1], self._parcelInfo)
end

function WushTowerBattleComp:_onClickCardItem(arg_6_1)
	self:_updateSelectCardComp(arg_6_1:getDataValue() + 1)
end

function WushTowerBattleComp:_updateSelectCardComp(arg_7_1)
	if var_0_0:setUsingCards(self._cardsData[arg_7_1]) then
		self:deletMyCardById(self._cardsData[arg_7_1].id)
	end

	self:_updateCardList()
end

function WushTowerBattleComp:deletMyCardById(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self._cardsData) do
		if iter_8_1.id == arg_8_1 then
			if iter_8_1.num > 1 then
				iter_8_1.num = iter_8_1.num - 1
			else
				table.remove(self._cardsData, iter_8_0)
			end
		end
	end
end

function WushTowerBattleComp:addMyCardById(arg_9_1)
	local var_9_0 = false

	for iter_9_0, iter_9_1 in pairs(self._cardsData) do
		if iter_9_1.id == arg_9_1 then
			iter_9_1.num = iter_9_1.num + 1
			var_9_0 = true
		end
	end

	if not var_9_0 then
		table.insert(self._cardsData, {
			num = 1,
			id = arg_9_1
		})
	end
end

function WushTowerBattleComp:_onClickCard1()
	if self.m_card1:isSelectCard() then
		local var_10_0 = self.m_card1:getCardId()

		var_0_0:deletUsingCards(var_10_0)
		self.m_card1:setUnSelectCard()
		self:addMyCardById(var_10_0)
		self:_updateCardList()
	end
end

function WushTowerBattleComp:_onClickCard2()
	if self.m_card2:isSelectCard() then
		local var_11_0 = self.m_card2:getCardId()

		var_0_0:deletUsingCards(var_11_0)
		self.m_card2:setUnSelectCard()
		self:addMyCardById(var_11_0)
		self:_updateCardList()
	end
end

function WushTowerBattleComp:getFirstCardCell()
	if self.m_cardList:numChildren() >= 1 then
		return self.m_cardList:getChildAt(0)
	end

	return nil
end

return WushTowerBattleComp
