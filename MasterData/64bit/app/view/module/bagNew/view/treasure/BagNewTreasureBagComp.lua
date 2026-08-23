local var_0_0 = g.core.config.treasure_info
local var_0_1 = g.core.config.treasure_attribute_pool_info
local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")
local BagNewTreasureBagComp = class("BagNewTreasureBagComp", require("app.fairyGUI.bagNew.UI_BagNewTreasureBagComp"))

function BagNewTreasureBagComp:ctor()
	self._tabIndex = 0
	self._treasureData = nil
	self._fragmentData = nil
	self._curQuality = 0
	self._curType = 0
	self._filterType = nil
	self._sortType = nil
	self._knightFormation = g.core.model.User.knightsData:getFormationKnights()

	self.m_hideInWearBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onHideInWearChange))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_itemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._updateItemInfo))
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornTouchClick))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClick))
	self.m_filterBtn:addClickListener(handler(self, self._onFilterBtnClick))
	self.m_sortBtn:addClickListener(handler(self, self._onSortBtnClick))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemProvider(handler(self, self._onItemGetProvider))
	self.m_itemList:setItemRenderer(handler(self, self._onRenderItemList))
	self:fitRedPoint()
	self:addListen(self.m_toolComp)
end

function BagNewTreasureBagComp:fitPosition()
	if not self._fited then
		self._fited = true

		local var_2_0 = self.m_itemList:getFromPool()
		local var_2_1 = var_2_0:getWidth()

		self.m_itemList:returnToPool(var_2_0)

		local var_2_2 = self.m_itemList:getWidth()
		local var_2_3 = self.m_itemList:getColumnGap()
		local var_2_4 = math.floor(var_2_2 / (var_2_1 + var_2_3))

		if var_2_2 - (var_2_4 * var_2_1 + var_2_3) >= var_2_1 + var_2_3 then
			var_2_4 = var_2_4 + 1
		end

		local var_2_5 = (var_2_2 - (var_2_1 + var_2_3) * var_2_4) / 4

		self.m_itemList:setX(self.m_itemList:getX() + (var_2_2 - (var_2_1 + var_2_3) * var_2_4) / 4)
		self.m_hideInWearBtn:setX(self.m_hideInWearBtn:getX() - var_2_5 * 2)
	end
end

function BagNewTreasureBagComp:fitRedPoint()
	self.m_fitTitle:setText(self.m_fragBtn:getTitle())

	local var_3_0 = self.m_fitTitle:getSize().width

	if var_3_0 > 100 then
		var_3_0 = 100
	end

	self.m_redPointComp:setX(self.m_fitTitle:getX() + var_3_0)
end

function BagNewTreasureBagComp:onLoad()
	self:updateTreasureShow(true)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, self._onSellTreasure, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onTreasureCompose), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onOpObjectUpdate), self)
	self.m_redPointComp:setId(97)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_LUCK, handler(self, self._onRcvTreasureLockOperation), self)
	self:_updateSellBtnRedPoint()
end

function BagNewTreasureBagComp:_onSellTreasure()
	self:updateTreasureShow()
end

function BagNewTreasureBagComp:_updateSellBtnRedPoint()
	if self.m_sellBtn.m_redPointComp then
		self.m_sellBtn.m_redPointComp:setShow(g.core.model.User.treasureData:countTreasureNum() >= g.core.model.User.treasureData:getBagLimit())
	end
end

function BagNewTreasureBagComp:_onOpObjectUpdate()
	self:_updateSellBtnRedPoint()
end

