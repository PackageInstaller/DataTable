local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local ShopFlushItemCell = class("ShopFlushItemCell", require("app.fairyGUI.shop.UI_ShopFlushItemCell"))
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.bagData
local var_0_4 = g.core.model.User.shopData
local var_0_5 = g.core.model.User.shopFlushData
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE
local var_0_8 = g.core.model.User.knightsData
local var_0_9 = g.core.const.ConstMgr.BAG_TYPE
local var_0_10 = g.core.common.Path
local var_0_11 = g.core.config.fragment_info

function ShopFlushItemCell:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._itemIndex = 0
	self._shopType = nil
	self._buyShopItem = {}
	self._buyItemGood = {}
	self._qualityEffectIcon = {}
	self._consumeItemType = 0
	self._consumeItemNum = 0
	self._consumeItemValue = 0

	self.m_comfortGroup:setVisible(false)
	self.m_comfortIconLoader:setURL((var_0_10:getIconByTypeValue(var_0_2.TYPE_RESOURCE, var_0_2.RESOURCE.TYPE_COMFORT, true)))
	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self:_addListeners()
end

function ShopFlushItemCell:_addListeners()
	self:addClickListener(handler(self, self._onShopFlushItemCellClick))
end

function ShopFlushItemCell:_onShopFlushItemCellClick(arg_3_1)
	if self.m_touchBg:containPoint((arg_3_1:getInput():getTouch():getLocation())) then
		if self._buyShopItem.type then
			self._buyShopItem.component = self.m_item

			g.core.common.GlobalFunc.pushInfoPop(self._buyShopItem)
		end
	else
		self:_onBuy()
	end
end

function ShopFlushItemCell:_onBuy()
	if not self._isBuy then
		g.core.module.ModuleManager:tip(g.core.lang:get(107004))

		return
	end

	if self._isEnough then
		if self._consumeItemType == var_0_9.GOLD and not (var_0_5:getGoldCostTip(self._shopType) and (self._shopType == var_0_7.MYSTERY or self._shopType == var_0_7.ARTIFACT or self._shopType == var_0_7.PET)) then
			local var_4_0 = self._shopType
			local var_4_1 = self._itemIndex
			local var_4_2 = {
				title = g.core.lang:get(107043),
				desc = g.core.lang:get(107044, {
					num = self._consumeItemNum,
					name = self._buyItemGood.name,
					costName = g.core.common.Goods:convert({
						type = self._consumeItemType,
						value = self._consumeItemValue,
						size = self._consumeItemNum
					}).name
				}),
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_FlushShop_Buy({
						num = 1,
						goods_type = 1,
						shop_id = var_4_0,
						index = var_4_1
					})
				end,
				cost2 = {
					value = 0,
					type = var_0_9.GOLD,
					size = self._consumeItemNum
				}
			}

			if self._shopType == var_0_7.MYSTERY or self._shopType == var_0_7.ARTIFACT or self._shopType == var_0_7.PET then
				var_4_2.tip = {
					isChecked = false,
					txt = g.core.lang:get(1000)
				}
				var_4_2.onCheck = handler(self, function(arg_6_0, arg_6_1)
					var_0_5:setGoldCostTip(self._shopType, arg_6_1)
				end)
			end

			g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, var_4_2)
		else
			g.core.network.GameNetProxy:send_C2S_FlushShop_Buy({
				num = 1,
				goods_type = 1,
				shop_id = self._shopType,
				index = self._itemIndex
			})
		end

		self:dispatchCompEvent("CompItem_click", {
			awards = self._buyShopItem
		})
	else
		local var_4_3 = {
			type = self._consumeItemType,
			value = self._consumeItemValue
		}

		var_4_3.size = var_0_3:getOwnNum(self._consumeItemType, self._consumeItemValue)

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_4_3)
	end
end

