local var_0_0 = g.core.config.equipment_info
local var_0_1 = table.insert
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local EquipSellPop = class("EquipSellPop", require("app.fairyGUI.bagNew.UI_EquipSellPop"), function()
	return fgui.GComponent:create({
		resName = "EquipSellPop",
		pkgName = "bagNew",
		pkgPath = "ui/bagNew/bagNew"
	}, ...)
end)

EquipSellPop.TYPE_EQUIP = 1
EquipSellPop.TYPE_EQUIP_FRAG = 2

function EquipSellPop:ctor()
	self._sellDatas = nil
	self._sellType = EquipSellPop.TYPE_EQUIP
	self._qualitySelected = {
		[var_0_2.NONE] = false,
		[var_0_2.R] = false,
		[var_0_2.SR] = false,
		[var_0_2.SSR] = false,
		[var_0_2.UR] = false,
		[var_0_2.MR] = false
	}

	for iter_2_0, iter_2_1 in ipairs((g.core.common.Storage:load("equip_sell_filter.json", true) or {}).qualities or {}) do
		self._qualitySelected[iter_2_1] = true
	end

	self._qualityDatas = {
		var_0_2.MR,
		var_0_2.UR,
		var_0_2.SSR,
		var_0_2.SR,
		var_0_2.R,
		var_0_2.NONE
	}
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

function EquipSellPop:onLoad(arg_3_1, arg_3_2)
	self._sellType = arg_3_2

	self:getView():setCtrlState("titleState", {
		index = (arg_3_2 == EquipSellPop.TYPE_EQUIP_FRAG or nil) and 1
	})
	self:_updateSellData()

	if self:_hasAnyQualitySelected() then
		self:_applyQualityFilter()
		self:_updateSellData()
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, self._onSell, self)
end

