local ShopFlushComp = class("ShopFlushComp", require("app.fairyGUI.shop.UI_ShopFlushComp"))
local var_0_2 = g.core.model.User.shopFlushData
local var_0_3 = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE
local var_0_4 = g.core.config.shop_flush_info
local var_0_5 = g.core.model.User.resourceData
local var_0_6 = g.core.common.Goods
local var_0_7 = g.core.module.ModuleManager
local DrawKnight = require("app.view.common.DrawKnight")

function ShopFlushComp:ctor()
	self._curTabListSelectIndex = 0
	self._shopData = nil
	self._alreadyFlushNum = 0
	self._flushMaxNum = 0
	self._specialShopData = {}
	self._curShopType = 1
	self._buyAwards = {}
	self._buyFlushNum = 0
	self._isUpdateShop = false
	self._freeFreshNum = 0
	self._curFreeNum = 0
	self._freeFreeCdTime = 0
	self._isSchedule = false

	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemListRender))
	self.m_flushBtn:addRefreshListener(handler(self, self._onFlushBtnClick))
end

function ShopFlushComp:_addAssistant(arg_2_1)
	self.m_knightComp:removeChildren()

	local var_2_0 = {}

	if arg_2_1.spine > 0 then
		var_2_0.resId = arg_2_1.spine or 700060
	end

	if g.core.utils.Rule.matchChannelAndLv() then
		var_2_0.resId = 500070
	end

	var_2_0.isShowBg = false

	self.m_knightComp:addChild((DrawKnight.new(var_2_0)))
end

function ShopFlushComp:_onItemListRender(arg_3_1, arg_3_2)
	if self._shopData and self._shopData[arg_3_1 + 1] then
		arg_3_2:updateCell(self._shopData[arg_3_1 + 1], self._curShopType, arg_3_1)
	end
end

