local var_0_0 = class("CombineGamePoolPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfPrizeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.listGo_, KagutsuchiGachaRewardItem)
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = KagutsuchiGachaData:GetAllDrawItemIds(arg_5_0.poolId)

	arg_5_2:SetData(arg_5_0.activityId, arg_5_0.poolId, var_5_0[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmask_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityId = arg_8_0.params_.activityId
	arg_8_0.poolId = arg_8_0.params_.poolId

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = KagutsuchiGachaData:GetAllDrawItemIds(arg_9_0.poolId)

	arg_9_0.list:StartScroll(#var_9_0)

	arg_9_0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.list then
		arg_12_0.list:Dispose()

		arg_12_0.list = nil
	end

	var_0_0.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_0
