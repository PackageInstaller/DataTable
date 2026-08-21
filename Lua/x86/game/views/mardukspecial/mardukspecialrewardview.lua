local var_0_0 = class("MardukSpecialRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/special/MardukSpecialRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, MardukSpecialRewardItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.activityIds_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function(arg_10_0)
		arg_9_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_13_0)
	arg_13_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()

	arg_14_0.cfg_ = ActivityCfg[arg_14_0.params_.activityID]
	arg_14_0.activityIds_ = arg_14_0.cfg_.sub_activity_list

	arg_14_0.uiList_:StartScroll(#arg_14_0.activityIds_, MardukSpecialData:GetCanGetRewardIndex(arg_14_0.params_.activityID))
	arg_14_0:UpdateView()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.getLabel1_.text = MardukSpecialData:GetGotRewardNum(arg_15_0.activityIds_)
	arg_15_0.getLabel2_.text = "/" .. 3 * #arg_15_0.activityIds_
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.uiList_ then
		arg_18_0.uiList_:Dispose()

		arg_18_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
