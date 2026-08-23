local BaseBuyPop = class("BaseBuyPop", require("app.fairyGUI.base_new.UI_BaseBuyPop"), function()
	return fgui.GComponent:create({
		resName = "BaseBuyPop",
		pkgPath = "ui/base_new/base_new",
		pkgName = "base_new"
	})
end)
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.model.User.bagData
local var_0_6 = g.core.model.User.shopData
local var_0_8 = g.core.common.Path
local var_0_9 = g.core.event.EventManager
local var_0_10 = {
	[g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.TIRED] = {
		resourceId = g.core.common.Goods.RESOURCE.TYPE_TIRED,
		basicFigureId = g.core.const.ConstMgr.BasicFigureConst.TIRED
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BIOGRAPHIE] = {
		resourceId = g.core.common.Goods.RESOURCE.TYPE_BIOGRAPHIE,
		basicFigureId = g.core.const.ConstMgr.BasicFigureConst.BIOGRAPHIE
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GRAIN] = {
		resourceId = g.core.common.Goods.RESOURCE.TYPE_GRAIN,
		basicFigureId = g.core.const.ConstMgr.BasicFigureConst.GRAIN
	},
	[g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.ARMY_TOKEN] = {
		resourceId = g.core.common.Goods.RESOURCE.TYPE_ARMY_TOKEN,
		basicFigureId = g.core.const.ConstMgr.BasicFigureConst.ARMY_TOKEN
	}
}

function BaseBuyPop:ctor(arg_2_1, arg_2_2)
	self._info = arg_2_1
	self._params = {}
	self._hasPop = false
	self._count = 0
	self._limit = 0
	self._maxNum = 0

	self:showAtCenter()
	self:_addListeners()
	self:_init(arg_2_1, arg_2_2)
end

function BaseBuyPop:_init(arg_3_1, arg_3_2)
	self:updateItem(arg_3_1)
	self:initBase(arg_3_1, arg_3_2)
end

function BaseBuyPop:updateItem(arg_4_1)
	if arg_4_1.isShop then
		self.m_popPanel:setTitle(g.core.lang:get(107015))

		local var_4_0 = var_0_4:convert({
			type = arg_4_1.type,
			value = arg_4_1.value,
			size = arg_4_1.size
		})

		self._params.hasIcon = true

		self.m_baseItem:setURL(var_4_0.bigIcon or var_4_0.icon)
		self.m_itemBg:setURL(var_0_8:getBaseBuyPopItemBg(var_4_0.quality))
		self:checkEquipEffect(var_4_0)

		if var_4_0.bigIconScale then
			self.m_baseItem:setScale(0.5)
		end

		self.m_nameTxt:setText(var_4_0.name)
		self.m_nameBg:setURL(var_0_8:getBaseBuyPopNameBg(var_4_0.quality or 0))
		self.m_haveNumTxt:setText(var_0_5:getOwnNum(arg_4_1.type, arg_4_1.value))

		if arg_4_1.size > 1 then
			self.m_showNumController:setSelectedIndex(1)
			self.m_numTxt:setText(g.core.lang:get(107073, {
				num = arg_4_1.size
			}))
		else
			self.m_showNumController:setSelectedIndex(0)
		end
	else
		self._params.hasIcon = false

		self.m_showNumController:setSelectedIndex(0)

		if arg_4_1 and arg_4_1.icon then
			self._params.hasIcon = true

			self.m_baseItem:setURL(arg_4_1.icon)

			if arg_4_1.quality then
				self.m_itemBg:setURL(var_0_8:getBaseBuyPopItemBg(arg_4_1.quality))
			end
		end

		self.m_popPanel:setTitle(g.core.lang:get(107016))
		self.m_nameTxt:setText(arg_4_1.direction)
		self.m_haveNumTxt:setText(var_0_6:getLeftCount(arg_4_1.id))
	end
end

function BaseBuyPop:checkEquipEffect(arg_5_1)
	if arg_5_1.type == var_0_4.TYPE_EQUIP then
		self:updateEquipQualityEffect(arg_5_1.quality, arg_5_1.value)
	elseif arg_5_1.type == var_0_4.TYPE_FRAGMENT and arg_5_1.info.fragment_type == var_0_4.TYPE_EQUIP then
		self:updateEquipQualityEffect(arg_5_1.info.quality, arg_5_1.info.fragment_value)
	else
		self:updateEquipQualityEffect(0)
	end
