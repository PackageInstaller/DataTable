local var_0_0 = class("QWorldMainMenuItemContainer", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
end

function var_0_0.Render(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.mainView = arg_2_1
	arg_2_0.systemId = arg_2_2

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	if arg_3_0.entity then
		arg_3_0.entity:Dispose()

		arg_3_0.entity = nil
	end

	if QWorldMainMenuConst[arg_3_0.systemId] then
		arg_3_0.entity = import("game.views.qworld.main." .. QWorldMainMenuConst[arg_3_0.systemId]).New(arg_3_0.gameObject_, arg_3_0.mainView, arg_3_0.systemId)

		arg_3_0.entity:Render()
	else
		Debug.LogError("错误,未实现的主界面系统Id:" .. (arg_3_0.systemId or "nil"))
	end

	arg_3_0:BindKeyMapValue()
end

function var_0_0.BindKeyMapValue(arg_4_0)
	local var_4_0 = arg_4_0.transform_:GetComponent(typeof(P08.Gamepad.HIDInputPage))

	if var_4_0 then
		local var_4_1 = SandPlaySystemCfg[arg_4_0.systemId]

		var_4_0:ReplaceButtonTypeIndex(var_4_1.button_type)
		var_4_0:RefreshActionUI()
	end
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.entity then
		arg_5_0.entity:Dispose()

		arg_5_0.entity = nil
	end

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
