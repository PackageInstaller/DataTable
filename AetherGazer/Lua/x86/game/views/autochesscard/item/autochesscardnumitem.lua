local var_0_0 = class("AutoChessCardNumItem", ReduxView)

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
	arg_3_0.selectHandler_ = nil
	arg_3_0.isSelect_ = false
	arg_3_0.selectController_ = arg_3_0.controller_:GetController("select")
	arg_3_0.ownNumController_ = arg_3_0.controller_:GetController("ownNum")
	arg_3_0.cardItem_ = AutoChessCardItem.New(arg_3_0.cardGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.cardID_ = arg_5_1
	arg_5_0.isSelect_ = arg_5_2

	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_0.isSelect_))
	arg_5_0.cardItem_:SetData(arg_5_1, arg_5_3)
	arg_5_0.cardItem_:SetClickHandler(handler(arg_5_0, arg_5_0.OnClick))
	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AutoChessCardData:GetCardNum(arg_6_0.cardID_) - 1
	local var_6_1 = AutoChessCardData:GetDesireInfo()

	if var_6_1 and table.indexof(var_6_1.CardList, arg_6_0.cardID_) ~= false then
		var_6_0 = var_6_0 + 1
	end

	if arg_6_0.isSelect_ then
		arg_6_0.txtNum_.text = var_6_0 - 1
	else
		arg_6_0.txtNum_.text = var_6_0
	end
end

function var_0_0.SetSelectHandler(arg_7_0, arg_7_1)
	arg_7_0.selectHandler_ = arg_7_1
end

function var_0_0.SetOwnNumState(arg_8_0, arg_8_1)
	arg_8_0.ownNumController_:SetSelectedState(arg_8_1)
end

function var_0_0.OnClick(arg_9_0)
	arg_9_0.isSelect_ = not arg_9_0.isSelect_

	arg_9_0.selectController_:SetSelectedState(tostring(arg_9_0.isSelect_))

	if arg_9_0.selectHandler_ then
		arg_9_0.selectHandler_(arg_9_0.isSelect_, arg_9_0.cardID_)
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