end

function BaseBuyPop:updateEquipQualityEffect(arg_6_1, arg_6_2)
	if arg_6_1 >= var_0_1.UR and arg_6_2 > 0 then
		if not self._qualityEffectBg then
			self.m_effectBg:removeAllEffect()

			self._qualityEffectBg = self.m_effectBg:addEffectSpine({
				anim = "play",
				scale = 0.5,
				name = "eff_ui_equipment_bg"
			})
		end

		self._qualityEffectBg:setVisible(true)

		if not self._qualityEffectIcon then
			self.m_effectIcon:removeAllEffect()

			self._qualityEffectIcon = self.m_effectIcon:addEffectSpine({
				anim = "play",
				scale = 0.5,
				isLoop = true,
				name = "eff_ui_equipment_" .. arg_6_2
			})
		end

		self._qualityEffectIcon:setVisible(true)
	else
		if self._qualityEffectBg then
			self._qualityEffectBg:setVisible(false)
		end

		if self._qualityEffectIcon then
			self._qualityEffectIcon:setVisible(false)
		end
	end
end

function BaseBuyPop:updateOwnRes()
	local var_7_0
	local var_7_1

	if self._info.price == 1 then
		self._info.costIdx = self._info.costIdx or 1
		var_7_0 = self._info["price_type_" .. self._info.costIdx]
		var_7_1 = self._info["price_value_" .. self._info.costIdx]
	else
		var_7_0 = self._info.price_type_1
		var_7_1 = self._info.price_value_1
	end

	if var_7_0 and var_7_0 > 0 then
		self.m_ownResIcon:setURL((var_0_8:getIconByTypeValue(var_7_0, var_7_1, true)))
		self.m_ownResNum:setText((var_0_5:getOwnNum(var_7_0, var_7_1)))
		self.m_ownResGroup:setVisible(true)
	else
		self.m_ownResGroup:setVisible(false)
	end
end

function BaseBuyPop:initBase(arg_8_1, arg_8_2)
	if arg_8_1.price == 1 then
		self.m_typeController:setSelectedIndex(1)
		self.m_isOnSaleController:setSelectedIndex(0)
		self.m_priceCostComp2:setVisible(false)
		self:_onCostCtrChange()
	else
		self.m_typeController:setSelectedIndex(0)

		local var_8_0 = 0

		for iter_8_0 = 1, var_0_2.COST_MAX_NUM do
			if arg_8_1["price_type_" .. iter_8_0] > 0 then
				local var_8_1, var_8_2, var_8_3 = var_0_6:getBuyItemPrice(arg_8_1, 1, iter_8_0)
				local var_8_4

				if var_8_2 ~= 0 and var_8_2 ~= 100 then
					var_8_4 = var_8_3

					self.m_cornerTxt:setText(g.core.lang:get(107030, {
						num = var_8_2
					}))

					if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN then
						self.m_cornerTxt:setText(g.core.lang:get(107030, {
							num = 100 - var_8_2
						}) .. g.core.lang:get(406513))
					elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
						self.m_cornerTxt:setText(g.core.lang:get(107030, {
							num = 100 - var_8_2
						}) .. "OFF")
					end

					var_8_0 = 1
				end

				self:getChild("priceCostComp" .. iter_8_0):updateByTVS({
					type = arg_8_1["price_type_" .. iter_8_0],
					value = arg_8_1["price_value_" .. iter_8_0],
					size = var_8_1,
					oldSize = var_8_4
				})
				self:getChild("priceCostComp" .. iter_8_0):setVisible(true)
			else
				self:getChild("priceCostComp" .. iter_8_0):setVisible(false)
			end
		end

		self.m_isOnSaleController:setSelectedIndex(var_8_0)
	end

	self._limit = var_0_6:getBuyLimitLeft(arg_8_1)

	if self._limit then
		self._params.limit = true

		local var_8_5 = var_0_6:getBuyLimit(arg_8_1)
		local var_8_6 = 107061

		if arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.LIFELONG then
			var_8_6 = 107063
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.WEEK then
			var_8_6 = 107062
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.MONTH then
			var_8_6 = 107064
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.SEASON then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.MINE_SEASON then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.CHIEF_ARENA_SEASON then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.GUILD_WAR then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.GVE then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.TEAM_PVP then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.EXPLORATION then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.RED_CLIFF then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.BOUNTY then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.TEAM_BATTLE then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.NEW_SLG then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.PUBG then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.SUCCUBA_LAUNCH then
			var_8_6 = 431502
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.SPIRE then
			var_8_6 = 107074
		elseif arg_8_1.num_ban_type == var_0_2.NUM_BAN_TYPE.ANCIENTS then
			var_8_6 = 107074
		end

		self.m_limitTypeTxt:setText(g.core.lang:get(var_8_6))
		self.m_limitCountTxt:setText(self._limit .. "/" .. var_8_5)
		self.m_showLimitController:setSelectedIndex(1)
	else
		self._params.limit = false

		self.m_showLimitController:setSelectedIndex(0)
	end

	if arg_8_1.isShop then
		if var_0_10[arg_8_1.id] then
			local var_8_7 = math.floor(math.max(0, g.core.config.basic_figure_info.get(var_0_10[arg_8_1.id].basicFigureId).max_limit - var_0_5:getOwnNum(var_0_4.TYPE_RESOURCE, var_0_10[arg_8_1.id].resourceId)) / arg_8_1.size)

			self._limit = self._limit and math.min(self._limit, var_8_7) or var_8_7
		end
	end

	self._maxNum = self:_getMaxCount()

	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = self._maxNum,
		callback = handler(self, self._setCount),
		reachMaxAddTipGetFunc = handler(self, self._getReachMaxAddTip)
	})

	if arg_8_2 and arg_8_2.initNum then
		self.m_subAddNumComp:setCurNum(math.ceil(arg_8_2.initNum / ((arg_8_1.isShop or nil) and arg_8_1.size)), {
			force = false,
			ignoreTip = true
		})
	else
		self.m_subAddNumComp:setCurNum(1, {
			force = true
		})
	end

	self:updateOwnRes()
