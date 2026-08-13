class = var_0_10000

local var_0_0 = "CourtYardFeastPedestalModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..CourtYardBaseModule"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.storey = arg_1_0.data

	local var_1_0 = arg_1_0._tf.parent

	arg_1_0.scrollView = var_1.Find(var_1_0, "scroll_view")

	return
end

function var_0_1.AddListeners(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.AddListener

	CourtYardEvent = var_1_10004

	var_2_1(var_2_0, var_1_10004.UPDATE_STOREY, arg_2_0.OnUpdate)

	return
end

function var_0_1.RemoveListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.RemoveListener

	CourtYardEvent = var_1_10004

	var_3_1(var_3_0, var_1_10004.UPDATE_STOREY, arg_3_0.OnUpdate)

	return
end

function var_0_1.OnUpdate(arg_4_0, arg_4_1)
	arg_4_0.level = arg_4_1

	arg_4_0:InitScrollRect(arg_4_1)

	return
end

function var_0_1.InitScrollRect(arg_5_0, arg_5_1)
	local var_5_0 = 1080 + (arg_5_1 - 1) * 22
	local var_5_1 = arg_5_0._tf

	Vector2 = var_1_10004
	var_5_1.sizeDelta = var_1_10004(arg_5_0._tf.sizeDelta.x, var_5_0)
	scrollTo = var_5_1

	var_5_1(arg_5_0.scrollView, 0.5, 0.5)

	return
end

function var_0_1.OnDispose(arg_6_0)
	return
end

return var_0_1
