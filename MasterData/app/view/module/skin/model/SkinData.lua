local SkinData = class("SkinData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.skin_info
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.const.ConstMgr.CensorConst
local var_0_5 = g.core.config.knight_info
local var_0_6 = g.core.model.User

function SkinData:ctor()
	self:initData()
end

function SkinData:initData()
	self._inited = false
	self._bookInfo = {}
	self._handBookData = {}
	self._allHandBookData = {}
	self._hasDressSkinData = nil
	self._gmActivitySkinData = {}
	self._gmActivitySkinIdMap = {}
	self._skinThemeList = {}
end

function SkinData:initSkinData()
	local var_3_0 = g.core.model.User.knightsData:getMainKnight()

	if not var_3_0 then
		return
	end

	self._handBookData = {}
	self._allHandBookData = {}
	self._bookInfo = {}
	self._inited = true

	local var_3_1 = var_3_0:getAdvanceId()

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_2 = var_0_1.indexOf(iter_3_0)
		local var_3_3 = var_0_5.get(var_3_2.knight_advance_id)

		if (var_3_3.type ~= 1 or var_3_3.advance_id == var_3_1) and g.core.utils.Tools.isOpIdMatchWithInfo(var_3_2, var_0_1) then
			if var_3_2.put > 0 then
				self._bookInfo[var_3_2.knight_advance_id] = self._bookInfo[var_3_2.knight_advance_id] or {}

				table.insert(self._bookInfo[var_3_2.knight_advance_id], var_3_2)

				self._handBookData[var_3_3.group] = self._handBookData[var_3_3.group] or {}

				table.insert(self._handBookData[var_3_3.group], var_3_2)
				table.insert(self._allHandBookData, var_3_2)
			elseif self:getActivitySkinById(var_3_2.id) and self:isActivitySkinInShowTime(var_3_2.id) or self:getSkinState(var_3_2.id) == 1 then
				self._bookInfo[var_3_2.knight_advance_id] = self._bookInfo[var_3_2.knight_advance_id] or {}

				table.insert(self._bookInfo[var_3_2.knight_advance_id], var_3_2)

				self._handBookData[var_3_3.group] = self._handBookData[var_3_3.group] or {}

				table.insert(self._handBookData[var_3_3.group], var_3_2)
				table.insert(self._allHandBookData, var_3_2)
			end
		end
	end

	self._hasDressSkinData = g.core.common.Storage:load("knight_has_new_skin.json", g.core.model.User:getId()) or {}
end

function SkinData:getKnightSkins(arg_4_1)
	self:initSkinData()

	if self._bookInfo[arg_4_1] then
		table.sort(self._bookInfo[arg_4_1], function(arg_5_0, arg_5_1)
			local var_5_0 = self:getSkinState(arg_5_0.id)
			local var_5_1 = self:getSkinState(arg_5_1.id)

			var_5_0 = var_5_0 == 1 and 0 or var_5_0 == 2 and 1 or 2
			var_5_1 = var_5_1 == 1 and 0 or var_5_1 == 2 and 1 or 2

			return var_5_0 < var_5_1
		end)
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self._bookInfo[arg_4_1] or {}) do
		if not g.core.model.User.homeData:checkItemIsInUnputList("skin_info", iter_4_1.id) and not g.core.model.User.homeData:checkReverseCensorItem(var_0_3.CENSOR_TYPE.SKIN, iter_4_1.id) then
			var_4_0[#var_4_0 + 1] = iter_4_1
		end
	end

	return var_4_0
end

function SkinData:getOwnKnightSkins(arg_6_1)
	self:initSkinData()

	if self._bookInfo[arg_6_1] then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(self._bookInfo[arg_6_1]) do
			if self:getSkinState(iter_6_1.id) == 1 then
				table.insert(var_6_0, iter_6_1)
			end
		end

		return var_6_0
	end

	return {}
end

function SkinData:getAllKnightSkin()
	self:initSkinData()

	if self._allHandBookData then
		table.sort(self._allHandBookData, function(arg_8_0, arg_8_1)
			local var_8_0 = self:getSkinState(arg_8_0.id)
			local var_8_1 = self:getSkinState(arg_8_1.id)

			var_8_0 = var_8_0 == 1 and 0 or var_8_0 == 2 and 1 or 2
			var_8_1 = var_8_1 == 1 and 0 or var_8_1 == 2 and 1 or 2

			if var_8_0 ~= var_8_1 then
				return var_8_0 < var_8_1
			elseif arg_8_0.quality ~= arg_8_1.quality then
				return arg_8_0.quality > arg_8_1.quality
			else
				return arg_8_0.id > arg_8_1.id
			end
		end)
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self._allHandBookData or {}) do
		if not g.core.model.User.homeData:checkItemIsInUnputList("skin_info", iter_7_1.id) and not g.core.model.User.homeData:checkReverseCensorItem(var_0_3.CENSOR_TYPE.SKIN, iter_7_1.id) then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	return var_7_0