end

function BaseBuyPop:_getReachMaxAddTip(arg_9_1)
	return g.core.lang:get(106011)
end

function BaseBuyPop:_setCount(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or {}

	if self._count > 0 and not arg_10_2.force then
		if arg_10_1 < 1 then
			arg_10_1 = 1
		elseif arg_10_1 > self._maxNum then
			arg_10_1 = self._maxNum
		end

		if arg_10_1 >= self._count and arg_10_2.isAdd and not arg_10_2.ignoreTip and self._count == arg_10_1 then
			if self._limit and self._count == self._limit then
				g.core.module.ModuleManager:tip(g.core.lang:get(107013))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(107014))
			end

			return
		end
	end

	self._count = arg_10_1

	self:_totalCost()
end

function BaseBuyPop:_getMaxCount()
	local var_11_0 = -1

	if self._info.price == 1 then
		var_11_0 = self:_getMaxCountBuyPriceIndex(self._info.costIdx)
	else
		for iter_11_0 = 1, var_0_2.COST_MAX_NUM do
			local var_11_1 = self:_getMaxCountBuyPriceIndex(iter_11_0)

			if var_11_0 < 0 or var_11_1 > -1 and var_11_1 < var_11_0 then
				var_11_0 = var_11_1
			end
		end
	end

	if self._limit then
		var_11_0 = var_11_0 < self._limit and var_11_0 or self._limit
	end

	var_11_0 = var_11_0 > 0 and var_11_0 or 1

	return var_11_0
end

function BaseBuyPop:_getMaxCountBuyPriceIndex(arg_12_1)
	if self._info["price_type_" .. arg_12_1] and self._info["price_type_" .. arg_12_1] > 0 then
		local var_12_0 = var_0_6:getBuyItemPrice(self._info, 1, arg_12_1)

		if var_12_0 > 0 then
			if self._info["price_add_id_" .. arg_12_1] == 0 then
				return math.floor(var_0_5:getOwnNum(self._info["price_type_" .. arg_12_1], self._info["price_value_" .. arg_12_1]) / var_12_0)
			else
				return (var_0_6:getBuyItemNum(self._info, arg_12_1))
			end
		end
	end

	return -1
