class = var_0_10000

local var_0_0 = var_0_10000("CourtYardStoreyDragBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	CourtYardDragAgent = var_3
	arg_1_0.agent = var_3.New(arg_1_0, arg_1_2)

	local var_1_0 = arg_1_0.agent

	var_3.Enable(var_1_0, false)

	return
end

function var_0_0.Active(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.OnDragCallBack = arg_2_1
	arg_2_0.OnDragingCallBack = arg_2_2
	arg_2_0.OnDragEndCallBack = arg_2_3

	local var_2_0 = arg_2_0.agent

	var_4.Enable(var_2_0, true)

	return
end

function var_0_0.DeActive(arg_3_0)
	arg_3_0.OnDragCallBack = nil
	arg_3_0.OnDragingCallBack = nil
	arg_3_0.OnDragEndCallBack = nil

	local var_3_0 = arg_3_0.agent

	var_1.Enable(var_3_0, false)

	return
end

function var_0_0.OnBeginDrag(arg_4_0)
	if arg_4_0.OnDragCallBack then
		arg_4_0.OnDragCallBack()
	end

	return
end

function var_0_0.OnDragging(arg_5_0, arg_5_1)
	if arg_5_0.OnDragingCallBack then
		arg_5_0.OnDragingCallBack(arg_5_1)
	end

	return
end

function var_0_0.OnDragEnd(arg_6_0, arg_6_1)
	if arg_6_0.OnDragEndCallBack then
		arg_6_0.OnDragEndCallBack(arg_6_1)
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:DeActive()

	local var_7_0 = arg_7_0.agent

	var_1.Dispose(var_7_0)

	return
end

return var_0_0