function ShopFlushItemCell:updateCell(arg_7_1, arg_7_2, arg_7_3)
	self._info = arg_7_1
	self._shopType = arg_7_2
	self._itemIndex = arg_7_3 + 1

	local var_7_0 = g.core.config.shop_flush_goods_info.get(self._info.id)
	local var_7_1 = var_7_0.goods_type
	local var_7_2 = var_7_0.goods_value

	self._totalBuyNum = var_7_0.total_limit
	self._buyShopItem = {
		type = var_7_1,
		value = var_7_2,
		size = var_7_0.goods_size
	}
	self._buyItemGood = var_0_2:convert(self._buyShopItem)
	self._buyItemGood.hideNum = false

	self.m_nameTxt:setText(self._buyItemGood.name)
	self.m_qualityBg:setURL(var_0_10:getUserIconQualityStarBg(self._buyItemGood.quality))
	self.m_item:setURL(self._buyItemGood.icon)
	self.m_num:setText(var_7_0.goods_size)

	if self._buyItemGood.type == var_0_2.TYPE_EQUIP then
		self:updateEquipQualityEffect(self._buyItemGood.quality, self._buyItemGood.value)
	else
		self:updateEquipQualityEffect(0)
	end

	self:_updateCost(var_7_0)
	self:_updateTips(var_7_0)

	self._isBuy = self._totalBuyNum > arg_7_1.buy_count

	if self._isBuy then
		self.m_isUnBuyController:setSelectedIndex(0)
	else
		self.m_limitTxt:setText(g.core.lang:get(107004))
		self.m_isUnBuyController:setSelectedIndex(1)
	end

	if var_7_1 == var_0_2.TYPE_FURNITURE then
		self.m_comfortTxt:setText(tostring(self._buyItemGood.info.comfort))

		local var_7_3 = var_0_3:isOwnItem(var_7_1, var_7_2)

		self.m_collectBg:setVisible(not var_7_3)
		self.m_noCollectTxt:setVisible(not var_7_3)
		self.m_comfortGroup:setVisible(true)
	else
		self.m_comfortGroup:setVisible(false)
	end

	if var_7_1 == var_0_2.TYPE_FRAGMENT then
		local var_7_4 = var_0_11.get(var_7_2)
		local var_7_5 = var_7_4.fragment_type

		if var_7_4.fragment_type ~= var_0_2.FRAGMENT.TYPE_KNIGHT and var_7_5 ~= var_0_2.FRAGMENT.TYPE_PET then
			self.m_isFragController:setSelectedIndex(1)
		else
			self.m_isFragController:setSelectedIndex(0)
		end

		if var_7_5 == var_0_2.TYPE_EQUIP then
			self:updateEquipQualityEffect(var_7_4.quality, var_7_4.fragment_value)
		else
			self:updateEquipQualityEffect(0)
		end
	else
		self.m_isFragController:setSelectedIndex(0)
	end

	self.m_LUStateController:setSelectedIndex(0)
	self.m_isShowGroupController:setSelectedIndex(0)

	if var_7_1 == var_0_2.TYPE_FRAGMENT then
		local var_7_6 = g.core.config.fragment_info.get(var_7_2)

		if var_7_6 and var_7_6.fragment_type == var_0_2.TYPE_KNIGHT then
			local var_7_7 = var_0_8:getKnight({
				advance_id = var_7_6.fragment_value
			})

			if var_7_7 then
				if var_7_7:isLineup() then
					self.m_LUStateController:setSelectedIndex(1)
				end

				self.m_groupLoader:setURL(g.core.common.Path:getCampURL(var_7_7:getGroup(), 4))
				self.m_isShowGroupController:setSelectedIndex(1)
			end
		elseif var_7_6 and var_7_6.fragment_type == var_0_2.TYPE_ARTIFACT then
			local var_7_8 = g.core.model.User.artifactData:getArtifactByBaseId(var_7_6.fragment_value)

			if var_7_8 and var_7_8:isLineup() then
				self.m_LUStateController:setSelectedIndex(2)
			end
		end
	end

	if var_7_1 == var_0_2.TYPE_KNIGHT then
		local var_7_9 = var_0_8:getKnight({
			base_id = var_7_2
		})

		if var_7_9 then
			self.m_groupLoader:setURL(g.core.common.Path:getCampURL(var_7_9:getGroup(), 4))
			self.m_isShowGroupController:setSelectedIndex(1)
		end
	end
end

