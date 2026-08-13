class = var_0_10000

local var_0_0 = "ManualSignActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

var_0_1.OP_SIGN = 1
var_0_1.OP_GET_AWARD = 2
var_0_1.STATE_EMPTY = 0
var_0_1.STATE_CAN_GET = 1
var_0_1.STATE_GOT = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.dataConfig = var_2.activity_event_sign[arg_1_0.id]

	return
end

function var_0_1.GetSignedList(arg_2_0)
	return arg_2_0.data1_list
end

function var_0_1.GetIndexByToday(arg_3_0)
	return arg_3_0:getDayIndex()
end

function var_0_1.GetTotalDayCnt(arg_4_0)
	return #arg_4_0:GetDropList()
end

function var_0_1.GetDropList(arg_5_0)
	local var_5_0 = {}

	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.dataConfig.drop_display) do
		table = var_1_10007

		var_1_10007.insert(var_5_0, {
			type = iter_5_1[1],
			id = iter_5_1[2],
			count = iter_5_1[3]
		})
	end

	return var_5_0
end

function var_0_1.TodayIsSigned(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetSignedList(var_6_0)
	local var_6_2 = arg_6_0:GetIndexByToday()

	table = var_6_0

	return var_6_0.contains(var_6_1, var_6_2)
end

function var_0_1.Signed(arg_7_0)
	local var_7_0 = arg_7_0:GetIndexByToday()

	table = var_1_10002

	if not var_1_10002.contains(arg_7_0.data1_list, var_7_0) then
		arg_7_0.data1 = arg_7_0.data1 + 1
		table = var_2

		var_2.insert(arg_7_0.data1_list, var_7_0)
	end

	return
end

function var_0_1.GetSignedDayCnt(arg_8_0)
	return #arg_8_0.data1_list
end

function var_0_1.CanGetAward(arg_9_0)
	return arg_9_0:GetGetAwardCnt() < arg_9_0:GetSignedDayCnt()
end

function var_0_1.AnyAwardCanGet(arg_10_0)
	return #arg_10_0:GetCanGetAwardIndexList() > 0
end

function var_0_1.GetCanGetAwardIndexList(arg_11_0)
	if not arg_11_0:CanGetAward() then
		return {}
	end

	local var_11_0 = arg_11_0:GetGetAwardCnt()

	math = var_1_10002

	if var_1_10002.max(arg_11_0:GetSignedDayCnt() - var_11_0, 0) <= 0 then
		return {}
	end

	table = var_3

	var_3.sort(arg_11_0.data2_list)

	local var_11_1 = var_11_0 == 0 and 0 or arg_11_0.data2_list[var_11_0]
	local var_11_2 = arg_11_0:GetTotalDayCnt()

	math = var_5

	local var_11_3 = var_5.min(var_11_1 + var_2, var_11_2)
	local var_11_4 = {}

	for iter_11_0 = var_11_1 + 1, var_11_3 do
		table = var_1_10011

		var_1_10011.insert(var_11_4, iter_11_0)
	end

	return var_11_4
end

function var_0_1.GetAwardState(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetCanGetAwardIndexList()

	table = var_1_10003

	if var_1_10003.contains(var_12_0, arg_12_1) then
		return var_0_1.STATE_CAN_GET
	else
		table = var_3

		if var_3.contains(arg_12_0.data2_list, arg_12_1) then
			return var_0_1.STATE_GOT
		else
			return var_0_1.STATE_EMPTY
		end
	end

	return
end

function var_0_1.GetGetAwardCnt(arg_13_0)
	return #arg_13_0.data2_list
end

function var_0_1.GetAllAwards(arg_14_0)
	local var_14_0 = arg_14_0:GetCanGetAwardIndexList()

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(var_14_0) do
		arg_14_0:GetIndexAward(iter_14_1)
	end

	return
end

function var_0_1.GetIndexAward(arg_15_0, arg_15_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_15_0.data2_list, arg_15_1) then
		arg_15_0.data2 = arg_15_0.data2 + 1
		table = var_2

		var_2.insert(arg_15_0.data2_list, arg_15_1)
	end

	return
end

function var_0_1.IsManualSignActAndAnyAwardCanGet(arg_16_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_16_0 = var_1_10001(var_1_10003)

	if not var_1.getActivityById(var_16_0, arg_16_0) or var_1:isEnd() then
		return false
	end

	isa = var_1_10002

	local var_16_1 = var_1

	ManualSignActivity = var_1_10005

	if not var_1_10002(var_16_1, var_1_10005) then
		return false
	end

	return var_1:AnyAwardCanGet()
end

return var_0_1