function BagNewTreasureBagComp:_onTreasureCompose(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._composeNum = arg_8_4.num

	local var_8_0 = g.core.config.fragment_info.get(arg_8_4.id)

	if var_8_0.fragment_type == g.core.common.Goods.TYPE_TREASURE then
		g.core.module.ModuleManager:awardSummary({
			{
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_8_0.fragment_value,
				size = arg_8_4.num
			}
		}, false, nil, g.core.lang:get(300001))
		self:_onChangeTabCtrl()
	end
end

function BagNewTreasureBagComp:updateFragData()
	self._fragmentData = {}

	for iter_9_0 = 1, var_0_0.getLength() do
		local var_9_0 = var_0_0.indexOf(iter_9_0)

		if var_9_0.seen_bag == 1 then
			local var_9_1 = {
				id = var_9_0.id,
				type = var_9_0.type,
				quality = var_9_0.quality
			}

			var_9_1.sortType = var_9_0.type == 3 and 1 or 0

			local var_9_2 = {}
			local var_9_3 = true
			local var_9_4 = false
			local var_9_5 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_FRAGMENT, var_9_0.fragment_1)
			local var_9_6 = g.core.config.fragment_info.get(var_9_0.fragment_1).combine_num

			var_9_1.needNum = var_9_6
			var_9_1.haveNum = var_9_5
			var_9_1.fragId = var_9_0.fragment_1

			if var_9_6 <= var_9_5 then
				var_9_3 = true
				var_9_1.canComposeNum = math.floor(var_9_5 / var_9_6)
			else
				var_9_3 = false
				var_9_1.canComposeNum = 0
			end

			if var_9_5 > 0 then
				var_9_4 = true
			end

			var_9_1.frag = var_9_2
			var_9_1.comFlag = var_9_3 and 1 or 0
			var_9_1.isHave = var_9_4 and 1 or 0

			if var_9_4 then
				table.insert(self._fragmentData, var_9_1)
			end
		end
	end

	table.sort(self._fragmentData, function(arg_10_0, arg_10_1)
		if arg_10_0.sortType ~= arg_10_1.sortType then
			return arg_10_0.sortType < arg_10_1.sortType
		end

		if arg_10_0.comFlag ~= arg_10_1.comFlag then
			return arg_10_0.comFlag > arg_10_1.comFlag
		end

		if arg_10_0.quality ~= arg_10_1.quality then
			return arg_10_0.quality > arg_10_1.quality
		end

		if arg_10_0.base_id ~= arg_10_1.base_id then
			return arg_10_0.base_id < arg_10_1.base_id
		end
	end)
end

function BagNewTreasureBagComp:_onItemGetProvider()
	if self.m_tabController:getSelectedIndex() == 0 then
		return "ui://bagNew/BagNewTreasureCell"
	else
		return "ui://bagNew/BagNewTreasureFragCell"
	end
end

function BagNewTreasureBagComp:_onRenderItemList(arg_12_1, arg_12_2)
	if self.m_tabController:getSelectedIndex() == 1 then
		arg_12_2:updateIconView(self._fragmentData[arg_12_1 + 1])
	else
		arg_12_2:updateIconView(self._treasureData[arg_12_1 + 1])
	end
end

function BagNewTreasureBagComp:_onHideInWearChange()
	self._isNotWear = self.m_hideInWearBtn:isSelected()

	self:updateTreasureShow()
end

function BagNewTreasureBagComp:playEnterAnim()
	self.m_rightComp:playEnterAnim()
end

function BagNewTreasureBagComp:_onChangeTabCtrl()
	if self.m_tabController:getSelectedIndex() == 1 then
		self:updateTreasureFragShow()
	else
		self:updateTreasureShow()
	end
end

function BagNewTreasureBagComp:getTreasureRealNum()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(self._treasureData) do
		var_16_0 = not iter_16_1.itemNum and var_16_0 + 1 or var_16_0 + iter_16_1.itemNum
	end

	return var_16_0
end

