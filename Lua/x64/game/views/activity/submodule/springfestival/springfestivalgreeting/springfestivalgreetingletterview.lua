local var_0_0 = class("SpringFestivalGreetingLetterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/letter/EDream_letterpop_2"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.adaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.portraitImage_.transform)
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.commonItemView_:Dispose()

	arg_6_0.commonItemView_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		local var_9_0 = arg_7_0:GetActivityID()

		if not ActivityData:GetActivityIsOpen(var_9_0) then
			ShowTips("TIME_OVER")

			return
		end

		local var_9_1 = SpringFestivalGreetingData:GetUnlockCnt(var_9_0)
		local var_9_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[var_9_0][var_9_1]

		SpringFestivalGreetingAction.GetGreetingReward(var_9_0, var_9_2, function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				getReward2(arg_10_0.reward_list)
				arg_7_0:RefreshReceiveState()
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end)
end

function var_0_0.GetActivityID(arg_11_0)
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0:GetActivityID()
	local var_12_1 = SpringFestivalGreetingData:GetUnlockCnt(var_12_0)
	local var_12_2 = ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[var_12_0][var_12_1]
	local var_12_3 = ActivitySpringFestivalGreetingCfg[var_12_2]
	local var_12_4 = SkinCfg[var_12_3.story_name].picture_id

	arg_12_0.portraitImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/" .. var_12_4)
	arg_12_0.titleText_.text = string.format(GetTips("ACTIVITY_HERO_PRESENT"), GetI18NText(HeroCfg[SkinCfg[var_12_3.story_name].hero].suffix))
	arg_12_0.greetingText_.text = GetI18NText(var_12_3.story_word)

	local var_12_5 = ActivityPointRewardCfg.get_id_list_by_activity_id[var_12_0][var_12_1]
	local var_12_6 = ActivityPointRewardCfg[var_12_5].reward_item_list[1]

	if arg_12_0.commonItemView_ == nil then
		arg_12_0.commonItemView_ = CommonItem.New(arg_12_0.itemGo_)
	end

	arg_12_0.commonItemView_:RefreshData(formatReward(var_12_6))
	arg_12_0.commonItemView_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_12_6)
	end)
	arg_12_0:RefreshReceiveState()
end

function var_0_0.RefreshReceiveState(arg_14_0)
	local var_14_0 = arg_14_0:GetActivityID()
	local var_14_1 = SpringFestivalGreetingData:GetUnlockCnt(var_14_0)

	if SpringFestivalGreetingData:GetReceiveCnt(var_14_0) == var_14_1 then
		arg_14_0.controller_:SetSelectedState("true")
	else
		arg_14_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