end

function BaseBuyPop:_totalCost()
	if self._info.price == 1 then
		self._info.costIdx = self._info.costIdx or 1

		self.m_resNumComp1:updateByTVS({
			type = self._info["price_type_" .. self._info.costIdx],
			value = self._info["price_value_" .. self._info.costIdx],
			size = self._info["price_size_" .. self._info.costIdx] * self._count
		})

		local var_13_0 = self.m_resNumComp1:getWidth()

		if var_13_0 % 2 == 0 then
			self.m_resNumComp1:setWidth(var_13_0 + 1)
		end

		self.m_resNumComp2:setVisible(false)
	else
		self.m_resNumComp1:setVisible(true)
		self.m_resNumComp1:setVisible(true)

		for iter_13_0 = 1, var_0_2.COST_MAX_NUM do
			if self._info["price_type_" .. iter_13_0] > 0 then
				local var_13_1, var_13_2 = g.core.model.User.shopData:getBuyItemPrice(self._info, self._count, iter_13_0)

				self:getChild("resNumComp" .. iter_13_0):updateByTVS({
					type = self._info["price_type_" .. iter_13_0],
					value = self._info["price_value_" .. iter_13_0],
					size = var_13_1
				})
				self:getChild("resNumComp" .. iter_13_0):setVisible(true)
			else
				self:getChild("resNumComp" .. iter_13_0):setVisible(false)
			end
		end
	end
end

function BaseBuyPop:_addListeners()
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtn))
	self.m_costController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCostCtrChange))
end

function BaseBuyPop:_onCostCtrChange()
	local var_15_0 = self.m_costController:getSelectedIndex() + 1

	self._info.costIdx = var_15_0

	self.m_priceCostComp1:updateByTVS({
		type = self._info["price_type_" .. var_15_0],
		value = self._info["price_value_" .. var_15_0],
		size = self._info["price_size_" .. var_15_0]
	})

	local var_15_1 = self.m_priceCostComp1:getWidth()

	if var_15_1 % 2 == 0 then
		self.m_priceCostComp1:setWidth(var_15_1 + 1)
	end

	self:_totalCost()

	self._maxNum = self:_getMaxCount()

	self.m_subAddNumComp:setMaxNum(self._maxNum)
	self:updateOwnRes()
end

function BaseBuyPop:_onConfirmBtn()
	local var_16_0 = self._info.costIdx or 0

	if var_0_2.COST_TYPE_INDEX[var_16_0] == true then
		if self._info["price_type_" .. var_16_0] > 0 then
			local var_16_1 = var_0_6:getBuyItemPrice(self._info, self._count, var_16_0)
			local var_16_2 = var_0_5:getOwnNum(self._info["price_type_" .. var_16_0], self._info["price_value_" .. var_16_0])

			if var_16_2 < var_16_1 then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = self._info["price_type_" .. var_16_0],
					value = self._info["price_value_" .. var_16_0],
					size = var_16_2,
					needSize = var_16_1,
					curSize = var_16_2,
					func = function()
						self._info.netHandler(self._info.id, self._count, self._info.shopId or 0, self._info.costIdx or 0)
					end
				})
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

				return
			end
		end
	else
		for iter_16_0 = 1, var_0_2.COST_MAX_NUM do
			if self._info["price_type_" .. iter_16_0] > 0 then
				local var_16_3 = var_0_6:getBuyItemPrice(self._info, self._count, iter_16_0)
				local var_16_4 = var_0_5:getOwnNum(self._info["price_type_" .. iter_16_0], self._info["price_value_" .. iter_16_0])

				if var_16_4 < var_16_3 then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = self._info["price_type_" .. iter_16_0],
						value = self._info["price_value_" .. iter_16_0],
						size = var_16_4,
						needSize = var_16_3,
						curSize = var_16_4
					})
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

					return
				end
			end
		end
	end

	if self._info.type == var_0_4.TYPE_EQUIP then
		if g.core.model.User.equipmentData:getBagLimit() < #g.core.model.User.equipmentData:getEquipList().allIndex + self._count then
			g.core.module.ModuleManager:tip(g.core.lang:get(1194))

			return
		end
	elseif self._info.type == var_0_4.TYPE_TREASURE then
		if g.core.model.User.treasureData:getBagLimit() < table.nums((g.core.model.User.treasureData:getTreasureData())) + self._count then
			g.core.module.ModuleManager:tip(g.core.lang:get(1196))

			return
		end
	elseif self._info.type == var_0_4.TYPE_PET_EQUIP and g.core.model.User.petEquipData:getBagLimit() < g.core.model.User.petEquipData:getTotalCount() + self._count then
		g.core.module.ModuleManager:tip(g.core.lang:get(1195))

		return
	end

	if self._info.end_times and self._info.end_times ~= 0 and os.time((var_0_6:numberToDate(self._info.end_times))) <= var_0_3:getTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(107072))

		return
	end

	self._info.netHandler(self._info.id, self._count, self._info.shopId or 0, self._info.costIdx or 0)
