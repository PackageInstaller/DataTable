local var_0_0 = g.core.model.User.skinData
local SkinGoodsData = class("SkinGoodsData")
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.const.ConstMgr.CensorConst
local var_0_4 = g.core.config.talent_skill_info
local var_0_5 = g.core.config.skin_shop_info
local var_0_6 = g.core.config.skin_info
local var_0_7 = g.core.config.knight_base_info
local var_0_8 = g.core.config.knight_info
local var_0_9 = g.core.config.skin_theme_info

function SkinGoodsData:ctor()
	self:initData()
end

function SkinGoodsData:initData()
	self._isRefreshTime = false
	self._skinGoodsList = {}
	self._skinGoodsIdList = {}
	self._skinGoodsSkinIdList = {}

	self:_initBaseInfo()
	self:refreshInTime(false)
end

function SkinGoodsData:_initBaseInfo()
	for iter_3_0 = 1, var_0_5.getLength() do
		local var_3_0 = self:_packSkinGoodsCfg((var_0_5.indexOf(iter_3_0)))

		if not self._skinGoodsIdList[var_3_0.id] then
			self._skinGoodsIdList[var_3_0.id] = var_3_0
			self._skinGoodsSkinIdList[var_3_0.skin_id] = var_3_0
		end
	end
end

function SkinGoodsData:refreshInTime(arg_4_1)
	if arg_4_1 then
		self._isRefreshTime = true
	end

	self._skinGoodsList = {}

	local var_4_0 = g.core.common.ServerTime:getTime()

	for iter_4_0, iter_4_1 in pairs(self._skinGoodsIdList) do
		self._skinGoodsList[iter_4_1.sale_value] = self._skinGoodsList[iter_4_1.sale_value] or {}

		if iter_4_1.sale_value == var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY then
			if iter_4_1.time_limit ~= 0 then
				local var_4_1 = os.time(iter_4_1.endDate)
				local var_4_2 = var_4_1 - var_4_0

				iter_4_1.isInTime = os.time(iter_4_1.startDate) < var_4_0 and var_4_0 < var_4_1
				iter_4_1.remainingTime = math.ceil(var_4_2 / 86400)
			end

			if iter_4_1.isInTime then
				table.insert(self._skinGoodsList[iter_4_1.sale_value], iter_4_1)
			end
		elseif iter_4_1.sale_value == var_0_2.SHOP_SKIN_TYPE.GM_SKIN then
			local var_4_3 = var_0_0:getActivitySkinById(iter_4_1.skin_id)

			if var_4_3 then
				if var_0_0:isActivitySkinInSellTime(iter_4_1.skin_id) and var_0_0:isActivitySkinLevelReach(iter_4_1.skin_id) then
					local var_4_4 = clone(iter_4_1)

					var_4_4.gmActivityInfo = var_4_3

					table.insert(self._skinGoodsList[iter_4_1.sale_value], var_4_4)
				end
			end
		end
	end
end

function SkinGoodsData:_packSkinGoodsCfg(arg_5_1)
	local var_5_0 = clone(arg_5_1).toObject()
	local var_5_1 = var_0_6.get(var_5_0.skin_id)

	var_5_0.resInfo = var_0_7.get(var_5_1.res).toObject()
	var_5_0.skinInfo = var_5_1.toObject()
	var_5_0.group = var_0_8.get(var_5_1.knight_advance_id).group
	var_5_0.buyTimes = 0
	var_5_0.isInTime = true

	if var_5_0.time_limit ~= 0 then
		var_5_0.startDate = self:_numberToDate(var_5_0.start_times)
		var_5_0.endDate = self:_numberToDate(var_5_0.end_times)
	end

	return var_5_0
end

function SkinGoodsData:_numberToDate(arg_6_1)
	local var_6_0 = {
		year = math.floor(arg_6_1 / 10000)
	}

	var_6_0.month = math.floor((arg_6_1 - 10000 * var_6_0.year) / 100)
	var_6_0.day = arg_6_1 % 100
	var_6_0.hour = 0

	return var_6_0
