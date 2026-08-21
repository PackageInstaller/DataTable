local var_0_0 = class("LinerActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.curFinishEvents = {}

	local var_1_0 = arg_1_1.date1_key_value_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.curFinishEvents[iter_1_1.key] = arg_1_0.curFinishEvents[iter_1_1.key] or {}

		table.insert(arg_1_0.curFinishEvents[iter_1_1.key], iter_1_1.value)
	end

	arg_1_0.timeGroupIds = arg_1_0:getConfig("config_data")[1]
	arg_1_0.roomGroupIds = arg_1_0:getConfig("config_data")[2]
	arg_1_0.eventGroupIds = arg_1_0:getConfig("config_data")[3]
	arg_1_0.times = {}
	arg_1_0.timeMaxIdx = 1
	arg_1_0.timeIdx2Day = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.timeGroupIds) do
		for iter_1_4, iter_1_5 in ipairs(pg.activity_liner_time_group[iter_1_3].ids) do
			arg_1_0.timeMaxIdx = 1
			arg_1_0.times[1] = LinerTime.New(iter_1_5)
			arg_1_0.timeIdx2Day[1] = iter_1_2
		end
	end

	if arg_1_0.data2 == 0 then
		arg_1_0.data2 = 1
	end

	return
end

function var_0_0.GetTimeGroupIds(arg_2_0)
	return arg_2_0.timeGroupIds
end

function var_0_0.GetRoomGroupIds(arg_3_0)
	return arg_3_0.roomGroupIds
end

function var_0_0.GetEventGroupIds(arg_4_0)
	return arg_4_0.eventGroupIds
end

function var_0_0.UpdateRoomIdx(arg_5_0, arg_5_1)
	arg_5_0.data2 = arg_5_1 and 1 or arg_5_0.data2 + 1

	return
end

function var_0_0.GetRoomIdx(arg_6_0)
	return arg_6_0.data2
end

function var_0_0.UpdateTimeIdx(arg_7_0)
	arg_7_0.data1 = arg_7_0.data1 + 1

	arg_7_0:ClearCurEventInfo()

	return
end

function var_0_0.GetCurIdx(arg_8_0)
	return math.min(arg_8_0.data1, arg_8_0.timeMaxIdx)
end

function var_0_0.GetTimeMaxIdx(arg_9_0)
	return arg_9_0.timeMaxIdx
end

function var_0_0.IsFinishAllTime(arg_10_0)
	return arg_10_0.data1 > arg_10_0.timeMaxIdx
end

function var_0_0.GetFinishTimeIds(arg_11_0)
	local var_11_0 = arg_11_0:GetCurIdx()

	for iter_11_0 = 1, arg_11_0.data1 - 1 do
		table.insert({}, arg_11_0.times[iter_11_0].id)
	end

	return {}
end

function var_0_0.GetDayByIdx(arg_12_0, arg_12_1)
	return arg_12_0.timeIdx2Day[arg_12_1]
end

function var_0_0.GetTimeByIdx(arg_13_0, arg_13_1)
	return arg_13_0.times[arg_13_1]
end

function var_0_0.GetCurTime(arg_14_0)
	return arg_14_0.times[arg_14_0:GetCurIdx()]
end