function ShopFlushComp:_onFlushBtnClick()
	if self._flushMaxNum - self._buyFlushNum > 0 or self._curFreeNum > 0 then
		if var_0_2:isCanFreeFlush(self._curShopType) then
			local var_4_0 = 0
			local var_4_1 = {}

			if self._curFreeNum <= 0 then
				var_4_1 = var_0_2:getConsumeItem(self._curShopType, self._buyFlushNum)
				var_4_0 = var_4_1.type

				if not var_4_1.isFlush then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = var_4_1.costType,
						value = var_4_1.costValue,
						size = var_4_1.costSize
					})

					return
				end
			end

			if var_4_0 ~= 0 and not var_0_2:getBuyFlag(var_4_1.costType, var_4_1.costValue) then
				local var_4_2 = var_0_6:convert({
					type = var_4_1.costType,
					value = var_4_1.costValue,
					size = var_4_1.size
				})
				local var_4_3 = var_4_1.costType
				local var_4_4 = var_4_1.costValue
				local var_4_5, var_4_6 = self:_isFreshPopTips()

				var_0_7:pushModule(g.view.entrance.CONFIRM_POP, var_4_5 and not var_0_2:getRecommandFlag(self._curShopType) and {
					title = g.core.lang:get(107050),
					desc = g.core.lang:get(107046, {
						name = var_4_2.name,
						num = var_4_2.size
					}),
					onConfirm = handler(self, function()
						local var_5_0 = {
							title = g.core.lang:get(107050),
							desc = g.core.lang:get(107047, {
								name = self:_getNameByList(var_4_6)
							}),
							onConfirm = handler(self, function()
								g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
									shop_id = self._curShopType,
									flush_type = var_4_0
								})
							end),
							tip = {
								isChecked = false,
								txt = g.core.lang:get(1000)
							},
							onCheck = handler(self, function(arg_7_0, arg_7_1)
								var_0_2:setRecommandFlag(self._curShopType, arg_7_1)
							end)
						}

						self:newScheduleOnce(handler(self, function()
							var_0_7:pushModule(g.view.entrance.CONFIRM_POP, var_5_0)
						end), 0)
					end),
					tip = {
						isChecked = false,
						txt = g.core.lang:get(1000)
					},
					onCheck = handler(self, function(arg_9_0, arg_9_1)
						var_0_2:setBuyFlag(var_4_3, var_4_4, arg_9_1)
					end)
				} or {
					title = g.core.lang:get(107050),
					desc = g.core.lang:get(107046, {
						name = var_4_2.name,
						num = var_4_2.size
					}),
					onConfirm = handler(self, function()
						g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
							shop_id = self._curShopType,
							flush_type = var_4_0
						})
					end),
					tip = {
						isChecked = false,
						txt = g.core.lang:get(1000)
					},
					onCheck = handler(self, function(arg_11_0, arg_11_1)
						var_0_2:setBuyFlag(var_4_3, var_4_4, arg_11_1)
					end)
				})

				return
			end

			local var_4_8 = var_0_2:getRecommandFlag(self._curShopType)
			local var_4_9, var_4_10 = self:_isFreshPopTips()

			if var_4_9 and not var_4_8 then
				var_0_7:pushModule(g.view.entrance.CONFIRM_POP, {
					title = g.core.lang:get(107050),
					desc = g.core.lang:get(107047, {
						name = self:_getNameByList(var_4_10)
					}),
					onConfirm = handler(self, function()
						g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
							shop_id = self._curShopType,
							flush_type = var_4_0
						})
					end),
					tip = {
						isChecked = false,
						txt = g.core.lang:get(1000)
					},
					onCheck = handler(self, function(arg_13_0, arg_13_1)
						var_0_2:setRecommandFlag(self._curShopType, arg_13_1)
					end)
				})

				return
			end

			g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
				shop_id = self._curShopType,
				flush_type = var_4_0
			})
		else
			local var_4_11 = var_0_2:getConsumeItem(self._curShopType, self._buyFlushNum)

			if var_4_11.isFlush then
				g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
					flush_type = 0,
					shop_id = self._curShopType
				})
			else
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = var_4_11.costType,
					value = var_4_11.costValue,
					size = var_4_11.costSize
				})
			end
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107048))
	end
end

function ShopFlushComp:_isFreshPopTips()
	local var_14_0 = {}

	local function var_14_1(arg_15_0)
		for iter_15_0, iter_15_1 in ipairs(var_14_0) do
			if iter_15_1.type == arg_15_0.type and iter_15_1.value == arg_15_0.value then
				return true
			end
		end

		return false
	end

	for iter_14_0 = 1, #self._shopData do
		local var_14_2 = g.core.config.shop_flush_goods_info.get(self._shopData[iter_14_0].id)

		if var_14_2.flush_confirm == 1 and self._shopData[iter_14_0].buy_count < var_14_2.total_limit then
			local var_14_3 = {
				size = 1,
				type = var_14_2.goods_type,
				value = var_14_2.goods_value
			}

			if not var_14_1(var_14_3) then
				table.insert(var_14_0, var_14_3)
			end
		end

		if var_0_2:getRecommandItemDesc({
			type = var_14_2.goods_type,
			value = var_14_2.goods_value
		}) ~= "" and self._shopData[iter_14_0].buy_count < var_14_2.total_limit then
			local var_14_4 = {
				size = 1,
				type = var_14_2.goods_type,
				value = var_14_2.goods_value
			}

			if not var_14_1(var_14_4) then
				table.insert(var_14_0, var_14_4)
			end
		end
	end

	if #var_14_0 > 0 then
		return true, var_14_0
	else
		return false, var_14_0
	end
end

