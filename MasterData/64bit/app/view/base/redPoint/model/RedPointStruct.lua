local var_0_0 = g.core.config.red_point_style_info
local RedPointStruct = class("RedPointStruct")

function RedPointStruct:ctor(arg_1_1, arg_1_2)
	self._id = arg_1_1
	self._conditionList = {}
	self._eventMap = {}

	self:addConditionList(arg_1_2)
end

function RedPointStruct:getId()
	return self._id
end

function RedPointStruct:getConditionList()
	return self._conditionList
end

function RedPointStruct:cloneConditionList(arg_4_1, arg_4_2)
	local var_4_0 = clone(self._conditionList)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		iter_4_1:setStyle(arg_4_1)
		iter_4_1:setLifeCycle(arg_4_2)
	end

	return var_4_0
end

function RedPointStruct:getEventList()
	return table.keys(self._eventMap)
end

function RedPointStruct:getEventMap()
	return self._eventMap
end

function RedPointStruct:addConditionList(arg_7_1)
	if not arg_7_1 or #arg_7_1 == 0 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if not self:_isConditionExist(iter_7_1) then
			table.insert(self._conditionList, iter_7_1)
			self:_addEventList(iter_7_1:getEventList())
		end
	end

	self:_sortConditionList()
end

function RedPointStruct:_sortConditionList()
	if #self._conditionList < 2 then
		return
	end

	table.sort(self._conditionList, function(arg_9_0, arg_9_1)
		return var_0_0.get((arg_9_0:getStyle())).sort_weight > var_0_0.get((arg_9_1:getStyle())).sort_weight
	end)
end

function RedPointStruct:_isConditionExist(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self._conditionList) do
		if iter_10_1:isSame(arg_10_1) then
			return true
		end
	end
end

function RedPointStruct:_addEventList(arg_11_1)
	if #arg_11_1 == 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self._eventMap[iter_11_1] = true
	end
end

function RedPointStruct:getMeetConditionStruct(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self._conditionList) do
		local var_12_0, var_12_1 = iter_12_1:isMeet(self._id, arg_12_1)

		if var_12_0 then
			return iter_12_1, var_12_1
		end
	end
end

function RedPointStruct:debugTraceRedPoint(arg_13_1)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(self._conditionList) do
		local var_13_1, var_13_2, var_13_3 = iter_13_1:isDebugMeet(self._id, arg_13_1)

		if var_13_1 then
			local var_13_4 = iter_13_1:getIdList() or {}
			local var_13_5 = {}

			for iter_13_2, iter_13_3 in ipairs(var_13_3) do
				var_13_5[iter_13_2] = var_13_4[iter_13_3]
			end

			var_13_0 = table.concat({
				"red point(id : ",
				self._id,
				" ) is trigger! condition is : ",
				table.concat(var_13_5, ";"),
				" customData is : ",
				json.encode(arg_13_1)
			})

			release_print(var_13_0)

			break
		end
	end

	return var_13_0
end

return RedPointStruct
