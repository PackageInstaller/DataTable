class = var_0_10000

local var_0_0 = "LinerActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.curFinishEvents = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.date1_key_value_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		local var_1_1

		if not arg_1_0.curFinishEvents[iter_1_1.key] then
			var_1_1 = arg_1_0.curFinishEvents
			var_1_1[iter_1_1.key] = {}
		end

		table = var_1_1

		var_1_1.insert(arg_1_0.curFinishEvents[iter_1_1.key], iter_1_1.value)
	end

	arg_1_0.timeGroupIds = arg_1_0:getConfig("config_data")[1]
	arg_1_0.roomGroupIds = arg_1_0:getConfig("config_data")[2]
	arg_1_0.eventGroupIds = arg_1_0:getConfig("config_data")[3]
	arg_1_0.times = {}
	arg_1_0.timeMaxIdx = 1
	arg_1_0.timeIdx2Day = {}

	local var_1_2 = 1

	ipairs = var_3

	for iter_1_2, iter_1_3 in var_3(arg_1_0.timeGroupIds) do
		ipairs = var_1_10008
		pg = var_1_10010

		for iter_1_4, iter_1_5 in var_1_10008(var_1_10010.activity_liner_time_group[iter_1_3].ids) do
			arg_1_0.timeMaxIdx = var_1_2

			local var_1_3 = arg_1_0.times

			LinerTime = var_1_10014
			var_1_3[var_1_2] = var_1_10014.New(iter_1_5)
			arg_1_0.timeIdx2Day[var_1_2] = iter_1_2
			var_1_2 = var_1_2 + 1
		end
	end

	if arg_1_0.data2 == 0 then
		arg_1_0.data2 = 1
	end

	return
end

function var_0_1.GetTimeGroupIds(arg_2_0)
	return arg_2_0.timeGroupIds
end

function var_0_1.GetRoomGroupIds(arg_3_0)
	return arg_3_0.roomGroupIds
end

function var_0_1.GetEventGroupIds(arg_4_0)
	return arg_4_0.eventGroupIds
end

function var_0_1.UpdateRoomIdx(arg_5_0, arg_5_1)
	arg_5_0.data2 = arg_5_1 and 1 or arg_5_0.data2 + 1

	return
end

function var_0_1.GetRoomIdx(arg_6_0)
	return arg_6_0.data2
end

function var_0_1.UpdateTimeIdx(arg_7_0)
	arg_7_0.data1 = arg_7_0.data1 + 1

	arg_7_0:ClearCurEventInfo()

	return
end

function var_0_1.GetCurIdx(arg_8_0)
	math = var_1_10001

	return var_1_10001.min(arg_8_0.data1, arg_8_0.timeMaxIdx)
end

function var_0_1.GetTimeMaxIdx(arg_9_0)
	return arg_9_0.timeMaxIdx
end

function var_0_1.IsFinishAllTime(arg_10_0)
	return arg_10_0.data1 > arg_10_0.timeMaxIdx
end