function BagNewTreasureBagComp:updateTreasureShow(arg_17_1)
	self:fitPosition()

	local var_17_0 = self.m_tabController:getSelectedIndex()

	if var_17_0 == 0 then
		self:_updateTreasureData(self._isNotWear)
		self.m_itemList:setNumItems(#self._treasureData)
		self.m_bagNumComp:showNum(self:getTreasureRealNum(), g.core.config.role_info.get(g.core.model.User:getLevel()).treasure_bag_num_client)
	else
		self:updateFragData()
		self.m_itemList:setNumItems(#self._fragmentData)
	end

	if arg_17_1 then
		self.m_itemList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end

	if var_17_0 == 0 then
		if #self._treasureData ~= 0 then
			self.m_itemList:setSelectedIndex(0)
			self.m_rightComp:updateView(self._treasureData[1], false)
		end

		self:_setEmptyState(#self._treasureData == 0)
	else
		if #self._fragmentData ~= 0 then
			self.m_itemList:setSelectedIndex(0)
			self.m_rightComp:updateView(self._fragmentData[1], true)
		end

		self:_setEmptyState(#self._fragmentData == 0)
	end
end

function BagNewTreasureBagComp:_updateTreasureData(arg_18_1)
	self._treasureData = {}

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs((g.core.model.User.treasureData:getTreasureData())) do
		local var_18_1 = var_0_0.get(iter_18_1.base_id)
		local var_18_3 = iter_18_1

		var_18_3.type = var_18_1.type
		var_18_3.quality = var_18_1.quality
		var_18_3.potential = var_18_1.potential
		var_18_3.attrPoolQuality = -1

		if var_18_3.attr_pools then
			local var_18_4 = -1

			for iter_18_2, iter_18_3 in ipairs(var_18_3.attr_pools) do
				local var_18_5 = g.core.config.treasure_attribute_pool_info.get(iter_18_3.id)

				if var_18_4 < var_18_5.quality then
					var_18_4 = var_18_5.quality
				end
			end

			var_18_3.attrPoolQuality = var_18_4
		end

		var_18_3.sortType = var_18_1.type == 3 and 1 or 0

		if iter_18_1.position ~= 0 then
			local var_18_6 = 0
			local var_18_7

			if iter_18_1.position % 2 > 0 then
				var_18_6 = (iter_18_1.position + 1) / 2
			else
				var_18_6 = iter_18_1.position / 2
				var_18_7 = {}
			end

			var_18_7.id = self._knightFormation[var_18_6]

			local var_18_8 = g.core.model.User.knightsData:getKnight(var_18_7)

			if var_18_8 then
				local var_18_9 = var_18_8:getBaseInfo()

				var_18_3.KnightQua = var_18_9.quality
				var_18_3.res = g.core.common.Path:getKnightIconById(var_18_9.res_id)
			end
		end

		if var_18_1.type == 3 then
			if not var_18_0[iter_18_1.base_id] then
				var_18_0[iter_18_1.base_id] = var_18_3
				var_18_0[iter_18_1.base_id].itemNum = 0
			end

			var_18_0[iter_18_1.base_id].itemNum = var_18_0[iter_18_1.base_id].itemNum + 1
		elseif self._curQuality == 0 and self._curType == 0 then
			if arg_18_1 then
				if iter_18_1.position == 0 then
					self:checkFilter(var_18_3)
				end
			else
				self:checkFilter(var_18_3)
			end
		elseif self._curQuality == 0 and self._curType ~= 0 then
			if self._curType == var_18_3.type then
				if arg_18_1 then
					if iter_18_1.position == 0 then
						self:checkFilter(var_18_3)
					end
				else
					self:checkFilter(var_18_3)
				end
			end
		elseif self._curQuality ~= 0 and self._curType == 0 then
			if self._curQuality == var_18_3.quality then
				if arg_18_1 then
					if iter_18_1.position == 0 then
						self:checkFilter(var_18_3)
					end
				else
					self:checkFilter(var_18_3)
				end
			end
		elseif self._curQuality == var_18_3.quality and self._curType == var_18_3.type then
			if arg_18_1 then
				if iter_18_1.position == 0 then
					self:checkFilter(var_18_3)
				end
			else
				self:checkFilter(var_18_3)
			end
		end
	end

	for iter_18_4, iter_18_5 in pairs(var_18_0) do
		self:checkFilter(iter_18_5)
	end

	self:_sortTreasureData()
end

function BagNewTreasureBagComp:_sortTreasureData()
	if not self._sortType or self._sortType == BagNewPropCfg.TREASURE_SORT.DEFAULT then
		self:onNormalSort()
	elseif self._sortType == BagNewPropCfg.TREASURE_SORT.SCORE then
		self:onScoreSort()
	else
		self:onAttrValueSort()
	end
end

function BagNewTreasureBagComp:onNormalSort()
	table.sort(self._treasureData, function(arg_21_0, arg_21_1)
		if arg_21_0.position ~= 0 and arg_21_1.position == 0 or arg_21_0.position == 0 and arg_21_1.position ~= 0 then
			return arg_21_0.position ~= 0
		end

		if arg_21_0.position ~= arg_21_1.position then
			return arg_21_0.position < arg_21_1.position
		end

		if arg_21_0.sortType ~= arg_21_1.sortType then
			return arg_21_0.sortType < arg_21_1.sortType
		end

		if arg_21_0.quality ~= arg_21_1.quality then
			return arg_21_0.quality > arg_21_1.quality
		end

		if arg_21_0.level ~= arg_21_1.level then
			return arg_21_0.level > arg_21_1.level
		end

		if arg_21_0.refining_level ~= arg_21_1.refining_level then
			return arg_21_0.refining_level > arg_21_1.refining_level
		end

		if arg_21_0.base_id ~= arg_21_1.base_id then
			return arg_21_0.base_id > arg_21_1.base_id
		end

		local var_21_0 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_21_0.id or 0)
		local var_21_1 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_21_1.id or 0)

		if var_21_0 ~= var_21_1 then
			return var_21_1 < var_21_0
		end

		return false
	end)
end

function BagNewTreasureBagComp:onScoreSort()
	table.sort(self._treasureData, function(arg_23_0, arg_23_1)
		local var_23_1 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_23_0.id or 0)
		local var_23_2 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_23_1.id or 0)

		if var_23_1 ~= var_23_2 then
			return var_23_2 < var_23_1
		end

		if arg_23_0.position ~= 0 and arg_23_1.position == 0 or arg_23_0.position == 0 and arg_23_1.position ~= 0 then
			return arg_23_0.position ~= 0
		end

		if arg_23_0.position ~= arg_23_1.position then
			return arg_23_0.position < arg_23_1.position
		end

		if arg_23_0.sortType ~= arg_23_1.sortType then
			return arg_23_0.sortType < arg_23_1.sortType
		end

		if arg_23_0.quality ~= arg_23_1.quality then
			return arg_23_0.quality > arg_23_1.quality
		end

		if arg_23_0.level ~= arg_23_1.level then
			return arg_23_0.level > arg_23_1.level
		end

		if arg_23_0.refining_level ~= arg_23_1.refining_level then
			return arg_23_0.refining_level > arg_23_1.refining_level
		end

		if arg_23_0.base_id ~= arg_23_1.base_id then
			return arg_23_0.base_id > arg_23_1.base_id
		end

		return false
	end)
