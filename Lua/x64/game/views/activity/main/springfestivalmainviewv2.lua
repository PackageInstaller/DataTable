ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("SpringFestivalMainViewV2", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaSpringMainUI/IndiaSpringMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.clickBtnHandler_ = handler(arg_2_0, arg_2_0.ClickBtn)
	arg_2_0.stateCon_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.InitSubmoduleButton(arg_3_0)
	arg_3_0.submoduleBtnList_ = {
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn1_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK),
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn2_, ActivityConst.ACTIVITY_INDIA_NIAN),
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn3_, ActivityConst.ACTIVITY_2_8_QUIZ),
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn4_, ActivityConst.ACTIVITY_PUSH_SNOW_BALL),
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn5_, ActivityConst.ACTIVITY_2_8_SPRING_MEMORY),
		ActivitySubmoduleWithAnimationItem.New(arg_3_0.btn6_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_WELFARE)
	}
end

function var_0_0.GetActivityID(arg_4_0)
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stateCon_:SetSelectedState(0)
	var_0_0.super.OnEnter(arg_5_0)

	if arg_5_0.params_.isEnter then
		arg_5_0:CheckStory()

		arg_5_0.params_.isEnter = false
	end

	manager.notify:RegistListener(ACTIVITY_MAIN_CLICK_BTN, arg_5_0.clickBtnHandler_)
end

function var_0_0.CheckStory(arg_6_0)
	arg_6_0.enterStoryID_ = GameSetting.spring_festival_memory_story_start.value[2]
	arg_6_0.activityStoryID_ = GameSetting.spring_festival_memory_story_process.value[2]
	arg_6_0.collectStoryID_ = GameSetting.spring_festival_memory_story_end.value[2]

	if arg_6_0:CheckEnterStory() then
		arg_6_0:PlayStory(arg_6_0.enterStoryID_, function()
			arg_6_0.stateCon_:SetSelectedStateWithCallback(1, function()
				ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_2_8_SPRING_MEMORY)
			end)
		end)

		return
	end

	if arg_6_0:CheckActivityStory() then
		arg_6_0:PlayStory(arg_6_0.activityStoryID_, function()
			arg_6_0.stateCon_:SetSelectedState(2)
		end)

		return
	end

	if arg_6_0:CheckCollectStory() then
		arg_6_0:PlayStory(arg_6_0.collectStoryID_)

		return
	end
end

function var_0_0.CheckEnterStory(arg_10_0)
	return arg_10_0.enterStoryID_ and not manager.story:IsStoryPlayed(arg_10_0.enterStoryID_)
end

function var_0_0.CheckActivityStory(arg_11_0)
	if not arg_11_0.activityStoryID_ or manager.story:IsStoryPlayed(arg_11_0.activityStoryID_) then
		return false
	end

	local var_11_0 = GameSetting.spring_festival_memory_story_process.value[1]
	local var_11_1 = ActivityData:GetActivityData(var_11_0)

	return var_11_1 and var_11_1:IsActivitying()
end

function var_0_0.CheckCollectStory(arg_12_0)
	if not arg_12_0.collectStoryID_ or manager.story:IsStoryPlayed(arg_12_0.collectStoryID_) then
		return false
	end

	local var_12_0 = 0
	local var_12_1 = ActivityConst.ACTIVITY_2_8_SPRING_MEMORY_TASK
	local var_12_2 = SpringFestivalMemoryCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY]

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = SpringFestivalMemoryCfg[iter_12_1].task_id
		local var_12_4 = AssignmentCfg[var_12_3]
		local var_12_5 = TaskData2:GetTask(var_12_3)

		if var_12_5 and var_12_5.progress >= var_12_4.need then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0 >= GameSetting.spring_festival_memory_story_end.value[1]
end

function var_0_0.PlayStory(arg_13_0, arg_13_1, arg_13_2)
	manager.story:StartStoryById(arg_13_1, function()
		if arg_13_2 then
			arg_13_2()
		end
	end)
end

function var_0_0.OnExit(arg_15_0)
	var_0_0.super.OnExit(arg_15_0)
	manager.notify:RemoveListener(ACTIVITY_MAIN_CLICK_BTN, arg_15_0.clickBtnHandler_)
	arg_15_0:CancelTween()
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	arg_16_0.clickBtnHandler_ = nil
end

function var_0_0.RefreshUI(arg_17_0)
	return
end

function var_0_0.ClickBtn(arg_18_0)
	manager.windowBar:HideBar()
	arg_18_0:ShowBtnList(false)
	arg_18_0:CancelTween()

	arg_18_0.leanTween_ = LeanTween.scale(arg_18_0.scrollTf_, Vector3(1.1, 1.1, 1.1), 0.5):setEase(LeanTweenType.easeOutCubic)
	arg_18_0.scrollView_.enabled = false
end

function var_0_0.OnTop(arg_19_0)
	arg_19_0:ShowBtnList(true)

	arg_19_0.scrollView_.enabled = true

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.ShowBtnList(arg_20_0, arg_20_1)
	SetActive(arg_20_0.btn1_.transform, arg_20_1)
	SetActive(arg_20_0.btn2_.transform, arg_20_1)
	SetActive(arg_20_0.btn3_.transform, arg_20_1)
	SetActive(arg_20_0.btn4_.transform, arg_20_1)
	SetActive(arg_20_0.btn5_.transform, arg_20_1)
	SetActive(arg_20_0.btn6_.transform, arg_20_1)

	arg_20_0.scrollTf_.localScale = Vector3(1, 1, 1)
end

function var_0_0.CancelTween(arg_21_0)
	if arg_21_0.leanTween_ then
		LeanTween.cancel(arg_21_0.scrollTf_)

		arg_21_0.leanTween_ = nil
	end
end

return var_0_0
