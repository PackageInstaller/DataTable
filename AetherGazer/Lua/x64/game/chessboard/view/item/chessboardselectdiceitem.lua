local var_0_0 = class("ChessBoardSelectDiceItem", ReduxView)
local var_0_1 = {
	state = {
		on = "on",
		name = "status",
		select = "select",
		gray = "gray"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.controllerexcollection_:GetController(var_0_1.state.name)

	arg_3_0:ChangeState(var_0_1.state.on)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE") >= arg_4_0.index then
			if arg_4_0.clickHandle_ and arg_4_0.index then
				arg_4_0.clickHandle_(arg_4_0.index)
			end
		else
			ShowTips("CHESSBOARD_CURSE_DICE")
		end
	end)
end

function var_0_0.RefreshUi(arg_6_0)
	arg_6_0:UpdateDefault()
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	if arg_7_0.index == arg_7_1 then
		arg_7_0:ChangeState(var_0_1.state.select)
	else
		arg_7_0:UpdateDefault()
	end
end

function var_0_0.UpdateDefault(arg_8_0)
	if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE") >= arg_8_0.index then
		arg_8_0:ChangeState(var_0_1.state.on)
	else
		arg_8_0:ChangeState(var_0_1.state.gray)
	end
end

function var_0_0.ChangeState(arg_9_0, arg_9_1)
	arg_9_0.controller_:SetSelectedState(arg_9_1)
end

function var_0_0.SetClickHandle(arg_10_0, arg_10_1)
	arg_10_0.clickHandle_ = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
