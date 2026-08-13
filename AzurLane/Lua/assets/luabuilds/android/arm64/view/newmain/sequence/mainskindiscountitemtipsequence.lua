class = var_0_10000

local var_0_0 = "MainSkinDiscountItemTipSequence"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainOverDueSkinDiscountItemSequence"))

function var_0_1.Execute(arg_1_0, arg_1_1)
	if not arg_1_0:ShouldTip() then
		arg_1_1()

		return
	end

	local var_1_0, var_1_1 = arg_1_0:CollectExpiredItems()

	if #var_1_0 <= 0 and #var_1_1 <= 0 then
		arg_1_1()

		return
	end

	var_0_1.TipFlag = true

	local var_1_2 = {}

	ipairs = var_5

	for iter_1_0, iter_1_1 in var_5(var_1_0) do
		table = var_1_10010

		var_1_10010.insert(var_1_2, iter_1_1)
	end

	ipairs = var_5

	for iter_1_2, iter_1_3 in var_5(var_1_1) do
		table = var_1_10010

		var_1_10010.insert(var_1_2, iter_1_3)
	end

	arg_1_0:DisplayResults(var_1_2, arg_1_1)

	return
end

function var_0_1.ShouldTip(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getRawData(var_2_0).id

	PlayerPrefs = var_1_10002

	if var_1_10002.GetString("SkinDiscountItemTip" .. var_2_1, "") == "" then
		return not var_0_1.TipFlag
	end

	pg = var_2_0

	local var_2_2 = var_2_0.TimeMgr.GetInstance()
	local var_2_3 = var_3.GetServerTime(var_2_2)

	tonumber = var_4

	if var_2_3 < var_4(var_2) then
		return false
	else
		return not var_0_1.TipFlag
	end

	return
end

function var_0_1.DisplayResults(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.Display

	MainSkinDiscountItemTipDisplayPage = var_1_10006

	var_3_1(var_3_0, var_1_10006, arg_3_1, arg_3_2)

	return
end

function var_0_1.InTime(arg_4_0, arg_4_1)
	type = var_1_10002

	if var_1_10002(arg_4_1) == "table" then
		local var_4_0 = arg_4_1[2]

		pg = var_1_10003

		local var_4_1 = var_1_10003.TimeMgr.GetInstance()
		local var_4_2 = var_3.parseTimeFromConfig(var_4_1, var_4_0) - 0

		pg = var_4_1

		local var_4_3 = var_4_1.TimeMgr.GetInstance()

		return var_4_2 <= var_5.GetServerTime(var_4_3) and var_5 < var_3
	end

	return false
end

return var_0_1