end

function SkinGoodsData:getSkinGoodsListBySaleValue(arg_7_1, arg_7_2)
	if not self._isRefreshTime then
		self:refreshInTime(true)
	end

	local var_7_0 = g.core.model.User.skinData

	if self._skinGoodsList[arg_7_1] then
		table.sort(self._skinGoodsList[arg_7_1], function(arg_8_0, arg_8_1)
			local var_8_0 = var_7_0:getSkinState(arg_8_0.skin_id)
			local var_8_1 = var_7_0:getSkinState(arg_8_1.skin_id)

			var_8_0 = var_8_0 == 1 and 0 or var_8_0 == 2 and 1 or 2
			var_8_1 = var_8_1 == 1 and 0 or var_8_1 == 2 and 1 or 2

			if var_8_0 ~= var_8_1 then
				return var_8_1 < var_8_0
			else
				return arg_8_0.id > arg_8_1.id
			end
		end)
	end

	local var_7_1 = {}
	local var_7_2 = g.core.model.User.homeData:getCensorList(1) or {}

	for iter_7_0, iter_7_1 in ipairs(self._skinGoodsList[arg_7_1]) do
		if not g.core.model.User.homeData:checkItemIsInUnputList("skin_info", iter_7_1.skin_id) and not (iter_7_1.skin_id > 0 and next(var_7_2) and not g.core.model.User.homeData:checkCensorInfoIsEnable(var_7_2[iter_7_1.skin_id])) then
			var_7_1[#var_7_1 + 1] = iter_7_1
		end
	end

	if arg_7_2 == nil then
		return var_7_1
	else
		local var_7_4 = {}

		for iter_7_2, iter_7_3 in pairs(var_7_1) do
			if self:_isGoodsInScreen(iter_7_3, arg_7_2) then
				table.insert(var_7_4, iter_7_3)
			end
		end

		return var_7_4
	end
end

function SkinGoodsData:_isGoodsInScreen(arg_9_1, arg_9_2)
	local var_9_0 = false
	local var_9_1 = false
	local var_9_2 = false

	if next(arg_9_2.quality) == nil then
		var_9_0 = true
	else
		for iter_9_0, iter_9_1 in pairs(arg_9_2.quality) do
			if arg_9_1.skinInfo.quality == iter_9_1 then
				var_9_0 = true

				break
			end
		end
	end

	if next(arg_9_2.camp) == nil then
		var_9_1 = true
	else
		for iter_9_2, iter_9_3 in pairs(arg_9_2.camp) do
			if arg_9_1.group == iter_9_3 then
				var_9_1 = true

				break
			end
		end
	end

	if next(arg_9_2.theme) == nil then
		var_9_2 = true
	else
		for iter_9_4, iter_9_5 in pairs(arg_9_2.theme) do
			if tonumber(arg_9_1.skinInfo.theme) == iter_9_5 then
				var_9_2 = true

				break
			end
		end
	end

	return var_9_0 and var_9_1 and var_9_2
end

function SkinGoodsData:getShinGoodsById(arg_10_1)
	return self._skinGoodsIdList[arg_10_1]
end

function SkinGoodsData:getShinGoodsBySkinId(arg_11_1)
	return self._skinGoodsSkinIdList[arg_11_1]
end

function SkinGoodsData:getSkinTalentSkillBySkinId(arg_12_1)
	local var_12_0 = ""
	local var_12_1 = ""

	if g.core.model.User.weddingData:isWeddingSkin(arg_12_1) then
		local var_12_2 = g.core.model.User.weddingData:getWeddingSkinAdvId(arg_12_1)
		local var_12_3 = g.core.model.User.weddingData:getFirstFavorInfo(var_12_2)
		local var_12_4 = var_0_4.fetch(var_12_3.talent_all or 0)

		if var_12_4 then
			var_12_0 = var_12_4.description
		end

		local var_12_5 = var_0_4.fetch(var_12_3.talent_self or 0)

		if var_12_5 then
			var_12_1 = g.core.config.knight_info.get(var_12_2).name .. var_12_5.description
		end
	else
		local var_12_6 = var_0_6.fetch(arg_12_1) or {}
		local var_12_7 = var_0_4.fetch(var_12_6.talent_skill or 0)

		if var_12_7 then
			var_12_1 = var_12_6.affect_des
			var_12_0 = var_12_7.description

			if var_12_6.affect_des ~= "" then
				var_12_1 = g.core.config.knight_info.get(var_12_6.knight_advance_id).name .. var_12_1
			end
		end
	end

	return var_12_0, var_12_1
end

function SkinGoodsData:markOldSkin(arg_13_1)
	self._old_skin = self._old_skin or {}
	self._old_skin[tostring(arg_13_1)] = 1
end

function SkinGoodsData:saveOldSkin()
	local var_14_0 = g.core.common.Storage:load("skin_old_record.json") or {}

	if self._old_skin then
		for iter_14_0, iter_14_1 in pairs(self._old_skin) do
			var_14_0[iter_14_0] = iter_14_1
		end
	end

	g.core.common.Storage:save("skin_old_record.json", var_14_0)
end

function SkinGoodsData:isNewSkin(arg_15_1)
	local var_15_0 = g.core.common.Storage:load("skin_old_record.json") or {}
	local var_15_1 = arg_15_1.skinId

	if not arg_15_1.skinId then
		if self._skinGoodsList[1] then
			for iter_15_0, iter_15_1 in pairs(self._skinGoodsList[1]) do
				if not var_15_0[tostring(iter_15_1.skin_id)] then
					return true
				end
			end
		end
	else
		if var_15_0[tostring(var_15_1)] then
			return false
		end

		return true
	end

	return false
end

function SkinGoodsData:getSkinGoodsListByForAllSkin(arg_16_1)
	self:refreshInTime(true)

	local var_16_0 = {}

	if self._skinGoodsList[var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY] then
		for iter_16_0, iter_16_1 in ipairs(self._skinGoodsList[var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY]) do
			table.insert(var_16_0, iter_16_1)
		end
	end

	if self._skinGoodsList[var_0_2.SHOP_SKIN_TYPE.GM_SKIN] then
		for iter_16_2, iter_16_3 in ipairs(self._skinGoodsList[var_0_2.SHOP_SKIN_TYPE.GM_SKIN]) do
			if var_0_0:getActivitySkinById(iter_16_3.skin_id) then
				table.insert(var_16_0, iter_16_3)
			end
		end
	end

	if #var_16_0 > 1 then
		table.sort(var_16_0, function(arg_17_0, arg_17_1)
			local var_17_0 = var_0_0:getSkinState(arg_17_0.skin_id)
			local var_17_1 = var_0_0:getSkinState(arg_17_1.skin_id)
			local var_17_2 = var_17_0 == 0 and var_0_0:isSkinTimeLimitAndDiscount(arg_17_0.skin_id) and 1 or 0
			local var_17_3 = var_17_1 == 0 and var_0_0:isSkinTimeLimitAndDiscount(arg_17_1.skin_id) and 1 or 0
			local var_17_4 = var_17_0 == 0 and var_0_0:isSkinTimeLimitAndSell(arg_17_0.skin_id) and 1 or 0
			local var_17_5 = var_17_1 == 0 and var_0_0:isSkinTimeLimitAndSell(arg_17_1.skin_id) and 1 or 0
			local var_17_6, var_17_7 = var_0_0:isActivitySkinInDiscountTime(arg_17_0.skin_id)
			local var_17_8, var_17_9 = var_0_0:isActivitySkinInDiscountTime(arg_17_1.skin_id)
			local var_17_10 = var_17_0 == 0 and var_17_7 == -1 and 1 or 0
			local var_17_11 = var_17_1 == 0 and var_17_9 == -1 and 1 or 0
			local var_17_12, var_17_13 = var_0_0:isActivitySkinInSellTime(arg_17_0.skin_id)
			local var_17_14, var_17_15 = var_0_0:isActivitySkinInSellTime(arg_17_1.skin_id)
			local var_17_16 = var_17_13 == -1 and var_17_0 == 0 and 1 or 0
			local var_17_17 = var_17_15 == -1 and var_17_1 == 0 and 1 or 0
			local var_17_18 = g.core.config.skin_info.get(arg_17_0.skin_id).limit == 1 and var_17_0 == 0 and 1 or 0
			local var_17_19 = g.core.config.skin_info.get(arg_17_1.skin_id).limit == 1 and var_17_1 == 0 and 1 or 0

			if var_17_2 ~= var_17_3 then
				return var_17_3 < var_17_2
			end

			if var_17_4 ~= var_17_5 then
				return var_17_5 < var_17_4
			end

			if var_17_10 ~= var_17_11 then
				return var_17_11 < var_17_10
			end

			if var_17_16 ~= var_17_17 then
				return var_17_17 < var_17_16
			end

			if var_17_18 ~= var_17_19 then
				return var_17_19 < var_17_18
			end

			if var_17_0 == 1 and var_17_1 == 1 and arg_17_0.limit ~= arg_17_1.limit then
				return arg_17_0.limit > arg_17_1.limit
			elseif var_17_0 ~= var_17_1 then
				return var_17_0 < var_17_1
			end
		end)
	end

	local var_16_1 = {}

	for iter_16_4, iter_16_5 in ipairs(var_16_0) do
		if not g.core.model.User.homeData:checkItemIsInUnputList("skin_info", iter_16_5.skin_id) and not g.core.model.User.homeData:checkReverseCensorItem(var_0_3.CENSOR_TYPE.SKIN, iter_16_5.skin_id) then
			var_16_1[#var_16_1 + 1] = iter_16_5
		end
	end

	local var_16_2 = var_16_1

	if arg_16_1 == nil then
		return var_16_2
	else
		local var_16_3 = {}

		for iter_16_6, iter_16_7 in pairs(var_16_2) do
			if self:_isGoodsInScreen(iter_16_7, arg_16_1) then
				table.insert(var_16_3, iter_16_7)
			end
		end

		return var_16_3
	end

	return var_16_2
end

function SkinGoodsData:isCanTicketBuy(arg_18_1)
	if arg_18_1.gmActivityInfo and arg_18_1.gmActivityInfo.skin_item_start_time and arg_18_1.gmActivityInfo.skin_item_start_time > 0 then
		local var_18_0 = g.core.common.ServerTime:getTime()

		if arg_18_1.gmActivityInfo.skin_item_start_time <= var_18_0 then
			if not arg_18_1.gmActivityInfo.skin_item_end_time or arg_18_1.gmActivityInfo.skin_item_end_time == 0 then
				return true
			end

			if var_18_0 <= arg_18_1.gmActivityInfo.skin_item_end_time then
				return true
			end
		end
	end

	return false
end

function SkinGoodsData:getTicketPrice(arg_19_1)
	return (arg_19_1.gmActivityInfo or nil) and (arg_19_1.gmActivityInfo.skin_item_num or 0)
end

function SkinGoodsData:getShowThemeDict()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in var_0_9.ipairs() do
		var_20_0[iter_20_0] = false
	end

	for iter_20_2, iter_20_3 in ipairs((self:getSkinGoodsListByForAllSkin())) do
		var_20_0[var_0_6.get(iter_20_3.skin_id).theme] = true
	end

	return var_20_0
end

function SkinGoodsData:hasTheme()
	for iter_21_0, iter_21_1 in pairs((self:getShowThemeDict())) do
		if iter_21_1 then
			return true
		end
	end

	return false
end

return SkinGoodsData
