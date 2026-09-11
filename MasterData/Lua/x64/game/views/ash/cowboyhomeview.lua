local CowboyHomeView = class("CowboyHomeView", ReduxView)

function CowboyHomeView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_HomeUI"
end

function CowboyHomeView:GetCustomScene()
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function CowboyHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function CowboyHomeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyHomeView:InitUI()
	self:BindCfgUI()

	self.infiniteTabController = self.infiniteController_:GetController("select")
	self.sectionTabController = self.sectionController_:GetController("select")
	self.lockInfiniteController = self.infiniteController_:GetController("lock")
end

function CowboyHomeView:AddUIListeners()
	self:AddBtnListener(self.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashPointView")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
	end)
	self:AddBtnListener(self.infiniteBtn_, nil, function()
		if AshSystemData:IsInfiniteOpen() then
			self:OnInfiniteClick()
		else
			ShowTips(GetTips("ASH_INFINITE_LOCK"))
		end
	end)
	self:AddBtnListener(self.InfiniteJumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashInfinityView")
	end)
	self:AddBtnListener(self.processBtn_, nil, function()
		self:GetCustomSceneController():ShowCutScene(function()
			JumpTools.OpenPageByJump("/ashProcessView")
		end)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		self:OnDescClick()
	end)
	self:AddBtnListener(self.sectionBtn_, nil, function()
		self:OnSectionClick()
	end)
	self:AddBtnListener(self.sectionJumpBtn_, nil, function()
		local var_15_0 = 1

		for iter_15_0 = 2, 3 do
			if AshSystemData:CheckIsOpenArea(iter_15_0) then
				var_15_0 = iter_15_0
			else
				break
			end
		end

		JumpTools.OpenPageByJump("/ashSectionView", {
			lastOpenArea = var_15_0
		})
	end)
end

function CowboyHomeView:OnAshAvgEnd()
	local var_16_0 = self:GetCustomSceneController()

	if var_16_0 then
		var_16_0:OnInit()
	end

	self:OnEnter()
	self:OnTop()
end

function CowboyHomeView:OnEnter()
	if AshSystemData:GetStoryState() then
		return
	end

	AshSystemData:UpdateTaskRedPoint()
	SetActive(self.clickMaskObj_, true)

	local var_17_0 = PlayerData:GetStoryList()
	local var_17_1 = getData("ash", "start_avg") or var_17_0[GameSetting.ash_start_story.value[1]] == true
	local var_17_2 = getData("ash", "end_avg") or var_17_0[GameSetting.ash_end_story.value[1]] == true

	if not var_17_1 then
		local var_17_3 = self:GetCustomSceneController()

		if var_17_3 then
			var_17_3:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "start_avg", true)
		AshSystemData:StartStory()
		manager.story:StartStoryById(GameSetting.ash_start_story.value[1], function()
			AshSystemData:EndStory()
		end)
	elseif AshSystemData:GetEndStoryIsUnlock() and not var_17_2 then
		local var_17_4 = self:GetCustomSceneController()

		if var_17_4 then
			var_17_4:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "end_avg", true)
		AshSystemData:StartStory()
		manager.story:StartStoryById(GameSetting.ash_end_story.value[1], function()
			AshSystemData:EndStory()
		end)
	else
		self:OnEnterFunc()
	end
end

function CowboyHomeView:OnEnterFunc()
	manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

	SetActive(self.clickMaskObj_, false)

	self.infiniteAnimator_.enabled = false
	self.activityID_ = ActivityConst.ACTIVITY_ASH_MAIN

	local var_20_0 = self:GetCustomSceneController()

	var_20_0:CloseCutScene()

	local var_20_1 = var_20_0:GetPlayableLength()

	var_20_0:Restart()

	if var_20_0.SwitchBgState then
		var_20_0:SwitchBgState(0)
	end

	self:RefreshLimitTime()
	manager.redPoint:bindUIandKey(self.sectionObj_.transform, RedPointConst.ASH_ACTIVITY_SECTION)
	manager.redPoint:bindUIandKey(self.rewardRedRoot_.transform, RedPointConst.ASH_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_ASH_LIMITED_TASK)
	manager.redPoint:bindUIandKey(self.pointBtn_.transform, RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN)
	self:SetupInfinite()

	local var_20_2 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	self.processTxt_.text = string.format("%d/%d", var_20_2, GameSetting.skuld_trust_max.value[1])
	self.progressImg_.fillAmount = var_20_2 / GameSetting.skuld_trust_max.value[1]

	local var_20_3 = 1

	for iter_20_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_20_0) then
			var_20_3 = iter_20_0
		else
			break
		end
	end

	self:GetCustomSceneController():SwitchBgStageIndex(var_20_3)
