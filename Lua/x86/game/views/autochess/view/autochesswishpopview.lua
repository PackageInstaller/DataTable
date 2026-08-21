local var_0_0 = class("AutoChessWishPopView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.cardItem_ = AutoChessCardItem.New(arg_2_0.cardGo_)
	arg_2_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_2_0.URItemGo_)
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Activity_AutoChess_Main/Com/Activity_AutoChess_WishSuccessTipsPopUI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.callBack_ then
			arg_5_0.callBack_()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	saveData("autochess_4_8", "isShowWish", 1)

	local var_7_0 = AutoChessCardData:GetDesireInfo()

	arg_7_0.cardItem_:SetData(var_7_0.CardID, arg_7_0.URFactoryItem_:GetItem(var_7_0.CardID))

	arg_7_0.callBack_ = arg_7_0.params_.callback
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.cardItem_:Dispose()
	arg_8_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
