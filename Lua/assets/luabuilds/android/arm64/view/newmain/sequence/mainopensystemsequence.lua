local var_0_0 = class("MainOpenSystemSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	pg.SystemOpenMgr.GetInstance():notification(getProxy(PlayerProxy):getRawData().level)
	arg_1_1()

	return
end

return var_0_0
