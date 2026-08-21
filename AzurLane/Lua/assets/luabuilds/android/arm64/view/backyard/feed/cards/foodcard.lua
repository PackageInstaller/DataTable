local var_0_0 = class("FoodCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.mask = arg_1_0._tf:Find("mask")
	arg_1_0.count = arg_1_0._tf:Find("icon_bg/count"):GetComponent(typeof(Text))
	arg_1_0.nameTxt = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.addTF = arg_1_0._tf:Find("add")
	arg_1_0.icon = arg_1_0._tf:Find("icon_bg/icon")
	arg_1_0.startPos = arg_1_0._tf.anchoredPosition
	arg_1_0.width = arg_1_0._tf.sizeDelta.x
	arg_1_0.space = 36

	return
end

function var_0_0.UpdatePositin(arg_2_0, arg_2_1)
	arg_2_0._tf.anchoredPosition3D = Vector3(arg_2_0.startPos.x + arg_2_1 * (arg_2_0.width + arg_2_0.space), arg_2_0.startPos.y, 0)

	return
end

function var_0_0.Update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.foodId = arg_3_1
	arg_3_0.name = i18n("word_food") .. Item.getConfigData(arg_3_1).usage_arg[1]

	arg_3_0:UpdateCnt(arg_3_2)

	arg_3_0._go.name = "food_" .. arg_3_1

	updateItem(arg_3_0._tf, Item.New({
		id = arg_3_1,
		cnt = arg_3_2
	}))

	return
end

function var_0_0.UpdateCnt(arg_4_0, arg_4_1)
	arg_4_0.count.text = arg_4_1

	setActive(arg_4_0.mask, arg_4_1 == 0)

	arg_4_0.count.text = arg_4_1
	arg_4_0.nameTxt.text = arg_4_0.name

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
