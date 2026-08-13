class = var_0_10000

local var_0_0 = var_0_10000("IslandVisitorLogCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.transform

	arg_1_0.mainTr = var_2.Find(var_1_0, "main")

	local var_1_1 = arg_1_1.transform

	arg_1_0.emptyTr = var_2.Find(var_1_1, "empty")

	local var_1_2 = arg_1_1.transform
	local var_1_3 = var_2.Find(var_1_2, "main/time")
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.timeTxt = var_1_4(var_1_3, var_4(var_1_10005))

	local var_1_5 = arg_1_1.transform
	local var_1_6 = var_2.Find(var_1_5, "main/name")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_1.transform
	local var_1_9 = var_2.Find(var_1_8, "main/op")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.opTxt = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_1.transform
	local var_1_12 = var_2.Find(var_1_11, "empty/time")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.emptyTimeTxt = var_1_13(var_1_12, var_4(var_1_10005))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if arg_2_1.id == -1 then
		arg_2_0:UpdateEmpty(arg_2_1)
	else
		arg_2_0:UpdateMain(arg_2_1)
	end

	setActive = var_1_10003

	var_1_10003(arg_2_0.mainTr, not var_2)

	setActive = var_1_10003

	var_1_10003(arg_2_0.emptyTr, var_2)

	return
end

function var_0_0.UpdateEmpty(arg_3_0, arg_3_1)
	arg_3_0.emptyTimeTxt.text = arg_3_1:GetTimeWithoutHAndM()

	return
end

function var_0_0.UpdateMain(arg_4_0, arg_4_1)
	arg_4_0.timeTxt.text = arg_4_1:GetTime()
	arg_4_0.nameTxt.text = arg_4_1:GetName()
	arg_4_0.opTxt.text = arg_4_1:GetOpDesc()

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