end

function BaseBuyPop:_onRcvShopping(arg_18_1, arg_18_2, arg_18_3)
	if self._onFinishHandler then
		self._onFinishHandler()
	end

	local var_18_0 = g.core.config.shop_score_info.get(arg_18_3.info.id)

	if self.m_useAfterBuyController:getSelectedIndex() == 1 and var_18_0.type == var_0_4.TYPE_ITEM then
		local var_18_1 = g.core.lang:get(107017)

		if self.m_useCheckBtn:isSelected() and var_18_0.type == var_0_4.TYPE_ITEM then
			local var_18_2 = g.core.config.item_info.get(var_18_0.value)
			local var_18_3 = self:_checkUseLimit(var_18_2)

			if (var_18_3 == -1 and arg_18_3.info.num or math.min(arg_18_3.info.num, var_18_3)) > 0 then
				local var_18_5 = {
					id = var_18_2.id
				}

				var_18_5.num = 1

				g.core.network.GameNetProxy:send_C2S_Item_Use(var_18_5)

				var_18_1 = 1 == arg_18_3.info.num and g.core.lang:get(107018) or g.core.lang:get(107019, {
					num = arg_18_3.info.num - 1
				})
			end
		end

		g.core.module.ModuleManager:tip(var_18_1)
	end

	if not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function BaseBuyPop:_onRcvFlushPlayNum(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_3.is_add == nil then
		arg_19_3.is_add = true
	end

	if self._onFinishHandler and arg_19_3.is_add then
		self._onFinishHandler()
	end

	if not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function BaseBuyPop:_onCrossDay()
	if not self._info then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	elseif self._info.end_times and self._info.end_times ~= 0 and os.time((var_0_6:numberToDate(self._info.end_times))) <= var_0_3:getTime() and not self._hasPop then
		self._hasPop = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function BaseBuyPop:onLoad()
	var_0_9:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self, 1)
	var_0_9:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._onRcvFlushPlayNum, self)
	var_0_9:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	var_0_9:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._totalCost), self)
end

function BaseBuyPop:create(arg_22_1, arg_22_2)
	if BaseBuyPop.check(self) then
		local var_22_0 = var_0_6:getBuyLimitLeft(self)
		local var_22_1 = self.num_get_type and self.num_get_type == 2

		if arg_22_1 == nil then
			arg_22_1 = true
		end

		if arg_22_1 == true and var_22_0 and var_22_0 == 1 or var_22_1 then
			local var_22_2 = false

			if var_22_1 then
				local var_22_3 = var_0_6:getResetCost(self.id)

				if not var_22_3 or var_22_3.size == 0 then
					var_22_2 = true
				end
			end

			local var_22_4 = {}

			var_22_4.title = var_22_1 and g.core.lang:get(107023) or g.core.lang:get(107022)

			local var_22_5 = ""

			if self.price_type_2 > 0 then
				var_22_5 = g.core.lang:get(107025, {
					num1 = var_0_6:getBuyItemPrice(self, 1, 1),
					name1 = var_0_4:convert({
						type = self.price_type_1,
						value = self.price_value_1
					}).name,
					num2 = var_0_6:getBuyItemPrice(self, 1, 2),
					name2 = var_0_4:convert({
						type = self.price_type_2,
						value = self.price_value_2
					}).name
				})
			else
				local var_22_6 = var_0_6:getBuyItemPrice(self, 1, 1)

				var_22_6 = var_22_2 and 0 or var_22_6

				local var_22_7 = var_0_4:convert({
					type = self.price_type_1,
					value = self.price_value_1
				})

				var_22_5 = var_22_1 and g.core.lang:get(107024, {
					num = var_22_6,
					name = var_22_7.name
				}) or g.core.lang:get(107024, {
					num = var_22_6,
					name = var_22_7.name
				})
			end

			var_22_4.desc = var_22_5

			function var_22_4.onConfirm()
				self.netHandler(self.id, 1, self.shopId or 0, self.costIdx or 0)
			end

			g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, var_22_4)
		else
			local var_22_8 = BaseBuyPop.new(self, arg_22_2)

			g.core.module.ModuleManager:pushPopup(var_22_8)

			return var_22_8
		end
	end