function var_0_0.CheckTimeFinish(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or arg_15_0:GetCurTime()

	return switch(var_15_0:GetType(), {
		[LinerTime.TYPE.TARGET] = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed(var_15_0:GetStory())
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			return arg_15_0:GetRemainExploreCnt() == 0
		end,
		[LinerTime.TYPE.EVENT] = function()
			if arg_15_0:GetRoomIdx() ~= #var_15_0:GetParamInfo() then
				return false
			else
				return arg_15_0:CheckRoomFinish(arg_15_1)
			end

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed(var_15_0:GetStory())
		end
	}, function()
		return false
	end)
end

function var_0_0.CheckRoomFinish(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 or arg_21_0:GetCurTime()

	if var_21_0:GetType() ~= LinerTime.TYPE.EVENT then
		return false
	end

	local var_21_1 = var_21_0:GetParamInfo()[arg_21_0:GetRoomIdx()]

	if var_21_1[2] == LinerTime.EVENT_SUB_TYPE.CLUE then
		local var_21_2 = arg_21_0:GetCurEventInfo()

		return underscore.all(var_21_1[4], function(arg_22_0)
			if not var_21_2[var_21_1[1]] then
				return false
			end

			return table.contains(var_21_2[var_21_1[1]], arg_22_0)
		end)
	elseif var_21_1[2] == LinerTime.EVENT_SUB_TYPE.STORY then
		return pg.NewStoryMgr.GetInstance():IsPlayed(var_21_1[3])
	end

	return false
end

function var_0_0.GetRemainExploreCnt(arg_23_0)
	local var_23_0 = 0

	for iter_23_0 = 1, arg_23_0:GetCurIdx() do
		var_23_0 = var_23_0 + arg_23_0.times[iter_23_0]:GetExploreCnt()
	end

	return var_23_0 - #arg_23_0:GetExploredRoomIds()
end

function var_0_0.GetTimeId2ExploredIds(arg_24_0)
	local var_24_0 = arg_24_0:GetExploredRoomIds()

	for iter_24_0 = 1, arg_24_0:GetCurIdx() do
		local var_24_2

		if arg_24_0.times[iter_24_0]:GetType() == LinerTime.TYPE.EXPLORE then
			({})[arg_24_0.times[iter_24_0].id] = {}

			local var_24_1 = arg_24_0.times[iter_24_0]:GetExploreCnt()

			for iter_24_1 = 1, math.min(1 + var_24_1 - 1, #var_24_0) do
				table.insert(({})[arg_24_0.times[iter_24_0].id], var_24_0[iter_24_1])
			end

			var_24_2 = 1 + var_24_1
		end
	end

	return {}
end

function var_0_0.GetExploredRoomIds(arg_25_0)
	return arg_25_0.data4_list
end

function var_0_0.AddExploredRoom(arg_26_0, arg_26_1)
	table.insert(arg_26_0:GetExploredRoomIds(), arg_26_1)

	return
end

function var_0_0.GetCurEventInfo(arg_27_0)
	return arg_27_0.curFinishEvents
end

function var_0_0.ClearCurEventInfo(arg_28_0)
	arg_28_0.curFinishEvents = {}

	return
end

function var_0_0.AddEvent(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.curFinishEvents[arg_29_1] = arg_29_0.curFinishEvents[arg_29_1] or {}

	table.insert(arg_29_0.curFinishEvents[arg_29_1], arg_29_2)

	return
end

function var_0_0.GetFinishEventIds(arg_30_0)
	local var_30_0 = {}

	for iter_30_0 = 1, arg_30_0:GetCurIdx() - 1 do
		var_30_0 = table.mergeArray(var_30_0, arg_30_0.times[iter_30_0]:GetEventIds(), true)
	end

	for iter_30_1, iter_30_2 in pairs(arg_30_0:GetCurEventInfo()) do
		var_30_0 = table.mergeArray(var_30_0, iter_30_2, true)
	end

	return var_30_0
end

function var_0_0.AddTimeAwardFlag(arg_31_0, arg_31_1)
	arg_31_0.data1_list[arg_31_1] = 1

	return
end

function var_0_0.IsGotTimeAward(arg_32_0, arg_32_1)
	return arg_32_0.data1_list[arg_32_1] and arg_32_0.data1_list[arg_32_1] ~= 0
end

function var_0_0.AddRoomAwardFlag(arg_33_0, arg_33_1)
	arg_33_0.data2_list[arg_33_1] = 1

	return
end

function var_0_0.IsGotRoomAward(arg_34_0, arg_34_1)
	return arg_34_0.data2_list[arg_34_1] and arg_34_0.data2_list[arg_34_1] ~= 0
end

function var_0_0.AddEventAwardFlag(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.data3_list[arg_35_1] = arg_35_2

	return
end

function var_0_0.IsGotEventAward(arg_36_0, arg_36_1)
	return arg_36_0.data3_list[arg_36_1] and arg_36_0.data3_list[arg_36_1] ~= 0
end

function var_0_0.GetEventAwardFlag(arg_37_0, arg_37_1)
	return arg_37_0.data3_list[arg_37_1]
end

function var_0_0.GetAllExploreRoomIds(arg_38_0)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.roomGroupIds) do
		var_38_0 = table.mergeArray(var_38_0, pg.activity_liner_room_group[iter_38_1].ids, true)
	end

	return var_38_0
end

function var_0_0.GetBgmName(arg_39_0)
	local var_39_0 = arg_39_0:IsFinishAllTime()

	var_39_0 = var_39_0 and pg.NewStoryMgr.GetInstance():IsPlayed(arg_39_0:getConfig("config_client").endingstory[1])

	if var_39_0 then
		return arg_39_0:GetCurTime():GetBgm((arg_39_0:GetReallyTimeType(os.date("*t", os.time()).hour)))
	else
		return arg_39_0:GetCurTime():GetBgm()
	end

	return
end

function var_0_0.GetReallyTimeType(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0:getConfig("config_client").endingtime) do
		if arg_40_1 >= iter_40_1[1][1] and arg_40_1 < iter_40_1[1][2] then
			return iter_40_1[2]
		end
	end

	return LinerTime.BG_TYPE.DAY
end

return var_0_0
