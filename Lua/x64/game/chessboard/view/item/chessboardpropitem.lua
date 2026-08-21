local var_0_0 = class("ChessBoardPropItem", ReduxView)
local var_0_1 = {
	showState = {
		selected = "selected",
		name = "state",
		grey = "grey",
		blank = "blank",
		normal = "normal"
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

	arg_3_0.interactable_ = true
	arg_3_0.controller_ = arg_3_0.controllerexcollection_:GetController(var_0_1.showState.name)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_6_0)
	if arg_6_0.interactable_ == false then
		return
	end

	if arg_6_0.clickHandle_ then
		arg_6_0.clickHandle_(arg_6_0.propID, arg_6_0.index)
	end

	if arg_6_0.selectHandle_ then
		arg_6_0.selectHandle_(arg_6_0.index)
	end
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	arg_7_0.propID = arg_7_1
	arg_7_0.interactable_ = true

	if arg_7_1 then
		local var_7_0 = ChessBoardPropCfg[arg_7_1]

		arg_7_0.iconImg_.sprite = ChessBoardTools.GetPropImage(var_7_0.icon)

		arg_7_0:ChangeState(var_0_1.showState.normal)
	else
		arg_7_0:ChangeState(var_0_1.showState.blank)
	end
end

function var_0_0.ShowGetEffect(arg_8_0)
	arg_8_0.animator_:Play("ItemGet", 0)
end

function var_0_0.SetSelectState(arg_9_0, arg_9_1)
	if arg_9_0.propID then
		local var_9_0 = arg_9_1 == arg_9_0.index and var_0_1.showState.selected or var_0_1.showState.normal

		arg_9_0:ChangeState(var_9_0)
	end
end

function var_0_0.ChangeState(arg_10_0, arg_10_1)
	arg_10_0.controller_:SetSelectedState(arg_10_1)
end

function var_0_0.SetClickHandle(arg_11_0, arg_11_1)
	arg_11_0.clickHandle_ = arg_11_1
end

function var_0_0.SetSelectHandle(arg_12_0, arg_12_1)
	arg_12_0.selectHandle_ = arg_12_1
end

function var_0_0.SetUnInteractable(arg_13_0)
	if arg_13_0.propID then
		arg_13_0.controller_:SetSelectedState("grey")
	else
		arg_13_0:ChangeState(var_0_1.showState.blank)
	end
end

function var_0_0.StartArenaChance(arg_14_0)
	if arg_14_0.propID then
		local var_14_0 = ChessBoardTools.GetChessBoardGameSetting("chessboard_dice_type_prop")

		if table.indexof(var_14_0, arg_14_0.propID) then
			arg_14_0:ChangeState(var_0_1.showState.normal)

			return
		else
			arg_14_0.controller_:SetSelectedState("grey")
		end
	else
		arg_14_0:ChangeState(var_0_1.showState.blank)
	end
end

function var_0_0.GetPropID(arg_15_0)
	return arg_15_0.propID
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
