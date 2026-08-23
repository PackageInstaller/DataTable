local RecruitWishMemberStruct = class("RecruitWishMemberStruct")

function RecruitWishMemberStruct:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._recruitType = nil
	self._recruitId = nil
	self._type = arg_1_1
	self._value = arg_1_2
	self._struct = arg_1_3
	self._state = nil
	self._pos = nil
	self._wishPlaceHolders = nil
	self._upCalFunc = nil
	self._extUp = 0
	self._maxLuckTimes = 0
	self._wishMaxNum = 1
	self._otherDevelopInfo = {}
	self._isDevelopFull = false
	self._minQuality = 0
	self._maxQuality = 0
end

function RecruitWishMemberStruct:setRecruitType(arg_2_1)
	self._recruitType = arg_2_1
end

function RecruitWishMemberStruct:setRecruitId(arg_3_1)
	self._recruitId = arg_3_1

	self:_updateMaxLuckTimes()
end

function RecruitWishMemberStruct:updateStructBaseInfo(arg_4_1)
	self._name = arg_4_1.name or ""
	self._star = arg_4_1.star or 0
	self._level = arg_4_1.level or 0
	self._quality = arg_4_1.quality or 0
	self._groupTag = arg_4_1.group or 0
	self._isLimit = arg_4_1.limit
	self._isOwn = arg_4_1.isOwn
	self._isMaxStar = arg_4_1.isMaxStar
	self._isDevelopFull = arg_4_1.fullDevelop ~= nil and arg_4_1.fullDevelop or self._isMaxStar

	if arg_4_1.wishMaxNum then
		self._wishMaxNum = arg_4_1.wishMaxNum or 1
	end
end

function RecruitWishMemberStruct:_updateMaxLuckTimes()
	if self._recruitId then
		local var_5_1 = g.core.config.recruit_knight_wish_rule_info.get(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(self._recruitId, true).wish_rule_id)

		self._maxLuckTimes = var_5_1.minimum_num
		self._maxQuality = var_5_1.minimum_quality
		self._minQuality = var_5_1.minimum_initial_quality
	end
end

function RecruitWishMemberStruct:updateStructNetInfo(arg_6_1)
	self._state = arg_6_1.state or 0
	self._pos = arg_6_1.pos
	self._wishPlaceHolders = arg_6_1.placeHolders
end

function RecruitWishMemberStruct:getId()
	return self._value
end

function RecruitWishMemberStruct:getType()
	return self._type
end

function RecruitWishMemberStruct:getStruct()
	return self._struct
end

function RecruitWishMemberStruct:getStar()
	return self._star
end

function RecruitWishMemberStruct:getQuality()
	return self._quality
end

function RecruitWishMemberStruct:getLevel()
	return self._level
end

function RecruitWishMemberStruct:getName()
	return self._name
end

function RecruitWishMemberStruct:getGroup()
	return self._groupTag
end

function RecruitWishMemberStruct:isLimitMember()
	return self._isLimit
end

function RecruitWishMemberStruct:isOwn()
	return self._isOwn
end

function RecruitWishMemberStruct:setPos(arg_17_1)
	self._pos = arg_17_1
end

function RecruitWishMemberStruct:getPos()
	return self._pos
end

function RecruitWishMemberStruct:setState(arg_19_1)
	self._state = arg_19_1
end

function RecruitWishMemberStruct:getState()
	return self._state
end

function RecruitWishMemberStruct:getWishMaxNum()
	return self._wishMaxNum
end

function RecruitWishMemberStruct:isCompleted()
	return self._state >= self._wishMaxNum
end

function RecruitWishMemberStruct:getPlaceHolders()
	return self._wishPlaceHolders
end

function RecruitWishMemberStruct:setUpCalFunc(arg_24_1)
	self._upCalFunc = arg_24_1
end

function RecruitWishMemberStruct:getUpValue(arg_25_1)
	if self._upCalFunc then
		return self:_isInTempTime() and 50 or self:_upCalFunc(arg_25_1)
	end

	return 0
end

function RecruitWishMemberStruct:setExtUp(arg_26_1)
	self._extUp = arg_26_1
end

function RecruitWishMemberStruct:getMaxLuckTimes()
	return self._maxLuckTimes
end

function RecruitWishMemberStruct:getCurLuckTimes(arg_28_1)
	local var_28_0 = arg_28_1:getWishLucks()
	local var_28_1 = 0

	for iter_28_0 = self._minQuality, self._maxQuality do
		if var_28_0[iter_28_0] then
			var_28_1 = var_28_1 + var_28_0[iter_28_0].num
		end
	end

	return (math.min(var_28_1, self._maxLuckTimes - 1))
end

function RecruitWishMemberStruct:getWishQuality()
	return self._maxQuality
end

function RecruitWishMemberStruct:getTotalUpValue()
	local var_30_0 = self:getUpValue()

	if self._state < self._wishMaxNum and self:getPos() ~= nil then
		var_30_0 = var_30_0 + self._extUp
	end

	return var_30_0
end

function RecruitWishMemberStruct:isMaxStar()
	return self._isMaxStar
end

function RecruitWishMemberStruct:isFullDevelop()
	return self._isDevelopFull
end

function RecruitWishMemberStruct:getOtherDevelopInfo()
	return self._otherDevelopInfo
end

function RecruitWishMemberStruct:_isInTempTime()
	g.core.config.parameter_info.get(15029)

	if g.core.common.Goods.TYPE_ARTIFACT ~= self._type or tonumber(g.core.config.parameter_info.get(15029).parameter) ~= self._value then
		return false
	end

	local var_34_0 = config.PUBLISH_REGION
	local var_34_1 = tonumber(g.core.config.parameter_info.get(15030).parameter)

	return g.core.model.User.recruitData:getArtifactActivityData(self) and g.core.common.ServerTime:getTime() < ((config.PUBLISH_REGION == 2 or var_34_0 == 0 or nil) and tonumber(g.core.config.parameter_info.get(15031).parameter))
end

return RecruitWishMemberStruct
