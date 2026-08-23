local var_0_0 = g.core.config.treasure_info
local var_0_1 = table.insert
local EquipSellPop = require("app.view.module.bagNew.view.equip.EquipSellPop")
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_4 = g.core.model.User.treasureData
local BagNewTreasureSellPop = class("BagNewTreasureSellPop", require("app.fairyGUI.bagNew.UI_EquipSellPop"), function()
	return fgui.GComponent:create({
		resName = "EquipSellPop",
		pkgPath = "ui/bagNew/bagNew",
		pkgName = "bagNew"
	}, ...)
end)

function BagNewTreasureSellPop:ctor()
	self._treasureData = nil
	self._qualitySelected = {
		false,
		false,
		false,
		false,
		false
	}
	self._qualityDatas = {
		var_0_3.MR,
		var_0_3.UR,
		var_0_3.SSR,
		var_0_3.SR,
		var_0_3.R
	}

	for iter_2_0, iter_2_1 in ipairs((g.core.common.Storage:load("treasure_sell_filter.json", true) or {}).qualities or {}) do
		self._qualitySelected[iter_2_1] = true
	end

	self._allQualityList = {}
	self._sellItems = {}
	self._priceMap = {}

	self:showAtCenter()
	self.m_sellList:setVirtual(self)
	self.m_sellList:setItemRenderer(handler(self, self._onListSellItemRenderer))
	self.m_filterList:setVirtual(self)
	self.m_filterList:setItemRenderer(handler(self, self._onListFilterItemRenderer))
	self.m_sellBtn:addClickListener(handler(self, self._onSellClick))
end

function BagNewTreasureSellPop:onLoad(arg_3_1, arg_3_2)
	self.m_titleStateController:setSelectedIndex(2)
	self:_updateSellData()

	if self:_hasAnyQualitySelected() then
		self:_applyQualityFilter()
		self:_updateSellData()
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, self._onSell, self)
end

function BagNewTreasureSellPop:_updateSellData()
	self._treasureData = {}
	self._allQualityList = {}

	for iter_4_0, iter_4_1 in pairs((g.core.model.User.treasureData:getTreasureData())) do
		local var_4_0 = var_0_0.get(iter_4_1.base_id)

		if var_4_0 and var_4_0.is_sell == 1 and iter_4_1.level <= 1 and iter_4_1.refining_level == 0 and iter_4_1.position == 0 and not iter_4_1.lock then
			local var_4_1 = clone(iter_4_1)

			var_4_1.quality = var_4_0.quality
			var_4_1.type = var_4_0.type
			var_4_1.sortType = var_4_0.type == 3 and 1 or 0
			self._allQualityList[var_4_1.quality] = var_4_1.quality

			table.insert(self._treasureData, var_4_1)
		end
	end

	table.sort(self._treasureData, function(arg_5_0, arg_5_1)
		if arg_5_0.sortType ~= arg_5_1.sortType then
			return arg_5_0.sortType < arg_5_1.sortType
		end

		if arg_5_0.quality ~= arg_5_1.quality then
			return arg_5_0.quality < arg_5_1.quality
		end

		if arg_5_0.base_id ~= arg_5_1.base_id then
			return arg_5_0.base_id < arg_5_1.base_id
		end
	end)
	self:_updatePriceComp()
	self.m_sellList:setNumItems(#self._treasureData)
	self.m_filterList:setNumItems(#self._qualityDatas)
end

function BagNewTreasureSellPop:_onListSellItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:update(self._treasureData[arg_6_1 + 1], self._sellItems)
end

function BagNewTreasureSellPop:_onListFilterItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:update(self._qualityDatas[arg_7_1 + 1], self._allQualityList, self._qualitySelected[self._qualityDatas[arg_7_1 + 1]], true)
end

function BagNewTreasureSellPop:_onSellClick()
	if next(self._sellItems) then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._sellItems) do
			var_0_1(var_8_0, iter_8_1)
		end

		local var_8_1 = {
			num1 = "",
			name2 = "",
			num2 = "",
			name1 = "",
			num = self._chooseCount,
			name = g.core.lang:get(201526)
		}
		local var_8_2 = 1

		for iter_8_2, iter_8_3 in pairs(self._priceMap) do
			if iter_8_3.size > 0 then
				var_8_1["num" .. var_8_2] = var_8_2 > 1 and "，" .. iter_8_3.size or iter_8_3.size
				var_8_1["name" .. var_8_2] = iter_8_3.name
				var_8_2 = var_8_2 + 1
			end
		end

		local var_8_3 = false

		for iter_8_4, iter_8_5 in ipairs(var_8_0) do
			if var_0_0.get(iter_8_5.baseId).quality >= 6 then
				var_8_3 = true
			end
		end

		if not g.core.model.User.rebornData:getIsNotTips("equip_sell_tip") and var_8_3 then
			self:addPopup((require("app.view.base.component.BaseTxtPopComp").new({
				text = g.core.lang:get(201529),
				title = g.core.lang:get(201530),
				handler_ok = handler(self, function()
					g.core.module.ModuleManager:pushModule(g.view.entrance.TXT_POP, {
						text = g.core.lang:get(201531, var_8_1),
						title = g.core.lang:get(201530),
						handler_ok = handler(self, function()
							self:onClickConfirmSell(var_8_0)
						end)
					})
				end),
				tip = {
					isChecked = false,
					txt = g.core.lang:get(1000)
				},
				handler_check = handler(self, function(arg_11_0, arg_11_1)
					if self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
						g.core.model.User.rebornData:setIsNotTips("equip_frag_sell_tip", arg_11_1)
					else
						g.core.model.User.rebornData:setIsNotTips("equip_sell_tip", arg_11_1)
					end
				end)
			})))
		else
			local var_8_6 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				desc = g.core.lang:get(201531, var_8_1),
				title = g.core.lang:get(201530),
				onConfirm = handler(self, function()
					self:onClickConfirmSell(var_8_0)
				end)
			}))
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201532))
	end
