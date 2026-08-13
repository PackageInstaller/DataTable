class = var_0_10000

local var_0_0 = "TransportCellView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".OniCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tf

	arg_1_0.tfShadow = var_2.Find(var_1_0, "shadow")

	local var_1_1 = arg_1_0.tf

	arg_1_0.tfIcon = var_2.Find(var_1_1, "ship/icon")

	local var_1_2 = arg_1_0.tf

	arg_1_0.tfHp = var_2.Find(var_1_2, "hp")

	local var_1_3 = arg_1_0.tf

	arg_1_0.tfHpText = var_2.Find(var_1_3, "hp/text")

	local var_1_4 = arg_1_0.tf

	arg_1_0.tfFighting = var_2.Find(var_1_4, "fighting")

	return
end

function var_0_1.GetRotatePivot(arg_2_0)
	return arg_2_0.tfIcon
end

function var_0_1.GetOrder(arg_3_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityLittle
end

function var_0_1.SetActive(arg_4_0, arg_4_1)
	SetActive = var_1_10002

	var_1_10002(arg_4_0.tf, arg_4_1)

	return
end

function var_0_1.LoadIcon(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == "" or arg_5_0.lastPrefab == arg_5_1 then
		existCall = var_1_10003

		var_1_10003(arg_5_2)

		return
	end

	arg_5_0.lastPrefab = arg_5_1

	local var_5_0 = arg_5_0:GetLoader()

	var_3.GetSpriteQuiet(var_5_0, "enemies/" .. arg_5_1, arg_5_1, arg_5_0.tfIcon)

	existCall = var_3

	var_3(arg_5_2)

	return
end

return var_0_1
