local var_0_0 = class("SpringPreheatPrayTreeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:RegistEventListener(NEW_DAY, handler(arg_3_0, arg_3_0.OnNewDay))
	arg_3_0:InitBranch()

	arg_3_0.stageController_ = ControllerUtil.GetController(arg_3_0.transform_, "stage")

	arg_3_0.stageController_:SetSelectedState("preheat")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("springPreheatPrayPreview", {})
	end)
end

function var_0_0.InitBranch(arg_6_0)
	local var_6_0 = arg_6_0:GetDays()

	arg_6_0.branchList_ = {}

	for iter_6_0 = 1, var_6_0 do
		local var_6_1 = arg_6_0[string.format("bubbleGo_%d", iter_6_0)]
		local var_6_2 = SpringPreheatPrayBubbleView.New(var_6_1)

		var_6_2:SetData(iter_6_0)
		var_6_2:SetClickHandler(function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
			arg_6_0:OnClickBubble(iter_6_0, arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		end)

		arg_6_0.branchList_[iter_6_0] = var_6_2
	end
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
		JumpTools.Back()
	end)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.branchList_) do
		iter_8_1:OnEnter()
	end

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.branchList_) do
		iter_10_1:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.branchList_) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RefreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.branchList_) do
		iter_12_1:UpdateItemIdList()
		iter_12_1:RefreshItemUiList()
		iter_12_1:RefreshUI()
	end

	local var_12_0 = SpringPreheatData:GetWelfareActivityId()
	local var_12_1 = ActivityData:GetActivityData(var_12_0)
	local var_12_2 = var_12_1.startTime
	local var_12_3 = var_12_1.stopTime

	arg_12_0.tipsText_.text = string.format(GetTips("SPRING_BLESSING_SCREEN_TIPS"), manager.time:STimeDescS(var_12_2, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_12_3, "!%Y.%m.%d %H:%M"))
end

function var_0_0.OnClickBubble(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = SpringPreheatData:GetDayState(arg_13_3)

	if var_13_0 == 1 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_LOCKED"), arg_13_3))
	elseif var_13_0 == 2 then
		ShowTips(string.format(GetTips("SPRING_PREHEAT_REWARD_BUBBLE_NOT_READY"), arg_13_3))
	elseif var_13_0 == 3 then
		JumpTools.OpenPageByJump("SpringPreheatPraySelectReward", {
			maxSelectCount = 2,
			onSelectionConfirmed = function(arg_14_0)
				arg_13_0:RefreshUI()
			end
		})
	elseif var_13_0 == 4 then
		JumpTools.OpenPageByJump("springPreheatPrayBranch", {
			day = arg_13_3
		})
	end
end

function var_0_0.OnNewDay(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.GetDays(arg_16_0)
	return SpringPreheatData:GetMaxProgress()
end

return var_0_0
