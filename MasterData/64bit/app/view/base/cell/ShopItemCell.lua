local ShopItemCell = class("ShopItemCell", require("app.fairyGUI.base_new.UI_ShopItemCell"))
local var_0_1 = g.core.model.User.cultivateDataMgr
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.model.User.shopData
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.common.ServerTime
local var_0_8 = g.core.common.Path
local var_0_9 = g.core.config.fragment_info

function ShopItemCell:ctor()
	self._info = nil
	self._goodInfo = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0
	self._endTime = 0
	self._fixSize = nil
	self._qualityEffectIcon = {}

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self:_addListeners()
	self.m_comfortGroup:setVisible(false)
	self.m_comfortIconLoader:setURL((var_0_8:getIconByTypeValue(var_0_3.TYPE_RESOURCE, var_0_3.RESOURCE.TYPE_COMFORT, true)))

	if self.m_attentCheckBtn and self.m_attentCheckBtn then
		self.m_attentGroup:setVisible(false)
		self.m_attentCheckBtn:setVisible(false)
	end
end

function ShopItemCell:_addListeners()
	self:addClickListener(handler(self, self._onShopItemCellClick))

	if self.m_attentCheckBtn then
		self.m_attentCheckBtn:addClickListener(handler(self, self._onClickAttentBtn))
	end
end

function ShopItemCell:setIconSize(arg_3_1)
	self.m_oneCostComp:setIconSize(arg_3_1)
	self.m_twoCostComp:setIconSize(arg_3_1)

	self._fixSize = arg_3_1
end

function ShopItemCell:_removeListeners()
	self:removeClickListener(1)
end

function ShopItemCell:_onShopItemCellClick(arg_5_1)
	local var_5_0 = arg_5_1:getInput():getTouch():getLocation()

	if self.m_touchBg:containPoint(var_5_0) then
		if self._goodInfo then
			self._goodInfo.component = self.m_item

			g.core.common.GlobalFunc.pushInfoPop(self._goodInfo)
		end
	elseif self.m_buyBg then
		if self.m_buyBg:containPoint(var_5_0) then
			self:_onBuy()
		end
	else
		self:_onBuy()
	end
end

function ShopItemCell:_onBuy()
	if not self._info then
		return
	end

	if self._isBuy and self._isShopUnLock then
		local var_6_0 = var_0_5:getShopInfoByScoreInfo({
			shop_type = self._info.shop_type,
			shop_first = self._info.shop_first,
			shop_second = self._info.shop_second
		})

		if self._info.price == 0 and not self._isEnough then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._costType,
				value = self._costValue,
				size = self._costHasNum,
				needSize = self._costPrice,
				curSize = self._costHasNum
			})
		elseif self._info.price_type_1 == 0 then
			g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
				cost_idx = 0,
				info = {
					num = 1,
					id = self._info.id
				},
				shop_id = var_6_0.id
			})
		elseif self._fixSize then
			require("app.view.base.component.BaseBuyPop").createShop(self._info, false, var_6_0):fixIconSize(self._fixSize)
		end
	elseif not self._isShopUnLock then
		g.core.module.ModuleManager:tip(self._shopUnlockText)
	elseif not self._isBuy then
		g.core.module.ModuleManager:tip(self.m_limitTxt:getText())
	end
end

function ShopItemCell:onLoad()
	return
end

