local var_0_0 = g.core.config.fragment_info
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.bagData
local var_0_4 = g.core.model.User.shopData
local var_0_5 = g.core.common.Path
local var_0_6 = g.core.model.User.commanderWorldData
local CommanderWorldShopItemCell = class("CommanderWorldShopItemCell", require("app.fairyGUI.commanderWorld.UI_CommanderWorldShopItemCell"))

function CommanderWorldShopItemCell:ctor()
	self._info = nil
	self._goods = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0
	self._endTime = 0
	self._qualityEffectIcon = {}

	self:addClickListener(handler(self, self._onShopItemCellClick))
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function CommanderWorldShopItemCell:_onShopItemCellClick(arg_2_1)
	if self.m_touchBg:containPoint((arg_2_1:getInput():getTouch():getLocation())) then
		if self._goods then
			self._goods.component = self.m_item

			g.core.common.GlobalFunc.pushInfoPop(self._goods)
		end
	else
		self:_onBuy()
	end
end

function CommanderWorldShopItemCell:_onBuy()
	if not self._info then
		return
	end

	if self._isBuy then
		if not self._isEnough then
			if self._costType == 999 and self._costValue == 0 then
				if self._costPrice <= self._costHasNum + g.core.model.User:getGold() then
					g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
						title = g.core.lang:get(111026),
						desc1 = g.core.lang:get(409601, {
							num = self._costPrice - self._costHasNum,
							name = var_0_2:convert({
								type = 999,
								value = 1
							}).name
						}),
						onConfirm = handler(self, function()
							g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
								gold = self._costPrice - self._costHasNum
							})
						end)
					}))
				else
					g.view.entrance.ModuleGotoProxy:gotoRechargeQuickPop({
						type = 0,
						needSize = self._costPrice - (self._costHasNum + g.core.model.User:getGold())
					})
				end
			elseif self._costType == 999 and self._costValue == 1 then
				g.view.entrance.ModuleGotoProxy:gotoRechargeQuickPop({
					type = 1,
					needSize = self._costPrice - self._costHasNum
				})
			else
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = self._costType,
					value = self._costValue,
					size = self._costHasNum,
					needSize = self._costPrice,
					curSize = self._costHasNum
				})
			end
		else
			self:addPopup(require("app.view.module.commanderWorld.view.CommanderWorldBuyPop").new(self._info))
		end
	end
end

function CommanderWorldShopItemCell:updateItemCell(arg_5_1)
	self._info = arg_5_1.info
	self._goods = var_0_2:convert({
		type = self._info.type,
		value = self._info.value,
		size = self._info.size
	})

	if not self._goods then
		return
	end

	self._goods.hideNum = false

	self.m_qualityBg:setURL(var_0_5:getUserIconQualityStarBg(self._goods.quality))
	self.m_item:setURL(self._goods.icon)
	self.m_num:setText(self._info.size)

	if self._goods.type == var_0_2.TYPE_EQUIP then
		self:updateEquipQualityEffect(self._goods.quality, self._goods.value)
	else
		self:updateEquipQualityEffect(0)
	end

	self.m_nameTxt:setText(self._goods.name)
	self:_updateCost(self._info)
	self:_updateTipsText(self._info)
	self.m_LUStateController:setSelectedIndex(0)

	if self._info.type == var_0_2.TYPE_FRAGMENT then
		local var_5_0 = var_0_0.get(self._info.value)
		local var_5_1 = var_5_0.fragment_type

		if var_5_0.fragment_type ~= var_0_2.FRAGMENT.TYPE_KNIGHT then
			self.m_isFragController:setSelectedIndex(1)
		else
			self.m_isFragController:setSelectedIndex(0)
		end

		if var_5_1 == var_0_2.FRAGMENT.TYPE_ARTIFACT then
			local var_5_2 = g.core.model.User.artifactData:getArtifactByBaseId(var_5_0.fragment_value)

			if var_5_2 and var_5_2:isLineup() then
				self.m_LUStateController:setSelectedIndex(2)
			end
		end

		if var_5_1 == var_0_2.TYPE_EQUIP then
			self:updateEquipQualityEffect(var_5_0.quality, var_5_0.fragment_value)
		else
			self:updateEquipQualityEffect(0)
		end
	elseif self._info.type == var_0_2.TYPE_ARTIFACT then
		local var_5_3 = g.core.model.User.artifactData:getArtifactByBaseId(self._info.value)

		if var_5_3 and var_5_3:isLineup() then
			self.m_LUStateController:setSelectedIndex(2)
		end
	else
		self.m_isFragController:setSelectedIndex(0)
	end