function var_0_1.GetFinishTimeIds(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:GetCurIdx()

	for iter_11_0 = 1, arg_11_0.data1 - 1 do
		table = var_1_10007

		var_1_10007.insert(var_11_0, arg_11_0.times[iter_11_0].id)
	end

	return var_11_0
end

function var_0_1.GetDayByIdx(arg_12_0, arg_12_1)
	return arg_12_0.timeIdx2Day[arg_12_1]
end

function var_0_1.GetTimeByIdx(arg_13_0, arg_13_1)
	return arg_13_0.times[arg_13_1]
end

function var_0_1.GetCurTime(arg_14_0)
	return arg_14_0.times[arg_14_0:GetCurIdx()]
end

function var_0_1.CheckTimeFinish(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or arg_15_0:GetCurTime()

	switch = var_1_10003

	local var_15_1 = var_15_0
	local var_15_2 = var_15_0.GetType(var_15_1)
	local var_15_3 = {}

	LinerTime = var_15_1
	var_15_3[var_15_1.TYPE.TARGET] = function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.NewStoryMgr.GetInstance()
		local var_16_1 = var_0.IsPlayed
		local var_16_2 = var_15_0

		return var_16_1(var_16_0, var_3.GetStory(var_16_2))
	end
	LinerTime = var_7
	var_15_3[var_7.TYPE.EXPLORE] = function()
		local var_17_0 = arg_15_0

		return var_0.GetRemainExploreCnt(var_17_0) == 0
	end
	LinerTime = var_7
	var_15_3[var_7.TYPE.EVENT] = function()
		local var_18_0 = var_15_0
		local var_18_1 = var_0.GetParamInfo(var_18_0)
		local var_18_2 = arg_15_0

		if var_1.GetRoomIdx(var_18_2) ~= #var_18_1 then
			return false
		else
			local var_18_3 = arg_15_0

			return var_1.CheckRoomFinish(var_18_3, arg_15_1)
		end

		return
	end
	LinerTime = var_7
	var_15_3[var_7.TYPE.STORY] = function()
		pg = var_2_10000

		local var_19_0 = var_2_10000.NewStoryMgr.GetInstance()
		local var_19_1 = var_0.IsPlayed
		local var_19_2 = var_15_0

		return var_19_1(var_19_0, var_3.GetStory(var_19_2))
	end

	return var_1_10003(var_15_2, var_15_3, function()
		return false
	end)
end

function var_0_1.CheckRoomFinish(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_1 then
		::label_21_0::

		var_1_10004 = arg_21_0
		var_21_0 = arg_21_0.GetCurTime(var_1_10004)
	end

	local var_21_1 = var_21_0:GetType()

	LinerTime = var_1_10004

	if var_21_1 ~= var_1_10004.TYPE.EVENT then
		return false
	end

	local var_21_2 = var_21_0:GetParamInfo()
	local var_21_3 = arg_21_0
	local var_21_4 = var_21_2[arg_21_0.GetRoomIdx(var_21_3)][2]

	LinerTime = var_21_3

	if var_21_4 == var_21_3.EVENT_SUB_TYPE.CLUE then
		local var_21_5 = arg_21_0:GetCurEventInfo()

		underscore = var_6

		return var_6.all(var_4[4], function(arg_22_0)
			local var_22_0 = var_0[1]

			if not var_21_5[var_22_0] then
				return false
			end

			table = var_2

			return var_2.contains(var_21_5[var_22_0], arg_22_0)
		end)
	else
		local var_21_6 = var_4[2]

		LinerTime = var_6

		if var_21_6 == var_6.EVENT_SUB_TYPE.STORY then
			pg = var_21_6

			local var_21_7 = var_21_6.NewStoryMgr.GetInstance()

			return var_5.IsPlayed(var_21_7, var_4[3])
		end
	end

	return false
end

function var_0_1.GetRemainExploreCnt(arg_23_0)
	local var_23_0 = 0

	for iter_23_0 = 1, arg_23_0:GetCurIdx() do
		local var_23_1 = arg_23_0.times[iter_23_0]

		var_23_0 = var_23_0 + var_6.GetExploreCnt(var_23_1)
	end

	return var_23_0 - #arg_23_0:GetExploredRoomIds()
end

function var_0_1.GetTimeId2ExploredIds(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = 1
	local var_24_2 = arg_24_0:GetExploredRoomIds()

	for iter_24_0 = 1, arg_24_0:GetCurIdx() do
		local var_24_3 = arg_24_0.times[iter_24_0]
		local var_24_4 = var_8.GetType(var_24_3)

		LinerTime = var_1_10010

		if var_24_4 == var_1_10010.TYPE.EXPLORE then
			var_24_0[var_8.id] = {}

			local var_24_5 = var_8
			local var_24_6 = var_8.GetExploreCnt(var_24_5)

			var_1_10010 = var_24_1
			math = var_24_5

			for iter_24_1 = var_1_10010, var_24_5.min(var_24_1 + var_24_6 - 1, #var_24_2) do
				table = var_14

				var_14.insert(var_24_0[var_8.id], var_24_2[iter_24_1])
			end

			var_24_1 = var_24_1 + var_24_6
		end
	end

	return var_24_0
end

function var_0_1.GetExploredRoomIds(arg_25_0)
	return arg_25_0.data4_list
end

function var_0_1.AddExploredRoom(arg_26_0, arg_26_1)
	table = var_1_10002

	var_1_10002.insert(arg_26_0:GetExploredRoomIds(), arg_26_1)

	return
end

function var_0_1.GetCurEventInfo(arg_27_0)
	return arg_27_0.curFinishEvents
end

function var_0_1.ClearCurEventInfo(arg_28_0)
	arg_28_0.curFinishEvents = {}

	return
end

function var_0_1.AddEvent(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if not arg_29_0.curFinishEvents[arg_29_1] then
		var_29_0 = arg_29_0.curFinishEvents
		var_29_0[arg_29_1] = {}
	end

	table = var_29_0

	var_29_0.insert(arg_29_0.curFinishEvents[arg_29_1], arg_29_2)

	return
end

function var_0_1.GetFinishEventIds(arg_30_0)
	local var_30_0 = {}

	for iter_30_0 = 1, arg_30_0:GetCurIdx() - 1 do
		local var_30_1 = arg_30_0.times[iter_30_0]

		table = var_1_10007
		var_30_0 = var_1_10007.mergeArray(var_30_0, var_30_1:GetEventIds(), true)
	end

	pairs = var_2

	for iter_30_1, iter_30_2 in var_2(arg_30_0:GetCurEventInfo()) do
		table = var_1_10007
		var_30_0 = var_1_10007.mergeArray(var_30_0, iter_30_2, true)
	end

	return var_30_0
end

function var_0_1.AddTimeAwardFlag(arg_31_0, arg_31_1)
	arg_31_0.data1_list[arg_31_1] = 1

	return
end

function var_0_1.IsGotTimeAward(arg_32_0, arg_32_1)
	local var_32_0

	if arg_32_0.data1_list[arg_32_1] then
		var_32_0 = arg_32_0.data1_list[arg_32_1] ~= 0
	end

	return var_32_0
end

function var_0_1.AddRoomAwardFlag(arg_33_0, arg_33_1)
	arg_33_0.data2_list[arg_33_1] = 1

	return
end

function var_0_1.IsGotRoomAward(arg_34_0, arg_34_1)
	local var_34_0

	if arg_34_0.data2_list[arg_34_1] then
		var_34_0 = arg_34_0.data2_list[arg_34_1] ~= 0
	end

	return var_34_0
end

function var_0_1.AddEventAwardFlag(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.data3_list[arg_35_1] = arg_35_2

	return
end

function var_0_1.IsGotEventAward(arg_36_0, arg_36_1)
	local var_36_0

	if arg_36_0.data3_list[arg_36_1] then
		var_36_0 = arg_36_0.data3_list[arg_36_1] ~= 0
	end

	return var_36_0
end

function var_0_1.GetEventAwardFlag(arg_37_0, arg_37_1)
	return arg_37_0.data3_list[arg_37_1]
end

function var_0_1.GetAllExploreRoomIds(arg_38_0)
	local var_38_0 = {}

	ipairs = var_1_10002

	for iter_38_0, iter_38_1 in var_1_10002(arg_38_0.roomGroupIds) do
		table = var_1_10007
		var_1_10007 = var_1_10007.mergeArray

		local var_38_1 = var_38_0

		pg = var_1_10010
		var_38_0 = var_1_10007(var_38_1, var_1_10010.activity_liner_room_group[iter_38_1].ids, true)
	end

	return var_38_0
end

function var_0_1.GetBgmName(arg_39_0)
	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.getConfig(var_39_0, "config_client").endingstory[1]
	local var_39_3

	if arg_39_0:IsFinishAllTime() then
		pg = var_39_3

		local var_39_2 = var_39_3.NewStoryMgr.GetInstance()

		var_39_3 = var_39_3.IsPlayed(var_39_2, var_39_1)
	end

	if var_39_3 then
		os = var_39_0

		local var_39_4 = var_39_0.date
		local var_39_5 = "*t"

		os = var_1_10006

		local var_39_6 = var_39_4(var_39_5, var_1_10006.time()).hour
		local var_39_7 = arg_39_0:GetReallyTimeType(var_39_6)
		local var_39_8 = arg_39_0:GetCurTime()

		return var_5.GetBgm(var_39_8, var_39_7)
	else
		local var_39_9 = arg_39_0:GetCurTime()

		return var_3.GetBgm(var_39_9)
	end

	return
end

function var_0_1.GetReallyTimeType(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getConfig("config_client").endingtime

	ipairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(var_40_0) do
		if arg_40_1 >= iter_40_1[1][1] and arg_40_1 < var_8[2] then
			return iter_40_1[2]
		end
	end

	LinerTime = var_3

	return var_3.BG_TYPE.DAY
end

return var_0_1
