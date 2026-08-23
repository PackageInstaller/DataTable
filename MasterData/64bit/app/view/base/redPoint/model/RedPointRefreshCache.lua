local RedPointRefreshCache = class("RedPointRefreshCache")

function RedPointRefreshCache:ctor()
	self._refreshCache = {}
	self._idMap = {}
	self._idOnCache = true
end

function RedPointRefreshCache:setCacheOn(arg_2_1)
	self._idOnCache = arg_2_1
end

function RedPointRefreshCache:getCacheState()
	return self._idOnCache
end

function RedPointRefreshCache:refreshAllRedCache()
	for iter_4_0, iter_4_1 in pairs(self._refreshCache) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			for iter_4_4, iter_4_5 in ipairs(iter_4_3) do
				iter_4_5.cacheIndex = 0
				iter_4_5.newestIndex = 1
			end
		end
	end
end

function RedPointRefreshCache:addRedPointCache(arg_5_1)
	if not self._idOnCache then
		return
	end

	if not self._refreshCache[arg_5_1] then
		self._refreshCache[arg_5_1] = {}
	else
		for iter_5_0, iter_5_1 in pairs(self._refreshCache[arg_5_1]) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				iter_5_3.newestIndex = iter_5_3.newestIndex + 1
			end
		end
	end
end

function RedPointRefreshCache:addEventsCache(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		cacheIndex = 0,
		newestIndex = 1,
		event = arg_6_1,
		id = arg_6_2,
		cache = {
			isShow = false
		},
		redId = arg_6_3
	}

	self._idMap[arg_6_2] = self._idMap[arg_6_2] or {}
	self._idMap[arg_6_2][arg_6_3] = var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self._refreshCache[iter_6_1] = self._refreshCache[iter_6_1] or {}
		self._refreshCache[iter_6_1][arg_6_2] = self._refreshCache[iter_6_1][arg_6_2] or {}

		table.insert(self._refreshCache[iter_6_1][arg_6_2], var_6_0)
	end
end

function RedPointRefreshCache:getCacheDataById(arg_7_1, arg_7_2)
	if not self._idMap[arg_7_1] or not self._idMap[arg_7_1][arg_7_2] then
		return false
	end

	return self._idMap[arg_7_1][arg_7_2].cache.isShow, self._idMap[arg_7_1][arg_7_2].cache.retData
end

function RedPointRefreshCache:_deepCompare(arg_8_1, arg_8_2)
	if type(arg_8_1) ~= "table" or type(arg_8_2) ~= "table" then
		return arg_8_1 == arg_8_2
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if arg_8_2[iter_8_0] ~= iter_8_1 then
			return false
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_2) do
		if arg_8_1[iter_8_2] ~= iter_8_3 then
			return false
		end
	end

	return true
end

function RedPointRefreshCache:isNeedRefreshWithId(arg_9_1, arg_9_2, arg_9_3)
	if not self._idOnCache then
		return true
	end

	if not self._idMap[arg_9_1] or not self._idMap[arg_9_1][arg_9_3] then
		return true
	end

	local var_9_0 = self._idMap[arg_9_1][arg_9_3]

	if arg_9_2 or var_9_0.customData then
		if not var_9_0.customData then
			return true
		end

		if not arg_9_2 then
			return true
		end

		if not self:_deepCompare(arg_9_2, var_9_0.customData) then
			return true
		end
	end

	return var_9_0.newestIndex > var_9_0.cacheIndex
end

function RedPointRefreshCache:refreshCacheById(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if not self._idOnCache then
		return
	end

	if not self._idMap[arg_10_1] or not self._idMap[arg_10_1][arg_10_5] then
		return
	end

	local var_10_0 = self._idMap[arg_10_1][arg_10_5]

	self._idMap[arg_10_1][arg_10_5].cache.isShow = arg_10_2
	var_10_0.cache.retData = arg_10_3
	var_10_0.cacheIndex = var_10_0.newestIndex
	var_10_0.customData = clone(arg_10_4)
end

return RedPointRefreshCache
