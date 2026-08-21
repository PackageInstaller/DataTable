local var_0_0 = class("PacGameItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._data = arg_1_3

	return
end

function var_0_0.SetParent(arg_2_0, arg_2_1)
	setParent(arg_2_0._tf, arg_2_1, false)

	return
end

function var_0_0.SetPosition(arg_3_0, arg_3_1)
	arg_3_0._tf.anchoredPosition = arg_3_1

	return
end

function var_0_0.GetPosition(arg_4_0)
	return arg_4_0._tf.anchoredPosition
end

function var_0_0.SetScale(arg_5_0, arg_5_1)
	arg_5_0._tf.localScale = arg_5_1

	return
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	setActive(arg_6_0._tf, arg_6_1)

	return
end

function var_0_0.GetIndex(arg_7_0)
	return arg_7_0._index
end

function var_0_0.GetConfig(arg_8_0, arg_8_1)
	return arg_8_0._data[arg_8_1]
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0._tf then
		Destroy(arg_9_0._tf)

		arg_9_0._tf = nil
	end

	arg_9_0._index = nil
	arg_9_0._data = nil

	return
end

return var_0_0
