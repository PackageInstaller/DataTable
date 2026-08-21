local var_0_0 = class("FishEndingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingEndingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
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

	arg_5_0.emptyStatusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "emptyStatus")
	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, FishIcon)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetId(arg_6_0.fishes_[arg_6_1].id)
	manager.audio:PlayEffect("minigame_fishing", "fishing_win_bubble", "")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		JumpTools.Back()

		if arg_7_0.params_.callback ~= nil then
			arg_7_0.params_.callback()
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.backBtn_, nil, function()
		JumpTools.Back()

		if arg_7_0.params_.callback ~= nil then
			arg_7_0.params_.callback()
		end
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	return
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_12_0)
	return
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()

	arg_13_0.score_ = arg_13_0.params_.score
	arg_13_0.fishes_ = arg_13_0.params_.fishes
	arg_13_0.gainScore_ = arg_13_0.params_.gainScore

	arg_13_0:UpdateView()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.uiList_:StartScroll(#arg_15_0.fishes_)

	arg_15_0.scoreValueLabel_.text = arg_15_0.score_

	local var_15_0 = FishingData:GetActivityData().today_total_score

	arg_15_0.coinValueLabel_.text = tostring(var_15_0) .. "/" .. GameSetting.activity_fishing_money_max.value[1]

	local var_15_1 = FishingData:GetActivityData().today_treasure_num

	arg_15_0.fishValueLabel_.text = tostring(var_15_1) .. "/" .. GameSetting.activity_fishing_fish_max.value[1]

	if var_15_1 >= GameSetting.activity_fishing_fish_max.value[1] then
		arg_15_0.emptyStatusController_:SetSelectedState("full")
	else
		arg_15_0.emptyStatusController_:SetSelectedState("no")
	end
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.uiList_ then
		arg_17_0.uiList_:Dispose()

		arg_17_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
