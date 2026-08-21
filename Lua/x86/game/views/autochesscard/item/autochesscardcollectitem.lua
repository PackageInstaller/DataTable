local var_0_0 = class("AutoChessCardCollectItem", ReduxView)

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
	arg_3_0.greyController_ = arg_3_0.controller_:GetController("grey")
	arg_3_0.mixTagController_ = arg_3_0.controller_:GetController("mixTag")
	arg_3_0.cardItem_ = AutoChessCardItem.New(arg_3_0.cardGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.cardID_ = arg_5_1
	arg_5_0.index_ = arg_5_2

	arg_5_0.cardItem_:SetData(arg_5_1, arg_5_3)
	arg_5_0.cardItem_:SetClickHandler(handler(arg_5_0, arg_5_0.OnClick))

	if AutoChessCardData:GetCardNum(arg_5_1) > 0 then
		arg_5_0.greyController_:SetSelectedState("off")
	else
		arg_5_0.greyController_:SetSelectedState("on")
	end

	arg_5_0:RefershMixTag()
end

function var_0_0.RefershMixTag(arg_6_0)
	if AutoChessCardCfg[arg_6_0.cardID_].type == AutoChessCardConst.CARD_TYPE.R then
		arg_6_0.mixTagController_:SetSelectedState("off")

		return
	end

	if AutoChessCardTools.GetMixExpByCardType(arg_6_0.cardID_) <= AutoChessCardTools.GetCardExp() and AutoChessCardData:GetCardNum(arg_6_0.cardID_) < 1 then
		arg_6_0.mixTagController_:SetSelectedState("on")
	else
		arg_6_0.mixTagController_:SetSelectedState("off")
	end
end

function var_0_0.SetSelectHandler(arg_7_0, arg_7_1)
	arg_7_0.selectHandler_ = arg_7_1
end

function var_0_0.OnClick(arg_8_0)
	if arg_8_0.selectHandler_ then
		arg_8_0.selectHandler_(arg_8_0.cardID_, arg_8_0.index_)
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
