ys = ys or {}

local var_0_1 = class("BattleLastingAOEData", ys.Battle.BattleAOEData)

ys.Battle.BattleLastingAOEData = var_0_1
var_0_1.__name = "BattleLastingAOEData"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_5)

	arg_1_0._exitCldFunc = arg_1_4

	if arg_1_6 then
		arg_1_0.Settle = arg_1_0.frequentlySettle
	end

	arg_1_0._handledList = {}

	return
end

function var_0_1.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0._handledList) do
		arg_2_0._exitCldFunc(iter_2_0)

		arg_2_0._handledList[iter_2_0] = nil
	end

	arg_2_0._exitCldFunc = nil
	arg_2_0._handledList = nil

	var_0_1.super.Dispose(arg_2_0)

	return
end

function var_0_1.Settle(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._cldObjList) do
		({})[iter_3_1.UID] = true

		if not arg_3_0._handledList[iter_3_1] then
			({})[#{} + 1] = iter_3_1
			arg_3_0._handledList[iter_3_1] = true
		end
	end

	arg_3_0.SortCldObjList({})
	arg_3_0._cldComponent:GetCldData().func({}, obj)

	for iter_3_2, iter_3_3 in pairs(arg_3_0._handledList) do
		if not ({})[iter_3_2.UID] or iter_3_2.ImmuneCLD == true then
			arg_3_0._exitCldFunc(iter_3_2)

			arg_3_0._handledList[iter_3_2] = nil
		end
	end

	return
end

function var_0_1.frequentlySettle(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._cldObjList) do
		({})[iter_4_1.UID] = true
		arg_4_0._handledList[iter_4_1] = arg_4_0._handledList[iter_4_1] or true
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0._handledList) do
		if not ({})[iter_4_2.UID] then
			arg_4_0._exitCldFunc(iter_4_2)

			arg_4_0._handledList[iter_4_2] = nil
		end
	end

	arg_4_0.SortCldObjList(arg_4_0._cldObjList)
	arg_4_0._cldComponent:GetCldData().func(arg_4_0._cldObjList)

	return
end

function var_0_1.ForceExit(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(arg_5_0._handledList) do
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
