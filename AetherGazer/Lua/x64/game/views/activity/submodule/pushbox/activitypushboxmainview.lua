local var_0_0 = class("ActivityPushBoxMainView", ReduxView)
local var_0_1 = 2.25

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryEntranceUI"
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

	arg_4_0.rewardPreviewTbl_ = {
		"CAKE_INDEX_REWARD_1",
		"CAKE_INDEX_REWARD_2",
		"CAKE_INDEX_REWARD_3",
		"CAKE_INDEX_REWARD_4",
		"CAKE_INDEX_REWARD_5",
		"CAKE_INDEX_REWARD_6",
		"CAKE_INDEX_REWARD_7"
	}
	arg_4_0.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}
	arg_4_0.cakeClip_ = {
		"00",
		"01",
		"02",
		"03",
		"04",
		"05",
		"06",
		"07"
	}
	arg_4_0.materialItem_ = {}
	arg_4_0.rewardItem_ = CommonItem.New(arg_4_0.rewardGo_)

	arg_4_0.rewardItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)

	arg_4_0.rewardCon_ = {}

	local var_4_0 = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_4_0.params_.activityID]

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0.rewardCon_[iter_4_0] = ControllerUtil.GetController(arg_4_0["preRewardGo_" .. iter_4_0].transform, "state")
	end

	arg_4_0.OnMaterialUpdateHandler_ = handler(arg_4_0, arg_4_0.OnMaterialUpdate)
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.progressCon_ = ControllerUtil.GetController(arg_4_0.transform_, "progress")
	arg_4_0.rewardItemCon_ = ControllerUtil.GetController(arg_4_0.rewardItem_.transform_, "completed")
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxReward", {
			activityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.materialBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.makeBtn_, nil, function()
		if arg_6_0:IsComplete(arg_6_0.curIndex_ + 1) then
			ActivityPushBoxAction.StartMaking(arg_6_0.activityID_, arg_6_0.curIndex_ + 1)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.preViewBtn_, nil, function()
		JumpTools.OpenPageByJump("activityPushBoxRewardPre", {
			activityID = arg_6_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_11_0)
	SetActive(arg_11_0.countDownGo_, false)
	arg_11_0.progressCon_:SetSelectedState(-1)

	arg_11_0.activityID_ = arg_11_0.params_.activityID

	manager.notify:RegistListener(MATERIAL_MODIFY, arg_11_0.OnMaterialUpdateHandler_)
	arg_11_0:BindRedPointUI()
	arg_11_0:RefreshData()
	arg_11_0:RefreshTime()
	arg_11_0:RefreshUI()
	arg_11_0:RefreshAni()
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.activityData_ = ActivityData:GetActivityData(arg_12_0.activityID_)
	arg_12_0.startTime_ = arg_12_0.activityData_.startTime
	arg_12_0.stopTime_ = arg_12_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_13_0)
	arg_13_0:StopTimer()

	local var_13_0 = manager.time:GetServerTime()

	if var_13_0 < arg_13_0.startTime_ then
		arg_13_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			if arg_13_0.startTime_ <= manager.time:GetServerTime() then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	elseif var_13_0 < arg_13_0.stopTime_ then
		arg_13_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_13_0.stopTime_)
		arg_13_0.timer_ = Timer.New(function()
			if arg_13_0.stopTime_ <= manager.time:GetServerTime() then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end

			arg_13_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_13_0.stopTime_)
		end, 1, -1)

		arg_13_0.timer_:Start()
	else
		arg_13_0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:RefreshState()
	arg_17_0:RefreshMaterial()
end

function var_0_0.RefreshState(arg_18_0)
	arg_18_0.curIndex_ = ActivityPushBoxData:GetCurIndex(arg_18_0.activityID_)

	arg_18_0.progressCon_:SetSelectedState(arg_18_0.curIndex_)

	for iter_18_0 = 1, arg_18_0.curIndex_ do
		arg_18_0.rewardCon_[iter_18_0]:SetSelectedState("complete")
	end

	for iter_18_1 = arg_18_0.curIndex_ + 2, #arg_18_0.rewardCon_ do
		arg_18_0.rewardCon_[iter_18_1]:SetSelectedState("uncomplete")
	end

	local var_18_0 = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_18_0.activityID_]

	if arg_18_0.curIndex_ >= #var_18_0 then
		arg_18_0.makeBtn_.interactable = false
		arg_18_0.cfg_ = ActivityCelebrationCakeCfg[var_18_0[arg_18_0.curIndex_]]

		arg_18_0.rewardItemCon_:SetSelectedState("true")

		arg_18_0.rewardPreviewTxt_.text = GetTips(arg_18_0.rewardPreviewTbl_[arg_18_0.curIndex_])
		arg_18_0.materialPreviewTxt_.text = GetTips(arg_18_0.materialPreviewTbl_[arg_18_0.curIndex_])

		arg_18_0.stateCon_:SetSelectedState("finished")
	else
		local var_18_1 = arg_18_0:IsComplete(arg_18_0.curIndex_ + 1)

		arg_18_0.rewardCon_[arg_18_0.curIndex_ + 1]:SetSelectedState(var_18_1 and "current" or "uncomplete")

		arg_18_0.makeBtn_.interactable = var_18_1
		arg_18_0.cfg_ = ActivityCelebrationCakeCfg[var_18_0[arg_18_0.curIndex_ + 1]]

		arg_18_0.rewardItemCon_:SetSelectedState("false")

		arg_18_0.rewardPreviewTxt_.text = GetTips(arg_18_0.rewardPreviewTbl_[arg_18_0.curIndex_ + 1])
		arg_18_0.materialPreviewTxt_.text = GetTips(arg_18_0.materialPreviewTbl_[arg_18_0.curIndex_ + 1])

		arg_18_0.stateCon_:SetSelectedState(arg_18_0.curIndex_ == #arg_18_0.rewardCon_ - 1 and "last" or "normal")
	end

	local var_18_2 = arg_18_0.cfg_.award_list[1]

	arg_18_0.rewardItem_:RefreshData(formatReward(var_18_2))
end

function var_0_0.IsComplete(arg_19_0, arg_19_1)
	local var_19_0 = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_19_0.activityID_]
	local var_19_1 = ActivityCelebrationCakeCfg[var_19_0[arg_19_1]].cost_list

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_2 = iter_19_1[1]

		if iter_19_1[2] > ItemTools.getItemNum(var_19_2) then
			return false
		end
	end

	return true