end

function BaseBuyPop:createShop(arg_24_1, arg_24_2)
	self = self.toObject()
	self.isShop = true
	self.shopId = 0

	if arg_24_2 then
		self.shopId = arg_24_2.id
	elseif self.shop_type ~= 999 and self.shop_type ~= 1000 then
		arg_24_2 = var_0_6:getShopInfoByScoreInfo(self)

		if arg_24_2 then
			self.shopId = arg_24_2.id or 0
		end
	end

	function self.netHandler(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
			info = {
				id = arg_25_0,
				num = arg_25_1
			},
			shop_id = arg_25_2,
			cost_idx = arg_25_3
		})
	end

	return (BaseBuyPop.create(self, arg_24_1))
end

function BaseBuyPop:createBuy()
	local var_26_0 = g.core.config.play_num_info.get(self)
	local var_26_1 = var_26_0.toObject()

	var_26_1.price_type_1 = var_26_1.price_type
	var_26_1.price_value_1 = var_26_1.price_value
	var_26_1.price_add_id_1 = var_26_1.price_add_id
	var_26_1.price_add_id_2 = 0
	var_26_1.price_type_2 = 0

	if var_26_0.icon then
		var_26_1.icon = var_0_8:getMiddleItemIconById(var_26_0.icon, false)
	end

	var_26_1.isShop = false

	function var_26_1.netHandler(arg_27_0, arg_27_1)
		if BaseBuyPop.check(var_26_1, arg_27_1) then
			g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
				id = arg_27_0,
				num = arg_27_1
			})
		end
	end

	local var_26_2 = BaseBuyPop.create(var_26_1, false)

	if var_26_2 then
		var_26_2:setFinishHandler(function()
			var_0_9:dispatchEvent(g.core.event.enum.EVENT_ITEM_FLUSH)

			if self ~= g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_RESET_SKILL and self ~= g.core.const.ConstMgr.ShopConst.PLAY_TYPE.SCHOOL_PVP_REFRESH_TIMES then
				g.core.module.ModuleManager:tip(g.core.lang:get(107020))
			end
		end)
	end

	return var_26_2
end

function BaseBuyPop:createPlayNum(arg_29_1, arg_29_2)
	self = self.toObject()
	self.isShop = true

	function self.netHandler(arg_30_0, arg_30_1)
		if var_0_10[self.id] and self.size * arg_30_1 + var_0_5:getOwnNum(var_0_4.TYPE_RESOURCE, var_0_10[self.id].resourceId) > g.core.config.basic_figure_info.get(var_0_10[self.id].basicFigureId).max_limit then
			g.core.module.ModuleManager:tip(g.core.lang:get(107021))

			return
		end

		g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
			cost_idx = 0,
			shop_id = 0,
			info = {
				id = arg_30_0,
				num = arg_30_1
			}
		})
	end

	local var_29_0 = BaseBuyPop.create(self, arg_29_1, arg_29_2)

	if var_29_0 then
		var_29_0:setFinishHandler(function()
			var_0_9:dispatchEvent(g.core.event.enum.EVENT_ITEM_FLUSH)

			if self.type == var_0_4.TYPE_ITEM then
				g.core.module.ModuleManager:tip((g.core.lang:get(107017)))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(107020))
			end
		end)
	end

	return var_29_0
end

