local var_0_0 = class("MainOverDueAttireSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(AttireProxy):getExpiredChaces()

	if #var_1_0 > 0 then
		arg_1_0:Display(AttireExpireDisplayPage, var_1_0, arg_1_1)
	else
		arg_1_1()
	end

	return
end

function var_0_0.Display(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.page = arg_2_1.New(pg.UIMgr.GetInstance().UIMain)

	function arg_2_0.page.Hide()
		arg_2_0:Clear()
		arg_2_3()

		return
	end

	arg_2_0.page:ExecuteAction("Show", arg_2_2)

	return
end

function var_0_0.Clear(arg_4_0)
	if arg_4_0.page then
		arg_4_0.page:Destroy()

		arg_4_0.page = nil
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_0
