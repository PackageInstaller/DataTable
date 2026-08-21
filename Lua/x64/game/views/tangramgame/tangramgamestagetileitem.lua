local var_0_0 = class("TangramGameStageTileItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddPonitListener(arg_3_0.buttonBtn_.gameObject, function()
		if arg_3_0.changePositionFunc then
			arg_3_0.changePositionFunc(arg_3_0)
		end
	end, function()
		return
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.index = arg_6_1
	arg_6_0.indexText = arg_6_0.index
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
