local var_0_0 = class("AutoChessCardChatItem", ReduxView)

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
	arg_3_0.wishStateController_ = arg_3_0.controller_:GetController("wishState")
	arg_3_0.cardItem_ = AutoChessCardItem.New(arg_3_0.cardGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.cardID_ = arg_5_1

	arg_5_0.cardItem_:SetData(arg_5_1, arg_5_2)
	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AutoChessCardData:GetDesireInfo()

	if arg_6_0.cardID_ == 0 then
		arg_6_0.wishStateController_:SetSelectedState("none")

		return
	end

	if arg_6_0.cardID_ == var_6_0.CardID then
		arg_6_0.wishStateController_:SetSelectedState("heart")
	elseif AutoChessCardData:GetCardNum(arg_6_0.cardID_) > 0 then
		arg_6_0.wishStateController_:SetSelectedState("none")
	else
		arg_6_0.wishStateController_:SetSelectedState("add")
	end
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.cardItem_:SetClickHandler(arg_7_1)
end

function var_0_0.SetGreyState(arg_8_0, arg_8_1)
	arg_8_0.cardItem_:SetGreyState(arg_8_1)
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
