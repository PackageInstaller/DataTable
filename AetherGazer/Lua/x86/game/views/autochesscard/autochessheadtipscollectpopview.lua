local var_0_0 = class("AutoChessHeadTipsCollectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Com/Com_Xihe_Tips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.Item1_ = AutoChessCardCollectInfoItem.New(arg_6_0.tipsGo1_, AutoChessCardConst.CARD_TYPE.UR)
	arg_6_0.Item2_ = AutoChessCardCollectInfoItem.New(arg_6_0.tipsGo2_, AutoChessCardConst.CARD_TYPE.SR)
	arg_6_0.Item3_ = AutoChessCardCollectInfoItem.New(arg_6_0.tipsGo3_, AutoChessCardConst.CARD_TYPE.R)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.Item1_:RefreshUI()
	arg_7_0.Item2_:RefreshUI()
	arg_7_0.Item3_:RefreshUI()

	arg_7_0.txtName_.text = PlayerData:GetPlayerInfo().nick
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.Item1_:Dispose()
	arg_8_0.Item2_:Dispose()
	arg_8_0.Item3_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