end

function BagNewTreasureSellPop:onClickConfirmSell(arg_13_1)
	local var_13_0 = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1, var_13_2 = var_0_4:getTreasureFullPurifyScore(iter_13_1.value)

		if var_13_1 > 0 then
			var_13_0 = true

			break
		end
	end

	if var_13_0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(201530),
			desc = g.core.lang:get(201589),
			onConfirm = handler(self, function()
				self:onCheckSureSell(arg_13_1)
			end)
		}))
	else
		self:onCheckSureSell(arg_13_1)
	end
end

function BagNewTreasureSellPop:onCheckSureSell(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		iter_15_1.baseId = nil
	end

	g.core.network.GameNetProxy:send_C2S_Sell({
		consumes = arg_15_1
	})
end

function BagNewTreasureSellPop:_onSell(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {
		num1 = "",
		name2 = "",
		num2 = "",
		name1 = ""
	}
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in pairs(self._priceMap) do
		if iter_16_1.size > 0 then
			var_16_0["num" .. var_16_1] = var_16_1 > 1 and "," .. iter_16_1.size or iter_16_1.size
			var_16_0["name" .. var_16_1] = iter_16_1.name
			var_16_1 = var_16_1 + 1
		end
	end

	local var_16_2 = {}

	for iter_16_2, iter_16_3 in ipairs(arg_16_3.awards) do
		if iter_16_3.type == 3 and iter_16_3.value == 94 then
			table.insert(var_16_2, iter_16_3)
		end
	end

	if next(var_16_2) then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_16_2)
		end, 0.1)
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(201533, var_16_0))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function BagNewTreasureSellPop:receiveCompEvent(arg_18_1)
	if arg_18_1 == "EquipSellCellComp_selected" then
		local var_18_0 = {
			...
		}
		local var_18_1 = var_18_0[2]

		self:_addChooseCost(var_18_0[1] and var_18_1 or var_18_1 * -1, var_18_0[3], var_18_0[4])
	elseif arg_18_1 == "EquipSellFilterCellComp" then
		local var_18_2 = {
			...
		}

		self._qualitySelected = self._qualitySelected or {}
		self._qualitySelected[var_18_2[2]] = var_18_2[1]

		self:_saveQualityFilter()
		self:_applyQualityFilter()
		self:_updateSellData()
		self:_updatePriceComp()
	end
