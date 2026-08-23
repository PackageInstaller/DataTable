local KnightSoulData = class("KnightSoulData")
local KnightSoulBookStruct = require("app.view.module.knightSoul.model.KnightSoulBookStruct")
local var_0_2 = g.core.const.ConstMgr.KnightSoulConst
local var_0_3 = g.core.model.User.bagData
local var_0_4 = g.core.const.ConstMgr.BAG_TYPE
local var_0_5 = g.core.common.ModuleUnlock
local var_0_6 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_7 = g.core.config.ksoul_info
local var_0_8 = g.core.config.ksoul_book_info
local var_0_9 = g.core.config.ksoul_honor_info
local var_0_10 = g.core.config.ksoul_book_chapter_info

function KnightSoulData:ctor()
	self:initData()
end

function KnightSoulData:initData()
	self._curHonorNum = 0
	self._activationHonorId = 0
	self._curActivateBookNum = 0
	self._wishCompleteMap = {}
	self._maxHonorId = var_0_9.getLength()
	self._knightSoulBookAttrMap = {}
	self._localRankList = {}
	self._crossRankList = {}
	self._myLocalRank = 0
	self._myCrossRank = 0

	self:_initKnightSoulBookInfo()
	self:_initKnightSoulHonorInfo()
	self:_updateKnightSoulChapterList()
end

function KnightSoulData:_updateKnightSoulChapterList()
	self._chapterIdList = {}

	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in var_0_10.ipairs() do
		if self:isChapterShow(nil, iter_3_1) then
			if iter_3_1.type == var_0_2.CHAPTER_TYPE.CFG then
				table.insert(var_3_0, iter_3_1.id)
			elseif iter_3_1.type == var_0_2.CHAPTER_TYPE.GM then
				table.insert(var_3_1, iter_3_1.id)
			end
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)
	table.sort(var_3_1, function(arg_5_0, arg_5_1)
		return arg_5_1 < arg_5_0
	end)

	for iter_3_2 = 1, #var_3_1 do
		table.insert(self._chapterIdList, var_3_1[iter_3_2])
	end

	for iter_3_3 = 1, #var_3_0 do
		table.insert(self._chapterIdList, var_3_0[iter_3_3])
	end
end

function KnightSoulData:_initKnightSoulBookInfo()
	self._knightSoulBookListMap = {}
	self._knightSoulBookList = {}
	self._knightSoulBookMap = {}
	self._knightSoulBelongToBookMap = {}

	for iter_6_0, iter_6_1 in var_0_8.ipairs() do
		self._knightSoulBookListMap[iter_6_1.chapter] = self._knightSoulBookListMap[iter_6_1.chapter] or {}

		local var_6_0 = KnightSoulBookStruct.new()

		var_6_0:setCfg(iter_6_1)
		table.insert(self._knightSoulBookList, var_6_0)

		self._knightSoulBookMap[iter_6_1.id] = var_6_0

		table.insert(self._knightSoulBookListMap[iter_6_1.chapter], var_6_0)

		local var_6_1 = 1

		while var_0_8.hasKey("ksoul_1") do
			if iter_6_1.ksoul_1 > 0 then
				self._knightSoulBelongToBookMap[iter_6_1.ksoul_1] = self._knightSoulBelongToBookMap[iter_6_1.ksoul_1] or {}

				table.insert(self._knightSoulBelongToBookMap[iter_6_1.ksoul_1], iter_6_1.id)
			end

			var_6_1 = var_6_1 + 1
		end
	end
end

function KnightSoulData:_initKnightSoulHonorInfo()
	self._knightSoulHonorList = {}

	for iter_7_0, iter_7_1 in var_0_9.ipairs() do
		local var_7_0 = {}

		while var_0_9.hasKey("affect_type_" .. 1) do
			if iter_7_1["affect_type_" .. 1] > 0 then
				table.insert(var_7_0, {
					attrType = iter_7_1["affect_type_" .. 1],
					attrValue = iter_7_1["affect_value_" .. 1]
				})
			end
		end

		table.insert(self._knightSoulHonorList, {
			cfg = iter_7_1,
			attrList = var_7_0
		})
	end