function EquipSellPop:_updateSellData()
	local var_4_0 = {}

	self._allQualityList = {}

	if self._sellType == EquipSellPop.TYPE_EQUIP then
		var_4_0 = g.core.model.User.equipmentData:getEquipList()
	elseif self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
		var_4_0 = g.core.model.User.fragmentsData:getSpFragmentList(g.core.common.Goods.FRAGMENT.TYPE_EQUIP, {
			type = 0,
			quality = 0
		})
	end

	self._sellDatas = {}

	if self._sellType == EquipSellPop.TYPE_EQUIP then
		for iter_4_0, iter_4_1 in ipairs(var_4_0.noWearIndex) do
			local var_4_1 = iter_4_1:getCfg()

			if var_4_1.is_sell == 1 and not iter_4_1:isDeveloped() then
				self._allQualityList[var_4_1.quality] = var_4_1.quality

				var_0_1(self._sellDatas, {
					info = var_4_1,
					sid = iter_4_1:getServerData().id
				})
			end
		end

		table.sort(self._sellDatas, function(arg_5_0, arg_5_1)
			if arg_5_0.info.potential ~= arg_5_1.info.potential then
				return arg_5_0.info.potential < arg_5_1.info.potential
			else
				return arg_5_0.info.id < arg_5_1.info.id
			end
		end)
	elseif self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
		for iter_4_2, iter_4_3 in ipairs(var_4_0) do
			local var_4_2 = g.core.config.fragment_info.get(iter_4_3.id)

			if var_4_2.is_sell == 1 then
				self._allQualityList[var_4_2.quality] = var_4_2.quality

				var_0_1(self._sellDatas, {
					info = var_4_2,
					num = iter_4_3.num
				})
			end
		end

		table.sort(self._sellDatas, function(arg_6_0, arg_6_1)
			local var_6_0 = var_0_0.get(arg_6_0.info.fragment_value)
			local var_6_1 = var_0_0.get(arg_6_1.info.fragment_value)

			if var_6_0.potential ~= var_6_1.potential then
				return var_6_0.potential < var_6_1.potential
			else
				return var_6_0.id < var_6_1.id
			end
		end)
	end

	self:_updatePriceComp()
	self.m_sellList:setNumItems(#self._sellDatas)
	self.m_filterList:setNumItems(#self._qualityDatas)
end

function EquipSellPop:_onListSellItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:update(self._sellDatas[arg_7_1 + 1], self._sellItems, self._sellType)
end

function EquipSellPop:_onListFilterItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:update(self._qualityDatas[arg_8_1 + 1], self._allQualityList, self._qualitySelected[self._qualityDatas[arg_8_1 + 1]])
end

function EquipSellPop:_onSellClick()
	if next(self._sellItems) then
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._sellItems) do
			var_0_1(var_9_0, iter_9_1)
		end

		local var_9_1 = g.core.lang:get(201526)
		local var_9_2 = {
			name1 = "",
			name2 = "",
			num2 = "",
			num1 = "",
			num = self._chooseCount,
			name = (self._sellType == EquipSellPop.TYPE_EQUIP_FRAG or nil) and g.core.lang:get(201527)
		}
		local var_9_3 = 1

		for iter_9_2, iter_9_3 in pairs(self._priceMap) do
			if iter_9_3.size > 0 then
				var_9_2["num" .. var_9_3] = var_9_3 > 1 and "，" .. iter_9_3.size or iter_9_3.size
				var_9_2["name" .. var_9_3] = iter_9_3.name
				var_9_3 = var_9_3 + 1
			end
		end

		local var_9_4 = false
		local var_9_5
		local var_9_6 = true

		if self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
			var_9_6 = g.core.model.User.rebornData:getIsNotTips("equip_frag_sell_tip")
			var_9_5 = g.core.lang:get(201528)

			for iter_9_4, iter_9_5 in ipairs(var_9_0) do
				if g.core.common.Goods:convert(iter_9_5).quality >= 6 then
					var_9_4 = true
				end
			end
		elseif self._sellType == EquipSellPop.TYPE_EQUIP then
			var_9_6 = g.core.model.User.rebornData:getIsNotTips("equip_sell_tip")
			var_9_5 = g.core.lang:get(201529)

			for iter_9_6, iter_9_7 in ipairs(var_9_0) do
				if g.core.model.User.equipmentData:getEquipBySid(iter_9_7.value):getCfg().quality >= 6 then
					var_9_4 = true
				end
			end
		end

		if not var_9_6 and var_9_4 then
			self:addPopup((require("app.view.base.component.BaseTxtPopComp").new({
				text = var_9_5,
				title = g.core.lang:get(201530),
				handler_ok = handler(self, function()
					g.core.module.ModuleManager:pushModule(g.view.entrance.TXT_POP, {
						text = g.core.lang:get(201531, var_9_2),
						title = g.core.lang:get(201530),
						handler_ok = handler(self, function()
							g.core.network.GameNetProxy:send_C2S_Sell({
								consumes = var_9_0
							})
						end)
					})
				end),
				tip = {
					isChecked = false,
					txt = g.core.lang:get(1000)
				},
				handler_check = handler(self, function(arg_12_0, arg_12_1)
					if self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
						g.core.model.User.rebornData:setIsNotTips("equip_frag_sell_tip", arg_12_1)
					else
						g.core.model.User.rebornData:setIsNotTips("equip_sell_tip", arg_12_1)
					end
				end)
			})))
		else
			local var_9_8 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				desc = g.core.lang:get(201531, var_9_2),
				title = g.core.lang:get(201530),
				onConfirm = handler(self, function()
					g.core.network.GameNetProxy:send_C2S_Sell({
						consumes = var_9_0
					})
				end)
			}))
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201532))
	end
end

function EquipSellPop:_onSell()
	g.core.module.ModuleManager:popModule()

	local var_14_0 = g.core.module.ModuleManager:getCurModule()

	if var_14_0 and var_14_0.display and var_14_0.display.getCurComp then
		local var_14_1 = var_14_0.display:getCurComp()

		if var_14_1 then
			var_14_1:updateEquipSellSucListView()
		end
	end

	local var_14_2 = {
		name2 = "",
		num2 = "",
		name1 = "",
		num1 = ""
	}
	local var_14_3 = 1

	for iter_14_0, iter_14_1 in pairs(self._priceMap) do
		if iter_14_1.size > 0 then
			var_14_2["num" .. var_14_3] = var_14_3 > 1 and "," .. iter_14_1.size or iter_14_1.size
			var_14_2["name" .. var_14_3] = iter_14_1.name
			var_14_3 = var_14_3 + 1
		end
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(201533, var_14_2))
end