end

function BagNewTreasureSellPop:_addChooseCost(arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_2 then
		return
	end

	if arg_19_3 then
		self._sellItems = self._sellItems or {}
		self._sellItems[string.format("%d_%d", arg_19_3.type, arg_19_3.value)] = arg_19_1 > 0 and clone(arg_19_3) or nil
	end

	self._chooseCount = self._chooseCount or 0
	self._chooseCount = self._chooseCount + arg_19_1
	self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value] = self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value] or {}
	self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value].type = arg_19_2.type
	self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value].value = arg_19_2.value
	self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value].size = (self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value].size or 0) + arg_19_1 * arg_19_2.size
	self._priceMap[arg_19_2.type .. "_" .. arg_19_2.value].name = g.core.common.Goods:convert(arg_19_2).name

	self:_updatePriceComp()
end

function BagNewTreasureSellPop:_updatePriceComp()
	if not self._treasureData[1] then
		return
	end

	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self._priceMap) do
		if iter_20_1.size > 0 then
			var_20_0 = var_20_0 + 1

			self["m_sellRewardComp" .. var_20_0]:updateByTVS(iter_20_1)
		end
	end

	self.m_priceNumController:setSelectedIndex(var_20_0 - 1)

	local var_20_1 = var_0_0.get(self._treasureData[1].base_id)

	if var_20_0 == 0 then
		self.m_sellRewardComp1:updateByTVS({
			size = 0,
			type = var_20_1.price_type,
			value = var_20_1.price_value
		})
	end
end

function BagNewTreasureSellPop:_updateSelectedNum()
	self._chooseCount = 0

	self:_updatePriceComp()
end

function BagNewTreasureSellPop:_hasAnyQualitySelected()
	for iter_22_0, iter_22_1 in pairs(self._qualitySelected) do
		if iter_22_1 then
			return true
		end
	end

	return false
end

function BagNewTreasureSellPop:_applyQualityFilter()
	self._sellItems = {}
	self._chooseCount = 0
	self._priceMap = {}

	for iter_23_0, iter_23_1 in ipairs(self._treasureData) do
		if self._qualitySelected[iter_23_1.quality] then
			local var_23_0 = iter_23_1.num or 1

			self._sellItems[string.format("%d_%d", g.core.common.Goods.TYPE_TREASURE, iter_23_1.id)] = {
				type = g.core.common.Goods.TYPE_TREASURE,
				value = iter_23_1.id,
				size = var_23_0,
				baseId = iter_23_1.base_id
			}
			self._chooseCount = self._chooseCount + 1

			local var_23_1 = g.core.config.treasure_info.get(iter_23_1.base_id)

			self._priceMap[var_23_1.price_type .. "_" .. var_23_1.price_value] = self._priceMap[var_23_1.price_type .. "_" .. var_23_1.price_value] or {}

			local var_23_2 = {
				type = var_23_1.price_type,
				value = var_23_1.price_value
			}

			var_23_2.size = (self._priceMap[var_23_1.price_type .. "_" .. var_23_1.price_value].size or 0) + var_23_1.price_size * var_23_0
			var_23_2.name = g.core.common.Goods:convert({
				type = var_23_1.price_type,
				value = var_23_1.price_value,
				size = var_23_1.price_size
			}).name
			self._priceMap[var_23_1.price_type .. "_" .. var_23_1.price_value] = var_23_2
		end
	end
end

function BagNewTreasureSellPop:_saveQualityFilter()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self._qualitySelected) do
		if iter_24_1 then
			table.insert(var_24_0, iter_24_0)
		end
	end

	g.core.common.Storage:save("treasure_sell_filter.json", {
		qualities = var_24_0
	}, true)
end

return BagNewTreasureSellPop
