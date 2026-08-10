local var_0_0 = class("AdminHomePageView", ReduxView)
local var_0_1 = {
	[1] = "Property_Files",
	[2] = "Skill_Details"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsHomepageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.switchController_ = arg_3_0.controller_:GetController("switch")
	arg_3_0.oathController_ = arg_3_0.selfController_:GetController("Hero_Oath")
	arg_3_0.oathHeroList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexOathHeroItem), arg_3_0.listGo_, OathHeroItem)
end

function var_0_0.IndexOathHeroItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.oath_hero_list[arg_4_1]

	arg_4_2:SetData(var_4_0)
	arg_4_2:ChangeSelect(false)
end

function var_0_0.UpdateOathUI(arg_5_0)
	arg_5_0:RegistEventListener(OATH_SELECT_HERO, handler(arg_5_0, arg_5_0.OnClickOathHero))

	if not OathTools.GetIsOpenOath() then
		arg_5_0.oathController_:SetSelectedState("hide")
	else
		local var_5_0 = OathTools.GetIsOpenOath()

		arg_5_0.oathController_:SetSelectedState(var_5_0 and "unlock" or "lock")

		if var_5_0 then
			local var_5_1 = WeddingCfg.all

			arg_5_0.oath_hero_list = OathTools.GetHeroSortList(var_5_1)

			arg_5_0.oathHeroList_:StartScroll(#arg_5_0.oath_hero_list)
		end
	end
end

function var_0_0.OnClickOathHero(arg_6_0, arg_6_1)
	OperationRecorder.RecordButtonTouch({
		button_name = "wedding_homepage_touch",
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		source = OathConst.OATH_SOURCE_ID.ADMIN
	})
	JumpTools.OpenPageByJump("/oathMainView", {
		selectHeroID = arg_6_1
	})
end

function var_0_0.AddOathBtnListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.oathTitleBtn_, nil, function()
		local var_8_0 = OathTools.CheckOpenOathCondition()

		if var_8_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.OATH_SYSTEM, var_8_0))
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.oathVideoBtn_, nil, function()
		manager.audio:StopAll()
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		arg_7_0:PlayClickOathPlot()
	end)
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.helpBtn_, nil, function()
		arg_10_0:Go("/adminSelectChip", {
			isFroming = false
		})
		arg_10_0:DisposeTimer()
	end)
	arg_10_0:AddBtnListener(arg_10_0.skinBtn_, nil, function()
		arg_10_0:Go("/adminSkinView")
		arg_10_0:DisposeTimer()
	end)
	arg_10_0:AddBtnListener(arg_10_0.switchBtn_, nil, function()
		arg_10_0:IdlePlayAnim()

		if arg_10_0.switchController_:GetSelectedIndex() == 0 then
			arg_10_0.switchController_:SetSelectedIndex(1)
			manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
				8,
				3
			})
		else
			arg_10_0.switchController_:SetSelectedIndex(0)
			manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
				8,
				0
			})
		end
	end)
	arg_10_0:AddOathBtnListeners()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:RealEnter()

	arg_14_0.op = {}
	arg_14_0.playdStoryIDList = {}

	if OathTools.GetIsNeedPlayOathPlot() then
		arg_14_0.guideWaitStory = true

		local var_14_0 = OathTools.GetOathUnPlayOpenPoltID()
		local var_14_1 = OathTools.GetOathOpenPoltList()
		local var_14_2 = table.indexof(var_14_1, var_14_0)

		arg_14_0:AddOpeningStory(var_14_0, function()
			arg_14_0:ContinuePlayEnterOathPlot()
		end)
	end

	arg_14_0:SchedulePlayOpeningStory()
end

function var_0_0.OathPlotEndCallback(arg_16_0, arg_16_1)
	arg_16_0:RealCameraEnter()
	arg_16_0:ShowGetSpecialRing(arg_16_1, function()
		arg_16_0.guideWaitStory = nil

		arg_16_0:CheckWeakGuide()
		arg_16_0:UpdateCanOathHeroListNotice()
	end)
end

function var_0_0.UpdateCanOathHeroListNotice(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.oath_hero_list) do
		OathSupportData:UpdateOathCanCompleteNotice(iter_18_1)
	end

	local var_18_0 = arg_18_0.oathHeroList_:GetItemList()

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		if iter_18_3 then
			iter_18_3:UpdateCanOathNotice()
		end
	end
end

function var_0_0.FindNextPlayEnterOathPlot(arg_19_0)
	local var_19_0 = OathTools.GetOathOpenPoltList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if not arg_19_0.playdStoryIDList[iter_19_1] and not manager.story:IsStoryPlayed(iter_19_1) then
			return iter_19_1
		end
	end
end

function var_0_0.ContinuePlayEnterOathPlot(arg_20_0)
	local var_20_0 = arg_20_0:FindNextPlayEnterOathPlot()

	if var_20_0 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(var_20_0, function()
			arg_20_0.playdStoryIDList[var_20_0] = true

			arg_20_0:ContinuePlayEnterOathPlot()
		end)
	else
		arg_20_0:OathPlotEndCallback(var_20_0)
	end