end

function var_0_0.RefreshMaterial(arg_20_0)
	local var_20_0 = arg_20_0.cfg_.cost_list

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if not arg_20_0.materialItem_[iter_20_0] then
			arg_20_0.materialItem_[iter_20_0] = RewardItem.New(arg_20_0.materialTemplate_, arg_20_0.materialParent_)

			arg_20_0.materialItem_[iter_20_0]:UpdateCommonItemAni()
		end

		arg_20_0.materialItem_[iter_20_0]:SetData(iter_20_1)

		local var_20_1 = iter_20_1[1]
		local var_20_2 = iter_20_1[2]
		local var_20_3 = ItemTools.getItemNum(var_20_1)
		local var_20_4 = var_20_3 .. "/" .. var_20_2
		local var_20_5 = "<color=#FF0000>%d</color>"

		if var_20_3 < var_20_2 then
			var_20_4 = string.format(var_20_5, var_20_3) .. "/" .. var_20_2
		end

		arg_20_0.materialItem_[iter_20_0].commonItem_:SetBottomText(var_20_4)
		arg_20_0.materialItem_[iter_20_0].commonItem_:RegistCallBack(function()
			ShowPopItem(POP_MERGE_ITEM, iter_20_1)
		end)
	end

	for iter_20_2 = #var_20_0 + 1, #arg_20_0.materialItem_ do
		arg_20_0.materialItem_[iter_20_2]:Show(false)
	end
end

function var_0_0.RefreshAni(arg_22_0)
	local var_22_0 = arg_22_0.cakeClip_[arg_22_0.curIndex_ + 1]

	arg_22_0.cakeAni_:Play(var_22_0, -1, 1)
end

function var_0_0.OnPushBoxMakeCake(arg_23_0, arg_23_1)
	arg_23_0.curIndex_ = ActivityPushBoxData:GetCurIndex(arg_23_0.activityID_)

	local var_23_0 = arg_23_0.cakeClip_[arg_23_0.curIndex_ + 1]

	arg_23_0.cakeAni_:Play(var_23_0, -1, 0)
	SetActive(arg_23_0.countDownGo_.gameObject, true)

	arg_23_0.makeBtn_.interactable = false

	if arg_23_0.curIndex_ >= #arg_23_0.rewardCon_ then
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake02")
	else
		manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_cake01")
	end

	arg_23_0:RemoveTween()

	arg_23_0.tween_ = LeanTween.value(var_0_1, 0, var_0_1):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
		arg_23_0.countSlider_.fillAmount = 1 - arg_24_0 / var_0_1
		arg_23_0.countText_.text = string.format("%.2f", arg_24_0)
	end)):setOnComplete(System.Action(function()
		SetActive(arg_23_0.countDownGo_.gameObject, false)

		if #arg_23_1 > 0 then
			getReward(arg_23_1, nil, nil, nil, true)
		end

		arg_23_0:RefreshUI()
		arg_23_0:RemoveTween()
	end))
end

function var_0_0.OnMaterialUpdate(arg_26_0)
	arg_26_0:RefreshMaterial()
end

function var_0_0.RemoveTween(arg_27_0)
	if arg_27_0.tween_ then
		arg_27_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_27_0.tween_.id)

		arg_27_0.tween_ = nil
	end
end

function var_0_0.BindRedPointUI(arg_28_0)
	local var_28_0 = ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK

	manager.redPoint:bindUIandKey(arg_28_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. var_28_0)
	manager.redPoint:bindUIandKey(arg_28_0.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_28_0.activityID_)
	manager.redPoint:bindUIandKey(arg_28_0.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_28_0.activityID_)
end

function var_0_0.UnbindRedPointUI(arg_29_0)
	local var_29_0 = ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK

	manager.redPoint:unbindUIandKey(arg_29_0.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. var_29_0)
	manager.redPoint:unbindUIandKey(arg_29_0.makeBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_MATERIAL .. "_" .. arg_29_0.activityID_)
	manager.redPoint:unbindUIandKey(arg_29_0.materialBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_29_0.activityID_)
end

function var_0_0.OnTop(arg_30_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:StopTimer()
	arg_31_0:RemoveTween()
	arg_31_0:UnbindRedPointUI()
	arg_31_0.rewardItem_:OnExit()
	manager.windowBar:HideBar()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.materialItem_) do
		iter_31_1:OnExit()
	end

	manager.notify:RemoveListener(MATERIAL_MODIFY, arg_31_0.OnMaterialUpdateHandler_)
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:RemoveAllListeners()

	arg_32_0.OnMaterialUpdateHandler_ = nil

	arg_32_0.rewardItem_:Dispose()

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.materialItem_) do
		iter_32_1:Dispose()
	end

	arg_32_0.super.Dispose(arg_32_0)
end

return var_0_0