function ShopFlushComp:_getNameByList(arg_16_1)
	local var_16_0 = ""

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		local var_16_1 = var_0_6:convert(iter_16_1)

		var_16_0 = var_16_0 == "" and (#arg_16_1 > 1 and var_16_1.name .. "," or var_16_1.name) or iter_16_0 == #arg_16_1 and var_16_0 .. var_16_1.name or var_16_0 .. var_16_1.name
	end

	return var_16_0
end

function ShopFlushComp:updateComp(arg_17_1)
	if arg_17_1 and arg_17_1.info then
		self._isUpdateShop = true

		self:_addAssistant(arg_17_1.info)
		g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.SHOP_SHOW)
		self.m_shopName:setText(arg_17_1.info.type_name)
		self.m_enterTransition:play()

		local var_17_0 = self:_getShopFlushInfoByFuncId(arg_17_1.info.function_id)

		if var_17_0 then
			self:_onUpdate(var_17_0.id, arg_17_1.info.function_id)
		end
	end
end

function ShopFlushComp:_getShopFlushInfoByFuncId(arg_18_1)
	for iter_18_0 = 1, var_0_4.getLength() do
		local var_18_0 = var_0_4.indexOf(iter_18_0)

		if var_18_0.function_id == arg_18_1 then
			return var_18_0
		end
	end

	return nil
end

function ShopFlushComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_INFO, handler(self, self._onReceiveFlushShop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_FLUSH, handler(self, self._onReceiveFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_BUY, handler(self, self._onReceiveBuy), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._recvResourceChange), self)
end

