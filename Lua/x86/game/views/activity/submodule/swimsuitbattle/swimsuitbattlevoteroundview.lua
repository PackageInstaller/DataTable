local var_0_0 = class("SwimsuitBattleVoteRoundView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVoteRoundUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.roundItemList_ = {}

	for iter_4_0 = 1, 3 do
		if arg_4_0["round" .. iter_4_0 .. "Go_"] then
			arg_4_0.roundItemList_[iter_4_0] = SwimsuitBattleVoteRoundItem.New(arg_4_0["round" .. iter_4_0 .. "Go_"])
		end
	end

	arg_4_0.roundFinalItem_ = SwimsuitBattleVoteRoundFinalItem.New(arg_4_0.round4Go_)
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_6_0 = 1, #arg_6_0.roundItemList_ do
		arg_6_0.roundItemList_[iter_6_0]:SetData(iter_6_0)
	end

	arg_6_0.roundFinalItem_:SetData(4)
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()

	for iter_8_0 = 1, 3 do
		if arg_8_0.roundItemList_[iter_8_0] then
			arg_8_0.roundItemList_[iter_8_0]:Dispose()

			arg_8_0.roundItemList_[iter_8_0] = nil
		end
	end

	if arg_8_0.roundFinalItem_ then
		arg_8_0.roundFinalItem_:Dispose()

		arg_8_0.roundFinalItem_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