function ShopItemCell:updateCell(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	self._info = arg_8_1
	self._shopInfo = arg_8_3
	self._isShopUnLock = arg_8_4 ~= false
	self._goodInfo = var_0_3:convert({
		type = arg_8_1.type,
		value = arg_8_1.value,
		size = arg_8_1.size
	})

	if not self._goodInfo then
		return
	end

	if arg_8_6 then
		self.m_bgStateController:setSelectedIndex(2)
		self.m_itemBg:setURL(var_0_8:getCultivateImage("pic_mnzj_shopkuang", var_0_1:getResDirId(var_0_1:getCultivateData(arg_8_6):getActivityCfg().id)))
		self.m_qualityBg:setURL(var_0_8:getWitchQualityStarBg(self._goodInfo.quality))
	else
		self.m_bgStateController:setSelectedIndex(arg_8_5 or 0)
		self.m_qualityBg:setURL(var_0_8:getUserIconQualityStarBg(self._goodInfo.quality))
	end

	self._goodInfo.hideNum = false

	self.m_item:setURL(self._goodInfo.icon)
	self.m_num:setText(arg_8_1.size)

	if self._goodInfo.type == var_0_3.TYPE_EQUIP then
		self:updateEquipQualityEffect(self._goodInfo.quality, self._goodInfo.value)
	else
		self:updateEquipQualityEffect(0)
	end

	self.m_nameTxt:setText(self._goodInfo.name)
	self:_updateCost(arg_8_1)
	self:_updateTipsText(arg_8_1)

	if self.m_attentGroup then
		self.m_attentGroup:setVisible(false)
	end

	if arg_8_1.type == var_0_3.TYPE_FURNITURE then
		self.m_comfortTxt:setText(tostring(self._goodInfo.info.comfort))
		self.m_comfortGroup:setVisible(true)
	else
		self.m_isFragController:setSelectedIndex(0)
		self.m_comfortGroup:setVisible(false)
	end

	self.m_LUStateController:setSelectedIndex(0)

	if arg_8_1.type == var_0_3.TYPE_FRAGMENT then
		local var_8_0 = var_0_9.get(self._info.value)
		local var_8_1 = var_8_0.fragment_type

		if var_8_0.fragment_type ~= var_0_3.FRAGMENT.TYPE_KNIGHT then
			self.m_isFragController:setSelectedIndex(1)
		else
			self.m_isFragController:setSelectedIndex(0)
		end

		if var_8_1 == var_0_3.FRAGMENT.TYPE_ARTIFACT then
			local var_8_2 = g.core.model.User.artifactData:getArtifactByBaseId(var_8_0.fragment_value)

			if var_8_2 and var_8_2:isLineup() then
				self.m_LUStateController:setSelectedIndex(2)
			end
		end

		if var_8_1 == var_0_3.TYPE_EQUIP then
			self:updateEquipQualityEffect(var_8_0.quality, var_8_0.fragment_value)
		else
			self:updateEquipQualityEffect(0)
		end
	elseif arg_8_1.type == var_0_3.TYPE_ARTIFACT then
		local var_8_3 = g.core.model.User.artifactData:getArtifactByBaseId(arg_8_1.value)

		if var_8_3 and var_8_3:isLineup() then
			self.m_LUStateController:setSelectedIndex(2)
		end
	else
		self.m_isFragController:setSelectedIndex(0)
	end

	if arg_8_1.type == var_0_3.TYPE_ITEM then
		local var_8_4 = g.core.model.User.weddingData:getWeddingSpRingAdvId(arg_8_1.value)

		if var_8_4 > 0 then
			self.m_showWeddingController:setSelectedIndex(1)
			self.m_weddingKnight:updateIconComp(var_8_4)
		else
			self.m_showWeddingController:setSelectedIndex(0)
		end
	else
		self.m_showWeddingController:setSelectedIndex(0)
	end

	if arg_8_1.end_times ~= 0 then
		self.m_isTimeLimitController:setSelectedIndex(1)

		self._endTime = os.time((var_0_5:numberToDate(arg_8_1.end_times)))

		self:_refreshTime()

		self._timeSchedule = self:newSchedule(handler(self, self._refreshTime), 1)
	else
		self.m_isTimeLimitController:setSelectedIndex(0)

		if self._timeSchedule then
			self:cancelSchedule(self._timeSchedule)

			self._timeSchedule = nil
		end
	end

	if self._shopInfo then
		if self._shopInfo.shop_type == var_0_6.SHOP_TYPE.SHOP_CAR and self._isShopUnLock then
			self.m_attentGroup:setVisible(true)
			self.m_attentNameTxt:setText(var_0_5:getShopInfoByScoreInfo({
				shop_type = arg_8_1.shop_type,
				shop_first = arg_8_1.shop_first,
				shop_second = arg_8_1.shop_second
			}).quick_name)
			self.m_cornerController:setSelectedIndex(0)
			self.m_isFragController:setSelectedIndex(0)
			self.m_comfortGroup:setVisible(false)
			self.m_LUStateController:setSelectedIndex(0)
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SHOP_CAR) and checkbool(self._shopInfo.quick_purchase == 1) and self._isShopUnLock then
			if self.m_attentCheckBtn then
				self.m_attentCheckBtn:setVisible(true)
				self.m_attentCheckBtn:setSelected((var_0_5:isShopItemFollow(arg_8_1.id)))
			end
		elseif self.m_attentCheckBtn then
			self.m_attentCheckBtn:setSelected(false)
			self.m_attentCheckBtn:setVisible(false)
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self,
		customData = {
			scoreInfo = arg_8_1
		}
	})
