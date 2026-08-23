local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.model.User.commanderWorldData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.common.Path
local var_0_6 = g.core.event.EventManager
local CommanderWorldBuyPop = class("CommanderWorldBuyPop", require("app.fairyGUI.commanderWorld.UI_CommanderWorldBuyPop"), function()
	return fgui.GComponent:create({
		resName = "CommanderWorldBuyPop",
		pkgPath = "ui/commanderWorld/commanderWorld",
		pkgName = "commanderWorld"
	})
end)

function CommanderWorldBuyPop:ctor(arg_2_1, arg_2_2)
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

function CommanderWorldBuyPop:_init(arg_3_1, arg_3_2)
	self:updateItem(arg_3_1)
	self:initBase(arg_3_1, arg_3_2)
end

function CommanderWorldBuyPop:updateItem(arg_4_1)
	self.m_popPanel:setTitle(g.core.lang:get(107015))

	local var_4_0 = var_0_3:convert({
		type = arg_4_1.type,
		value = arg_4_1.value,
		size = arg_4_1.size
	})

	self._params.hasIcon = true

	self.m_baseItem:setURL(var_4_0.bigIcon or var_4_0.icon)
	self.m_itemBg:setURL(var_0_5:getBaseBuyPopItemBg(var_4_0.quality))
	self:checkEquipEffect(var_4_0)

	if var_4_0.bigIconScale then
		self.m_baseItem:setScale(0.5)
	end

	self.m_nameTxt:setText(var_4_0.name)
	self.m_nameBg:setURL(var_0_5:getBaseBuyPopNameBg(var_4_0.quality or 0))
	self.m_haveNumTxt:setText(var_0_4:getOwnNum(arg_4_1.type, arg_4_1.value))

	if arg_4_1.size > 1 then
		self.m_showNumController:setSelectedIndex(1)
		self.m_numTxt:setText(g.core.lang:get(107073, {
			num = arg_4_1.size
		}))
	else
		self.m_showNumController:setSelectedIndex(0)
	end
end

function CommanderWorldBuyPop:checkEquipEffect(arg_5_1)
	if arg_5_1.type == var_0_3.TYPE_EQUIP then
		self:updateEquipQualityEffect(arg_5_1.quality, arg_5_1.value)
	elseif arg_5_1.type == var_0_3.TYPE_FRAGMENT and arg_5_1.info.fragment_type == var_0_3.TYPE_EQUIP then
		self:updateEquipQualityEffect(arg_5_1.info.quality, arg_5_1.info.fragment_value)
	else
		self:updateEquipQualityEffect(0)
	end
end

function CommanderWorldBuyPop:updateEquipQualityEffect(arg_6_1, arg_6_2)
	if arg_6_1 >= var_0_0.UR and arg_6_2 > 0 then
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

function CommanderWorldBuyPop:initBase(arg_7_1, arg_7_2)
	self.m_typeController:setSelectedIndex(0)

	local var_7_0 = 0

	for iter_7_0 = 1, 2 do
		if arg_7_1["price_type_" .. iter_7_0] > 0 then
			local var_7_1, var_7_2 = var_0_2:getBuyItemPrice(arg_7_1, 1, iter_7_0)

			if var_7_2 ~= 0 and var_7_2 ~= 100 then
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = var_7_2
				}))

				var_7_0 = 1
			end

			self:getChild("priceCostComp" .. iter_7_0):updateByTVS({
				type = arg_7_1["price_type_" .. iter_7_0],
				value = arg_7_1["price_value_" .. iter_7_0],
				size = var_7_1
			})
			self:getChild("priceCostComp" .. iter_7_0):setVisible(true)
		else
			self:getChild("priceCostComp" .. iter_7_0):setVisible(false)
		end
	end

	self.m_isOnSaleController:setSelectedIndex(var_7_0)

	self._limit = var_0_2:getBuyLimitLeft(arg_7_1)

	if self._limit then
		self._params.limit = true

		self.m_limitTypeTxt:setText(g.core.lang:get(410314))
		self.m_limitCountTxt:setText(self._limit .. "/" .. self._info.buy_num)
		self.m_showLimitController:setSelectedIndex(1)
	else
		self._params.limit = false

		self.m_showLimitController:setSelectedIndex(0)
	end

	self._maxNum = self:_getMaxCount()

	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = self._maxNum,
		callback = handler(self, self._setCount),
		reachMaxAddTipGetFunc = handler(self, self._getReachMaxAddTip)
	})

	if arg_7_2 and arg_7_2.initNum then
		self.m_subAddNumComp:setCurNum(math.ceil(arg_7_2.initNum / ((arg_7_1.isShop or nil) and arg_7_1.size)), {
			force = false,
			ignoreTip = true
		})
	else
		self.m_subAddNumComp:setCurNum(1, {
			force = true
		})
	end