function ShopFlushComp:_onReceiveFlushShop(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not arg_20_4 or not arg_20_4.shop then
		return
	end

	self:_onUpdateView(arg_20_4.shop)
	var_0_2:updateLastFlushTime()
end

function ShopFlushComp:_onReceiveFlush(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if not arg_21_4 or not arg_21_4.shop then
		return
	end

	self:_onUpdateView(arg_21_4.shop)
end

function ShopFlushComp:_onReceiveBuy(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if not arg_22_4 or not arg_22_4.shop then
		return
	end

	self:_onUpdateView(arg_22_4.shop)

	local var_22_0

	if arg_22_4.shop then
		if arg_22_4.goods_type == 1 then
			var_22_0 = arg_22_4.shop.normal_goods[arg_22_4.index]
		elseif arg_22_4.goods_type == 2 then
			var_22_0 = arg_22_4.shop.special_goods[1]
		end
	end

	if var_22_0 then
		local var_22_1 = g.core.config.shop_flush_goods_info.get(var_22_0.id)

		g.core.module.ModuleManager:awardSummary({
			{
				type = var_22_1.goods_type,
				value = var_22_1.goods_value,
				size = var_22_1.goods_size
			}
		})
	end
end

function ShopFlushComp:_recvResourceChange()
	self:_updateAndSchedule()
end

function ShopFlushComp:_onUpdate(arg_24_1, arg_24_2)
	self._curShopType = arg_24_1

	if self._curShopType == var_0_3.MYSTERY then
		local var_24_0 = g.core.model.User.resourceData:getMysteryShopFreeTime()

		if var_24_0 < g.core.common.ServerTime:getTime() then
			var_0_2:setIgnoreShopRedPoint(var_24_0)
		end

		self.m_isLimitTimeController:setSelectedIndex(0)
	elseif self._curShopType == var_0_3.ARTIFACT then
		var_0_2:ignoreArtifactShopRedPoint()
		self.m_isLimitTimeController:setSelectedIndex(0)
	elseif self._curShopType == var_0_3.PET then
		var_0_2:ignorePetShopRedPoint()
		self.m_isLimitTimeController:setSelectedIndex(0)
	elseif self._curShopType == var_0_3.LIMIT_TIME then
		var_0_2:updateLastFlushTime()
		self.m_isLimitTimeController:setSelectedIndex(1)
	end

	local var_24_2 = g.core.config.shop_info.match(function(arg_25_0)
		return arg_25_0.function_id == arg_24_2
	end)

	if var_24_2 and #var_24_2 > 0 then
		-- block empty
	end

	self:_reqShopData(arg_24_1)
end

function ShopFlushComp:_reqShopData(arg_26_1)
	if not var_0_2:hasData(arg_26_1) then
		g.core.network.GameNetProxy:send_C2S_FlushShop_Info({
			shop_id = arg_26_1
		})
	elseif var_0_2:isExpired(arg_26_1) then
		g.core.network.GameNetProxy:send_C2S_FlushShop_Info({
			shop_id = arg_26_1
		})
	else
		self:_onUpdateView((var_0_2:getShopFlushInfo(arg_26_1)))
	end
end

function ShopFlushComp:_onUpdateView(arg_27_1)
	self._shopData = arg_27_1.normal_goods
	self._alreadyFlushNum = arg_27_1.flush_total_count
	self._buyFlushNum = arg_27_1.flush_buy_count
	self._flushMaxNum = 0

	if self:_checkFlushType(self._curShopType) then
		self._flushMaxNum = var_0_2:getUserMaxFlushNum(var_0_4.get(self._curShopType).manual_flush_num_max)

		self:_updateAndSchedule()
	end

	if self._curShopType == var_0_3.LIMIT_TIME then
		self._specialShopData = arg_27_1.special_goods
	end

	local var_27_0 = #self._shopData

	if #self._shopData > 0 then
		self.m_itemList:setScrollEnabled(self.m_itemList:getFitSize(var_27_0) > self.m_itemList:getViewHeight())
		self.m_itemList:setNumItems(var_27_0)
		self.m_itemList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
	else
		self:setScrollEnabled(false)
		self.m_itemList:setNumItems(0)
	end
end

function ShopFlushComp:_checkFlushType(arg_28_1)
	return arg_28_1 == var_0_3.MYSTERY or arg_28_1 == var_0_3.ARTIFACT or arg_28_1 == var_0_3.PET or arg_28_1 == var_0_3.FURNITURE
end

function ShopFlushComp:_onUpdateConstView()
	self._curFreeNum = 0

	if self._curShopType == var_0_3.MYSTERY then
		self._curFreeNum = var_0_5:getMysteryShopFreeNum()
	elseif self._curShopType == var_0_3.ARTIFACT then
		self._curFreeNum = var_0_5:getArtifactShopFreeNum()
	elseif self._curShopType == var_0_3.PET then
		self._curFreeNum = var_0_5:getPetShopFreeNum()
	elseif self._curShopType == var_0_3.FURNITURE then
		self._curFreeNum = var_0_5:getFurnitureShopFreeNum()
	end

	self._freeFreshNum = var_0_2:getFreeFlushNumLimit(self._curShopType)
	self._freeFreeCdTime = var_0_2:getFreeFlushCdTime(self._curShopType)

	self.m_flushBtn:updateComp({
		maxNum = self._flushMaxNum,
		buyNum = self._buyFlushNum,
		curFreeNum = self._curFreeNum,
		shopType = self._curShopType,
		num = self._buyFlushNum
	})

	if self._curFreeNum < self._freeFreshNum then
		self.m_canFlushController:setSelectedIndex(1)
	else
		self.m_canFlushController:setSelectedIndex(0)
	end
end

function ShopFlushComp:_updateAndSchedule()
	self:_onUpdateConstView()
	self:_onScheduleUpdate()

	if self._curFreeNum < self._freeFreshNum then
		self._isUpdateShop = false

		if not self._isSchedule then
			self:cancelAllSchedule()
			self:newSchedule(handler(self, self._onScheduleUpdate), 1)
			self:_onScheduleUpdate()

			self._isSchedule = true
		end
	else
		if self._isSchedule then
			self:cancelAllSchedule()

			self._isSchedule = false
		end

		self._isUpdateShop = false
	end
end

function ShopFlushComp:_onScheduleUpdate(arg_31_1, arg_31_2)
	if self._isUpdateShop then
		return
	end

	local var_31_0 = 0

	if self._curShopType == var_0_3.MYSTERY then
		var_31_0 = var_0_5:getMysteryShopFreeTime()
	elseif self._curShopType == var_0_3.ARTIFACT then
		var_31_0 = var_0_5:getArtifactShopFreeTime()
	elseif self._curShopType == var_0_3.PET then
		var_31_0 = var_0_5:getPetShopFreeTime()
	elseif self._curShopType == var_0_3.FURNITURE then
		var_31_0 = var_0_5:getFurnitureShopFreeTime()
	end

	local var_31_1 = var_31_0 - g.core.common.ServerTime:getTime()
	local var_31_2 = math.floor(var_31_1 / self._freeFreeCdTime)
	local var_31_3 = var_31_1 - var_31_2 * self._freeFreeCdTime

	if var_31_1 - var_31_2 * self._freeFreeCdTime > 0 and var_31_2 + 1 > self._freeFreshNum - self._curFreeNum then
		return
	end

	if var_31_3 == 0 and var_31_2 > 0 then
		var_31_3 = self._freeFreeCdTime
	end

	self.m_freeTimeTxt:setText((g.core.common.ServerTime:secondToHMSString(var_31_3)))

	if var_31_1 % self._freeFreeCdTime == 0 then
		local var_31_4 = {}

		if self._curShopType == var_0_3.MYSTERY then
			table.insert(var_31_4, {
				id = var_0_6.RESOURCE.TYPE_MYSTERY_SHOP_FREE_NUM,
				num = self._freeFreshNum - var_31_1 / self._freeFreeCdTime
			})
		elseif self._curShopType == var_0_3.ARTIFACT then
			table.insert(var_31_4, {
				id = var_0_6.RESOURCE.TYPE_ARTIFACT_SHOP_FREE_NUM,
				num = self._freeFreshNum - var_31_1 / self._freeFreeCdTime
			})
		elseif self._curShopType == var_0_3.PET then
			table.insert(var_31_4, {
				id = var_0_6.RESOURCE.TYPE_PET_SHOP_FREE_NUM,
				num = self._freeFreshNum - var_31_1 / self._freeFreeCdTime
			})
		elseif self._curShopType == var_0_3.FURNITURE then
			table.insert(var_31_4, {
				id = var_0_6.RESOURCE.TYPE_FURNITURE_SHOP_FREE_NUM,
				num = self._freeFreshNum - var_31_1 / self._freeFreeCdTime
			})
		end

		var_0_5:updateData(var_31_4)
		self:_onUpdateConstView()
	end

	self.m_freeTimeTxt:setVisible(true)

	if var_31_1 < 0 then
		self:cancelAllSchedule()

		self._isSchedule = false

		local var_31_5 = {}

		if self._curShopType == var_0_3.MYSTERY then
			table.insert(var_31_5, {
				id = var_0_6.RESOURCE.TYPE_MYSTERY_SHOP_FREE_NUM,
				num = self._freeFreshNum
			})
		elseif self._curShopType == var_0_3.ARTIFACT then
			table.insert(var_31_5, {
				id = var_0_6.RESOURCE.TYPE_ARTIFACT_SHOP_FREE_NUM,
				num = self._freeFreshNum
			})
		elseif self._curShopType == var_0_3.PET then
			table.insert(var_31_5, {
				id = var_0_6.RESOURCE.TYPE_PET_SHOP_FREE_NUM,
				num = self._freeFreshNum
			})
		elseif self._curShopType == var_0_3.FURNITURE then
			table.insert(var_31_5, {
				id = var_0_6.RESOURCE.TYPE_FURNITURE_SHOP_FREE_NUM,
				num = self._freeFreshNum
			})
		end

		var_0_5:updateData(var_31_5)
		self.m_freeTimeTxt:setVisible(false)
	end
end

return ShopFlushComp