end

function KnightSoulData:getKnightSoulHonorAttr(arg_8_1)
	return self._knightSoulHonorList[arg_8_1]
end

function KnightSoulData:updateKnightSoulData(arg_9_1)
	if not arg_9_1 then
		return
	end

	self:setCurHonorNum(arg_9_1.honor or 0)

	self._activationHonorId = arg_9_1.max_honor_id or 0

	if arg_9_1.cb_info then
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in ipairs(arg_9_1.cb_info) do
			if iter_9_1.books and next(iter_9_1.books) then
				var_9_0 = var_9_0 + #iter_9_1.books

				for iter_9_2, iter_9_3 in ipairs(iter_9_1.books) do
					self:setBookStarById(iter_9_3.id, iter_9_3.star)
					self:setBookActivate(iter_9_3.id)
				end
			end
		end

		self:setCurActivateBookNum(var_9_0)
	end
end

function KnightSoulData:resKSoulHonor(arg_10_1)
	self._activationHonorId = arg_10_1
end

function KnightSoulData:recvBookActivate(arg_11_1)
	self:setBookActivate(arg_11_1.book_id)
	self:setCurActivateBookNum(self:getCurActivateBookNum() + 1)
	self:setCurHonorNum(arg_11_1.honor)
end

function KnightSoulData:recvBookStarUp(arg_12_1)
	self:setBookStarById(arg_12_1.book_id, arg_12_1.star)
end

function KnightSoulData:onS2CGetCommonRankList(arg_13_1)
	if not arg_13_1 then
		return
	end

	local var_13_0 = table.values(arg_13_1.rank_units or {})
	local var_13_1 = arg_13_1.self_rank or 0

	if arg_13_1.id == g.core.network.proto.KSOUL_HONOR_LOCAL then
		self._localRankList = var_13_0
		self._myLocalRank = var_13_1
	elseif arg_13_1.id == g.core.network.proto.KSOUL_HONOR_CROSS then
		self._crossRankList = var_13_0
		self._myCrossRank = var_13_1
	end
end

function KnightSoulData:updateRedPoint(arg_14_1)
	self._activationHonorId = arg_14_1.max_honor_id or self._activationHonorId
	self._curHonorNum = arg_14_1.honor or self._curHonorNum
end

function KnightSoulData:getActivationHonorId()
	return self._activationHonorId
end

function KnightSoulData:getMaxHonorId()
	return self._maxHonorId
end

function KnightSoulData:getHonorNumById(arg_17_1)
	if arg_17_1 == 0 then
		return 0
	end

	if arg_17_1 > self._maxHonorId then
		arg_17_1 = self._maxHonorId
	end

	return var_0_9.get(arg_17_1).honor_num
end

function KnightSoulData:setCurHonorNum(arg_18_1)
	self._curHonorNum = arg_18_1
end

function KnightSoulData:getCurHonorNum()
	return self._curHonorNum
end

function KnightSoulData:setCurActivateBookNum(arg_20_1)
	self._curActivateBookNum = arg_20_1
end

function KnightSoulData:getCurActivateBookNum()
	return self._curActivateBookNum
end

function KnightSoulData:setBookStarById(arg_22_1, arg_22_2)
	local var_22_0 = self:getBookById(arg_22_1)

	if var_22_0 then
		var_22_0:setStarNum(arg_22_2)
	end
end

function KnightSoulData:setBookActivate(arg_23_1)
	local var_23_0 = self:getBookById(arg_23_1)

	if var_23_0 then
		var_23_0:setActivate(true)
	end
end

function KnightSoulData:getBookById(arg_24_1)
	return self._knightSoulBookMap[arg_24_1] or {}
end