end

function CommanderWorldBuyPop:_getReachMaxAddTip(arg_8_1)
	return g.core.lang:get(106011)
end

function CommanderWorldBuyPop:_setCount(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or {}

	if self._count > 0 and not arg_9_2.force then
		if arg_9_1 < 1 then
			arg_9_1 = 1
		elseif arg_9_1 > self._maxNum then
			arg_9_1 = self._maxNum
		end

		if arg_9_1 >= self._count and arg_9_2.isAdd and not arg_9_2.ignoreTip and self._count == arg_9_1 then
			if self._limit and self._count == self._limit then
				g.core.module.ModuleManager:tip(g.core.lang:get(107013))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(107014))
			end

			return
		end
	end

	self._count = arg_9_1

	self:_totalCost()
end

function CommanderWorldBuyPop:_getMaxCount()
	local var_10_0 = var_0_2:getBuyLimitLeft(self._info)
	local var_10_1 = 0

	if (self._info.price_type_2 > 0 and 2 or 1) == 1 then
		var_10_1 = math.floor(g.core.model.User.bagData:getOwnNum(self._info.price_type_1, self._info.price_value_1) / self._info.price_size_1)
	else
		local var_10_2 = {}

		for iter_10_0 = 1, 2 do
			var_10_2[iter_10_0] = math.floor(g.core.model.User.bagData:getOwnNum(self._info["price_type_" .. iter_10_0], self._info["price_value_" .. iter_10_0]) / self._info["price_size_" .. iter_10_0])
		end

		var_10_1 = math.min(var_10_2[1], var_10_2[2])
	end

	return not var_10_0 and math.min(var_10_1, 999) or math.min(999, math.min(var_10_0, var_10_1))
end

function CommanderWorldBuyPop:_totalCost()
	self.m_resNumComp1:setVisible(true)
	self.m_resNumComp1:setVisible(true)

	for iter_11_0 = 1, var_0_1.COST_MAX_NUM do
		if self._info["price_type_" .. iter_11_0] > 0 then
			local var_11_0, var_11_1 = var_0_2:getBuyItemPrice(self._info, self._count, iter_11_0)

			self:getChild("resNumComp" .. iter_11_0):updateByTVS({
				type = self._info["price_type_" .. iter_11_0],
				value = self._info["price_value_" .. iter_11_0],
				size = var_11_0
			})
			self:getChild("resNumComp" .. iter_11_0):setVisible(true)
		else
			self:getChild("resNumComp" .. iter_11_0):setVisible(false)
		end
	end
end

function CommanderWorldBuyPop:_addListeners()
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtn))
	self.m_costController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCostCtrChange))
end

function CommanderWorldBuyPop:_onCostCtrChange()
	local var_13_0 = self.m_costController:getSelectedIndex() + 1

	self._info.costIdx = var_13_0

	self.m_priceCostComp1:updateByTVS({
		type = self._info["price_type_" .. var_13_0],
		value = self._info["price_value_" .. var_13_0],
		size = self._info["price_size_" .. var_13_0]
	})

	local var_13_1 = self.m_priceCostComp1:getWidth()

	if var_13_1 % 2 == 0 then
		self.m_priceCostComp1:setWidth(var_13_1 + 1)
	end

	self:_totalCost()

	self._maxNum = self:_getMaxCount()

	self.m_subAddNumComp:setMaxNum(self._maxNum)
end

function CommanderWorldBuyPop:_onConfirmBtn()
	g.core.network.GameNetProxy:send_C2S_OrderWorld_ShopBuy({
		goods_id = self._info.goods_id,
		num = self._count
	})
end

function CommanderWorldBuyPop:_onRcvShopping(arg_15_1, arg_15_2, arg_15_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function CommanderWorldBuyPop:onLoad()
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_SHOPBUY, self._onRcvShopping, self, 1)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._totalCost), self)
end

return CommanderWorldBuyPop
