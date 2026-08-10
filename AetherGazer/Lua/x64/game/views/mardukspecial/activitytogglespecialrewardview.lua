local var_0_0 = import("game.views.mardukSpecial.MardukSpecialRewardView")
local var_0_1 = class("ActivityToggleSpecialRewardView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortRewardUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.uilistGo_, ActivityToggleSpecialRewardItemView)
end

return var_0_1