end

function SkinData:_sortSkinDatas(arg_9_1)
	local var_9_0 = g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.SKIN)
	local var_9_1 = g.core.common.ServerTime:getTime()

	table.sort(arg_9_1, function(arg_10_0, arg_10_1)
		local var_10_0 = false
		local var_10_1 = false
		local var_10_2 = true
		local var_10_3 = true
		local var_10_6 = self:isWorn(arg_10_0.id)
		local var_10_7 = self:isWorn(arg_10_1.id)

		for iter_10_0, iter_10_1 in ipairs(var_9_0) do
			if iter_10_1.id == arg_10_0.id then
				var_10_0 = true

				if iter_10_1.ts > var_9_1 or iter_10_1.ts == 0 then
					var_10_2 = false
				end
			end

			if iter_10_1.id == arg_10_1.id then
				var_10_1 = true

				if iter_10_1.ts > var_9_1 or iter_10_1.ts == 0 then
					var_10_3 = false
				end
			end
		end

		local var_10_8 = 0
		local var_10_9 = 0

		if var_10_0 and not var_10_2 then
			var_10_8 = 0
		elseif var_10_0 and var_10_2 then
			var_10_8 = 1
		elseif not var_10_0 then
			var_10_8 = 2
		end

		if var_10_6 then
			var_10_8 = -1
		end

		if var_10_1 and not var_10_3 then
			var_10_9 = 0
		elseif var_10_1 and var_10_3 then
			var_10_9 = 1
		elseif not var_10_1 then
			var_10_9 = 2
		end

		if var_10_7 then
			var_10_9 = -1
		end

		if var_10_8 == var_10_9 then
			return arg_10_0.quality > arg_10_1.quality
		else
			return var_10_8 < var_10_9
		end
	end)
end

function SkinData:newSortWeight(arg_11_1)
	table.sort(arg_11_1, function(arg_12_0, arg_12_1)
		local var_12_0 = self:getSkinState(arg_12_0.id)
		local var_12_1 = self:getSkinState(arg_12_1.id)

		var_12_0 = var_12_0 == 1 and 0 or var_12_0 == 2 and 1 or 2
		var_12_1 = var_12_1 == 1 and 0 or var_12_1 == 2 and 1 or 2

		local var_12_2 = g.core.config.skin_info.get(arg_12_0.id)
		local var_12_3 = g.core.config.skin_info.get(arg_12_1.id)
		local var_12_4 = var_12_2.limit == 1
		local var_12_5 = var_12_3.limit == 1
		local var_12_6 = var_12_2.quality
		local var_12_7 = var_12_3.quality

		local function var_12_8()
			if var_12_4 and var_12_5 then
				if var_12_6 == var_12_7 then
					return arg_12_0.id > arg_12_1.id
				else
					return var_12_6 > var_12_7
				end
			elseif not var_12_4 and var_12_5 then
				return false
			elseif var_12_4 and not var_12_5 then
				return true
			elseif not var_12_4 and not var_12_5 then
				if var_12_6 == var_12_7 then
					return arg_12_0.id > arg_12_1.id
				else
					return var_12_6 > var_12_7
				end
			end
		end

		if var_12_0 == var_12_1 then
			if var_12_0 == 0 then
				local var_12_9 = self:isWorn(arg_12_0.id)
				local var_12_10 = self:isWorn(arg_12_1.id)

				if var_12_9 and var_12_10 then
					return var_12_8()
				elseif var_12_9 and not var_12_10 then
					return true
				elseif not var_12_9 and var_12_10 then
					return false
				elseif not var_12_9 and not var_12_10 then
					return var_12_8()
				end
			elseif var_12_0 == 1 then
				return false
			elseif var_12_0 == 2 then
				return var_12_8()
			end
		else
			return var_12_0 < var_12_1
		end
	end)
end

function SkinData:getKnightSkinsByGroup(arg_14_1)
	self:_sortSkinDatas(self._handBookData[arg_14_1])

	return self._handBookData[arg_14_1]
