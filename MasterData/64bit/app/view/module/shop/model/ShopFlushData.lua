local ShopFlushData = class("ShopFlushData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.shop_flush_info
local var_0_2 = g.core.config.buy_price_info
local var_0_3 = g.core.config.play_num_info
local var_0_4 = g.core.config.buy_vipnum_info
local var_0_5 = g.core.config.shop_flush_time_info
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.model.User.bagData

function ShopFlushData:ctor()
	self:initData()
end

function ShopFlushData:initData()
	self._lastUpdateTime = {}
	self._shopFlushInfo = {}
	self._lastFreeFreshTime = 0
	self._priceInfo = {}
	self._vipInfo = {}
	self._nextAutoFreshTime = 0
	self._score = 0
	self._isBuyTip = {}
	self._isBuyTip[1] = {}
	self._isBuyTip[999] = {}
	self._knightFragRecommandMap = {}
	self._uniteTokenFragRecommandMap = {}
	self._fileCache = 0
	self._isRecommand = {}
	self._isGoldCostTip = {}
	self._shopIgnoreRedPoint = {}
	self._ignoreArtifactShopRedPoint = false
	self._ignorePetShopRedPoint = false

	self:initPriceInfo()
	self:initVipInfo()
	self:_initFileCache()
end

function ShopFlushData:hasData(arg_3_1)
	if self._shopFlushInfo[arg_3_1] and next(self._shopFlushInfo[arg_3_1]) then
		return true
	end

	return false
end

function ShopFlushData:isExpired(arg_4_1)
	if arg_4_1 == var_0_6.SHOP_FLUSH_TYPE.MYSTERY or arg_4_1 == var_0_6.SHOP_FLUSH_TYPE.ARTIFACT or arg_4_1 == var_0_6.SHOP_FLUSH_TYPE.PET then
		local var_4_0 = g.core.common.ServerTime:getTime()

		if self._lastUpdateTime[arg_4_1] < var_4_0 then
			local var_4_1 = g.core.common.ServerTime:secondsFromToday(self._lastUpdateTime[arg_4_1])

			return var_4_0 >= self._lastUpdateTime[arg_4_1] - var_4_1 + ((var_4_1 > 0 or nil) and (ShopFlushData.SECONDS_ONE_DAY or 0))
		end
	elseif arg_4_1 == var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME then
		return self:getShopLeftTime(arg_4_1) <= 0 or self:getScoreLeftTime() <= 0
	end

	return false
end

function ShopFlushData:updateShopFlushInfo(arg_5_1)
	if arg_5_1 and arg_5_1.shop_id then
		self._shopFlushInfo[arg_5_1.shop_id] = arg_5_1.shop
		self._lastUpdateTime[arg_5_1.shop_id] = g.core.common.ServerTime:getTime()
	end
end

function ShopFlushData:getShopFlushInfo(arg_6_1)
	return self._shopFlushInfo[arg_6_1]
end

function ShopFlushData:setBuyFlag(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 ~= 3 then
		self._isBuyTip[arg_7_1][arg_7_2] = arg_7_3
	end
end

function ShopFlushData:getBuyFlag(arg_8_1, arg_8_2)
	if arg_8_1 == 3 then
		return true
	else
		return self._isBuyTip[arg_8_1][arg_8_2]
	end
end

function ShopFlushData:setRecommandFlag(arg_9_1, arg_9_2)
	self._isRecommand[arg_9_1] = arg_9_2
end

function ShopFlushData:getRecommandFlag(arg_10_1)
	return checkbool(self._isRecommand[arg_10_1])
end

function ShopFlushData:setGoldCostTip(arg_11_1, arg_11_2)
	self._isGoldCostTip[arg_11_1] = arg_11_2
end

function ShopFlushData:getGoldCostTip(arg_12_1)
	return checkbool(self._isGoldCostTip[arg_12_1])
end

function ShopFlushData:initPriceInfo()
	for iter_13_0 = 1, var_0_2.getLength() do
		local var_13_0 = var_0_2.indexOf(iter_13_0)

		self._priceInfo[var_13_0.id] = self._priceInfo[var_13_0.id] or {}
		self._priceInfo[var_13_0.id][#self._priceInfo[var_13_0.id] + 1] = var_13_0
	end
end

function ShopFlushData:initVipInfo()
	for iter_14_0 = 1, var_0_4.getLength() do
		local var_14_0 = var_0_4.indexOf(iter_14_0)

		self._vipInfo[var_14_0.id] = self._vipInfo[var_14_0.id] or {}
		self._vipInfo[var_14_0.id][#self._vipInfo[var_14_0.id] + 1] = var_14_0
	end
end

function ShopFlushData:getPriceInfo(arg_15_1, arg_15_2)
	if self._priceInfo[arg_15_1] then
		local var_15_0 = 1

		for iter_15_0, iter_15_1 in ipairs(self._priceInfo[arg_15_1]) do
			var_15_0 = var_15_0 + 1

			if var_15_0 < #self._priceInfo[arg_15_1] then
				if arg_15_2 >= iter_15_1.num and arg_15_2 < self._priceInfo[arg_15_1][var_15_0].num then
					return iter_15_1.price
				end
			else
				return iter_15_1.price
			end
		end
	end

	return 0
end

function ShopFlushData:getLimitShopScore()
	if not self._shopFlushInfo[var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME] then
		return 0
	end

	return self._shopFlushInfo[var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME].score
end

function ShopFlushData:setLastFreeFreshTime(arg_17_1)
	self._lastFreeFreshTime = arg_17_1
end

function ShopFlushData:getLastFreeFreshTime()
	return
end

function ShopFlushData:setNextAutoFreshTime(arg_19_1)
	self._nextAutoFreshTime = arg_19_1
end

function ShopFlushData:getNextAutoFreshTime()
	return self._nextAutoFreshTime
end

function ShopFlushData:getShopLeftTime(arg_21_1)
	if not self._shopFlushInfo[arg_21_1] then
		return 0
	end

	return self._shopFlushInfo[arg_21_1].goods_flush_time - g.core.common.ServerTime:getTime()
end

function ShopFlushData:getShopFlushTime(arg_22_1)
	if not self._shopFlushInfo[arg_22_1] then
		return 0
	end

	return self._shopFlushInfo[arg_22_1].goods_flush_time
end

function ShopFlushData:getScoreLeftTime()
	if not self._shopFlushInfo[var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME] then
		return 0
	end

	return self._shopFlushInfo[var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME].score_flush_time - g.core.common.ServerTime:getTime()
end

function ShopFlushData:getConsumeItem(arg_24_1, arg_24_2)
	local var_24_0 = var_0_1.get(arg_24_1)
	local var_24_1 = g.core.common.Goods:convert({
		type = var_24_0.flush_cost_type_1,
		value = var_24_0.flush_cost_value_1,
		size = var_24_0.flush_cost_size_1
	})

	if var_24_0.flush_cost_type_1 == 999 then
		local var_24_2 = g.core.model.User:getFreeGold()

		if var_24_0.flush_cost_size_1 <= var_24_2 then
			return {
				isFlush = true,
				type = 1,
				icon = var_24_1.icon_mini,
				size = var_24_0.flush_cost_size_1,
				costType = var_24_0.flush_cost_type_1,
				costValue = var_24_0.flush_cost_value_1,
				costSize = var_24_2
			}
		else
			return {
				isFlush = false,
				type = 1,
				icon = var_24_1.icon_mini,
				size = var_24_0.flush_cost_size_1,
				costType = var_24_0.flush_cost_type_1,
				costValue = var_24_0.flush_cost_value_1,
				costSize = var_24_2
			}
		end
	elseif var_24_0.flush_cost_type_1 ~= 0 then
		local var_24_3 = var_0_7:getOwnNum(var_24_0.flush_cost_type_1, var_24_0.flush_cost_value_1)

		if var_24_0.flush_cost_size_1 <= var_24_3 then
			return {
				isFlush = true,
				type = 1,
				icon = var_24_1.icon_mini,
				size = var_24_0.flush_cost_size_1,
				costType = var_24_0.flush_cost_type_1,
				costValue = var_24_0.flush_cost_value_1,
				costSize = var_24_3
			}
		elseif var_24_0.flush_cost_type_2 > 0 then
			var_24_3 = var_0_7:getOwnNum(var_24_0.flush_cost_type_2, var_24_0.flush_cost_value_2)
			var_24_1 = g.core.common.Goods:convert({
				type = var_24_0.flush_cost_type_2,
				value = var_24_0.flush_cost_value_2,
				size = var_24_0.flush_cost_size_2
			})

			if var_24_0.flush_cost_size_2 <= var_24_3 then
				return {
					isFlush = true,
					type = 2,
					icon = var_24_1.icon_mini,
					size = var_24_0.flush_cost_size_2,
					costType = var_24_0.flush_cost_type_2,
					costValue = var_24_0.flush_cost_value_2,
					costSize = var_24_3
				}
			elseif var_24_0.flush_cost_type_3 > 0 then
				var_24_1 = g.core.common.Goods:convert({
					type = var_24_0.flush_cost_type_3,
					value = var_24_0.flush_cost_value_3,
					size = var_24_0.flush_cost_size_3
				})

				if var_24_0.flush_cost_type_3 == g.core.common.Goods.TYPE_GOLD then
					local var_24_4 = g.core.model.User:getFreeGold()

					if var_24_0.flush_cost_size_3 <= var_24_4 then
						return {
							isFlush = true,
							type = 3,
							icon = var_24_1.icon_mini,
							size = var_24_0.flush_cost_size_3,
							costType = var_24_0.flush_cost_type_3,
							costValue = var_24_0.flush_cost_value_3,
							costSize = var_24_4
						}
					else
						return {
							isFlush = false,
							type = 3,
							icon = var_24_1.icon_mini,
							size = var_24_0.flush_cost_size_3,
							costType = var_24_0.flush_cost_type_3,
							costValue = var_24_0.flush_cost_value_3,
							costSize = var_24_4
						}
					end
				else
					var_24_3 = var_0_7:getOwnNum(var_24_0.flush_cost_type_3, var_24_0.flush_cost_value_3)

					if var_24_0.flush_cost_size_3 <= var_24_3 then
						return {
							isFlush = true,
							type = 3,
							icon = var_24_1.icon_mini,
							size = var_24_0.flush_cost_size_3,
							costType = var_24_0.flush_cost_type_3,
							costValue = var_24_0.flush_cost_value_3,
							costSize = var_24_3
						}
					else
						return {
							isFlush = false,
							type = 3,
							icon = var_24_1.icon_mini,
							size = var_24_0.flush_cost_size_3,
							costType = var_24_0.flush_cost_type_3,
							costValue = var_24_0.flush_cost_value_3,
							costSize = var_24_3
						}
					end
				end
			else
				return {
					isFlush = false,
					type = 2,
					icon = var_24_1.icon_mini,
					size = var_24_0.flush_cost_size_2,
					costType = var_24_0.flush_cost_type_2,
					costValue = var_24_0.flush_cost_value_2,
					costSize = var_24_3
				}
			end
		else
			return {
				isFlush = false,
				type = 1,
				icon = var_24_1.icon_mini,
				size = var_24_0.flush_cost_size_1,
				costType = var_24_0.flush_cost_type_1,
				costValue = var_24_0.flush_cost_value_1,
				costSize = var_24_3
			}
		end
	elseif var_24_0.flush_cost_type_1 == 0 then
		if var_24_0.manual_flush_num_id ~= 0 then
			local var_24_5 = var_0_3.get(var_24_0.manual_flush_num_id)

			if var_24_5.price_type == 999 then
				local var_24_6 = g.core.common.Path:getIconByTypeValue(var_24_5.price_type, var_24_5.price_value, true)
				local var_24_7 = self:getPriceInfo(var_24_5.price_add_id, arg_24_2 + 1)
				local var_24_8 = g.core.model.User:getFreeGold()

				if var_24_7 <= var_24_8 then
					return {
						isFlush = true,
						type = 1,
						icon = var_24_6,
						size = var_24_7,
						costType = var_24_5.price_type,
						costValue = var_24_5.price_value,
						costSize = var_24_7
					}
				else
					return {
						isFlush = false,
						type = 1,
						icon = var_24_6,
						size = var_24_7,
						costType = var_24_5.price_type,
						costValue = g.core.common.Goods.RESOURCE.TYPE_FREE_GOLD,
						costSize = var_24_8
					}
				end
			end
		end
	end

	return {
		icon = "",
		isFlush = false,
		size = "",
		type = 0
	}
end

function ShopFlushData:getFreshNumByHand(arg_25_1)
	local var_25_0 = var_0_3.get(var_0_1.get(arg_25_1).manual_flush_num_id)
	local var_25_1 = self:getFreshNumByVipLv(var_25_0.buy_vip_num, (g.core.model.User:getVipLevel()))

	if var_25_1 == 0 then
		var_25_1 = var_25_0.reset
	end

	return var_25_1
end

function ShopFlushData:getFreshNumByVipLv(arg_26_1, arg_26_2)
	if self._vipInfo[arg_26_1] then
		local var_26_0 = 1

		for iter_26_0, iter_26_1 in ipairs(self._vipInfo[arg_26_1]) do
			if var_26_0 < #self._vipInfo[arg_26_1] then
				if arg_26_2 >= iter_26_1.vip and arg_26_2 < self._vipInfo[arg_26_1][var_26_0].vip then
					return iter_26_1.max_buy_num
				end

				if var_26_0 == 1 and arg_26_2 <= iter_26_1.vip then
					return iter_26_1.max_buy_num
				end
			elseif arg_26_2 >= iter_26_1.vip then
				return iter_26_1.max_buy_num
			end

			var_26_0 = var_26_0 + 1
		end
	end

	return 0
end

function ShopFlushData:getUserMaxFlushNum(arg_27_1)
	local var_27_0 = g.core.model.User:getVipLevel()

	if self._vipInfo[arg_27_1] then
		for iter_27_0 = 1, #self._vipInfo[arg_27_1] do
			if var_27_0 <= self._vipInfo[arg_27_1][iter_27_0].vip then
				return self._vipInfo[arg_27_1][iter_27_0].max_buy_num
			end
		end

		return self._vipInfo[arg_27_1][#self._vipInfo[arg_27_1]].max_buy_num
	end

	return 0
end

function ShopFlushData:isCanHandFlush(arg_28_1)
	if self._vipInfo[arg_28_1] then
		if #self._vipInfo[arg_28_1] == 1 then
			if self._vipInfo[arg_28_1][1].vip == 999 and self._vipInfo[arg_28_1][1].max_buy_num == 0 then
				return false
			end
		else
			return true
		end
	end

	return false
end

function ShopFlushData:getAutoFreshTime(arg_29_1)
	local var_29_0 = var_0_1.get(arg_29_1).auto_flush_time_id
	local var_29_1 = {}

	if var_29_0 ~= 0 then
		for iter_29_0 = 1, var_0_5.getLength() do
			local var_29_2 = var_0_5.indexOf(iter_29_0)

			if var_29_2.flush_id == var_29_0 then
				table.insert(var_29_1, var_29_2)
			end
		end
	end

	return var_29_1
end

function ShopFlushData:getCurAutoFreshTime(arg_30_1)
	local var_30_0 = g.core.common.ServerTime:getDateObject()
	local var_30_1 = self:getAutoFreshTime(arg_30_1)
	local var_30_2 = 1

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		if iter_30_1.flush_type == 1 then
			if iter_30_0 == 1 and var_30_0.hour < iter_30_1.hour then
				return var_30_0.hour
			end

			var_30_2 = var_30_2 + 1

			if var_30_2 <= #var_30_1 then
				if var_30_0.hour >= iter_30_1.hour and var_30_0.hour < var_30_1[var_30_2].hour then
					return var_30_1[var_30_2].hour
				end
			end
		end
	end

	return 0
end

function ShopFlushData:getAutoFreshDesc(arg_31_1)
	local var_31_0 = self:getAutoFreshTime(arg_31_1)
	local var_31_1 = ""
	local var_31_2 = ""
	local var_31_3 = ""
	local var_31_4 = 1

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_1.flush_type == 1 then
			var_31_4 = iter_31_1.flush_type
			var_31_1 = var_31_1 == "" and iter_31_1.hour .. g.core.lang:get(1087) or var_31_1 .. "、" .. iter_31_1.hour .. g.core.lang:get(1087)
		else
			var_31_4 = iter_31_1.flush_type
			var_31_2 = var_31_2 == "" and iter_31_1.day or iter_31_0 ~= #var_31_0 and var_31_2 .. "、" .. iter_31_1.day or var_31_2 .. "、" .. iter_31_1.day .. g.core.lang:get(1085)
			var_31_1 = var_31_1 == "" and iter_31_1.hour .. g.core.lang:get(1087) or var_31_1 .. "、" .. iter_31_1.hour .. g.core.lang:get(1087)
		end
	end

	if var_31_4 == 1 then
		var_31_3 = g.core.lang:get(1086, {
			time = var_31_1
		})
	elseif var_31_4 == 2 then
		var_31_3 = g.core.lang:get(1096, {
			time = var_31_2 .. var_31_1
		})
	else
		local var_31_5 = {}

		var_31_5.time = var_31_2 .. var_31_1
		var_31_3 = g.core.lang:get(1088, var_31_5)
	end

	return var_31_3
end

function ShopFlushData:getFreeFlushNumLimit(arg_32_1)
	local var_32_0 = var_0_1.get(arg_32_1).manual_free_num_id

	for iter_32_0 = 1, g.core.config.basic_figure_info.getLength() do
		local var_32_1 = g.core.config.basic_figure_info.indexOf(iter_32_0)

		if var_32_1.value == var_32_0 then
			return var_32_1.max_limit
		end
	end

	return 0
end

function ShopFlushData:getFreeFlushCdTime(arg_33_1)
	local var_33_0 = var_0_1.get(arg_33_1).manual_free_num_id

	for iter_33_0 = 1, g.core.config.basic_figure_info.getLength() do
		local var_33_1 = g.core.config.basic_figure_info.indexOf(iter_33_0)

		if var_33_1.value == var_33_0 then
			return var_33_1.unit_time
		end
	end

	return 0
end

function ShopFlushData:updateRecommandData()
	self:_updateKnightRecommandData()
	self:_updateUniteTokenRecommandData()
end

function ShopFlushData:_updateKnightRecommandData()
	self._knightFragRecommandMap = {}

	local function var_35_0(arg_36_0, arg_36_1)
		if not self._knightFragRecommandMap[arg_36_0] or arg_36_1 < self._knightFragRecommandMap[arg_36_0] then
			self._knightFragRecommandMap[arg_36_0] = arg_36_1
		end
	end

	local var_35_1 = g.core.model.User.knightsData:getFormationKnights()

	for iter_35_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_BACKUP_MAX do
		local var_35_2 = g.core.model.User.knightsData:getKnight({
			id = var_35_1[iter_35_0]
		})

		if var_35_2 then
			local var_35_3 = var_35_2:getBaseInfo()

			if var_35_2:isLineup() then
				var_35_0(var_35_3.advance_id, g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_LINE_UP)

				for iter_35_1 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASSCT_MAX do
					if var_35_3["association_" .. iter_35_1] > 0 then
						local var_35_4 = g.core.config.knight_association_info.get(var_35_3["association_" .. iter_35_1])

						if var_35_4 and var_35_4.type == 1 then
							for iter_35_2 = 1, g.core.const.ConstMgr.KNIGHT_CONST.ASS_COND_MAX do
								if var_35_4["value_" .. iter_35_2] > 0 then
									if not g.core.model.User.knightsData:getKnightByAdvanceId(var_35_4["value_" .. iter_35_2]):isOwn() then
										var_35_0(var_35_4["value_" .. iter_35_2], g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_ASSOCIATION)
									end
								end
							end
						end
					end
				end
			elseif var_35_2:isBackup() then
				var_35_0(var_35_3.advance_id, g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_BACKUP)
			end
		end
	end

	for iter_35_3, iter_35_4 in pairs(self._knightFragRecommandMap) do
		if g.core.model.User.knightsData:getKnightByAdvanceId(iter_35_3):isMaxStar() then
			self._knightFragRecommandMap[iter_35_3] = nil
		end
	end
end

function ShopFlushData:_updateUniteTokenRecommandData()
	self._uniteTokenFragRecommandMap = {}

	local function var_37_0(arg_38_0, arg_38_1)
		if not self._uniteTokenFragRecommandMap[arg_38_0] or arg_38_1 < self._uniteTokenFragRecommandMap[arg_38_0] then
			self._uniteTokenFragRecommandMap[arg_38_0] = arg_38_1
		end
	end

	for iter_37_0, iter_37_1 in ipairs((g.core.model.User.uniteTokenData:getTokenList())) do
		if iter_37_1:isLineup() and not iter_37_1:isMaxStarLevel() then
			var_37_0(iter_37_1:getAdvanceId(), g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.UNITETOKEN_LINE_UP)
		end
	end
end

function ShopFlushData:getRecommandItemDesc(arg_39_1)
	if not arg_39_1 then
		return false
	end

	self:updateRecommandData()

	local var_39_0 = arg_39_1.type
	local var_39_1 = arg_39_1.value

	if arg_39_1.type == g.core.common.Goods.TYPE_FRAGMENT then
		local var_39_2 = g.core.config.fragment_info.get(arg_39_1.value)

		var_39_0 = var_39_2.fragment_type
		var_39_1 = var_39_2.fragment_value
	end

	if var_39_0 == g.core.common.Goods.TYPE_KNIGHT then
		local var_39_3 = ""
		local var_39_4 = self._knightFragRecommandMap[var_39_1]

		if self._knightFragRecommandMap[var_39_1] == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_LINE_UP then
			var_39_3 = g.core.lang:get(1094)
		elseif var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_ASSOCIATION then
			var_39_3 = g.core.lang:get(1091)
		elseif var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_AWAKE_UNITETOKEN then
			var_39_3 = g.core.lang:get(1095)
		elseif var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_BACKUP then
			var_39_3 = g.core.lang:get(1093)
		end

		return var_39_3, var_39_4, var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_LINE_UP and 0 or (var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_BACKUP or var_39_4 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.KNIGHT_ASSOCIATION) and 1 or 2
	elseif var_39_0 == g.core.common.Goods.TYPE_UNITETOKEN then
		local var_39_6 = ""
		local var_39_7 = self._uniteTokenFragRecommandMap[var_39_1]

		if self._uniteTokenFragRecommandMap[var_39_1] == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.UNITETOKEN_LINE_UP then
			var_39_6 = g.core.lang:get(1094)
		elseif var_39_7 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.UNITETOKEN_AWAKE then
			var_39_6 = g.core.lang:get(1092)
		end

		return var_39_6, var_39_7, var_39_7 == g.core.const.ConstMgr.ShopConst.RECOMMAND_TYPE.UNITETOKEN_LINE_UP and 0 or 2
	end

	return ""
end

function ShopFlushData:isCanFreeFlush(arg_40_1)
	if g.core.config.shop_flush_info.get(arg_40_1).manual_free_num_id ~= 0 then
		return true
	else
		return false
	end
end

function ShopFlushData:_initFileCache()
	self._fileCache = g.core.common.Storage:load("shop_flush.json") or {}
end

function ShopFlushData:updateLastFlushTime()
	self._fileCache = self._fileCache or {}
	self._fileCache.lastFlushTime = self:getShopFlushTime(var_0_6.SHOP_FLUSH_TYPE.LIMIT_TIME)

	g.core.common.Storage:save("shop_flush.json", self._fileCache)
end

function ShopFlushData:getLastFlushTime()
	return (self._fileCache or {}).lastFlushTime or 0
end

function ShopFlushData:setIgnoreShopRedPoint(arg_44_1)
	self._shopIgnoreRedPoint[arg_44_1] = true
end

function ShopFlushData:isIgnoreShopRedPoint(arg_45_1)
	if not self._shopIgnoreRedPoint[arg_45_1] then
		return false
	end

	return self._shopIgnoreRedPoint[arg_45_1]
end

function ShopFlushData:ignoreArtifactShopRedPoint()
	self._ignoreArtifactShopRedPoint = true
end

function ShopFlushData:isIgnoreArtifactShopRedPoint()
	return self._ignoreArtifactShopRedPoint
end

function ShopFlushData:ignorePetShopRedPoint()
	self._ignorePetShopRedPoint = true
end

function ShopFlushData:isIgnorePetShopRedPoint()
	return self._ignorePetShopRedPoint
end

return ShopFlushData
