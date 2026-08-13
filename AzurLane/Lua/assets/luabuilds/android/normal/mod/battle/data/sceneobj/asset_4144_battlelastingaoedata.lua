ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleLastingAOEData", var_0.Battle.BattleAOEData)

var_0.Battle.BattleLastingAOEData = var_0_2
var_0_2.__name = "BattleLastingAOEData"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_5)

	arg_1_0._exitCldFunc = arg_1_4

	if arg_1_6 then
		arg_1_0.Settle = arg_1_0.frequentlySettle
	end

	arg_1_0._handledList = {}

	return
end

function var_0_2.Dispose(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0._handledList) do
		arg_2_0._exitCldFunc(iter_2_0)

		arg_2_0._handledList[iter_2_0] = nil
	end

	arg_2_0._exitCldFunc = nil
	arg_2_0._handledList = nil

	var_0_2.super.Dispose(arg_2_0)

	return
end

function var_0_2.Settle(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0._cldObjList) do
		var_3_1[iter_3_1.UID] = true

		if not arg_3_0._handledList[iter_3_1] then
			var_3_0[#var_3_0 + 1] = iter_3_1
			arg_3_0._handledList[iter_3_1] = true
		end
	end

	arg_3_0.SortCldObjList(var_3_0)

	local var_3_2 = arg_3_0._cldComponent
	local var_3_3 = var_3.GetCldData(var_3_2).func
	local var_3_4 = var_3_0

	obj = var_5

	var_3_3(var_3_4, var_5)

	pairs = var_3_3

	for iter_3_2, iter_3_3 in var_3_3(arg_3_0._handledList) do
		if not var_3_1[iter_3_2.UID] or iter_3_2.ImmuneCLD == true then
			arg_3_0._exitCldFunc(iter_3_2)

			arg_3_0._handledList[iter_3_2] = nil
		end
	end

	return
end

function var_0_2.frequentlySettle(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0._cldObjList) do
		var_4_0[iter_4_1.UID] = true

		if not arg_4_0._handledList[iter_4_1] then
			arg_4_0._handledList[iter_4_1] = true
		end
	end

	pairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0._handledList) do
		if not var_4_0[iter_4_2.UID] then
			arg_4_0._exitCldFunc(iter_4_2)

			arg_4_0._handledList[iter_4_2] = nil
		end
	end

	arg_4_0.SortCldObjList(arg_4_0._cldObjList)

	local var_4_1 = arg_4_0._cldComponent

	var_2.GetCldData(var_4_1).func(arg_4_0._cldObjList)

	return
end

function var_0_2.ForceExit(arg_5_0, arg_5_1)
	local var_5_0

	pairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0._handledList) do
		if iter_5_0.UID == arg_5_1 then
			var_5_0 = iter_5_0

			break
		end
	end

	if var_5_0 then
		arg_5_0._exitCldFunc(var_5_0)

		arg_5_0._handledList[var_5_0] = nil
	end

	return
end

return
