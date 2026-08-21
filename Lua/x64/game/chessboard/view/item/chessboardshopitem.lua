local var_0_0 = class("ChessBoardShopItem", ReduxView)
local var_0_1 = "D46068"
local var_0_2 = {
	selectState = {
		off = "off",
		name = "select",
		on = "on"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.controller_ = arg_2_0.controllerexcollection_:GetController(var_0_2.selectState.name)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickHandle_ then
			arg_3_0.clickHandle_(arg_3_0.propID_)
		end
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0.propID_ = arg_5_1

	local var_5_0 = ChessBoardPropCfg[arg_5_1]

	arg_5_0.nameText_.text = var_5_0.name
	arg_5_0.iconImg_.sprite = ChessBoardTools.GetPropImage(var_5_0.icon)

	if ChessBoardPropCfg[arg_5_0.propID_].cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
		arg_5_0.priceText_.text = "<color=#" .. var_0_1 .. ">" .. var_5_0.cost .. "</color>"
	else
		arg_5_0.priceText_.text = var_5_0.cost
	end
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.propID_ == arg_6_1 and var_0_2.selectState.on or var_0_2.selectState.off

	arg_6_0.controller_:SetSelectedState(var_6_0)
end

function var_0_0.SetClickHandle(arg_7_0, arg_7_1)
	arg_7_0.clickHandle_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
