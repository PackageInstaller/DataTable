local var_0_0 = class("AutoChessCardMixSelectItem", ReduxView)

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
	arg_3_0.cardItem_ = AutoChessCardItem.New(arg_3_0.cardGo_)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.cardID_ = arg_5_1
	arg_5_0.isSelect_ = arg_5_2
	arg_5_0.index_ = arg_5_3

	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_0.isSelect_))
	arg_5_0.cardItem_:SetData(arg_5_1, arg_5_4)
	arg_5_0.cardItem_:SetClickHandler(handler(arg_5_0, arg_5_0.OnClick))
end

function var_0_0.SetSelectHandler(arg_6_0, arg_6_1)
	arg_6_0.selectHandler_ = arg_6_1
end

function var_0_0.OnClick(arg_7_0)
	arg_7_0.isSelect_ = not arg_7_0.isSelect_

	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_0.isSelect_))

	if arg_7_0.selectHandler_ then
		arg_7_0.selectHandler_(arg_7_0.isSelect_, arg_7_0.cardID_, arg_7_0.index_)
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.cardItem_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
