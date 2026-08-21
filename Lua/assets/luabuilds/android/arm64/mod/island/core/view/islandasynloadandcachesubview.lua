local var_0_0 = class("IslandASynLoadAndCacheSubView", import(".IslandASynLoadSubView"))

function var_0_0.LoadUI(arg_1_0, arg_1_1)
	arg_1_0:GetPoolMgr():GetUI(arg_1_0:GetUIName(), function(arg_2_0)
		setParent(arg_2_0, (arg_1_0:GetUIParent()))
		arg_1_1(arg_2_0)

		return
	end)

	return
end

function var_0_0.UnloadUI(arg_3_0)
	if not arg_3_0._go then
		return
	end

	arg_3_0:GetPoolMgr():ReturnUI(arg_3_0:GetUIName(), arg_3_0._go)

	return
end

return var_0_0