function ShopFlushItemCell:_updateCost(arg_8_1)
	self._isEnough = true

	local function var_8_0(arg_9_0, arg_9_1)
		if arg_9_0 > var_0_3:getOwnNum(arg_8_1["price_type_" .. arg_9_1], arg_8_1["price_value_" .. arg_9_1]) then
			self._isEnough = false
		end
	end

	self.m_cornerController:setSelectedIndex(0)
	self.m_cornerTxt:setText("")

	for iter_8_0 = 1, var_0_6.FLUSH_COST_MAX_NUM do
		local var_8_1 = arg_8_1["price_type_" .. iter_8_0]
		local var_8_2 = arg_8_1["price_value_" .. iter_8_0]
		local var_8_3 = arg_8_1["price_size_" .. iter_8_0]
		local var_8_4 = arg_8_1.discount

		if iter_8_0 == 1 then
			self._consumeItemType, self._consumeItemNum, self._consumeItemValue = var_8_1, var_8_3, var_8_2
		end

		if arg_8_1.discount ~= 0 and arg_8_1.discount ~= 100 then
			self.m_typeController:setSelectedIndex(2)
			self.m_cornerController:setSelectedIndex(2)
			self.m_cornerTxt:setText(g.core.lang:get(107030, {
				num = arg_8_1.discount
			}))

			if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN then
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = 100 - arg_8_1.discount
				}) .. g.core.lang:get(406513))
			elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = 100 - arg_8_1.discount
				}) .. "OFF")
			end

			if var_8_1 > 0 then
				self.m_oneCostComp:updateByTVS({
					showLack = true,
					discount = true,
					type = var_8_1,
					value = var_8_2,
					size = var_8_3,
					oldSize = math.ceil(var_8_3 / var_8_4 * 100)
				})
				var_8_0(var_8_3, iter_8_0)
			end
		elseif iter_8_0 == 1 then
			if var_8_1 > 0 then
				self.m_oneCostComp:updateByTVS({
					showLack = true,
					discount = false,
					type = var_8_1,
					value = var_8_2,
					size = var_8_3
				})
				var_8_0(var_8_3, iter_8_0)
			end
		elseif var_8_1 > 0 then
			self.m_typeController:setSelectedIndex(1)
			self.m_twoCostComp:updateByTVS({
				showLack = true,
				discount = false,
				type = var_8_1,
				value = var_8_2,
				size = var_8_3
			})
			var_8_0(var_8_3, iter_8_0)
		else
			self.m_typeController:setSelectedIndex(0)
		end
	end
end

function ShopFlushItemCell:_updateTips(arg_10_1)
	self.m_tips:enableRich()

	if self._shopType == var_0_7.MYSTERY or self._shopType == var_0_7.ARTIFACT or self._shopType == var_0_7.PET then
		local var_10_0, var_10_1, var_10_2 = var_0_4:getFragNumInfo(self._buyShopItem)

		if var_10_0 then
			if var_10_2 > 0 then
				self.m_tips:setText(g.core.lang:get(var_10_1 > 0 and 107039 or 107054, {
					num1 = g.core.lang:getFormatNumText(var_10_1),
					num2 = g.core.lang:getFormatNumText(var_10_2)
				}))
			else
				self.m_tips:setText(g.core.lang:get(107105))
			end
		end

		self.m_tips:setVisible(var_10_0)
		self.m_tipBg:setVisible(var_10_0)
	elseif self._shopType == var_0_7.LIMIT_TIME then
		self.m_tips:setText(g.core.lang:get(107042, {
			num = arg_10_1.progress_score
		}))
	else
		self.m_tips:setVisible(false)
		self.m_tipBg:setVisible(false)
	end
end

function ShopFlushItemCell:updateEquipQualityEffect(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_11_0]:setVisible(false)
	end

	if arg_11_1 >= var_0_0.UR and arg_11_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_11_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_11_2] or self.m_effectIcon:addEffectSpine({
			isLoop = true,
			anim = "play",
			scale = 0.25,
			name = "eff_ui_equipment_128_" .. arg_11_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_11_2]:setVisible(true)
	end
end

return ShopFlushItemCell
