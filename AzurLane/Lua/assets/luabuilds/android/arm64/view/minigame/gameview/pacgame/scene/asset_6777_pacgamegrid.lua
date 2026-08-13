class = var_0_10000

local var_0_0 = var_0_10000("PacGameGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._id = arg_1_3

	if arg_1_0._id == 0 then
		PacGameConst = var_4
		arg_1_0._id = var_4.default_grid
	end

	PacGameConst = var_4
	arg_1_0._data = var_4.grid_data[arg_1_0._id]
	findTF = var_4
	arg_1_0._selectTF = var_4(arg_1_1, "ad/select")
	setActive = var_4

	var_4(arg_1_0._selectTF, false)

	findTF = var_4
	arg_1_0._scoreTF = var_4(arg_1_1, "ad/score")

	if arg_1_0._scoreTF then
		setActive = var_4

		var_4(arg_1_0._scoreTF, false)
	end

	arg_1_0._scoreFlag = false

	if arg_1_0._data.score then
		arg_1_0._score = arg_1_0._data.score
	end

	return
end

function var_0_0.GetId(arg_2_0)
	return arg_2_0._id
end

function var_0_0.SetParent(arg_3_0, arg_3_1)
	setParent = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1, false)

	return
end

function var_0_0.SetPosition(arg_4_0, arg_4_1)
	arg_4_0._tf.anchoredPosition = arg_4_1

	return
end

function var_0_0.GetPosition(arg_5_0)
	return arg_5_0._tf.anchoredPosition
end

function var_0_0.SetScale(arg_6_0, arg_6_1)
	arg_6_0._tf.localScale = arg_6_1

	return
end

function var_0_0.HasScore(arg_7_0)
	return arg_7_0._data.score and true or false
end

function var_0_0.SetScoreFlag(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0._scoreTF, arg_8_1)

	arg_8_0._scoreFlag = arg_8_1

	return
end

function var_0_0.SetVH(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._vetical = arg_9_1
	arg_9_0._horizontal = arg_9_2

	return
end

function var_0_0.GetVH(arg_10_0)
	return arg_10_0._vetical, arg_10_0._horizontal
end

function var_0_0.GetScoreFlag(arg_11_0)
	local var_11_0

	if arg_11_0._scoreFlag then
		isActive = var_11_0
		var_11_0 = var_11_0(arg_11_0._scoreTF)
	end

	return var_11_0
end

function var_0_0.GetScore(arg_12_0)
	local var_12_0

	if not arg_12_0._score or not arg_12_0._score then
		var_12_0 = 0
	end

	return var_12_0
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0._tf, arg_13_1)

	return
end

function var_0_0.GetIndex(arg_14_0)
	return arg_14_0._index
end

function var_0_0.GetPassAble(arg_15_0)
	return arg_15_0._data.pass
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0._tf then
		Destroy = var_1

		var_1(arg_16_0._tf)

		arg_16_0._tf = nil
	end

	arg_16_0._data = nil

	return
end

return var_0_0
