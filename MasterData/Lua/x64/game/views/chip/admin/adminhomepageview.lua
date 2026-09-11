local AdminHomePageView = class("AdminHomePageView", ReduxView)
local var_0_1 = {
	[1] = "Property_Files",
	[2] = "Skill_Details"
}

function AdminHomePageView:UIName()
	return "Widget/System/Administrators/AdministratorsHomepageUI"
end

function AdminHomePageView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminHomePageView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchController_ = self.controller_:GetController("switch")
	self.oathController_ = self.selfController_:GetController("Hero_Oath")
	self.oathHeroList_ = LuaList.New(handler(self, self.IndexOathHeroItem), self.listGo_, OathHeroItem)
end

function AdminHomePageView:IndexOathHeroItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.oath_hero_list[arg_4_1])
	arg_4_2:ChangeSelect(false)
end

function AdminHomePageView:UpdateOathUI()
	self:RegistEventListener(OATH_SELECT_HERO, handler(self, self.OnClickOathHero))

	if not OathTools.GetIsOpenOath() then
		self.oathController_:SetSelectedState("hide")
	else
		local var_5_0 = OathTools.GetIsOpenOath()

		self.oathController_:SetSelectedState(var_5_0 and "unlock" or "lock")

		if var_5_0 then
			self.oath_hero_list = OathTools.GetHeroSortList(WeddingCfg.all)

			self.oathHeroList_:StartScroll(#self.oath_hero_list)
		end
	end
end

function AdminHomePageView:OnClickOathHero(arg_6_1)
	OperationRecorder.RecordButtonTouch({
		button_name = "wedding_homepage_touch",
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		source = OathConst.OATH_SOURCE_ID.ADMIN
	})
	JumpTools.OpenPageByJump("/oathMainView", {
		selectHeroID = arg_6_1
	})
end

function AdminHomePageView:AddOathBtnListeners()
	self:AddBtnListener(self.oathTitleBtn_, nil, function()
		local var_8_0 = OathTools.CheckOpenOathCondition()

		if var_8_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.OATH_SYSTEM, var_8_0))
		end
	end)
	self:AddBtnListener(self.oathVideoBtn_, nil, function()
		manager.audio:StopAll()
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		self:PlayClickOathPlot()
	end)
end

function AdminHomePageView:AddListeners()
	self:AddBtnListener(self.helpBtn_, nil, function()
		self:Go("/adminSelectChip", {
			isFroming = false
		})
		self:DisposeTimer()
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		self:Go("/adminSkinView")
		self:DisposeTimer()
	end)
	self:AddBtnListener(self.switchBtn_, nil, function()
		self:IdlePlayAnim()

		if self.switchController_:GetSelectedIndex() == 0 then
			self.switchController_:SetSelectedIndex(1)
			manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
				8,
				3
			})
		else
			self.switchController_:SetSelectedIndex(0)
			manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
				8,
				0
			})
		end
	end)
	self:AddOathBtnListeners()
end

function AdminHomePageView:OnEnter()
	self:RealEnter()

	self.op = {}
	self.playdStoryIDList = {}

	if OathTools.GetIsNeedPlayOathPlot() then
		self.guideWaitStory = true

		local var_14_0 = OathTools.GetOathUnPlayOpenPoltID()
		local var_14_1 = table.indexof(OathTools.GetOathOpenPoltList(), var_14_0)

		self:AddOpeningStory(var_14_0, function()
			self:ContinuePlayEnterOathPlot()
		end)
	end

	self:SchedulePlayOpeningStory()
end

function AdminHomePageView:OathPlotEndCallback(arg_16_1)
	self:RealCameraEnter()
	self:ShowGetSpecialRing(arg_16_1, function()
		self.guideWaitStory = nil

		self:CheckWeakGuide()
		self:UpdateCanOathHeroListNotice()
	end)
end

function AdminHomePageView:UpdateCanOathHeroListNotice()
	for iter_18_0, iter_18_1 in pairs(self.oath_hero_list) do
		OathSupportData:UpdateOathCanCompleteNotice(iter_18_1)
	end

	for iter_18_2, iter_18_3 in pairs((self.oathHeroList_:GetItemList())) do
		if iter_18_3 then
			iter_18_3:UpdateCanOathNotice()
		end
	end
end

function AdminHomePageView:FindNextPlayEnterOathPlot()
	for iter_19_0, iter_19_1 in ipairs((OathTools.GetOathOpenPoltList())) do
		if not self.playdStoryIDList[iter_19_1] and not manager.story:IsStoryPlayed(iter_19_1) then
			return iter_19_1
		end
	end
