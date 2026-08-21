local var_0_0 = class("IslandVisitorLogCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.mainTr = arg_1_1.transform:Find("main")
	arg_1_0.emptyTr = arg_1_1.transform:Find("empty")
	arg_1_0.timeTxt = arg_1_1.transform:Find("main/time"):GetComponent(typeof(Text))
	arg_1_0.nameTxt = arg_1_1.transform:Find("main/name"):GetComponent(typeof(Text))
	arg_1_0.opTxt = arg_1_1.transform:Find("main/op"):GetComponent(typeof(Text))
	arg_1_0.emptyTimeTxt = arg_1_1.transform:Find("empty/time"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id == -1

	if arg_2_1.id == -1 then
		arg_2_0:UpdateEmpty(arg_2_1)
	else
		arg_2_0:UpdateMain(arg_2_1)
	end

	setActive(arg_2_0.mainTr, not var_2_0)
	setActive(arg_2_0.emptyTr, var_2_0)

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