function KnightSoulData:getBookAllAttrListByChapterId(arg_25_1)
	local var_25_0 = {
		[0] = {
			type = 0,
			attrName = g.core.lang:get(410607)
		}
	}

	for iter_25_0, iter_25_1 in ipairs(self._knightSoulBookListMap[arg_25_1]) do
		for iter_25_2, iter_25_3 in ipairs((iter_25_1:getBookAttrList())) do
			var_25_0[iter_25_3.attrType] = var_25_0[iter_25_3.attrType] or {}

			local var_25_1, var_25_2 = g.core.lang:getAttr(iter_25_3.attrType, iter_25_3.attrValue, false)

			var_25_0[iter_25_3.attrType] = {
				type = iter_25_3.attrType,
				attrName = var_25_1
			}
		end
	end

	local var_25_3 = {}

	for iter_25_4, iter_25_5 in pairs(var_25_0) do
		table.insert(var_25_3, iter_25_5)
	end

	table.sort(var_25_3, function(arg_26_0, arg_26_1)
		return arg_26_0.type < arg_26_1.type
	end)

	return var_25_3
end

function KnightSoulData:getBookListByChapterIdAndAttrType(arg_27_1, arg_27_2)
	local var_27_0 = {}

	if arg_27_2 and arg_27_2 > 0 then
		for iter_27_0, iter_27_1 in ipairs(self._knightSoulBookListMap[arg_27_1]) do
			for iter_27_2, iter_27_3 in ipairs((iter_27_1:getBookAttrList())) do
				if iter_27_3.attrType == arg_27_2 then
					table.insert(var_27_0, iter_27_1)
				end
			end
		end
	else
		var_27_0 = self._knightSoulBookListMap[arg_27_1]
	end

	return var_27_0
end

function KnightSoulData:getBookActivateNumByChapterId(arg_28_1)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(self._knightSoulBookListMap[arg_28_1]) do
		if iter_28_1:isActivate() then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0, #self._knightSoulBookListMap[arg_28_1]
end

function KnightSoulData:getCurActivationHonorId()
	return (self._activationHonorId + 1 > self._maxHonorId or nil) and self._maxHonorId
end

function KnightSoulData:getAllBookAttr()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self._knightSoulBookList) do
		if iter_30_1:isActivate() then
			for iter_30_2, iter_30_3 in ipairs((iter_30_1:getBookAttrList())) do
				var_30_0[iter_30_3.attrType] = var_30_0[iter_30_3.attrType] and var_30_0[iter_30_3.attrType] + iter_30_3.attrValue or iter_30_3.attrValue
			end
		end
	end

	local var_30_1 = {}

	for iter_30_4, iter_30_5 in pairs(var_30_0) do
		table.insert(var_30_1, {
			attrType = iter_30_4,
			attrValue = iter_30_5
		})
	end

	self:sortAttrByType(var_30_1)

	return var_30_1
end

function KnightSoulData:sortAttrByType(arg_31_1)
	table.sort(arg_31_1, function(arg_32_0, arg_32_1)
		return arg_32_0.attrType < arg_32_1.attrType
	end)
end

function KnightSoulData:getTotalHonorAttr()
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(self._knightSoulHonorList) do
		if iter_33_1.cfg.id <= self._activationHonorId then
			for iter_33_2, iter_33_3 in ipairs(iter_33_1.attrList) do
				var_33_0[iter_33_3.attrType] = var_33_0[iter_33_3.attrType] and var_33_0[iter_33_3.attrType] + iter_33_3.attrValue or iter_33_3.attrValue
			end
		end
	end

	local var_33_1 = {}

	for iter_33_4, iter_33_5 in pairs(var_33_0) do
		table.insert(var_33_1, {
			attrType = iter_33_4,
			attrValue = iter_33_5
		})
	end

	self:sortAttrByType(var_33_1)

	return var_33_1
end