function EquipSellPop:receiveCompEvent(arg_15_1)
	if arg_15_1 == "EquipSellCellComp_selected" then
		local var_15_0 = {
			...
		}
		local var_15_1 = var_15_0[2]

		self:_addChooseCost(var_15_0[1] and var_15_1 or var_15_1 * -1, var_15_0[3], var_15_0[4])
	elseif arg_15_1 == "EquipSellFilterCellComp" then
		local var_15_2 = {
			...
		}

		self._qualitySelected = self._qualitySelected or {}
		self._qualitySelected[var_15_2[2]] = var_15_2[1]

		self:_saveQualityFilter()
		self:_applyQualityFilter()
		self:_updateSellData()
		self:_updatePriceComp()
	end
end

function EquipSellPop:_addChooseCost(arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_2 then
		return
	end

	if arg_16_3 then
		self._sellItems = self._sellItems or {}
		self._sellItems[string.format("%d_%d", arg_16_3.type, arg_16_3.value)] = arg_16_1 > 0 and clone(arg_16_3) or nil
	end

	self._chooseCount = self._chooseCount or 0
	self._chooseCount = self._chooseCount + arg_16_1
	self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value] = self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value] or {}
	self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value].type = arg_16_2.type
	self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value].value = arg_16_2.value
	self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value].size = (self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value].size or 0) + arg_16_1 * arg_16_2.size
	self._priceMap[arg_16_2.type .. "_" .. arg_16_2.value].name = g.core.common.Goods:convert(arg_16_2).name

	self:_updatePriceComp()
end

function EquipSellPop:_updatePriceComp()
	if not self._sellDatas[1] then
		return
	end

	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(self._priceMap) do
		if iter_17_1.size > 0 then
			var_17_0 = var_17_0 + 1

			self["m_sellRewardComp" .. var_17_0]:updateByTVS(iter_17_1)
		end
	end

	self.m_priceNumController:setSelectedIndex(var_17_0 - 1)

	if var_17_0 == 0 then
		self.m_sellRewardComp1:updateByTVS({
			size = 0,
			type = self._sellDatas[1].info.price_type,
			value = self._sellDatas[1].info.price_value
		})
	end
end

function EquipSellPop:_updateSelectedNum()
	self._chooseCount = 0

	self:_updatePriceComp()
end

function EquipSellPop:_hasAnyQualitySelected()
	for iter_19_0, iter_19_1 in pairs(self._qualitySelected) do
		if iter_19_1 then
			return true
		end
	end

	return false
end

function EquipSellPop:_applyQualityFilter()
	self._sellItems = {}
	self._chooseCount = 0
	self._priceMap = {}

	for iter_20_0, iter_20_1 in ipairs(self._sellDatas) do
		if self._qualitySelected[iter_20_1.info.quality] then
			local var_20_0

			if self._sellType == 1 then
				var_20_0 = g.core.common.Goods.TYPE_EQUIP or g.core.common.Goods.TYPE_FRAGMENT
			end

			local var_20_1 = iter_20_1.sid or iter_20_1.info.id
			local var_20_2 = iter_20_1.num or 1

			self._sellItems[string.format("%d_%d", var_20_0, var_20_1)] = {
				type = var_20_0,
				value = var_20_1,
				size = var_20_2
			}

			if self._sellType == EquipSellPop.TYPE_EQUIP then
				self._chooseCount = self._chooseCount + 1
			elseif self._sellType == EquipSellPop.TYPE_EQUIP_FRAG then
				self._chooseCount = self._chooseCount + iter_20_1.num
			end

			self._priceMap[iter_20_1.info.price_type .. "_" .. iter_20_1.info.price_value] = self._priceMap[iter_20_1.info.price_type .. "_" .. iter_20_1.info.price_value] or {}

			local var_20_3 = {
				type = iter_20_1.info.price_type,
				value = iter_20_1.info.price_value
			}

			var_20_3.size = (self._priceMap[iter_20_1.info.price_type .. "_" .. iter_20_1.info.price_value].size or 0) + iter_20_1.info.price_size * var_20_2
			var_20_3.name = g.core.common.Goods:convert({
				type = iter_20_1.info.price_type,
				value = iter_20_1.info.price_value,
				size = iter_20_1.info.price_size
			}).name
			self._priceMap[iter_20_1.info.price_type .. "_" .. iter_20_1.info.price_value] = var_20_3
		end
	end
end

function EquipSellPop:_saveQualityFilter()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._qualitySelected) do
		if iter_21_1 then
			table.insert(var_21_0, iter_21_0)
		end
	end

	g.core.common.Storage:save("equip_sell_filter.json", {
		qualities = var_21_0
	}, true)
end

return EquipSellPop
