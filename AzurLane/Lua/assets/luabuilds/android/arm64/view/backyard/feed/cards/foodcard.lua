class = var_0_10000

local var_0_0 = var_0_10000("FoodCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.mask = var_2.Find(var_1_0, "mask")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.Find(var_1_1, "icon_bg/count")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.count = var_1_3(var_1_2, var_5(var_1_10007))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_6(var_1_5, var_5(var_1_10007))

	local var_1_7 = arg_1_0._tf

	arg_1_0.addTF = var_2.Find(var_1_7, "add")

	local var_1_8 = arg_1_0._tf

	arg_1_0.icon = var_2.Find(var_1_8, "icon_bg/icon")
	arg_1_0.startPos = arg_1_0._tf.anchoredPosition
	arg_1_0.width = arg_1_0._tf.sizeDelta.x
	arg_1_0.space = 36

	return
end

function var_0_0.UpdatePositin(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.startPos.x + arg_2_1 * (arg_2_0.width + arg_2_0.space)
	local var_2_1 = arg_2_0._tf

	Vector3 = var_4
	var_2_1.anchoredPosition3D = var_4(var_2_0, arg_2_0.startPos.y, 0)

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.foodId = arg_3_1
	i18n = var_1_10003

	local var_3_0 = var_1_10003("word_food")

	Item = var_1_10004
	arg_3_0.name = var_3_0 .. var_1_10004.getConfigData(arg_3_1).usage_arg[1]

	arg_3_0:UpdateCnt(arg_3_2)

	local var_3_1 = arg_3_0._go

	var_3_1.name = "food_" .. arg_3_1
	updateItem = var_3_1

	local var_3_2 = arg_3_0._tf

	Item = var_6

	var_3_1(var_3_2, var_6.New({
		id = arg_3_1,
		cnt = arg_3_2
	}))

	return
end

function var_0_0.UpdateCnt(arg_4_0, arg_4_1)
	arg_4_0.count.text = arg_4_1

	local var_4_0 = arg_4_1 == 0

	setActive = var_1_10003

	var_1_10003(arg_4_0.mask, var_4_0)

	arg_4_0.count.text = arg_4_1
	arg_4_0.nameTxt.text = arg_4_0.name

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
