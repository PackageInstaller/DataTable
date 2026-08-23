local var_0_0 = g.core.const.ConstMgr.RedPointConst
local RedPointConditionConfig = require("app.view.base.redPoint.conditions.RedPointConditionConfig")
local var_0_2 = g.core.model.User.redPointRefreshCache
local ConditionStruct = class("ConditionStruct")

function ConditionStruct:ctor(arg_1_1)
	arg_1_1 = arg_1_1 or {}
	self._style = arg_1_1.style or var_0_0.STYLE.NONE
	self._lifeCycle = arg_1_1.lifeCycle or var_0_0.LIFE_CYCLE.RESIDENT
	self._functionId = arg_1_1.functionId or 0
	self._redId = arg_1_1.redPointId
	self._idList = {}
	self._funcList = {}
	self._eventList = {}
	self._idsStr = ""

	self:setIdsWithStr(arg_1_1.idsStr)
end

function ConditionStruct:getFunctionId()
	return self._functionId
end

function ConditionStruct:isValidIdsStr()
	if type(self) ~= "string" then
		return false
	else
		return string.find(self, "%d")
	end
end

function ConditionStruct:parseIdListByIdsStr()
	local var_4_0 = {}

	if ConditionStruct.isValidIdsStr(self) then
		for iter_4_0, iter_4_1 in ipairs((string.split(self, var_0_0.ID_SEPARATOR))) do
			local var_4_1 = checknumber(iter_4_1)

			if var_4_1 == 0 then
				g.core.log:error(string.format("Error!! Invalid id: [%s] from [%s]. Abandoned!!", iter_4_1, self))
			else
				table.insert(var_4_0, var_4_1)
			end
		end
	end

	return var_4_0
end

function ConditionStruct:getStyle()
	return self._style
end

function ConditionStruct:setStyle(arg_6_1)
	self._style = arg_6_1
end

function ConditionStruct:getLifeCycle()
	return self._lifeCycle
end

function ConditionStruct:setLifeCycle(arg_8_1)
	self._lifeCycle = arg_8_1
end

function ConditionStruct:getEventList()
	return self._eventList
end

function ConditionStruct:rmvDuplicateEvent()
	if #self._eventList < 2 then
		return
	end

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._eventList) do
		var_10_0[iter_10_1] = true
	end

	self._eventList = table.keys(var_10_0)
end

function ConditionStruct:getIdList()
	return self._idList
end

function ConditionStruct:getIdsStr()
	return self._idsStr
end

function ConditionStruct:_refreshIdsStr()
	local var_13_0 = {}

	if #self._idList == 0 then
		self._idsStr = ""
	elseif #self._idList > 1 then
		for iter_13_0, iter_13_1 in ipairs(self._idList) do
			table.insert(var_13_0, iter_13_1)
		end

		table.sort(var_13_0)
	end

	self._idsStr = table.concat(var_13_0, var_0_0.ID_SEPARATOR)
end

function ConditionStruct:getFuncList()
	return self._funcList
end

function ConditionStruct:setIdList(arg_15_1)
	self._idList = {}
	self._funcList = {}
	self._eventList = {}

	if not arg_15_1 or #arg_15_1 == 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = RedPointConditionConfig[iter_15_1]

		if RedPointConditionConfig[iter_15_1] then
			table.insert(self._idList, iter_15_1)

			if var_15_0.func then
				table.insert(self._funcList, var_15_0.func)
			else
				g.core.log:error("Error! Fun is nil! RedPointConditionConfig key: ", iter_15_1)
			end

			if var_15_0.events then
				var_0_2:addEventsCache(var_15_0.events, iter_15_1, self._redId)
				table.insertto(self._eventList, var_15_0.events)
			end
		else
			g.core.log:error("Error!! ConditionId in RedPointConditionConfig(Client table) is missing: ", iter_15_1)
		end
	end

	self:_refreshIdsStr()
	self:rmvDuplicateEvent()
end

function ConditionStruct:setIdsWithStr(arg_16_1)
	self:setIdList((ConditionStruct.parseIdListByIdsStr(arg_16_1)))
