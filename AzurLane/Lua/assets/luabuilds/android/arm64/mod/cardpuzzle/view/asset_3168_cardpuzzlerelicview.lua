class = var_0_10000

local var_0_0 = var_0_10000("CardPuzzleRelicView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1

	return
end

function var_0_0.UpdateView(arg_3_0)
	setImageSprite = var_1_10001

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_3.Find(var_3_0, "Icon")

	LoadSprite = var_1_10004

	local var_3_2 = arg_3_0.data

	var_1_10001(var_3_1, var_1_10004(var_6.GetIconPath(var_3_2), ""), true)

	setText = var_1_10001

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_3.Find(var_3_3, "Name")
	local var_3_5 = arg_3_0.data

	var_1_10001(var_3_4, var_4.GetName(var_3_5))

	setText = var_1_10001

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_3.Find(var_3_6, "Detail")
	local var_3_8 = arg_3_0.data

	var_1_10001(var_3_7, var_4.GetDesc(var_3_8))

	TweenItemAlphaAndWhite = var_1_10001
	go = var_3_7

	var_1_10001(var_3_7(arg_3_0._tf))

	return
end

function var_0_0.Clear(arg_4_0)
	ClearTweenItemAlphaAndWhite = var_1_10001
	go = var_1_10003

	var_1_10001(var_1_10003(arg_4_0._tf))

	return
end

return var_0_0