end

function ShopItemCell:updateEquipQualityEffect(arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_9_0]:setVisible(false)
	end

	if arg_9_1 >= var_0_2.UR and arg_9_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_9_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_9_2] or self.m_effectIcon:addEffectSpine({
			isLoop = true,
			anim = "play",
			scale = 0.25,
			name = "eff_ui_equipment_128_" .. arg_9_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_9_2]:setVisible(true)
	end
end

function ShopItemCell:_refreshTime()
	self.m_limitTimeTxt:setText((var_0_7:getLeftDHMSFormat(self._endTime)))
end

function ShopItemCell:_updateTipsText(arg_11_1)
	local var_11_0 = var_0_5:getBuyLimitLeft(arg_11_1)

	if var_11_0 ~= nil and self._info.price_type_1 > 0 then
		local var_11_2 = 107061

		if arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.LIFELONG then
			var_11_2 = 107063
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.WEEK then
			var_11_2 = 107062
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.MONTH then
			var_11_2 = 107064
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.SEASON then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.MINE_SEASON then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.CHIEF_ARENA_SEASON then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.GUILD_WAR then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.GVE then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.TEAM_PVP then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.EXPLORATION then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.RED_CLIFF then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.BOUNTY then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.TEAM_BATTLE then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.NEW_SLG then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.PUBG then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.SPIRE then
			var_11_2 = 107074
		elseif arg_11_1.num_ban_type == var_0_6.NUM_BAN_TYPE.ANCIENTS then
			var_11_2 = 107074
		end

		self.m_tips:setText(g.core.lang:get(var_11_2) .. " " .. g.core.lang:get(var_11_0 > 0 and 107056 or 107060, {
			num = var_11_0,
			maxNum = var_0_5:getBuyLimit(arg_11_1)
		}))
		self.m_tips:setVisible(true)
		self.m_tipBg:setVisible(true)
	elseif self._info.type == var_0_3.TYPE_FRAGMENT then
		local var_11_3, var_11_4, var_11_5 = var_0_5:getFragNumInfo(self._info)

		if var_11_3 then
			if var_11_5 > 0 then
				self.m_tips:setText(g.core.lang:get(var_11_4 > 0 and 107039 or 107054, {
					num1 = g.core.lang:getFormatNumText(var_11_4),
					num2 = g.core.lang:getFormatNumText(var_11_5)
				}))
			else
				self.m_tips:setText(g.core.lang:get(107040, {
					num1 = g.core.lang:getFormatNumText(var_11_4)
				}))
			end
		end

		self.m_tips:setVisible(var_11_3)
		self.m_tipBg:setVisible(var_11_3)
	else
		self.m_tips:setVisible(false)
		self.m_tipBg:setVisible(false)
	end

	if not var_11_0 or var_11_0 > 0 then
		if arg_11_1.buy_ban_type > 0 and var_0_5:checkBuyBan(arg_11_1) then
			self.m_limitTxt:setText(var_0_5:getShopBuyBanText(arg_11_1.buy_ban_type, arg_11_1.buy_ban_value, arg_11_1.buy_ban_key) or "")
			self.m_isUnBuyController:setSelectedIndex(1)
			self.m_cornerController:setSelectedIndex(0)

			self._isBuy = false
		elseif var_11_0 and var_11_0 > 0 then
			self.m_isUnBuyController:setSelectedIndex(0)

			self._isBuy = true
		else
			self.m_isUnBuyController:setSelectedIndex(0)

			self._isBuy = true
		end
	else
		self.m_isUnBuyController:setSelectedIndex(1)
		self.m_limitTxt:setText(g.core.lang:get(107004))

		self._isBuy = not not var_0_5:getBuyNextVip(arg_11_1.buy_vip_num)
	end

	self._shopUnlockText = self._isShopUnLock and "" or var_0_5:getShopUnlockText(self._shopInfo.open_type, self._shopInfo.open_value)

	if not self._isBuy and self._isShopUnLock or self._info.price_type_1 > 0 then
		self.m_freeTxt:setVisible(false)
	elseif self._info.price_type_1 <= 0 then
		self.m_freeTxt:setVisible(true)
	end

	self.m_isShopUnLockController:setSelectedIndex(self._isShopUnLock and 1 or 0)
end

function ShopItemCell:_updateCost(arg_12_1)
	self._isEnough = true

	local function var_12_0(arg_13_0, arg_13_1)
		local var_13_0 = var_0_4:getOwnNum(arg_12_1["price_type_" .. arg_13_1], arg_12_1["price_value_" .. arg_13_1])

		self._costPrice = arg_13_0

		if var_13_0 < arg_13_0 then
			self._costType = arg_12_1["price_type_" .. arg_13_1]
			self._costValue = arg_12_1["price_value_" .. arg_13_1]
			self._costHasNum = var_13_0
			self._isEnough = false
		end
	end

	self.m_cornerController:setSelectedIndex(0)
	self.m_cornerTxt:setText("")

	if arg_12_1.price_type_1 <= 0 then
		self.m_typeController:setSelectedIndex(4)
	else
		for iter_12_0 = 1, var_0_6.COST_MAX_NUM do
			local var_12_1, var_12_2, var_12_3 = var_0_5:getBuyItemPrice(arg_12_1, 1, iter_12_0)

			if var_12_2 ~= 0 and var_12_2 ~= 100 then
				self.m_typeController:setSelectedIndex(2)
				self.m_cornerController:setSelectedIndex(3)
				self.m_cornerTxt:setText(g.core.lang:get(107030, {
					num = var_12_2
				}))

				if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN then
					self.m_cornerTxt:setText(g.core.lang:get(107030, {
						num = 100 - var_12_2
					}) .. g.core.lang:get(406513))
				elseif config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
					self.m_cornerTxt:setText(g.core.lang:get(107030, {
						num = 100 - var_12_2
					}) .. "OFF")
				end

				if arg_12_1["price_type_" .. iter_12_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						showLack = true,
						discount = true,
						type = arg_12_1["price_type_" .. iter_12_0],
						value = arg_12_1["price_value_" .. iter_12_0],
						size = var_12_1,
						oldSize = var_12_3
					})
					var_12_0(var_12_1, iter_12_0)
				end
			elseif iter_12_0 == 1 then
				if arg_12_1["price_type_" .. iter_12_0] > 0 then
					self.m_oneCostComp:updateByTVS({
						showLack = true,
						discount = false,
						type = arg_12_1["price_type_" .. iter_12_0],
						value = arg_12_1["price_value_" .. iter_12_0],
						size = var_12_1
					})
					var_12_0(var_12_1, iter_12_0)
				end
			elseif arg_12_1["price_type_" .. iter_12_0] > 0 then
				self.m_twoCostComp:updateByTVS({
					showLack = true,
					discount = false,
					type = arg_12_1["price_type_" .. iter_12_0],
					value = arg_12_1["price_value_" .. iter_12_0],
					size = var_12_1
				})
				var_12_0(var_12_1, iter_12_0)

				if arg_12_1.price == 0 then
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

function ShopItemCell:_onClickAttentBtn()
	if var_0_5:isShopItemFollow(self._info.id) then
		g.core.network.GameNetProxy:send_C2S_ShopCar_Unfollow({
			id = self._info.id
		})
	else
		g.core.network.GameNetProxy:send_C2S_ShopCar_Follow({
			id = self._info.id
		})
	end
end

return ShopItemCell