function BaseBuyPop:createExtraReset()
	local var_32_0 = self.callback

	if self.count >= var_0_6:getBuyNum(self.vid) then
		return false
	end

	local var_32_1 = var_0_4:convert({
		value = 0,
		type = var_0_4.TYPE_GOLD
	})
	local var_32_2 = var_0_6:getBuyPrice(self.pid, self.count + 1)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(302058, {
			num = var_32_2
		}),
		onConfirm = function()
			if var_0_5:getOwnNum(var_0_4.TYPE_GOLD, 0) >= var_32_2 then
				if var_32_0 then
					var_32_0()
				end
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(107034, {
					name = var_32_1.name
				}))
			end
		end
	}))

	return true
end

function BaseBuyPop:checkPlayNum(arg_34_1, arg_34_2)
	local var_34_0 = g.core.config.play_num_info.get(self).toObject()

	var_34_0.price_type_1 = var_34_0.price_type
	var_34_0.price_value_1 = var_34_0.price_value
	var_34_0.price_add_id_1 = var_34_0.price_add_id
	var_34_0.price_add_id_2 = 0
	var_34_0.price_type_2 = 0
	var_34_0.isShop = false

	return BaseBuyPop.check(var_34_0, arg_34_1, arg_34_2)
end

function BaseBuyPop:check(arg_35_1, arg_35_2)
	arg_35_1 = arg_35_1 or 1

	if arg_35_2 == nil then
		arg_35_2 = true
	end

	if var_0_6:checkBuyBan(self) then
		if arg_35_2 then
			g.core.module.ModuleManager:tip((var_0_6:getShopBuyBanText(self.buy_ban_type, self.buy_ban_value, self.buy_ban_key)))
		end

		return false
	end

	local var_35_0 = var_0_6:getBuyLimitLeft(self)

	if var_35_0 and var_35_0 < arg_35_1 then
		if arg_35_2 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1197))
		end

		return false
	end

	return true
end

function BaseBuyPop:showVipPop()
	self = self or g.core.lang:get(1193)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(107028),
		desc = self,
		confirmText = g.core.lang:get(107029),
		cancelText = g.core.lang:get(101507),
		onConfirm = function()
			g.core.common.Scheduler:newScheduleOnce(function()
				g.core.module.ModuleManager:tip(g.core.lang:get(1170))
			end, 0)
		end
	}))
end

function BaseBuyPop:setFinishHandler(arg_39_1)
	self._onFinishHandler = arg_39_1
end

function BaseBuyPop:_checkUseLimit(arg_40_1)
	local var_40_0 = -1

	if arg_40_1.item_type == 3 and arg_40_1.use_type == 1 then
		local var_40_2 = {}

		for iter_40_0 = 1, g.core.config.basic_figure_info.getLength() do
			local var_40_3 = g.core.config.basic_figure_info.indexOf(iter_40_0)

			var_40_2[#var_40_2 + 1] = {
				type = var_40_3.type,
				value = var_40_3.value,
				limit = var_40_3.max_limit,
				name = var_40_3.name
			}
		end

		local var_40_4 = g.core.config.drop_info.get(arg_40_1.item_value, 1)

		for iter_40_1 = 1, 5 do
			if var_40_4["reward_type_" .. iter_40_1] ~= 0 then
				for iter_40_2 = 1, #var_40_2 do
					if var_40_4["reward_type_" .. iter_40_1] == 1 and var_40_4["reward_value_" .. iter_40_1] == var_40_2[iter_40_2].value then
						var_40_0 = math.floor((var_40_2[iter_40_2].limit - g.core.model.User.resourceData:getResourceById(var_40_2[iter_40_2].value)) / var_40_4["reward_min_" .. iter_40_1])

						break
					end
				end
			end
		end
	elseif arg_40_1.use_type ~= 2 then
		if arg_40_1.use_type == 3 then
			var_40_0 = tonumber(g.core.config.parameter_info.get(g.const.BAG_TYPE.ITEM_LIMITE).parameter)
		end
	end

	return var_40_0
end

function BaseBuyPop:onUnload()
	return
end

function BaseBuyPop:fixIconSize(arg_42_1)
	self.m_priceCostComp1:fixIconSize(arg_42_1)
	self.m_priceCostComp2:fixIconSize(arg_42_1)
	self.m_resNumComp1:fixIconSize(arg_42_1)
	self.m_resNumComp1:fixIconSize(arg_42_1)
end

return BaseBuyPop
