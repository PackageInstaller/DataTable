local var_0_0 = class("XH3rdWaterExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPopUI"
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

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.uilistGo_, XH3rdWaterExchangeItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.taskIdList_[arg_6_1]

	arg_6_2:SetData(var_6_0, arg_6_0.params_.activityID)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function()
		arg_9_0:UpdateView()
	end)
end

function var_0_0.OnWaterResult(arg_11_0, arg_11_1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = arg_11_1
	})
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	arg_14_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()
	arg_15_0:UpdateView()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.taskIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_17_0.params_.activityID]

	arg_17_0.uiList_:StartScroll(#arg_17_0.taskIdList_)
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.uiList_ then
		arg_19_0.uiList_:Dispose()

		arg_19_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
