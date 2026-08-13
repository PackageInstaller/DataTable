class = var_0_10000

local var_0_0 = var_0_10000("MainForcePlayerNameModificationSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getRawData(var_1_0)

	if var_2.WhetherServerModifiesName(var_1_1) then
		arg_1_0:ShowModityPlayerNameWindow(arg_1_1)
	else
		arg_1_1()
	end

	return
end

function var_0_0.ShowModityPlayerNameWindow(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.renameWindow then
		ForcePlayerNameModificationPage = var_2_0
		var_2_0 = var_2_0.New
		pg = var_1_10004
		var_2_0 = var_2_0(var_1_10004.UIMgr.GetInstance().OverlayMain)
	end

	arg_2_0.renameWindow = var_2_0

	local var_2_1 = arg_2_0.renameWindow

	var_2.ExecuteAction(var_2_1, "Show", function()
		local var_3_0 = arg_2_0

		var_0.Clear(var_3_0)

		return
	end)

	return
end

function var_0_0.Clear(arg_4_0)
	if arg_4_0.renameWindow then
		local var_4_0 = arg_4_0.renameWindow

		var_1.Destroy(var_4_0)

		arg_4_0.renameWindow = nil
	end

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:Clear()

	return
end

return var_0_0