end

function AdminHomePageView:ContinuePlayEnterOathPlot()
	local var_20_0 = self:FindNextPlayEnterOathPlot()

	if var_20_0 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(var_20_0, function()
			self.playdStoryIDList[var_20_0] = true

			self:ContinuePlayEnterOathPlot()
		end)
	else
		self:OathPlotEndCallback(var_20_0)
	end
end

function AdminHomePageView:PlayClickOathPlot(arg_22_1)
	arg_22_1 = arg_22_1 or 1

	local var_22_0 = OathTools.GetOathOpenPoltList()[arg_22_1]

	if var_22_0 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(var_22_0, function()
			self:PlayClickOathPlot(arg_22_1 + 1)
		end)
	else
		self:RealCameraEnter()
	end
end

function AdminHomePageView:AddOpeningStory(arg_24_1, arg_24_2)
	table.insert(self.op, {
		plotID = arg_24_1,
		callback = arg_24_2
	})
end

function AdminHomePageView:SchedulePlayOpeningStory()
	self:StopOpeningStoryDelayTimer()

	if #self.op > 0 then
		self.openingTimer = FrameTimer.New(function()
			if manager.guide:IsPlaying() then
				if self.waitGuideFlag == nil then
					self.waitGuideFlag = true

					self:RealCameraEnter()
				end
			else
				self.waitGuideFlag = nil

				if #self.op <= 0 then
					self:StopOpeningStoryDelayTimer()

					return
				end

				local var_26_0 = table.remove(self.op, 1)
				local var_26_1 = var_26_0.plotID
				local var_26_2 = var_26_0.callback

				manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
				manager.story:StartStoryById(var_26_0.plotID, function()
					self.playdStoryIDList[var_26_1] = true

					if var_26_2 then
						var_26_2()
					end
				end)
			end
		end, 1, -1)

		self.openingTimer:Start()
	else
		self:RealCameraEnter()
	end
end

function AdminHomePageView:StopOpeningStoryDelayTimer()
	self.waitGuideFlag = nil

	if self.openingTimer then
		self.openingTimer:Stop()

		self.openingTimer = nil
	end
end

function AdminHomePageView:RealEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.helpText_.text = string.format("%d%%", math.floor(100 * ChipTools.GetChipUnlockProgress()))
	self.skinText_.text = 100 * AdminSystemData:GetPlayerSkinProp() .. "%"

	self:BindRedPoint()
	self:IdlePlayAnim()
	self:UpdateOathUI()
end

function AdminHomePageView:CheckWeakGuide()
	if self.guideWaitStory then
		return
	end

	AdminHomePageView.super.CheckWeakGuide(self)
end

function AdminHomePageView:IdlePlayAnim()
	self:DisposeTimer()

	self.timer_ = Timer.New(function()
		manager.heroRaiseTrack:RemainAni("", var_0_1[math.random(1, 2)])
		self:IdlePlayAnim()
		self:DisposeTimer()
	end, 10, -1)

	self.timer_:Start()
end

function AdminHomePageView:DisposeTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AdminHomePageView:CameraEnter()
	return
end

function AdminHomePageView:RealCameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		0
	}, self.displayGo_)
	manager.heroRaiseTrack:SetModelState((AdminSystemTools.HeroUsingSkinInfo(1001)))
end

function AdminHomePageView:OnExit()
	self:RemoveAllEventListener()
	self:StopOpeningStoryDelayTimer()
	self:DisposeTimer()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function AdminHomePageView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.helpNotice_, RedPointConst.ADMIN_HELP_BATTLE)
end

function AdminHomePageView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.helpNotice_)
end

function AdminHomePageView:Dispose()
	self.oathHeroList_:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

function AdminHomePageView:ShowGetSpecialRing(arg_40_1, arg_40_2)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(WeddingCfg.all) do
		local var_40_1 = WeddingCfg[iter_40_1].read_reward

		if WeddingCfg[iter_40_1].read_reward == "" then
			var_40_1 = nil
		end

		if WeddingCfg[iter_40_1].read_story_id == arg_40_1 and var_40_1 ~= nil then
			mergeRewardList(var_40_0, formatRewardCfgList(var_40_1))
		end
	end

	if #var_40_0 > 0 then
		getReward(var_40_0, nil, arg_40_2)
	elseif arg_40_2 then
		arg_40_2()
	end
end

return AdminHomePageView
