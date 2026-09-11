ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local SpringFestivalMainViewV2 = class("SpringFestivalMainViewV2", ActivityMainBaseView)

function SpringFestivalMainViewV2:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaSpringMainUI/IndiaSpringMainUI"
end

function SpringFestivalMainViewV2:Init()
	SpringFestivalMainViewV2.super.Init(self)

	self.clickBtnHandler_ = handler(self, self.ClickBtn)
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function SpringFestivalMainViewV2:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleWithAnimationItem.New(self.btn1_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK),
		ActivitySubmoduleWithAnimationItem.New(self.btn2_, ActivityConst.ACTIVITY_INDIA_NIAN),
		ActivitySubmoduleWithAnimationItem.New(self.btn3_, ActivityConst.ACTIVITY_2_8_QUIZ),
		ActivitySubmoduleWithAnimationItem.New(self.btn4_, ActivityConst.ACTIVITY_PUSH_SNOW_BALL),
		ActivitySubmoduleWithAnimationItem.New(self.btn5_, ActivityConst.ACTIVITY_2_8_SPRING_MEMORY),
		ActivitySubmoduleWithAnimationItem.New(self.btn6_, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_WELFARE)
	}
end

function SpringFestivalMainViewV2:GetActivityID()
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2
end

function SpringFestivalMainViewV2:OnEnter()
	self.stateCon_:SetSelectedState(0)
	SpringFestivalMainViewV2.super.OnEnter(self)

	if self.params_.isEnter then
		self:CheckStory()

		self.params_.isEnter = false
	end

	manager.notify:RegistListener(ACTIVITY_MAIN_CLICK_BTN, self.clickBtnHandler_)
end

function SpringFestivalMainViewV2:CheckStory()
	self.enterStoryID_ = GameSetting.spring_festival_memory_story_start.value[2]
	self.activityStoryID_ = GameSetting.spring_festival_memory_story_process.value[2]
	self.collectStoryID_ = GameSetting.spring_festival_memory_story_end.value[2]

	if self:CheckEnterStory() then
		self:PlayStory(self.enterStoryID_, function()
			self.stateCon_:SetSelectedStateWithCallback(1, function()
				ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_2_8_SPRING_MEMORY)
			end)
		end)

		return
	end

	if self:CheckActivityStory() then
		self:PlayStory(self.activityStoryID_, function()
			self.stateCon_:SetSelectedState(2)
		end)

		return
	end

	if self:CheckCollectStory() then
		self:PlayStory(self.collectStoryID_)

		return
	end
end

function SpringFestivalMainViewV2:CheckEnterStory()
	return self.enterStoryID_ and not manager.story:IsStoryPlayed(self.enterStoryID_)
end

function SpringFestivalMainViewV2:CheckActivityStory()
	if not self.activityStoryID_ or manager.story:IsStoryPlayed(self.activityStoryID_) then
		return false
	end

	local var_11_0 = ActivityData:GetActivityData(GameSetting.spring_festival_memory_story_process.value[1])

	return var_11_0 and var_11_0:IsActivitying()
end

function SpringFestivalMainViewV2:CheckCollectStory()
	if not self.collectStoryID_ or manager.story:IsStoryPlayed(self.collectStoryID_) then
		return false
	end

	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_8_SPRING_MEMORY]) do
		local var_12_2 = TaskData2:GetTask(SpringFestivalMemoryCfg[iter_12_1].task_id)

		if var_12_2 and var_12_2.progress >= AssignmentCfg[SpringFestivalMemoryCfg[iter_12_1].task_id].need then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0 >= GameSetting.spring_festival_memory_story_end.value[1]
end

function SpringFestivalMainViewV2:PlayStory(arg_13_1, arg_13_2)
	manager.story:StartStoryById(arg_13_1, function()
		if arg_13_2 then
			arg_13_2()
		end
	end)
end

function SpringFestivalMainViewV2:OnExit()
	SpringFestivalMainViewV2.super.OnExit(self)
	manager.notify:RemoveListener(ACTIVITY_MAIN_CLICK_BTN, self.clickBtnHandler_)
	self:CancelTween()
end

function SpringFestivalMainViewV2:Dispose()
	SpringFestivalMainViewV2.super.Dispose(self)

	self.clickBtnHandler_ = nil
end

function SpringFestivalMainViewV2:RefreshUI()
	return
end

function SpringFestivalMainViewV2:ClickBtn()
	manager.windowBar:HideBar()
	self:ShowBtnList(false)
	self:CancelTween()

	self.leanTween_ = LeanTween.scale(self.scrollTf_, Vector3(1.1, 1.1, 1.1), 0.5):setEase(LeanTweenType.easeOutCubic)
	self.scrollView_.enabled = false
end

function SpringFestivalMainViewV2:OnTop()
	self:ShowBtnList(true)

	self.scrollView_.enabled = true

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SpringFestivalMainViewV2:ShowBtnList(arg_20_1)
	SetActive(self.btn1_.transform, arg_20_1)
	SetActive(self.btn2_.transform, arg_20_1)
	SetActive(self.btn3_.transform, arg_20_1)
	SetActive(self.btn4_.transform, arg_20_1)
	SetActive(self.btn5_.transform, arg_20_1)
	SetActive(self.btn6_.transform, arg_20_1)

	self.scrollTf_.localScale = Vector3(1, 1, 1)
end

function SpringFestivalMainViewV2:CancelTween()
	if self.leanTween_ then
		LeanTween.cancel(self.scrollTf_)

		self.leanTween_ = nil
	end
end

return SpringFestivalMainViewV2
