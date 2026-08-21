local var_0_0 = class("AutoChessCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.switchController_ = arg_3_0.controller_:GetController("switch")
	arg_3_0.collapseController_ = arg_3_0.controller_:GetController("collapse")
	arg_3_0.newTagController_ = arg_3_0.controller_:GetController("new")
	arg_3_0.greyController_ = arg_3_0.controller_:GetController("grey")
	arg_3_0.cardURItem_ = AutoChessBaseURCardItem.New(arg_3_0.cardURGo_)
	arg_3_0.cardSRItem_ = AutoChessBaseCardItem.New(arg_3_0.cardSRGo_)
	arg_3_0.cardRItem_ = AutoChessBaseCardItem.New(arg_3_0.cardRGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.cardID_ = arg_5_1

	arg_5_0:RefreshUI(arg_5_2)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = AutoChessCardCfg[arg_6_0.cardID_]

	if not var_6_0 then
		return
	end

	if arg_6_0.switchController_ then
		arg_6_0.switchController_:SetSelectedIndex(var_6_0.type - 1)
	end

	if var_6_0.type == AutoChessCardConst.CARD_TYPE.UR then
		arg_6_0.cardURItem_:SetItem(arg_6_0.cardID_, arg_6_1)
		arg_6_0.cardURItem_:SetData(arg_6_0.cardID_)
	elseif var_6_0.type == AutoChessCardConst.CARD_TYPE.SR then
		arg_6_0.cardSRItem_:SetData(arg_6_0.cardID_)
	else
		arg_6_0.cardRItem_:SetData(arg_6_0.cardID_)
	end
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.SetClickHandler(arg_8_0, arg_8_1)
	local var_8_0 = AutoChessCardCfg[arg_8_0.cardID_]

	if not var_8_0 then
		return
	end

	if var_8_0.type == AutoChessCardConst.CARD_TYPE.UR then
		arg_8_0.cardURItem_:SetClickHandler(arg_8_1)
	elseif var_8_0.type == AutoChessCardConst.CARD_TYPE.SR then
		arg_8_0.cardSRItem_:SetClickHandler(arg_8_1)
	else
		arg_8_0.cardRItem_:SetClickHandler(arg_8_1)
	end
end

function var_0_0.SetPositionState(arg_9_0, arg_9_1)
	local var_9_0 = AutoChessCardCfg[arg_9_0.cardID_]

	if arg_9_1 then
		if var_9_0.type == AutoChessCardConst.CARD_TYPE.UR then
			arg_9_0.cardURItem_:SetPositionState("on")
		elseif var_9_0.type == AutoChessCardConst.CARD_TYPE.SR then
			arg_9_0.cardSRItem_:SetPositionState("on")
		else
			arg_9_0.cardRItem_:SetPositionState("on")
		end
	elseif var_9_0.type == AutoChessCardConst.CARD_TYPE.UR then
		arg_9_0.cardURItem_:SetPositionState("off")
	elseif var_9_0.type == AutoChessCardConst.CARD_TYPE.SR then
		arg_9_0.cardSRItem_:SetPositionState("off")
	else
		arg_9_0.cardRItem_:SetPositionState("off")
	end
end

function var_0_0.SetCollapseState(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		arg_10_0.collapseController_:SetSelectedState("on")

		arg_10_0.txtNum_.text = "×" .. arg_10_2
	else
		arg_10_0.collapseController_:SetSelectedState("off")
	end
end

function var_0_0.SetNewTagState(arg_11_0, arg_11_1)
	arg_11_0.newTagController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function var_0_0.SetGreyState(arg_12_0, arg_12_1)
	arg_12_0.greyController_:SetSelectedState(arg_12_1 and "on" or "off")
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.cardURItem_:Dispose()
	arg_13_0.cardSRItem_:Dispose()
	arg_13_0.cardRItem_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
