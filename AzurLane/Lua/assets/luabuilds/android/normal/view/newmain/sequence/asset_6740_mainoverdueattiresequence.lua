class = var_0_10000

local var_0_0 = var_0_10000("MainOverDueAttireSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	AttireProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if #var_2.getExpiredChaces(var_1_0) > 0 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.Display

		AttireExpireDisplayPage = var_1_10006

		var_1_2(var_1_1, var_1_10006, var_3, arg_1_1)
	else
		arg_1_1()
	end

	return
end

function var_0_0.Display(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1.New

	pg = var_1_10005
	arg_2_0.page = var_2_0(var_1_10005.UIMgr.GetInstance().UIMain)

	function arg_2_0.page.Hide()
		local var_3_0 = arg_2_0

		var_0.Clear(var_3_0)
		arg_2_3()

		return
	end

	local var_2_1 = arg_2_0.page

	var_4.ExecuteAction(var_2_1, "Show", arg_2_2)

	return
end

function var_0_0.Clear(arg_4_0)
	if arg_4_0.page then
		local var_4_0 = arg_4_0.page

		var_1.Destroy(var_4_0)

		arg_4_0.page = nil
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_0