end

function CowboyHomeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ASH_ENTRANCE_TIP")

	local var_21_0 = 1

	for iter_21_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_21_0) then
			var_21_0 = iter_21_0
		else
			break
		end
	end

	if AshSystemData:GetStoryState() then
		return
	end

	self:GetCustomSceneController():SwitchBgStageIndex(var_21_0)
end

function CowboyHomeView:OnBehind()
	manager.windowBar:HideBar()
end

function CowboyHomeView:OnExit()
	self:LimitStopTimer()
	manager.redPoint:unbindUIandKey(self.sectionObj_.transform)
	manager.redPoint:unbindUIandKey(self.rewardRedRoot_.transform)
	manager.redPoint:unbindUIandKey(self.pointBtn_.transform)
end

function CowboyHomeView:OnDescClick()
	local var_24_0 = {
		content = GetTips("ASH_ENTRANCE_TIP")
	}

	var_24_0.key = "ASH_ENTRANCE_TIP"

	JumpTools.OpenPageByJump("gameHelp", var_24_0)
end

function CowboyHomeView:SetupInfinite()
	if AshSystemData:IsInfiniteOpen() then
		self.lockInfiniteController:SetSelectedState("unlock")

		local var_25_0 = "CowbotHomeViewInfiniteLock"

		if not getData("ash", "CowbotHomeViewInfiniteLock") then
			self:OnSectionClick()
			FrameTimer.New(function()
				self.aniTimer_ = Timer.New(function()
					if self.infiniteAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if self.aniTimer_ then
							self.aniTimer_:Stop()

							self.aniTimer_ = nil
						end

						saveData("ash", var_25_0, true)
						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)

				self.infiniteAnimator_.enabled = true

				self.infiniteAnimator_:Play("tabItem02", 0, 0)
				self:OnInfiniteClick()
				self.aniTimer_:Start()
			end, 1, 1):Start()
		else
			self:OnInfiniteClick()
		end
	else
		self.lockInfiniteController:SetSelectedState("lock")
		self:OnSectionClick()
	end
end

function CowboyHomeView:OnSectionClick()
	self.infiniteTabController:SetSelectedState("false")
	self.sectionTabController:SetSelectedState("true")
	SetActive(self.sectionObj_, true)
	SetActive(self.infiniteObj_, false)

	local var_28_0 = 1

	for iter_28_0 = 2, 3 do
		if AshSystemData:CheckIsOpenArea(iter_28_0) then
			var_28_0 = iter_28_0
		else
			break
		end
	end

	self.sectionIcon_.sprite = pureGetSpriteWithoutAtlas(GameSetting["ash_area_background_" .. var_28_0].value[1])
	self.sectionImg_.sprite = getSprite("Atlas/Activity_EkChuahAtlas", GameSetting["ash_area_icon_" .. var_28_0].value[1])
	self.sectionTxt_.text = GetTips("ASH_AREA_NAME_" .. var_28_0)
end

function CowboyHomeView:OnInfiniteClick()
	self.infiniteTabController:SetSelectedState("true")
	self.sectionTabController:SetSelectedState("false")
	SetActive(self.sectionObj_, false)
	SetActive(self.infiniteObj_, true)

	local var_29_0 = 0

	for iter_29_0, iter_29_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_29_1].stage_group == 4 then
			var_29_0 = iter_29_1

			break
		end
	end

	local var_29_1 = AshSystemData:GetStagePoint(var_29_0)

	self.infiniteTxt_.text = tostring((var_29_1 > 0 or nil) and tostring(var_29_1))
end

function CowboyHomeView:RefreshLimitTime()
	local var_30_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		SetActive(self.taskBtn_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_30_0.stopTime)
	else
		SetActive(self.taskBtn_.gameObject, false)
	end

	self:LimitStopTimer()

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_30_0.stopTime)
			else
				if manager.time:GetServerTime() < var_30_0.startTime then
					self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_30_0.startTime))
				elseif manager.time:GetServerTime() > var_30_0.stopTime then
					self.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(self.taskBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function CowboyHomeView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function CowboyHomeView:Dispose()
	if self.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self:LimitStopTimer()
	CowboyHomeView.super.Dispose(self)
end

return CowboyHomeView
