local var_0_0 = class("HeroSkillView", ReduxView)
local var_0_1 = {
	PROPERTY = 2,
	SKILL = 1
}
local var_0_2 = {
	[var_0_1.SKILL] = "skill",
	[var_0_1.PROPERTY] = "property"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_skill/HeroSkillMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tabSelectController_ = arg_4_0.tablistControllerEx_:GetController("tabSelect")
	arg_4_0.propertyController_ = arg_4_0.propertyControllerexcollection_:GetController("lock")
	arg_4_0.hideTabController_ = arg_4_0.controller_:GetController("hide")
	arg_4_0.skillView_ = HeroSkillView.New(arg_4_0, arg_4_0.heroskilluiGo_)
	arg_4_0.propertyObj_ = arg_4_0.propertyBtn_.gameObject
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		arg_5_0:ChangeTab(var_0_1.SKILL)
	end)
	arg_5_0:AddBtnListener(arg_5_0.propertyBtn_, nil, function()
		local var_7_0, var_7_1 = arg_5_0:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

		if not var_7_0 then
			ShowTips(var_7_1)

			return
		end

		OperationRecorder.RecordButtonTouch("hero_skill_attribute_lv_up")
		arg_5_0:ChangeTab(var_0_1.PROPERTY)
	end)
end

function var_0_0.CheckPrepertyCondition(arg_8_0, arg_8_1)
	if not table.keyof(ViewConst.SYSTEM_ID, arg_8_1) then
		return true, ""
	end

	local var_8_0 = JumpTools.IsSystemLocked(arg_8_1)

	if not var_8_0 then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(arg_8_1, var_8_0)
	end
end

function var_0_0.ChangeTab(arg_9_0, arg_9_1)
	if arg_9_0.selectTabType and arg_9_0.selectTabType == arg_9_1 then
		return
	end

	arg_9_0.tabSelectController_:SetSelectedState(var_0_2[arg_9_1])
	arg_9_0:ExitSendMgr(arg_9_0.selectTabType)

	arg_9_0.selectTabType = arg_9_1

	arg_9_0.skillView_:ChangeTabShow(arg_9_1)
	arg_9_0:EnterSendMgr(arg_9_0.selectTabType)
end

function var_0_0.NotHaveAttrShow(arg_10_0, arg_10_1)
	SetActive(arg_10_0.propertyObj_, not arg_10_1)

	if arg_10_1 and arg_10_0.selectTabType == var_0_1.PROPERTY then
		arg_10_0:ChangeTab(var_0_1.SKILL)
	end
end

function var_0_0.isPropertyView(arg_11_0)
	return arg_11_0.selectTabType == var_0_1.PROPERTY
end

function var_0_0.GetSelectTabType(arg_12_0)
	return arg_12_0.selectTabType
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if arg_13_0.skillView_ then
		arg_13_0.skillView_:OnTop()
	end
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.skillView_:OnEnter(arg_14_0.params_)

	arg_14_0.heroViewDataProxy_ = arg_14_0.params_.proxy

	arg_14_0.hideTabController_:SetSelectedState(tostring(arg_14_0.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))

	if not arg_14_0.selectTabType or arg_14_0.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		arg_14_0:ChangeTab(var_0_1.SKILL)
	else
		arg_14_0:EnterSendMgr(arg_14_0.selectTabType)
	end

	arg_14_0:CheckLocked()
	arg_14_0:UpdateAvatarView()
end

function var_0_0.CheckLocked(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

	arg_15_0.propertyController_:SetSelectedState(var_15_0 and "false" or "true")
end

function var_0_0.UpdateAvatarView(arg_16_0)
	local var_16_0 = arg_16_0.params_ and arg_16_0.params_.heroInfo and arg_16_0.params_.heroInfo.id or nil

	if var_16_0 then
		manager.heroRaiseTrack:SetModelStateByHeroProxy(arg_16_0.heroViewDataProxy_, var_16_0)
	end
end

function var_0_0.CameraEnter(arg_17_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		1
	})

	local var_17_0 = arg_17_0.params_.proxy
	local var_17_1 = arg_17_0.params_.heroInfo.id

	manager.heroRaiseTrack:SetModelStateByHeroProxy(var_17_0, var_17_1)
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	arg_18_0.skillView_:OnExit()

	if arg_18_0.skillView_ and arg_18_0.skillView_.isGoHeroMain then
		arg_18_0:ChangeTab(var_0_1.SKILL)
	end

	arg_18_0:ExitSendMgr(arg_18_0.selectTabType)
end

function var_0_0.OnHeroSkillUpgrade(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.skillView_:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
end

function var_0_0.OnHeroSkillAttrUpgrade(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.skillView_:OnHeroSkillAttrUpgradeInView(arg_20_1, arg_20_2)
end

function var_0_0.GetPlayBackwardsAnimator(arg_21_0)
	return arg_21_0.skillView_:GetPlayBackwardsAnimator()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.skillView_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.EnterSendMgr(arg_23_0, arg_23_1)
	if arg_23_1 then
		local var_23_0 = var_0_2[arg_23_1]

		manager.uiTime:OnEnterRoute(var_23_0)
	end
end

function var_0_0.ExitSendMgr(arg_24_0, arg_24_1)
	if arg_24_1 then
		local var_24_0 = var_0_2[arg_24_1]

		manager.uiTime:OnExitRoute(var_24_0)
	end
end

return var_0_0
