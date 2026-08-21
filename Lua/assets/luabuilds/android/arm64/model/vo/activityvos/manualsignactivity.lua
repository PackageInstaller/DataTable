local var_0_0 = class("ManualSignActivity", import("model.vo.Activity"))

var_0_0.OP_SIGN = 1
var_0_0.OP_GET_AWARD = 2
var_0_0.STATE_EMPTY = 0
var_0_0.STATE_CAN_GET = 1
var_0_0.STATE_GOT = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.dataConfig = pg.activity_event_sign[arg_1_0.id]

	return
end

function var_0_0.GetSignedList(arg_2_0)
	return arg_2_0.data1_list
end

function var_0_0.GetIndexByToday(arg_3_0)
	return arg_3_0:getDayIndex()
end

function var_0_0.GetTotalDayCnt(arg_4_0)
	return #arg_4_0:GetDropList()
end

function var_0_0.GetDropList(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.dataConfig.drop_display) do
		table.insert({}, {
			type = iter_5_1[1],
			id = iter_5_1[2],
			count = iter_5_1[3]
		})
	end

	return {}
end

function var_0_0.TodayIsSigned(arg_6_0)
	return table.contains(arg_6_0:GetSignedList(), (arg_6_0:GetIndexByToday()))
end

function var_0_0.Signed(arg_7_0)
	local var_7_0 = arg_7_0:GetIndexByToday()

	if not table.contains(arg_7_0.data1_list, var_7_0) then
		arg_7_0.data1 = arg_7_0.data1 + 1

		table.insert(arg_7_0.data1_list, var_7_0)
	end

	return
end

function var_0_0.GetSignedDayCnt(arg_8_0)
	return #arg_8_0.data1_list
end

function var_0_0.CanGetAward(arg_9_0)
	return arg_9_0:GetGetAwardCnt() < arg_9_0:GetSignedDayCnt()
end

function var_0_0.AnyAwardCanGet(arg_10_0)
	return #arg_10_0:GetCanGetAwardIndexList() > 0
end

function var_0_0.GetCanGetAwardIndexList(arg_11_0)
	if not arg_11_0:CanGetAward() then
		return {}
	end

	local var_11_0 = arg_11_0:GetGetAwardCnt()
	local var_11_1 = math.max(arg_11_0:GetSignedDayCnt() - var_11_0, 0)

	if var_11_1 <= 0 then
		return {}
	end

	table.sort(arg_11_0.data2_list)

	for iter_11_0 = (var_11_0 == 0 and 0 or arg_11_0.data2_list[var_11_0]) + 1, math.min((var_11_0 == 0 and 0 or arg_11_0.data2_list[var_11_0]) + var_11_1, (arg_11_0:GetTotalDayCnt())) do
		table.insert({}, iter_11_0)
	end

	return {}
end

function var_0_0.GetAwardState(arg_12_0, arg_12_1)
	if table.contains(arg_12_0:GetCanGetAwardIndexList(), arg_12_1) then
		return var_0_0.STATE_CAN_GET
	elseif table.contains(arg_12_0.data2_list, arg_12_1) then
		return var_0_0.STATE_GOT
	else
		return var_0_0.STATE_EMPTY
	end

	return
end

function var_0_0.GetGetAwardCnt(arg_13_0)
	return #arg_13_0.data2_list
end

function var_0_0.GetAllAwards(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs((arg_14_0:GetCanGetAwardIndexList())) do
		arg_14_0:GetIndexAward(iter_14_1)
	end

	return
end

function var_0_0.GetIndexAward(arg_15_0, arg_15_1)
	if not table.contains(arg_15_0.data2_list, arg_15_1) then
		arg_15_0.data2 = arg_15_0.data2 + 1

		table.insert(arg_15_0.data2_list, arg_15_1)
	end

	return
end

function var_0_0.IsManualSignActAndAnyAwardCanGet(arg_16_0)
	local var_16_0 = getProxy(ActivityProxy):getActivityById(arg_16_0)

	if not var_16_0 or var_16_0:isEnd() then
		return false
	end

	if not isa(var_16_0, ManualSignActivity) then
		return false
	end

	return var_16_0:AnyAwardCanGet()
end

return var_0_0
