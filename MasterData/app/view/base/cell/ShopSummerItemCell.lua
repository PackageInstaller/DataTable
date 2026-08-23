local ShopSummerItemCell = class("ShopSummerItemCell", require("app.fairyGUI.shop.UI_ShopSummerItemCell"))
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr.ShopConst
local var_0_5 = g.core.const.ConstMgr.ThemeConst
local var_0_6 = g.core.common.ServerTime
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.config.fragment_info

function ShopSummerItemCell:ctor()
	self._info = nil
	self._goodInfo = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0
	self._endTime = 0

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self:_addListeners()
	self.m_comfortGroup:setVisible(false)
	self.m_comfortIconLoader:setURL((var_0_7:getIconByTypeValue(var_0_1.TYPE_RESOURCE, var_0_1.RESOURCE.TYPE_COMFORT, true)))
end

function ShopSummerItemCell:_addListeners()
	self:addClickListener(handler(self, self._onShopSummerItemCellClick))
end

function ShopSummerItemCell:_removeListeners()
	self:removeClickListener(1)
end

function ShopSummerItemCell:_onShopSummerItemCellClick(arg_4_1)
	if self.m_touchBg:containPoint((arg_4_1:getInput():getTouch():getLocation())) then
		if self._goodInfo then
			self._goodInfo.component = self.m_item

			g.core.common.GlobalFunc.pushInfoPop(self._goodInfo)
		end
	else
		self:_onBuy()
	end
end

function ShopSummerItemCell:_onBuy()
	if not self._info then
		return
	end

	if self._isBuy and self._isShopUnLock then
		if self._info.price == 0 and not self._isEnough then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._costType,
				value = self._costValue,
				size = self._costHasNum
			})
		elseif self._info.price_type_1 == 0 then
			g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
				cost_idx = 0,
				info = {
					num = 1,
					id = self._info.id
				},
				shop_id = self._shopInfo.id
			})
		else
			require("app.view.base.component.BaseBuyPop").createShop(self._info, false, self._shopInfo)
		end
	elseif not self._isShopUnLock then
		g.core.module.ModuleManager:tip(self._shopUnlockText)
	elseif not self._isBuy then
		g.core.module.ModuleManager:tip(self.m_limitTxt:getText())
	end
end

function ShopSummerItemCell:onLoad()
	return
end