end

function BagNewTreasureBagComp:onAttrValueSort()
	local var_24_0 = self._sortType

	local function var_24_1(arg_25_0)
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.attr_pools or {}) do
			if var_0_1.get(iter_25_1.id).pool_type == var_24_0 then
				var_25_0 = var_25_0 + iter_25_1.init_value
			end
		end

		return var_25_0
	end

	table.sort(self._treasureData, function(arg_26_0, arg_26_1)
		local var_26_0 = var_24_1(arg_26_0)
		local var_26_1 = var_24_1(arg_26_1)

		if var_26_0 ~= var_26_1 then
			return var_26_1 < var_26_0
		end

		if arg_26_0.position ~= 0 and arg_26_1.position == 0 or arg_26_0.position == 0 and arg_26_1.position ~= 0 then
			return arg_26_0.position ~= 0
		end

		if arg_26_0.position ~= arg_26_1.position then
			return arg_26_0.position < arg_26_1.position
		end

		if arg_26_0.sortType ~= arg_26_1.sortType then
			return arg_26_0.sortType < arg_26_1.sortType
		end

		if arg_26_0.quality ~= arg_26_1.quality then
			return arg_26_0.quality > arg_26_1.quality
		end

		if arg_26_0.level ~= arg_26_1.level then
			return arg_26_0.level > arg_26_1.level
		end

		if arg_26_0.refining_level ~= arg_26_1.refining_level then
			return arg_26_0.refining_level > arg_26_1.refining_level
		end

		if arg_26_0.base_id ~= arg_26_1.base_id then
			return arg_26_0.base_id > arg_26_1.base_id
		end

		local var_26_2 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_26_0.id or 0)
		local var_26_3 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_26_1.id or 0)

		if var_26_2 ~= var_26_3 then
			return var_26_3 < var_26_2
		end

		return false
	end)
