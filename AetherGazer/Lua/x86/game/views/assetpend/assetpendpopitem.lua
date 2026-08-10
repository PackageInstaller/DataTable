AssetPendSettingBaseItem = import("game.views.setting.assetPend.AssetPendSettingBaseItem")

local var_0_0 = class("AssetPendPopItem", AssetPendSettingBaseItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	arg_1_0:AddUIListener()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

return var_0_0