function KnightSoulData:getAllAttrList()
	local var_34_0 = {}
	local var_34_1 = self:getAllBookAttr()

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		var_34_0[iter_34_1.attrType] = var_34_0[iter_34_1.attrType] and var_34_0[iter_34_1.attrType] + iter_34_1.attrValue or iter_34_1.attrValue
	end

	local var_34_2 = self:getTotalHonorAttr()

	for iter_34_2, iter_34_3 in ipairs(var_34_2) do
		var_34_0[iter_34_3.attrType] = var_34_0[iter_34_3.attrType] and var_34_0[iter_34_3.attrType] + iter_34_3.attrValue or iter_34_3.attrValue
	end

	local var_34_3 = {}

	for iter_34_4, iter_34_5 in pairs(var_34_0) do
		table.insert(var_34_3, {
			attrType = iter_34_4,
			attrValue = iter_34_5
		})
	end

	self:sortAttrByType(var_34_3)

	return var_34_3, var_34_1, var_34_2
end

function KnightSoulData:getAllAttrDict()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs((self:getAllAttrList())) do
		var_35_0[iter_35_1.attrType] = iter_35_1.attrValue
	end

	return var_35_0
end

function KnightSoulData:getShowAttrList()
	local var_36_0 = {}
	local var_36_1 = self:getAllAttrList()

	if #var_36_1 > 0 then
		table.insert(var_36_0, {
			title = g.core.lang:get("KNIGHT_SOUL_ALL_ATTR"),
			attrList = var_36_1
		})
	end

	local var_36_2 = self:getAllBookAttr()

	if #var_36_2 > 0 then
		table.insert(var_36_0, {
			title = g.core.lang:get("KNIGHT_SOUL_BOOk_ATTR"),
			attrList = var_36_2
		})
	end

	local var_36_3 = self:getTotalHonorAttr()

	if #var_36_3 > 0 then
		table.insert(var_36_0, {
			title = g.core.lang:get("KNIGHT_SOUL_HONOR_ATTR"),
			attrList = var_36_3
		})
	end

	return var_36_0
end