end

function CommanderWorldShopItemCell:updateEquipQualityEffect(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_6_0]:setVisible(false)
	end

	if arg_6_1 >= var_0_1.UR and arg_6_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_6_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_6_2] or self.m_effectIcon:addEffectSpine({
			scale = 0.25,
			anim = "play",
			isLoop = true,
			name = "eff_ui_equipment_128_" .. arg_6_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_6_2]:setVisible(true)
	end
end

function CommanderWorldShopItemCell:_updateTipsText(arg_7_1)
	local var_7_0 = var_0_6:getBuyLimitLeft(arg_7_1)

	if var_7_0 ~= nil and self._info.price_type_1 > 0 then
		self.m_tips:setText(g.core.lang:get(self._info.reset == 1 and 107061 or 410314) .. " " .. g.core.lang:get(var_7_0 > 0 and 107056 or 107060, {
			num = var_7_0,
			maxNum = self._info.buy_num
		}))
		self.m_tips:setVisible(true)
		self.m_tipBg:setVisible(true)
	elseif self._info.type == var_0_2.TYPE_FRAGMENT then
		local var_7_1, var_7_2, var_7_3 = var_0_4:getFragNumInfo(self._info)

		if var_7_1 then
			if var_7_3 > 0 then
				self.m_tips:setText(g.core.lang:get(var_7_2 > 0 and 107039 or 107054, {
					num1 = g.core.lang:getFormatNumText(var_7_2),
					num2 = g.core.lang:getFormatNumText(var_7_3)
				}))
			else
				self.m_tips:setText(g.core.lang:get(107040, {
					num1 = g.core.lang:getFormatNumText(var_7_2)
				}))
			end
		end

		self.m_tips:setVisible(var_7_1)
		self.m_tipBg:setVisible(var_7_1)
	else
		self.m_tips:setVisible(false)
		self.m_tipBg:setVisible(false)
	end

	if not var_7_0 or var_7_0 > 0 then
		self._isBuy = true

		self.m_isUnBuyController:setSelectedIndex(0)
	else
		self._isBuy = false

		self.m_isUnBuyController:setSelectedIndex(1)
	end
end

function CommanderWorldShopItemCell:_updateCost(arg_8_1)
	self._isEnough = true

	local function var_8_0(arg_9_0, arg_9_1)
		local var_9_0 = var_0_3:getOwnNum(arg_8_1["price_type_" .. arg_9_1], arg_8_1["price_value_" .. arg_9_1])

		self._costPrice = arg_9_0

		if var_9_0 < arg_9_0 then
			self._costType = arg_8_1["price_type_" .. arg_9_1]
			self._costValue = arg_8_1["price_value_" .. arg_9_1]
			self._costHasNum = var_9_0
			self._isEnough = false
		end
	end

	self.m_cornerController:setSelectedIndex(0)
	self.m_cornerTxt:setText("")

	if arg_8_1.price_type_1 <= 0 then
		self.m_typeController:setSelectedIndex(4)
	else
		for iter_8_0 = 1, 2 do
			local var_8_1, var_8_2 = var_0_6:getBuyItemPrice(arg_8_1, 1, iter_8_0)

			if var_8_2 ~= 0 and var_8_2 ~= 100 then
				self.m_typeController:setSelectedIndex(2)
				self.m_cornerController:setSelectedIndex(3)
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = var_8_2
				}))

				if arg_8_1["price_type_" .. iter_8_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						discount = true,
						showLack = true,
						type = arg_8_1["price_type_" .. iter_8_0],
						value = arg_8_1["price_value_" .. iter_8_0],
						size = var_8_1
					})
					var_8_0(var_8_1, iter_8_0)
				end
			elseif iter_8_0 == 1 then
				if arg_8_1["price_type_" .. iter_8_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						discount = false,
						showLack = true,
						type = arg_8_1["price_type_" .. iter_8_0],
						value = arg_8_1["price_value_" .. iter_8_0],
						size = var_8_1
					})
					var_8_0(var_8_1, iter_8_0)
				end
			elseif arg_8_1["price_type_" .. iter_8_0] > 0 then
				self.m_twoCostComp:updateByTVS({
					discount = false,
					showLack = true,
					type = arg_8_1["price_type_" .. iter_8_0],
					value = arg_8_1["price_value_" .. iter_8_0],
					size = var_8_1
				})
				var_8_0(var_8_1, iter_8_0)

				if arg_8_1.price == 0 then
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

return CommanderWorldShopItemCell