end

function SkinData:getSkinState(arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.SKIN) or {}) do
		if arg_15_1 == iter_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if not var_15_0 then
		return 0
	end

	if self:getActivitySkinById(arg_15_1) then
		if var_15_0 then
			return 1
		end
	else
		local var_15_1 = var_15_0.ts

		if var_15_0.ts > g.core.common.ServerTime:getTime() or var_15_1 == 0 then
			return 1, var_15_1
		else
			return 2
		end
	end
end

function SkinData:isWorn(arg_16_1)
	local var_16_0 = var_0_1.fetch(arg_16_1)

	if var_16_0 then
		local var_16_1 = g.core.model.User.knightsData:getKnightByAdvanceId(var_16_0.knight_advance_id)

		if var_16_1 then
			local var_16_2 = var_16_1:getInfo()

			if var_16_2 and var_16_2.skin and var_16_2.skin == arg_16_1 and var_16_2.skin_ts and (var_16_2.skin_ts == 0 or var_16_2.skin_ts > g.core.common.ServerTime:getTime()) then
				return true
			end
		end
	end

	return false
end

function SkinData:createSkinBookDataByWearStatusAndGroup(arg_17_1, arg_17_2)
	if not arg_17_1 then
		return self._handBookData[arg_17_2]
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self._handBookData[arg_17_2]) do
		if not self:isWorn(iter_17_1.id) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	self:_sortSkinDatas(var_17_0)

	return var_17_0
end

function SkinData:isNewSkin(arg_18_1)
	self:initSkinData()

	if arg_18_1.skinId then
		return self:getSkinState(arg_18_1.skinId) == 1 and not self:hasSkinDress(arg_18_1.skinId)
	end

	return false
end

function SkinData:hasNewSkinByAdvanceId(arg_19_1)
	self:initSkinData()

	if arg_19_1.advId then
		if self._bookInfo[arg_19_1.advId] then
			for iter_19_0, iter_19_1 in pairs(self._bookInfo[arg_19_1.advId]) do
				if self:getSkinState(iter_19_1.id) == 1 and not self:hasSkinDress(iter_19_1.id) then
					return true
				end
			end
		end
	end

	return false
end

function SkinData:setSkinDress(arg_20_1)
	if self._hasDressSkinData == nil then
		self._hasDressSkinData = g.core.common.Storage:load("knight_has_new_skin.json", g.core.model.User:getId()) or {}
	end

	if not self._hasDressSkinData[tostring(arg_20_1)] then
		self._hasDressSkinData[tostring(arg_20_1)] = true

		g.core.common.Storage:save("knight_has_new_skin.json", self._hasDressSkinData, g.core.model.User:getId())
	end
end

function SkinData:hasSkinDress(arg_21_1)
	if self._hasDressSkinData == nil then
		self._hasDressSkinData = g.core.common.Storage:load("knight_has_new_skin.json", g.core.model.User:getId()) or {}
	end

	return self._hasDressSkinData[tostring(arg_21_1)]
end

function SkinData:getThemeStr(arg_22_1)
	arg_22_1 = tonumber(arg_22_1)

	if arg_22_1 == 1 then
		return g.core.lang:get(204008)
	elseif arg_22_1 == 2 then
		return g.core.lang:get(204009)
	elseif arg_22_1 == 3 then
		return g.core.lang:get(204010)
	elseif arg_22_1 == 4 then
		return g.core.lang:get(204011)
	elseif arg_22_1 == 5 then
		return g.core.lang:get(204016)
	elseif arg_22_1 == 6 then
		return g.core.lang:get(204019)
	elseif arg_22_1 == 7 then
		return g.core.lang:get(204020)
	elseif arg_22_1 == 8 then
		return g.core.lang:get(204023)
	end

	return ""
end

function SkinData:getSkinOwnAndWearState(arg_23_1)
	local var_23_0 = 0
	local var_23_1 = self:getSkinState(arg_23_1)

	if var_23_1 == 0 or var_23_1 == 2 then
		var_23_0 = 0
	elseif var_23_1 == 1 then
		if self:isWorn(arg_23_1) then
			var_23_0 = 3
		else
			var_23_0 = 2

			if not self:isOwnCurKnightForSkin(arg_23_1) then
				var_23_0 = 1
			end
		end
	end

	return var_23_0
end

