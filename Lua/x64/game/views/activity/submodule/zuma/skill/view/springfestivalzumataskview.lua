local var_0_0 = import("game.views.activity.Submodule.Zuma.Normal.View.ZumaTaskView")
local var_0_1 = class("SpringFestivalZumaTaskView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumarewardPopUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.showStateController = arg_2_0.controllerexcollection_:GetController("clear")
	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, SpringFestivalZumaTaskItem)
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		arg_3_0:OnReceive()
	end)
	arg_3_0:AddBtnListener(arg_3_0.onClickBtn_, nil, function()
		JumpTools.Back()
	end)
end

return var_0_1