end

function var_0_0.PlayClickOathPlot(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or 1

	local var_22_0 = OathTools.GetOathOpenPoltList()[arg_22_1]

	if var_22_0 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		manager.story:StartStoryById(var_22_0, function()
			arg_22_0:PlayClickOathPlot(arg_22_1 + 1)
		end)
	else
		arg_22_0:RealCameraEnter()
	end
end

function var_0_0.AddOpeningStory(arg_24_0, arg_24_1, arg_24_2)
	table.insert(arg_24_0.op, {
		plotID = arg_24_1,
		callback = arg_24_2
	})
end

function var_0_0.SchedulePlayOpeningStory(arg_25_0)
	arg_25_0:StopOpeningStoryDelayTimer()

	if #arg_25_0.op > 0 then
		arg_25_0.openingTimer = FrameTimer.New(function()
			if manager.guide:IsPlaying() then
				if arg_25_0.waitGuideFlag == nil then
					arg_25_0.waitGuideFlag = true

					arg_25_0:RealCameraEnter()
				end
			else
				arg_25_0.waitGuideFlag = nil

				if #arg_25_0.op <= 0 then
					arg_25_0:StopOpeningStoryDelayTimer()

					return
				end

				local var_26_0 = table.remove(arg_25_0.op, 1)
				local var_26_1 = var_26_0.plotID
				local var_26_2 = var_26_0.callback

				manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
				manager.story:StartStoryById(var_26_1, function()
					arg_25_0.playdStoryIDList[var_26_1] = true

					if var_26_2 then
						var_26_2()
					end
				end)
			end
		end, 1, -1)

		arg_25_0.openingTimer:Start()
	else
		arg_25_0:RealCameraEnter()
	end
end

function var_0_0.StopOpeningStoryDelayTimer(arg_28_0)
	arg_28_0.waitGuideFlag = nil

	if arg_28_0.openingTimer then
		arg_28_0.openingTimer:Stop()

		arg_28_0.openingTimer = nil
	end
end

function var_0_0.RealEnter(arg_29_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_29_0.helpText_.text = string.format("%d%%", math.floor(100 * ChipTools.GetChipUnlockProgress()))
	arg_29_0.skinText_.text = 100 * AdminSystemData:GetPlayerSkinProp() .. "%"

	arg_29_0:BindRedPoint()
	arg_29_0:IdlePlayAnim()
	arg_29_0:UpdateOathUI()
end

function var_0_0.CheckWeakGuide(arg_30_0)
	if arg_30_0.guideWaitStory then
		return
	end

	var_0_0.super.CheckWeakGuide(arg_30_0)
end

function var_0_0.IdlePlayAnim(arg_31_0)
	arg_31_0:DisposeTimer()

	arg_31_0.timer_ = Timer.New(function()
		local var_32_0 = math.random(1, 2)

		manager.heroRaiseTrack:RemainAni("", var_0_1[var_32_0])
		arg_31_0:IdlePlayAnim()
		arg_31_0:DisposeTimer()
	end, 10, -1)

	arg_31_0.timer_:Start()
end

function var_0_0.DisposeTimer(arg_33_0)
	if arg_33_0.timer_ then
		arg_33_0.timer_:Stop()

		arg_33_0.timer_ = nil
	end
end

function var_0_0.CameraEnter(arg_34_0)
	return
end

function var_0_0.RealCameraEnter(arg_35_0)
	local var_35_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		0
	}, arg_35_0.displayGo_)
	manager.heroRaiseTrack:SetModelState(var_35_0)
end

function var_0_0.OnExit(arg_36_0)
	arg_36_0:RemoveAllEventListener()
	arg_36_0:StopOpeningStoryDelayTimer()
	arg_36_0:DisposeTimer()
	arg_36_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPoint(arg_37_0)
	manager.redPoint:bindUIandKey(arg_37_0.helpNotice_, RedPointConst.ADMIN_HELP_BATTLE)
end

function var_0_0.UnbindRedPoint(arg_38_0)
	manager.redPoint:unbindUIandKey(arg_38_0.helpNotice_)
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0.oathHeroList_:Dispose()
	arg_39_0:RemoveAllListeners()
	arg_39_0.super.Dispose(arg_39_0)
end

function var_0_0.ShowGetSpecialRing(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(WeddingCfg.all) do
		local var_40_1 = WeddingCfg[iter_40_1]
		local var_40_2 = var_40_1.read_story_id
		local var_40_3 = var_40_1.read_reward

		if var_40_3 == "" then
			var_40_3 = nil
		end

		if var_40_2 == arg_40_1 and var_40_3 ~= nil then
			mergeRewardList(var_40_0, formatRewardCfgList(var_40_3))
		end
	end

	if #var_40_0 > 0 then
		getReward(var_40_0, nil, arg_40_2)
	elseif arg_40_2 then
		arg_40_2()
	end
end

return var_0_0
