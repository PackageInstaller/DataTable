local var_0_0 = g.core.config.red_point_info
local var_0_1 = g.core.const.ConstMgr.RedPointConst
local RedPointStruct = import(".RedPointStruct")
local ConditionStruct = import(".ConditionStruct")
local RedPointData = class("RedPointData")

function RedPointData:ctor()
	self:initData()
end

function RedPointData:initData()
	self._todayRecordDict = {}
	self._redPointStructMap = {}
	self._loginOnceFinishedMap = {}
end

function RedPointData:getRedPointStruct(arg_3_1)
	local var_3_0 = self._redPointStructMap[arg_3_1]

	if not self._redPointStructMap[arg_3_1] then
		var_3_0 = self:_parseRedPointInfo(arg_3_1)
		self._redPointStructMap[arg_3_1] = var_3_0
	end

	return var_3_0
end

function RedPointData:getRedPointEventMap(arg_4_1)
	if not self:isRedPointIdValid(arg_4_1) then
		return
	end

	local var_4_0 = self:getRedPointStruct(arg_4_1)

	if var_4_0 then
		return var_4_0:getEventMap()
	else
		g.core.log:error("Error!! GetRedPointEventMap ==> RedPointStruct is nil, redPointId:", arg_4_1)
	end
end

function RedPointData:isRedPointIdValid(arg_5_1)
	return checknumber(arg_5_1) > 0
end

function RedPointData:_parseRedPointInfo(arg_6_1)
	local var_6_0 = var_0_0.get(arg_6_1)

	if not var_6_0 then
		g.core.log:error("Error!! Invalid RedPointId: " .. tostring(arg_6_1))

		return
	end

	local var_6_1 = {}
	local var_6_2 = 1

	while var_0_0.hasKey("style_" .. 1) do
		if var_6_0["style_" .. 1] > 0 then
			if ConditionStruct.isValidIdsStr(var_6_0["conditions_" .. var_6_2]) then
				table.insert(var_6_1, (ConditionStruct.new({
					style = var_6_0["style_" .. 1],
					lifeCycle = var_6_0["timing_" .. var_6_2],
					functionId = var_6_0.func_id,
					idsStr = var_6_0["conditions_" .. var_6_2],
					redPointId = arg_6_1
				})))
			end

			for iter_6_0, iter_6_1 in ipairs((ConditionStruct.parseIdListByIdsStr(var_6_0["sub_" .. var_6_2]))) do
				local var_6_3 = self:getRedPointStruct(iter_6_1)

				if var_6_3 then
					table.insertto(var_6_1, (var_6_3:cloneConditionList(var_6_0["style_" .. 1], var_6_0["timing_" .. var_6_2])))
				end
			end
		end

		var_6_2 = var_6_2 + 1
	end

	if #var_6_1 > 0 then
		return RedPointStruct.new(arg_6_1, var_6_1)
	else
		g.core.log:info("Error!! Invalid red_point_info by id: " .. tostring(arg_6_1))
	end
end

function RedPointData:recordFinishedRedPoint(arg_7_1, arg_7_2)
	if arg_7_1 == var_0_1.LIFE_CYCLE.RESIDENT then
		return
	elseif checknumber(arg_7_2) == 0 then
		g.core.log:info("----------     Red point redPointId is nil    -----------")

		return
	elseif arg_7_1 == var_0_1.LIFE_CYCLE.LOGIN_ONCE and self._loginOnceFinishedMap[arg_7_2] ~= var_0_1.FINISHED.YES then
		self._loginOnceFinishedMap[arg_7_2] = var_0_1.FINISHED.YES
	end
end

function RedPointData:isRedPointFinished(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1.LIFE_CYCLE.RESIDENT then
		return false
	elseif checknumber(arg_8_2) == 0 then
		g.core.log:info("----------     Red point redPointId is nil    -----------")

		return false
	elseif arg_8_1 == var_0_1.LIFE_CYCLE.LOGIN_ONCE then
		return self._loginOnceFinishedMap[arg_8_2] == var_0_1.FINISHED.YES
	end
end

function RedPointData:getTodayRecordTime(arg_9_1, arg_9_2)
	local var_9_0 = "user"

	if arg_9_2 then
		var_9_0 = "user_" .. (g.core.network.GameNetProxy:getUserId() or 0)
	end

	self._todayRecordDict[var_9_0] = self._todayRecordDict[var_9_0] or g.core.common.Storage:load("today_record_key.json", arg_9_2) or {}

	if self._todayRecordDict[var_9_0][arg_9_1] then
		return self._todayRecordDict[var_9_0][arg_9_1]
	else
		return 0
	end
end

function RedPointData:todayIsRecord(arg_10_1, arg_10_2)
	return g.core.common.ServerTime:isToday((self:getTodayRecordTime(arg_10_1, arg_10_2)))
end

function RedPointData:recordTodayKey(arg_11_1, arg_11_2)
	if not g.core.common.ServerTime:isToday((self:getTodayRecordTime(arg_11_1, arg_11_2))) then
		local var_11_1 = self._todayRecordDict[(arg_11_2 or nil) and "user_" .. (g.core.network.GameNetProxy:getUserId() or 0)]

		var_11_1[arg_11_1] = g.core.common.ServerTime:getTime()

		g.core.common.Storage:save("today_record_key.json", var_11_1, arg_11_2)
	end
end

return RedPointData