end

function BagNewTreasureBagComp:updateTreasureFragShow()
	self:fitPosition()
	self:updateFragData()
	self.m_itemList:setNumItems(#self._fragmentData)

	if #self._fragmentData ~= 0 then
		self.m_itemList:setSelectedIndex(0)
		self.m_rightComp:updateView(self._fragmentData[1], true)
	end

	self:_setEmptyState(#self._fragmentData == 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function BagNewTreasureBagComp:_updateItemInfo()
	local var_28_0 = self.m_itemList:getSelectedIndex() + 1

	if self.m_tabController:getSelectedIndex() == 1 then
		self.m_rightComp:updateView(self._fragmentData[var_28_0], true)
	else
		self.m_rightComp:updateView(self._treasureData[var_28_0], false)
	end
end

function BagNewTreasureBagComp:_setEmptyState(arg_29_1)
	self.m_isEmptyController:setSelectedIndex(arg_29_1 and 1 or 0)
end

function BagNewTreasureBagComp:_onSellBtnClick()
	if g.core.model.User.treasureData:hasTreasureCanSell() then
		self:addPopup(require("app.view.module.bagNew.view.popup.BagNewTreasureSellPop").new())
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201565))
	end
end

function BagNewTreasureBagComp:_onRebornTouchClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.TREASURE
		})
	end
end

function BagNewTreasureBagComp:_onRcvTreasureLockOperation()
	self:_updateTreasureData(self._isNotWear)
	self.m_itemList:setNumItems(#self._treasureData)
	self.m_rightComp:onRcvTreasureLock()
end

function BagNewTreasureBagComp:receiveCompEvent(arg_33_1, arg_33_2)
	if arg_33_1 == "BagTreasureFilterEvent" then
		if self._filterType == arg_33_2.id then
			return
		end

		self._filterType = arg_33_2.id

		self.m_filterBtn:setTitle(arg_33_2.name)
	elseif arg_33_1 == "BagTreasureSortEvent" then
		if self._sortType == arg_33_2.poolType then
			return
		end

		self._sortType = arg_33_2.poolType

		self.m_sortBtn:setCtrlState("inSort", {
			index = self._sortType == BagNewPropCfg.TREASURE_SORT.DEFAULT and 0 or 1
		})
	end

	self:_updateTreasureData(self._isNotWear)
	self.m_itemList:setNumItems(#self._treasureData)

	if self._treasureData[1] then
		self.m_itemList:setSelectedIndex(0)
		self.m_rightComp:updateView(self._treasureData[1], false)
	end

	self:_setEmptyState(#self._treasureData == 0)
end

function BagNewTreasureBagComp:checkFilter(arg_34_1)
	if not self._filterType or self._filterType == BagNewPropCfg.TREASURE_FILTER.DEFAULT then
		table.insert(self._treasureData, arg_34_1)
	elseif arg_34_1.base_id == self._filterType then
		table.insert(self._treasureData, arg_34_1)
	end
end

function BagNewTreasureBagComp:_onFilterBtnClick()
	self.m_toolComp:updateWithFilter(self._filterType)
end

function BagNewTreasureBagComp:_onSortBtnClick()
	self.m_toolComp:updateWithSort(self._sortType)
end

return BagNewTreasureBagComp