function SkinData:isOwnCurKnightForSkin(arg_24_1)
	local var_24_0 = var_0_1.fetch(arg_24_1)

	if var_24_0 then
		local var_24_2 = g.core.model.User.knightsData:getKnightByAdvanceId(var_24_0.knight_advance_id)

		if var_24_2 and var_24_2:isOwn() then
			return true
		end
	end

	return false
end

function SkinData:getSkinAllStateAtSkinShop(arg_25_1)
	local var_25_0 = 0

	if self:getSkinState(arg_25_1) == 1 then
		var_25_0 = not self:isOwnCurKnightForSkin(arg_25_1) and 1 or self:isWorn(arg_25_1) and 3 or 4
	else
		if self:isWeddingSkin(arg_25_1) then
			return 5
		end

		if self:getActivitySkinById(arg_25_1) then
			if self:isActivitySkinInSellTime(arg_25_1) then
				return 0
			else
				return 2
			end
		else
			local var_25_1 = var_0_6.skinGoodsData:getShinGoodsBySkinId(arg_25_1)

			var_25_0 = var_25_1 and var_25_1.isInTime and var_25_1.sale_value ~= 3 and 0 or 2
		end
	end

	return var_25_0
end

function SkinData:getSkinAllStateForOwnKnight(arg_26_1, arg_26_2)
	if arg_26_2.knightInfo then
		local var_26_0 = arg_26_1:getInfo()

		if not var_26_0.skin or var_26_0.skin == 0 or var_26_0.skin and var_26_0.skin > 0 and var_26_0.skin_ts < g.core.common.ServerTime:getTime() and var_26_0.skin_ts ~= 0 then
			return var_0_2.SKIN_STATE.STATE_1
		else
			return var_0_2.SKIN_STATE.STATE_0
		end
	elseif arg_26_2.skinInfo then
		if self:getSkinState(arg_26_2.skinInfo.id) == 1 then
			if self:isWorn(arg_26_2.skinInfo.id) then
				return var_0_2.SKIN_STATE.STATE_4
			else
				return var_0_2.SKIN_STATE.STATE_5
			end
		else
			if self:isWeddingSkin(arg_26_2.skinInfo.id) then
				return var_0_2.SKIN_STATE.STATE_6
			end

			if self:getActivitySkinById(arg_26_2.skinInfo.id) then
				if self:isActivitySkinInSellTime(arg_26_2.skinInfo.id) then
					return var_0_2.SKIN_STATE.STATE_2
				else
					return var_0_2.SKIN_STATE.STATE_3
				end
			else
				local var_26_1 = var_0_6.skinGoodsData:getShinGoodsBySkinId(arg_26_2.skinInfo.id)

				if var_26_1 and var_26_1.isInTime and var_26_1.sale_value ~= 3 then
					return var_0_2.SKIN_STATE.STATE_2
				else
					return var_0_2.SKIN_STATE.STATE_3
				end
			end
		end
	end
end

function SkinData:updateGMSkinData(arg_27_1)
	self._gmActivitySkinData = {}
	self._gmActivitySkinIdMap = {}

	local var_27_0 = g.core.common.ServerTime:getOpenDays()

	if arg_27_1 and arg_27_1.infos then
		if not arg_27_1.infos or #arg_27_1.infos <= 0 then
			return
		end

		for iter_27_0, iter_27_1 in ipairs(arg_27_1.infos) do
			local var_27_1 = clone(iter_27_1)
			local var_27_2 = g.core.config.skin_shop_info.fetch(iter_27_1.id) or {}
			local var_27_3 = var_27_2.skin_id

			var_27_1.skinId = var_27_2.skin_id
			var_27_1.isAtOpenServerTime = false

			if var_27_3 and iter_27_1.open_days and iter_27_1.open_days ~= 0 and var_27_0 >= iter_27_1.open_days then
				var_27_1.isAtOpenServerTime = true
				var_27_1.isInShowTime = false

				if self:isActivitySkinInShowTime(nil, iter_27_1) then
					table.insert(self._gmActivitySkinData, var_27_1)

					self._gmActivitySkinIdMap[var_27_3] = var_27_1
					var_27_1.isInShowTime = true
					var_27_1.isInSellTime = false

					if self:isActivitySkinInSellTime(var_27_3) then
						var_27_1.isInSellTime = true
					end

					var_27_1.isInDiscountTime = false

					if self:isActivitySkinInDiscountTime(var_27_3) then
						var_27_1.isInDiscountTime = true
					end

					var_27_1.discountValue = string.split(tostring(math.ceil((iter_27_1.original_price - iter_27_1.discount_price) / iter_27_1.original_price * 100)), ".")[1]
				end
			end
		end
	end