function KnightSoulData:getKnightSouls(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs((var_0_3:getList(var_0_4.KSOUL))) do
		local var_37_1 = var_0_7.get(iter_37_1.id)

		if var_37_1 then
			if arg_37_1 and arg_37_1 > 0 then
				if arg_37_1 == var_37_1.quality then
					table.insert(var_37_0, {
						overrideClick = true,
						type = var_0_4.KSOUL,
						info = var_37_1,
						value = iter_37_1.id,
						size = iter_37_1.num
					})
				end
			else
				table.insert(var_37_0, {
					overrideClick = true,
					type = var_0_4.KSOUL,
					info = var_37_1,
					value = iter_37_1.id,
					size = iter_37_1.num
				})
			end
		end
	end

	table.sort(var_37_0, function(arg_38_0, arg_38_1)
		if arg_38_0.info.quality ~= arg_38_1.info.quality then
			return arg_38_0.info.quality > arg_38_1.info.quality
		end

		if arg_38_0.info.type ~= arg_38_1.info.type then
			return arg_38_0.info.type == var_0_4.KNIGHT
		end

		return arg_38_0.info.id > arg_38_1.info.id
	end)

	return var_37_0
end

function KnightSoulData:getSellKnightSouls(arg_39_1)
	local var_39_0 = g.core.model.User.bagData:getList(var_0_4.KSOUL)
	local var_39_1 = {}

	for iter_39_0 = 1, #var_39_0 do
		local var_39_2 = var_0_7.get(var_39_0[iter_39_0].id)

		if var_39_2 then
			if arg_39_1 and arg_39_1 > 0 then
				if arg_39_1 == var_39_2.quality then
					table.insert(var_39_1, {
						overrideClick = true,
						type = var_0_4.KSOUL,
						info = var_39_2,
						value = var_39_2.id,
						size = var_39_0[iter_39_0].num
					})
				end
			else
				table.insert(var_39_1, {
					overrideClick = true,
					type = var_0_4.KSOUL,
					info = var_39_2,
					value = var_39_2.id,
					size = var_39_0[iter_39_0].num
				})
			end
		end
	end

	table.sort(var_39_1, function(arg_40_0, arg_40_1)
		if arg_40_0.info.quality ~= arg_40_1.info.quality then
			return arg_40_0.info.quality < arg_40_1.info.quality
		else
			return arg_40_0.info.id < arg_40_1.info.id
		end
	end)

	return var_39_1
end

function KnightSoulData:hasKnightSoulById(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs((var_0_3:getList(var_0_4.KSOUL))) do
		if iter_41_1.id == arg_41_1 then
			return true
		end
	end

	return false
end

function KnightSoulData:getChapterNum()
	return #self._chapterIdList
end

function KnightSoulData:getChapterIdList()
	self:_updateKnightSoulChapterList()
	self:_sortByRedPoint()

	return self._chapterIdList
end

function KnightSoulData:_sortByRedPoint()
	if not self._chapterIdList or #self._chapterIdList == 0 then
		return
	end

	local function var_44_0(arg_45_0)
		if not self._knightSoulBookListMap[arg_45_0] then
			return false
		end

		for iter_45_0, iter_45_1 in ipairs(self._knightSoulBookListMap[arg_45_0]) do
			if iter_45_1:isCanActivate() or iter_45_1:isCanStarUp() then
				return true
			end
		end

		return false
	end

	table.sort(self._chapterIdList, function(arg_46_0, arg_46_1)
		local var_46_0 = self:isChapterUnlock(arg_46_0)

		if var_46_0 ~= self:isChapterUnlock(arg_46_1) then
			return var_46_0
		end

		local var_46_1 = var_44_0(arg_46_0)

		if var_46_1 ~= var_44_0(arg_46_1) then
			return var_46_1
		end

		return false
	end)
end

function KnightSoulData:isChapterShow(arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2 or var_0_10.fetch(arg_47_1)

	if var_47_0 then
		if var_47_0.type == var_0_2.CHAPTER_TYPE.CFG then
			return true
		elseif var_47_0.type == var_0_2.CHAPTER_TYPE.GM and var_47_0.put == 1 then
			return true
		end
	end

	return false
end

function KnightSoulData:getKnightSoulBelongToBookId(arg_48_1)
	local var_48_0 = {}
	local var_48_1 = self._knightSoulBelongToBookMap[arg_48_1] or {}

	for iter_48_0 = 1, #var_48_1 do
		if self:isChapterShow(var_0_8.get(var_48_1[iter_48_0]).chapter) then
			table.insert(var_48_0, var_48_1[iter_48_0])
		end
	end

	return var_48_0
end

function KnightSoulData:getKsoulActivatedBookIds(arg_49_1)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs((self:getKnightSoulBelongToBookId(arg_49_1))) do
		if self:getBookById(iter_49_1):isActivate() then
			table.insert(var_49_0, iter_49_1)
		end
	end

	return var_49_0
end

function KnightSoulData:getRankListByType(arg_50_1)
	if arg_50_1 == 0 then
		return self._localRankList
	elseif arg_50_1 == 1 then
		return self._crossRankList
	end

	return {}
end

function KnightSoulData:getRankByType(arg_51_1)
	if arg_51_1 == 0 then
		return self._myLocalRank
	elseif arg_51_1 == 1 then
		return self._myCrossRank
	end

	return 0
end

function KnightSoulData:sortBookList(arg_52_1)
	table.sort(arg_52_1, function(arg_53_0, arg_53_1)
		local var_53_0 = arg_53_0:isCanActivate()

		if var_53_0 ~= arg_53_1:isCanActivate() then
			return var_53_0
		end

		local var_53_1 = arg_53_0:isCanStarUp()

		if var_53_1 ~= arg_53_1:isCanStarUp() then
			return var_53_1
		end

		local var_53_2 = arg_53_0:isActivate()

		if var_53_2 ~= arg_53_1:isActivate() then
			return not var_53_2
		end

		local var_53_3 = arg_53_0:getQuality()
		local var_53_4 = arg_53_1:getQuality()

		if var_53_3 ~= var_53_4 then
			return var_53_4 < var_53_3
		end

		return arg_53_0:getId() > arg_53_1:getId()
	end)
end

function KnightSoulData:isChapterUnlock(arg_54_1)
	local var_54_0 = var_0_10.fetch(arg_54_1)

	if not var_54_0 then
		return false
	end

	if var_54_0.level > g.core.model.User:getLevel() then
		return false, var_0_2.UNLOCK_TYPE.LEVEL, var_54_0.level
	end

	if var_54_0.unlock_type == var_0_2.UNLOCK_TYPE.HONOR then
		return self._activationHonorId >= var_54_0.unlock_value, var_0_2.UNLOCK_TYPE.HONOR, var_0_9.get(var_54_0.unlock_value).name
	end

	return true
end

function KnightSoulData:getWishCompleteMap()
	return self._wishCompleteMap or {}
end

function KnightSoulData:updateWishCompleteMap(arg_56_1)
	self._wishCompleteMap = {}

	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		self._wishCompleteMap[iter_56_1] = var_0_7.get(iter_56_1)
	end
end

function KnightSoulData:updateWishCompleteMapByOpData(arg_57_1)
	if arg_57_1.insert then
		self:_addWishCompleteMap(arg_57_1.insert)
	end

	if arg_57_1.update then
		self:_updateWishCompleteMap(arg_57_1.update)
	end

	if arg_57_1.del then
		self:_delWishCompleteMap(arg_57_1.del)
	end
end

function KnightSoulData:_addWishCompleteMap(arg_58_1)
	for iter_58_0 = 1, #arg_58_1 do
		self._wishCompleteMap[arg_58_1[iter_58_0].id] = var_0_7.get(arg_58_1[iter_58_0].id)
	end
end

function KnightSoulData:_delWishCompleteMap(arg_59_1)
	for iter_59_0 = 1, #arg_59_1 do
		self._wishCompleteMap[arg_59_1[iter_59_0]] = nil
	end
end

function KnightSoulData:_updateWishCompleteMap(arg_60_1)
	for iter_60_0 = 1, #arg_60_1 do
		self._wishCompleteMap[arg_60_1[iter_60_0].id] = var_0_7.get(arg_60_1[iter_60_0].id)
	end
end

function KnightSoulData:getBagListForKSoulId(arg_61_1, arg_61_2)
	local var_61_0 = {}
	local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")

	for iter_61_0, iter_61_1 in ipairs((g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.ITEM))) do
		local var_61_2 = g.core.config.item_info.get(iter_61_1.id)

		if iter_61_1.num > 0 and var_61_2.use_type == BagNewPropCfg.USE_TYPE.SELECT then
			for iter_61_2, iter_61_3 in ipairs((g.core.common.Drops:getGoodsArrayNoRank(var_61_2.item_value))) do
				if iter_61_3.type == g.core.common.Goods.TYPE_KNIGHT_SOUL then
					if iter_61_3.value == arg_61_1 then
						table.insert(var_61_0, {
							id = iter_61_1.id,
							num = iter_61_1.num,
							index = iter_61_2
						})

						break
					end
				else
					break
				end
			end
		end
	end

	if arg_61_2 then
		table.sort(var_61_0, function(arg_62_0, arg_62_1)
			return arg_62_0.id > arg_62_1.id
		end)
	end

	return var_61_0
end

function KnightSoulData:isHaveHonorCanActivate()
	if not var_0_5:isModuleUnlock(var_0_6.KNIGHT_SOUL) then
		return false
	end

	if self._activationHonorId < self._maxHonorId then
		return self:getHonorNumById(self._activationHonorId + 1) <= self:getCurHonorNum()
	end

	return false
end

function KnightSoulData:isHaveBookCanStarUp(arg_64_1)
	if not var_0_5:isModuleUnlock(var_0_6.KNIGHT_SOUL) then
		return false
	end

	if arg_64_1.bookStruct then
		return arg_64_1.bookStruct:isCanStarUp()
	elseif arg_64_1.chapterId then
		for iter_64_0, iter_64_1 in ipairs((self:getBookListByChapterIdAndAttrType(arg_64_1.chapterId))) do
			if iter_64_1:isCanStarUp() then
				return true
			end
		end
	else
		for iter_64_2, iter_64_3 in ipairs(self._knightSoulBookList) do
			if iter_64_3:isCanStarUp() then
				return true
			end
		end
	end

	return false
end

function KnightSoulData:isOpenBookStarUp()
	for iter_65_0, iter_65_1 in ipairs(self._knightSoulBookList) do
		if iter_65_1:isOpenStarUp() then
			return true
		end
	end

	return false
end

function KnightSoulData:isHaveBookCanActivate(arg_66_1)
	if not var_0_5:isModuleUnlock(var_0_6.KNIGHT_SOUL) then
		return false
	end

	if arg_66_1.bookStruct then
		return arg_66_1.bookStruct:isCanActivate()
	elseif arg_66_1.chapterId then
		for iter_66_0, iter_66_1 in ipairs((self:getBookListByChapterIdAndAttrType(arg_66_1.chapterId))) do
			if iter_66_1:isCanActivate() then
				return true
			end
		end
	else
		for iter_66_2, iter_66_3 in ipairs(self._knightSoulBookList) do
			if iter_66_3:isCanActivate() then
				return true
			end
		end
	end

	return false
end

function KnightSoulData:isChapterHaveBookCanStarUpById(arg_67_1)
	for iter_67_0, iter_67_1 in ipairs(self._knightSoulBookListMap[arg_67_1]) do
		if iter_67_1:isCanStarUp() then
			return true
		end
	end

	return false
end

function KnightSoulData:isChapterHaveBookCanActivateById(arg_68_1)
	for iter_68_0, iter_68_1 in ipairs(self._knightSoulBookListMap[arg_68_1]) do
		if iter_68_1:isCanActivate() then
			return true
		end
	end

	return false
end

function KnightSoulData:isUnlockNewBook()
	local var_69_0 = self._activationHonorId + 1

	if self._activationHonorId + 1 > self._maxHonorId then
		return false
	end

	local var_69_1 = var_0_9.get(var_69_0)

	if var_69_1 and var_69_1.honor_num then
		return self._curHonorNum >= var_69_1.honor_num, var_69_0
	end

	return false
end

function KnightSoulData:isHaveNewGMChapter(arg_70_1)
	if not var_0_5:isModuleUnlock(var_0_6.KNIGHT_SOUL) then
		return false
	end

	if not self._gmChapterCache then
		local var_70_0 = g.core.common.Storage:load("ksoul_gm_chapter.json", true)

		if var_70_0 then
			self._gmChapterCache = var_70_0.chapterList or {}
		end
	end

	if arg_70_1.chapterId then
		local var_70_1 = arg_70_1.chapterId or 0
		local var_70_2 = var_0_10.fetch(var_70_1)

		if var_70_2 and var_70_2.type == var_0_2.CHAPTER_TYPE.GM and not self._gmChapterCache[tostring(var_70_1)] then
			return true
		end
	else
		for iter_70_0, iter_70_1 in var_0_10.ipairs() do
			if iter_70_1 and iter_70_1.type == var_0_2.CHAPTER_TYPE.GM and self:isChapterShow(iter_70_1.id) and not self._gmChapterCache[tostring(iter_70_1.id)] then
				return true
			end
		end
	end

	return false
end

function KnightSoulData:saveNewGMChapter(arg_71_1)
	if not self._gmChapterCache then
		local var_71_0 = g.core.common.Storage:load("ksoul_gm_chapter.json", true)

		if var_71_0 then
			self._gmChapterCache = var_71_0.chapterList or {}
		end
	end

	if not self._gmChapterCache[tostring(arg_71_1)] then
		self._gmChapterCache[tostring(arg_71_1)] = true

		g.core.common.Storage:save("ksoul_gm_chapter.json", {
			chapterList = self._gmChapterCache
		}, true)
	end
end

return KnightSoulData
