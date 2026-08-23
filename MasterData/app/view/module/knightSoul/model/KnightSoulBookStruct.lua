local KnightSoulBookStruct = class("KnightSoulBookStruct")
local var_0_1 = g.core.config.ksoul_book_chapter_info
local var_0_2 = g.core.config.ksoul_book_info
local var_0_3 = g.core.model.User.knightSoulData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.const.ConstMgr.BAG_TYPE
local var_0_6 = g.core.const.ConstMgr.KnightSoulConst

function KnightSoulBookStruct:ctor()
	self._cfg = {}
	self._needKnightSoulList = {}
	self._bookAttrInfoList = {}
	self._isActivate = false
end

function KnightSoulBookStruct:_initNeedKnightSoulList()
	self._needKnightSoulList = {}

	while var_0_2.hasKey("ksoul_" .. 1) do
		if self._cfg["ksoul_" .. 1] > 0 then
			table.insert(self._needKnightSoulList, self._cfg["ksoul_" .. 1])
		end
	end
end

function KnightSoulBookStruct:_initBookAttrList()
	self._bookAttrInfoList = {}

	while var_0_2.hasKey("affect_type_" .. 1) do
		if self._cfg["affect_type_" .. 1] > 0 then
			table.insert(self._bookAttrInfoList, {
				attrType = self._cfg["affect_type_" .. 1],
				attrValue = self._cfg["affect_value_" .. 1],
				attrGrow = self._cfg["affect_grow_" .. 1]
			})
		end
	end

	table.sort(self._bookAttrInfoList, function(arg_4_0, arg_4_1)
		return arg_4_0.attrType < arg_4_1.attrType
	end)
end

function KnightSoulBookStruct:isUnlock()
	return (var_0_3:isChapterUnlock(self._cfg.chapter))
end

function KnightSoulBookStruct:isActivate()
	return self._isActivate
end

function KnightSoulBookStruct:isCanActivate()
	if not var_0_3:isChapterShow(self._cfg.chapter) then
		return false
	end

	if not self:isUnlock() then
		return false
	end

	if self:isActivate() then
		return false
	end

	for iter_7_0, iter_7_1 in ipairs(self._needKnightSoulList) do
		if var_0_4:getOwnNum(var_0_5.KSOUL, iter_7_1) == 0 then
			return false
		end
	end

	return true
end

function KnightSoulBookStruct:isOpenStarUp()
	return var_0_3:getCurHonorNum() >= self:getOpenStarUpNeedHonorNum()
end

function KnightSoulBookStruct:isCanStarUp()
	if not var_0_3:isChapterShow(self._cfg.chapter) then
		return false
	end

	if not self:isOpenStarUp() then
		return false, var_0_6.UNABLE_STAR_UP_TYPE.HONOR_NUM
	end

	if not self:isUnlock() then
		return false
	end

	if not self:isActivate() then
		return false
	end

	if self:isMaxStar() then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(self._needKnightSoulList) do
		if var_0_4:getOwnNum(var_0_5.KSOUL, iter_9_1) == 0 then
			return false, var_0_6.UNABLE_STAR_UP_TYPE.CARD_NUM
		end
	end

	return true
end

function KnightSoulBookStruct:isMaxStar()
	return self._cfg.max_star == self._starNum
end

function KnightSoulBookStruct:getStatusIndex()
	if self:isMaxStar() then
		return var_0_6.BOOK_STATUS.MAX_STAR
	end

	if self:isCanStarUp() then
		return var_0_6.BOOK_STATUS.STAR_UP_ABLE
	end

	if self:isActivate() then
		return var_0_6.BOOK_STATUS.NOT_MAX_STAR
	end

	if self:isCanActivate() then
		return var_0_6.BOOK_STATUS.ACTIVATE_ABLE
	end

	return var_0_6.BOOK_STATUS.ACTIVATE_UNABLE
end

function KnightSoulBookStruct:setCfg(arg_12_1)
	self._starNum = 0
	self._cfg = arg_12_1

	self:_initNeedKnightSoulList()
	self:_initBookAttrList()
end

function KnightSoulBookStruct:getCfg()
	return self._cfg
end

function KnightSoulBookStruct:getId()
	return self._cfg.id
end

function KnightSoulBookStruct:getName()
	return self._cfg.name
end

function KnightSoulBookStruct:getChapter()
	return self._cfg.chapter
end

function KnightSoulBookStruct:getQuality()
	return self._cfg.quality
end

function KnightSoulBookStruct:getChapterName()
	return var_0_1.get((self:getChapter())).name
end

function KnightSoulBookStruct:getActivateHonor()
	return self._cfg.honor
end

function KnightSoulBookStruct:setActivate(arg_20_1)
	self._isActivate = arg_20_1
end

function KnightSoulBookStruct:getNeedKnightSoulList()
	return self._needKnightSoulList
end

function KnightSoulBookStruct:setStarNum(arg_22_1)
	self._starNum = arg_22_1 or 0
end

function KnightSoulBookStruct:getStarNum()
	return self._starNum
end

function KnightSoulBookStruct:getMaxStar()
	return self._cfg.max_star
end

function KnightSoulBookStruct:getKnightShow()
	return self._cfg.knight_show
end

function KnightSoulBookStruct:getEmbryoType()
	return
end

function KnightSoulBookStruct:getOpenStarUpNeedHonorNum()
	local var_27_0 = var_0_1.get(self._cfg.chapter)

	return (var_27_0 or nil) and (var_27_0.star_honor or 0)
end

function KnightSoulBookStruct:getBookAttrList()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self._bookAttrInfoList) do
		table.insert(var_28_0, {
			attrType = iter_28_1.attrType,
			attrValue = iter_28_1.attrValue + iter_28_1.attrGrow * self._starNum,
			colorIndex = self._isActivate and 2 or 0
		})
	end

	return var_28_0
end

function KnightSoulBookStruct:getBookAttrInfoList()
	return self._bookAttrInfoList
end

function KnightSoulBookStruct:getNextNeedBagHaveKSoulIdList(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self._needKnightSoulList) do
		if var_0_4:getOwnNum(var_0_5.KSOUL, iter_30_1) == 0 and #var_0_3:getBagListForKSoulId(iter_30_1) > 0 then
			table.insert(var_30_0, iter_30_1)
		end
	end

	if arg_30_1 then
		table.sort(var_30_0, function(arg_31_0, arg_31_1)
			local var_31_0 = g.core.config.ksoul_info.get(arg_31_0)
			local var_31_1 = g.core.config.ksoul_info.get(arg_31_1)

			if var_31_0.quality ~= var_31_1.quality then
				return var_31_0.quality > var_31_1.quality
			end

			return arg_31_1 < arg_31_0
		end)
	end

	return var_30_0
end

return KnightSoulBookStruct