end

function SkinData:isActivitySkinLevelReach(arg_28_1, arg_28_2)
	local var_28_0 = self._gmActivitySkinIdMap[arg_28_1] or arg_28_2

	if var_28_0 then
		if var_28_0.show_level then
			return g.core.model.User:getLevel() >= var_28_0.show_level
		else
			return true
		end
	end

	return false
end

function SkinData:isActivitySkinInShowTime(arg_29_1, arg_29_2)
	local var_29_0 = self._gmActivitySkinIdMap[arg_29_1] or arg_29_2

	if var_29_0 then
		if var_29_0 then
			local var_29_1, var_29_2 = self:getGmSkinIsInTime(var_29_0.start_time, var_29_0.end_time)

			return var_29_1, var_29_2
		end

		return false, 0
	end

	return false
end

function SkinData:isActivitySkinInSellTime(arg_30_1, arg_30_2)
	local var_30_0 = self._gmActivitySkinIdMap[arg_30_1] or arg_30_2

	if var_30_0 then
		local var_30_1, var_30_2 = self:getGmSkinIsInTime(var_30_0.sale_start_time, var_30_0.sale_end_time)

		return var_30_1, var_30_2
	end

	return false, 0
end

function SkinData:isActivitySkinInDiscountTime(arg_31_1, arg_31_2)
	if not self:isActivitySkinInSellTime(arg_31_1) then
		return false, 0
	end

	local var_31_0 = self._gmActivitySkinIdMap[arg_31_1] or arg_31_2

	if var_31_0 and var_31_0 then
		local var_31_1, var_31_2 = self:getGmSkinIsInTime(var_31_0.discount_start_time, var_31_0.discount_end_time)

		return var_31_1, var_31_2
	end

	return false, 0
end

function SkinData:getActivitySkinById(arg_32_1)
	return self._gmActivitySkinIdMap[arg_32_1]
end

function SkinData:getActivityAllSkin()
	return self._gmActivitySkinData
end

function SkinData:getSkinTypeById(arg_34_1)
	if self._gmActivitySkinIdMap[arg_34_1] then
		return g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.GM_SKIN
	else
		return g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.DIRECT_BUY
	end
end

function SkinData:getGmSkinState(arg_35_1)
	local var_35_0 = 0

	if self:getSkinState(arg_35_1) == 1 then
		var_35_0 = 1
	else
		local var_35_1 = self._gmActivitySkinIdMap[arg_35_1]

		if self._gmActivitySkinIdMap[arg_35_1] and var_35_1.gmActivityInfo then
			local var_35_2, var_35_3 = self:isActivitySkinInDiscountTime(var_35_1.gmActivityInfo.skinId)

			if var_35_2 then
				var_35_0 = 4
			end

			local var_35_4, var_35_5 = self:isActivitySkinInSellTime(var_35_1.gmActivityInfo.skinId)

			if var_35_4 then
				var_35_0 = 3
			end

			if not var_35_2 and not var_35_4 then
				var_35_0 = self:isActivitySkinInShowTime(arg_35_1) and 5 or 2
			end
		end
	end

	return var_35_0
end

function SkinData:getGmSkinEndTime(arg_36_1)
	if self._gmActivitySkinIdMap[arg_36_1] then
		local var_36_0, var_36_1 = self:isActivitySkinInDiscountTime(arg_36_1)
		local var_36_2, var_36_3 = self:isActivitySkinInSellTime(arg_36_1)

		if var_36_0 and var_36_1 > 0 then
			return self._gmActivitySkinIdMap[arg_36_1].discount_end_time
		elseif var_36_2 and var_36_3 > 0 then
			return self._gmActivitySkinIdMap[arg_36_1].sale_end_time
		end
	end

	return 0
end

function SkinData:getGMSkinSellEndTime(arg_37_1)
	if self._gmActivitySkinIdMap[arg_37_1] then
		local var_37_0, var_37_1 = self:isActivitySkinInSellTime(arg_37_1)

		if var_37_0 and var_37_1 > 0 then
			return self._gmActivitySkinIdMap[arg_37_1].sale_end_time
		end
	end

	return 0
end

function SkinData:getGMSkinDiscountEndTime(arg_38_1)
	if self._gmActivitySkinIdMap[arg_38_1] then
		local var_38_0, var_38_1 = self:isActivitySkinInDiscountTime(arg_38_1)

		if var_38_0 and var_38_1 > 0 then
			return self._gmActivitySkinIdMap[arg_38_1].discount_end_time
		end
	end

	return 0