function ShopSummerItemCell:updateCell(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._info = arg_7_1
	self._shopInfo = arg_7_3
	self._isShopUnLock = arg_7_4 ~= false
	self._goodInfo = var_0_1:convert({
		type = arg_7_1.type,
		value = arg_7_1.value,
		size = arg_7_1.size
	})

	if not self._goodInfo then
		return
	end

	self._themeValue = self._info.shop_first
	self._goodInfo.hideNum = false

	self.m_qualityBg:setURL(var_0_7:getSummerShopItemQualityBg(self._goodInfo.quality))

	if self._themeValue == var_0_5.THEME_VALUE.NEWYEAR then
		self.m_cellBg:setURL(var_0_7:getNewYearShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.AKIRA then
		self.m_cellBg:setURL(var_0_7:getAkiraShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.GOLDENDANCE then
		self.m_cellBg:setURL(var_0_7:getTenmaShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.OVERLORD then
		self.m_cellBg:setURL(var_0_7:getOverlordShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.LINEDELL then
		self.m_cellBg:setURL(var_0_7:getLindellShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.RHAINA then
		self.m_cellBg:setURL(var_0_7:getRhainaShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.LILITH then
		self.m_cellBg:setURL(var_0_7:getLilithShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.ANUBIS then
		self.m_cellBg:setURL(var_0_7:getAnubisShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.DIESS then
		self.m_cellBg:setURL(var_0_7:getDiessShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.METEOR then
		self.m_cellBg:setURL(var_0_7:getMeteorShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.DAIMONIKA then
		self.m_cellBg:setURL(var_0_7:getMirrorShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.PRAY then
		self.m_cellBg:setURL(var_0_7:getPrayShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.LINK then
		self.m_cellBg:setURL(var_0_7:getLinkShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.LING then
		self.m_cellBg:setURL(var_0_7:getLingShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.SPRING then
		self.m_cellBg:setURL(var_0_7:getSpringShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.CLOUDS then
		self.m_cellBg:setURL(var_0_7:getCloudsShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.ANNA then
		self.m_cellBg:setURL(var_0_7:getAnnaShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.FEIFEI then
		self.m_cellBg:setURL(var_0_7:getFeifeiShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.CARLA then
		self.m_cellBg:setURL(var_0_7:getCarlaShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.YUANDAN then
		self.m_cellBg:setURL(var_0_7:getYuanDanItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.PENGPENG then
		self.m_cellBg:setURL(var_0_7:getPengpengItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.JULIET then
		self.m_cellBg:setURL(var_0_7:getJulietItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.BAIYU then
		self.m_cellBg:setURL(var_0_7:getBaiYuItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.WEIYANG then
		self.m_cellBg:setURL(var_0_7:getWeiYangItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.ILIYI or self._themeValue == var_0_5.THEME_VALUE.REUSE_97 or self._themeValue == var_0_5.THEME_VALUE.REUSE_98 then
		self.m_cellBg:setURL(var_0_7:getIliyiItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.JOSEPHINE or self._themeValue == var_0_5.THEME_VALUE.REUSE_100 or self._themeValue == var_0_5.THEME_VALUE.REUSE_101 then
		self.m_cellBg:setURL(var_0_7:getDiessShopItemQualityCellBg(self._goodInfo.quality))
	elseif self._themeValue == var_0_5.THEME_VALUE.ELISA or self._themeValue == var_0_5.THEME_VALUE.REUSE_103 or self._themeValue == var_0_5.THEME_VALUE.REUSE_104 then
		self.m_cellBg:setURL(var_0_7:getDiessShopItemQualityCellBg(self._goodInfo.quality))
	else
		self.m_cellBg:setURL(var_0_7:getSummerShopItemQualityCellBg(self._goodInfo.quality))
	end

	if self.m_repoBg and self._themeValue == var_0_5.THEME_VALUE.ANUBIS then
		self.m_repoBg:setURL(var_0_7:getAnubisShopItemRepoBg(self._goodInfo.quality))
	end

	self.m_item:setURL(self._goodInfo.icon)
	self.m_num:setText(arg_7_1.size)
	self.m_nameTxt:setText(self._goodInfo.name)
	self:_updateCost(arg_7_1)
	self:_updateTipsText(arg_7_1)

	if arg_7_1.type == var_0_1.TYPE_FURNITURE then
		self.m_comfortTxt:setText(tostring(self._goodInfo.info.comfort))
		self.m_comfortGroup:setVisible(true)
	else
		self.m_isFragController:setSelectedIndex(0)
		self.m_comfortGroup:setVisible(false)
	end

	if arg_7_1.type == var_0_1.TYPE_FRAGMENT then
		if var_0_8.get(self._info.value).fragment_type ~= var_0_1.FRAGMENT.TYPE_KNIGHT then
			self.m_isFragController:setSelectedIndex(1)
		else
			self.m_isFragController:setSelectedIndex(0)
		end
	else
		self.m_isFragController:setSelectedIndex(0)
	end

	if arg_7_1.end_times ~= 0 then
		self.m_isTimeLimitController:setSelectedIndex(1)

		self._endTime = os.time((var_0_3:numberToDate(arg_7_1.end_times)))

		self:_refreshTime()

		self._timeSchedule = self:newSchedule(handler(self, self._refreshTime), 1)
	else
		self.m_isTimeLimitController:setSelectedIndex(0)

		if self._timeSchedule then
			self:cancelSchedule(self._timeSchedule)

			self._timeSchedule = nil
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self,
		customData = {
			scoreInfo = arg_7_1
		}
	})
end

function ShopSummerItemCell:_refreshTime()
	self.m_limitTimeTxt:setText((var_0_6:getLeftDHMSFormat(self._endTime)))
end

function ShopSummerItemCell:_updateTipsText(arg_9_1)
	local var_9_0 = var_0_3:getBuyLimitLeft(arg_9_1)

	if var_9_0 ~= nil and self._info.price_type_1 > 0 then
		self.m_tips:setText(g.core.lang:get(107079) .. var_9_0)
		self.m_tips:setVisible(true)
	elseif self._info.type == var_0_1.TYPE_FRAGMENT then
		local var_9_1, var_9_2, var_9_3 = var_0_3:getFragNumInfo(self._info)

		if var_9_1 then
			if var_9_3 > 0 then
				self.m_tips:setText(g.core.lang:get(var_9_2 > 0 and 107039 or 107054, {
					num1 = g.core.lang:getFormatNumText(var_9_2),
					num2 = g.core.lang:getFormatNumText(var_9_3)
				}))
			else
				self.m_tips:setText(g.core.lang:get(107040, {
					num1 = g.core.lang:getFormatNumText(var_9_2)
				}))
			end
		end

		self.m_tips:setVisible(var_9_1)
	else
		self.m_tips:setVisible(false)
	end

	if not var_9_0 or var_9_0 > 0 then
		if arg_9_1.buy_ban_type > 0 and var_0_3:checkBuyBan(arg_9_1) then
			self.m_limitTxt:setText(var_0_3:getShopBuyBanText(arg_9_1.buy_ban_type, arg_9_1.buy_ban_value, arg_9_1.buy_ban_key) or "")
			self.m_isUnBuyController:setSelectedIndex(1)
			self.m_cornerController:setSelectedIndex(0)

			self._isBuy = false
		elseif var_9_0 and var_9_0 > 0 then
			self.m_isUnBuyController:setSelectedIndex(0)

			self._isBuy = true
		else
			self.m_isUnBuyController:setSelectedIndex(0)

			self._isBuy = true
		end
	else
		self.m_isUnBuyController:setSelectedIndex(1)
		self.m_limitTxt:setText(g.core.lang:get(107004))

		self._isBuy = not not var_0_3:getBuyNextVip(arg_9_1.buy_vip_num)
	end

	self._shopUnlockText = self._isShopUnLock and "" or var_0_3:getShopUnlockText(self._shopInfo.open_type, self._shopInfo.open_value)

	if not self._isBuy and self._isShopUnLock or self._info.price_type_1 > 0 then
		self.m_freeTxt:setVisible(false)
	elseif self._info.price_type_1 <= 0 then
		self.m_freeTxt:setVisible(true)
	end

	self.m_isShopUnLockController:setSelectedIndex(self._isShopUnLock and 1 or 0)
end

function ShopSummerItemCell:_updateCost(arg_10_1)
	self._isEnough = true

	local function var_10_0(arg_11_0, arg_11_1)
		local var_11_0 = var_0_2:getOwnNum(arg_10_1["price_type_" .. arg_11_1], arg_10_1["price_value_" .. arg_11_1])

		if var_11_0 < arg_11_0 then
			self._costType = arg_10_1["price_type_" .. arg_11_1]
			self._costValue = arg_10_1["price_value_" .. arg_11_1]
			self._costHasNum = var_11_0
			self._isEnough = false
		end
	end

	self.m_cornerController:setSelectedIndex(0)
	self.m_cornerTxt:setText("")

	if arg_10_1.price_type_1 <= 0 then
		self.m_typeController:setSelectedIndex(4)
	else
		for iter_10_0 = 1, var_0_4.COST_MAX_NUM do
			local var_10_1, var_10_2, var_10_3 = var_0_3:getBuyItemPrice(arg_10_1, 1, iter_10_0)

			if var_10_2 ~= 0 and var_10_2 ~= 100 then
				self.m_typeController:setSelectedIndex(2)
				self.m_cornerController:setSelectedIndex(3)
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = var_10_2
				}))

				if arg_10_1["price_type_" .. iter_10_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						discount = true,
						showLack = true,
						type = arg_10_1["price_type_" .. iter_10_0],
						value = arg_10_1["price_value_" .. iter_10_0],
						size = var_10_1,
						oldSize = var_10_3
					})
					var_10_0(var_10_1, iter_10_0)
				end
			elseif iter_10_0 == 1 then
				if arg_10_1["price_type_" .. iter_10_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						showLack = true,
						discount = false,
						type = arg_10_1["price_type_" .. iter_10_0],
						value = arg_10_1["price_value_" .. iter_10_0],
						size = var_10_1
					})
					var_10_0(var_10_1, iter_10_0)
				end
			elseif arg_10_1["price_type_" .. iter_10_0] > 0 then
				self.m_twoCostComp:updateByTVS({
					showLack = true,
					discount = false,
					type = arg_10_1["price_type_" .. iter_10_0],
					value = arg_10_1["price_value_" .. iter_10_0],
					size = var_10_1
				})
				var_10_0(var_10_1, iter_10_0)

				if arg_10_1.price == 0 then
					self.m_typeController:setSelectedIndex(1)
				else
					self.m_typeController:setSelectedIndex(3)
				end
			else
				self.m_typeController:setSelectedIndex(0)
			end
		end
	end
end

return ShopSummerItemCell
