local var_0_0 = class("RaceCollectRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/CharacterGuideUI/HeroPreviewUIRewardUI"
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

	arg_5_0.raceItems_ = {}
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.raceIds_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		HeroRaceCollectAction.ReceiveAllTasksReward()
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(RACE_COLLECT_REWARD_GET, function(arg_11_0)
		arg_10_0:UpdateView()
	end)
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

	arg_15_0.raceIds_ = RaceEffectCfg.all

	arg_15_0:UpdateView()
end

function var_0_0.UpdateView(arg_16_0)
	arg_16_0.getLabel1_.text = HeroRaceCollectData:GetTasksReceivedCount()
	arg_16_0.getLabel2_.text = "/" .. HeroRaceCollectData:GetTaskTotalCount()

	SetActive(arg_16_0.receiveAllBtn_, HeroRaceCollectData:HasRewardReceive())

	for iter_16_0, iter_16_1 in pairs(arg_16_0.raceIds_) do
		if arg_16_0.raceItems_[iter_16_0] == nil then
			arg_16_0.raceItems_[iter_16_0] = RaceCollectRewardItemView.New(arg_16_0.itemGo_, arg_16_0.itemParent_)
		end

		arg_16_0.raceItems_[iter_16_0]:SetData(iter_16_0, iter_16_1)
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.raceItems_) do
		iter_19_1:Dispose()
	end

	arg_19_0.raceItems_ = {}

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