end

function SkinData:getGmSkinBuyState(arg_39_1)
	local var_39_0 = self:getActivitySkinById(arg_39_1)

	if not var_39_0 then
		return 2
	end

	local var_39_1 = self:getGmSkinState(var_39_0.skinId)
	local var_39_2 = 0

	if var_39_1 == 0 then
		var_39_2 = self:isActivitySkinInSellTime(var_39_0.skinId) and 1 or 2
	elseif var_39_1 == 2 then
		var_39_2 = 2
	end

	return var_39_2
end

function SkinData:getGmSkinCurMoney(arg_40_1)
	local var_40_0 = self:getActivitySkinById(arg_40_1)
	local var_40_1, var_40_2 = self:isActivitySkinInDiscountTime(arg_40_1)

	if var_40_1 then
		return var_40_0.discount_price
	else
		return var_40_0.original_price
	end
end

function SkinData:getGmSkinIsInTime(arg_41_1, arg_41_2)
	local var_41_0 = g.core.common.ServerTime:getTime()
	local var_41_1 = false
	local var_41_2 = 0

	if not arg_41_1 or arg_41_1 == 0 then
		var_41_1 = false
	elseif arg_41_1 and (not arg_41_2 or arg_41_2 == 0) then
		if arg_41_1 < var_41_0 then
			var_41_1 = true
			var_41_2 = -1
		end
	elseif arg_41_1 <= var_41_0 and var_41_0 < arg_41_2 then
		var_41_1 = true
		var_41_2 = arg_41_2
	end

	return var_41_1, var_41_2
end

function SkinData:isSkinTimeLimit(arg_42_1)
	local var_42_0 = self:getSkinTypeById(arg_42_1)

	if self:getSkinState(arg_42_1) == 1 then
		return false
	end

	local var_42_1 = false

	if var_42_0 == g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.GM_SKIN then
		if self:getGmSkinEndTime(arg_42_1) > 0 then
			var_42_1 = true
		end
	elseif var_42_0 == g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.DIRECT_BUY then
		local var_42_2 = var_0_6.skinGoodsData:getShinGoodsBySkinId(arg_42_1)

		if var_42_2 and var_42_2.time_limit == 1 then
			var_42_1 = true
		end
	end

	return var_42_1
end

function SkinData:isSkinTimeLimitAndDiscount(arg_43_1)
	return self:isSkinTimeLimit(arg_43_1) and self:isActivitySkinInDiscountTime(arg_43_1)
end

function SkinData:isSkinTimeLimitAndSell(arg_44_1)
	return self:isSkinTimeLimit(arg_44_1) and self:isActivitySkinInSellTime(arg_44_1)
end

function SkinData:isWeddingSkin(arg_45_1)
	return g.core.model.User.weddingData:isWeddingSkin(arg_45_1)
end

function SkinData:checkRelatedSkinAdvance()
	local var_46_0 = g.core.common.ServerTime:getTime()
	local var_46_1 = {}
	local var_46_2 = {}

	for iter_46_0, iter_46_1 in ipairs((g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.SKIN))) do
		local var_46_3 = iter_46_1.id
		local var_46_4 = var_0_1.get(iter_46_1.id)

		if (iter_46_1.ts == 0 or var_46_0 < iter_46_1.ts) and not g.core.model.User.homeData:checkItemIsInUnputList("skin_info", iter_46_1.id) and var_46_4.put == 1 and not g.core.model.User.homeData:checkReverseCensorItem(var_0_3.CENSOR_TYPE.SKIN, iter_46_1.id) then
			local var_46_6 = var_46_1[var_46_4.skin_advance]

			if not var_46_1[var_46_4.skin_advance] then
				var_46_6 = {}
				var_46_1[var_46_4.skin_advance] = var_46_6
			end

			var_46_6[var_46_3] = true
		end

		var_46_2[iter_46_1.id] = true
	end

	local var_46_7 = {}

	for iter_46_2 = 1, var_0_1.getLength() do
		local var_46_8 = var_0_1.indexOf(iter_46_2)

		if var_46_1[var_46_8.skin_advance] and not var_46_1[var_46_8.skin_advance][var_46_8.id] then
			var_46_7[#var_46_7 + 1] = var_46_8.skin_advance
		end
	end

	return var_46_7
end

return SkinData
