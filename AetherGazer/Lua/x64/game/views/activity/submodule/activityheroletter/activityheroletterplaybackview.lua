local var_0_0 = class("ActivityHeroLetterPlayBackView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityHeroLetterTools.GetPlayBackUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItem_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		arg_5_0:GotoWeb()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshReward()
	arg_8_0:RefreshType()
end

function var_0_0.RefreshReward(arg_9_0)
	local var_9_0 = GameSetting.activity_hero_task_reward_list.value

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not arg_9_0.rewardItem_[iter_9_0] then
			local var_9_1 = Object.Instantiate(arg_9_0.rewardGo_, arg_9_0.rewardContent_)

			arg_9_0.rewardItem_[iter_9_0] = CommonItemView.New(var_9_1)
		end

		local var_9_2 = clone(ItemTemplateData)

		var_9_2.id = iter_9_1[1]
		var_9_2.number = iter_9_1[2]

		function var_9_2.clickFun()
			ShowPopItem(POP_ITEM, {
				var_9_2.id
			})
		end

		arg_9_0.rewardItem_[iter_9_0]:SetData(var_9_2)
		arg_9_0.rewardItem_[iter_9_0]:Show(true)
	end

	for iter_9_2 = #var_9_0 + 1, #arg_9_0.rewardItem_ do
		arg_9_0.rewardItem_[iter_9_2]:Show(false)
	end
end

function var_0_0.RefreshType(arg_11_0)
	local var_11_0 = ActivityHeroLetterData:GetRewwardSign(arg_11_0.activityID_)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.rewardItem_) do
		iter_11_1:RefreshCompleted(var_11_0 == 1)
	end
end

function var_0_0.GotoWeb(arg_12_0)
	local var_12_0 = {
		userId = PlayerData:GetPlayerInfo().userID,
		signUserId = PlayerData:GetPlayerInfo().signUserId
	}

	OperationAction.OpenOperationUrl("ACTIVITY_URL", var_12_0)

	if ActivityHeroLetterData:GetRewwardSign(arg_12_0.activityID_) ~= 1 then
		ActivityHeroLetterAction.GetReward(arg_12_0.activityID_)
	end
end

function var_0_0.OnHeroLetterReward(arg_13_0)
	arg_13_0:RefreshReward()
	arg_13_0:RefreshType()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.rewardItem_) do
		iter_15_1:Dispose()
	end

	arg_15_0.super.Dispose(arg_15_0)
end

return var_0_0