end

function ConditionStruct:isSame(arg_17_1)
	if not arg_17_1 then
		return false
	elseif arg_17_1:getFunctionId() ~= self._functionId then
		return false
	else
		return self:isSameIdsStr((arg_17_1:getIdsStr()))
	end
end

function ConditionStruct:isSameIdsStr(arg_18_1)
	if type(arg_18_1) ~= "string" or arg_18_1 == "" then
		return false
	else
		return arg_18_1 == self._idsStr
	end
end

function ConditionStruct:_isDuringLifeCycle(arg_19_1)
	return not g.core.model.User.redPointData:isRedPointFinished(self._lifeCycle, arg_19_1)
end

function ConditionStruct:_doFunctionsFromFuncList(arg_20_1)
	arg_20_1 = arg_20_1 or {}
	arg_20_1.functionId = self._functionId

	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(self._funcList) do
		if not self:isNeedRefreshRedCond(self._idList[iter_20_0], self._redId) and not var_0_2:isNeedRefreshWithId(self._idList[iter_20_0], arg_20_1, self._redId) then
			local var_20_1, var_20_2 = var_0_2:getCacheDataById(self._idList[iter_20_0], self._redId)

			if not var_20_1 then
				return false
			elseif var_20_2 then
				var_20_0 = var_20_2
			end
		else
			local var_20_3, var_20_4 = iter_20_1(arg_20_1)

			var_0_2:refreshCacheById(self._idList[iter_20_0], var_20_3, var_20_4, arg_20_1, self._redId)

			if var_20_3 then
				if var_20_4 then
					var_20_0 = var_20_4
				end
			else
				return false
			end
		end
	end

	return true, var_20_0
end

function ConditionStruct:isNeedRefreshRedCond(arg_21_1, arg_21_2)
	if #self._eventList <= 0 then
		return true
	end

	if self._style == var_0_0.STYLE.NEW_WORD then
		return true
	end

	if ({
		[59] = true,
		[324] = true,
		[537] = true,
		[536] = true,
		[1031] = true,
		[1001] = true,
		[5000003] = true,
		[60] = true,
		[407] = true,
		[68] = true,
		[5000004] = true
	})[arg_21_1] then
		return true
	end

	return false
end

function ConditionStruct:isMeet(arg_22_1, arg_22_2)
	if self:_isDuringLifeCycle(arg_22_1) then
		return self:_doFunctionsFromFuncList(arg_22_2)
	end

	return false
end

function ConditionStruct:isDebugMeet(arg_23_1, arg_23_2)
	if self:_isDuringLifeCycle(arg_23_1) then
		return self:_doDebugFunctionsFromFuncList(arg_23_2)
	end

	return false
end

function ConditionStruct:_doDebugFunctionsFromFuncList(arg_24_1)
	arg_24_1 = arg_24_1 or {}
	arg_24_1.functionId = self._functionId

	local var_24_0 = {}
	local var_24_1

	for iter_24_0, iter_24_1 in ipairs(self._funcList) do
		if not self:isNeedRefreshRedCond(self._idList[iter_24_0], self._redId) and not var_0_2:isNeedRefreshWithId(self._idList[iter_24_0], arg_24_1, self._redId) then
			local var_24_2, var_24_3 = var_0_2:getCacheDataById(self._idList[iter_24_0], self._redId)

			if not var_24_2 then
				return false
			else
				if var_24_3 then
					var_24_1 = var_24_3
				end

				var_24_0[#var_24_0 + 1] = iter_24_0
			end
		else
			local var_24_4, var_24_5 = iter_24_1(arg_24_1)

			var_0_2:refreshCacheById(self._idList[iter_24_0], var_24_4, var_24_5, arg_24_1, self._redId)

			if var_24_4 then
				if var_24_5 then
					var_24_1 = var_24_5
				end

				var_24_0[#var_24_0 + 1] = iter_24_0
			else
				return false
			end
		end
	end

	return true, var_24_1, var_24_0
end

return ConditionStruct
