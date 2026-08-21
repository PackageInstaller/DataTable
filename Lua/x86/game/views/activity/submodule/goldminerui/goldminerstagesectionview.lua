local var_0_0 = class("GoldMinerStageSectionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_StageBaseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshRewardItem), arg_4_0.rewardUIListGo_, CommonItemView)
	arg_4_0.hideDropPanelController_ = arg_4_0.controllerEx_:GetController("hideDropPanel")
	arg_4_0.btnController_ = arg_4_0.btnControllerEx_:GetController("lock")
	arg_4_0.sectionInfoThreeStarBar_ = GoldMinerSectionInfoThreeStarBar.New(arg_4_0.threeStarGo_)
end

function var_0_0.RefreshRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rewardList_[arg_5_1]
	local var_5_1

	if var_5_0 then
		var_5_1 = rewardToItemTemplate(var_5_0)
		var_5_1.number = arg_5_0.isFirstClear_ and var_5_0.num or nil

		function var_5_1.clickFun(arg_6_0)
			ShowPopItem(POP_ITEM, arg_6_0)
		end
	end

	arg_5_2:SetData(var_5_1)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.battleBtn_, nil, function()
		local var_8_0 = GodEaterData:GetCurHeroID()

		if var_8_0 == 0 then
			manager.notify:CallUpdateFunc(GOLDMINER_OPEN_SELECT_HERO_PANEL)
		else
			GodEaterData:SetGoldActivityId(arg_7_0.activityID_)
			arg_7_0:Back()
			JumpTools.OpenPageByJump("/goldMinerGameView", {
				subActivityID = arg_7_0.activityID_,
				heroID = var_8_0
			})
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.isActivityOpen_ = arg_9_0.params_.isActivityOpen
	arg_9_0.isUnLock_ = arg_9_0.params_.isUnLock
	arg_9_0.systemCfg_ = ActivityGodEaterGoldminerStageCfg[arg_9_0.activityID_]

	arg_9_0:RefreshData()

	if not arg_9_0.isActivityOpen_ then
		local var_9_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_9_0.activityID_).startTime)

		arg_9_0.btnLockText_.text = string.format(GetTips("GOLDMINER_ENTER_TIPS_1"), var_9_0)
	elseif not arg_9_0.isUnLock_ then
		arg_9_0.btnLockText_.text = GetTips("GOLDMINER_ENTER_TIPS_2")
	end

	arg_9_0.btnController_:SetSelectedState(tostring(not arg_9_0.isActivityOpen_ or not arg_9_0.isUnLock_))

	arg_9_0.sectionName_.text = arg_9_0.systemCfg_.name
	arg_9_0.icon1_.sprite = ItemTools.getItemSprite(75)
	arg_9_0.icon2_.sprite = ItemTools.getItemSprite(75)
	arg_9_0.icon3_.sprite = ItemTools.getItemSprite(75)

	if arg_9_0.isFirstClear_ then
		arg_9_0.hideDropPanelController_:SetSelectedState("false")

		arg_9_0.rewardList_ = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_0.systemCfg_.first_reward) do
			table.insert(arg_9_0.rewardList_, {
				id = iter_9_1[1],
				num = iter_9_1[2]
			})
		end

		arg_9_0.uiList_:StartScroll(#arg_9_0.rewardList_)
	else
		arg_9_0.hideDropPanelController_:SetSelectedState("true")
	end

	arg_9_0.threeStarDataList_ = {}

	local var_9_1 = GodEaterData:GetStageStar(arg_9_0.activityID_)

	for iter_9_2 = 1, 3 do
		arg_9_0.threeStarDataList_[iter_9_2] = {
			iter_9_2 <= var_9_1,
			arg_9_0.systemCfg_.score[iter_9_2],
			arg_9_0.systemCfg_.reward[iter_9_2][1][2]
		}
	end

	arg_9_0.sectionInfoThreeStarBar_:SetData(arg_9_0.threeStarDataList_)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnUpdate(arg_12_0)
	if arg_12_0.activityID_ == arg_12_0.params_.activityID then
		return
	end

	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.isActivityOpen_ = arg_12_0.params_.isActivityOpen
	arg_12_0.isUnLock_ = arg_12_0.params_.isUnLock
	arg_12_0.systemCfg_ = ActivityGodEaterGoldminerStageCfg[arg_12_0.activityID_]

	arg_12_0:RefreshData()

	arg_12_0.sectionName_.text = arg_12_0.systemCfg_.name

	if not arg_12_0.isActivityOpen_ then
		local var_12_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_12_0.activityID_).startTime)

		arg_12_0.btnLockText_.text = string.format(GetTips("GOLDMINER_ENTER_TIPS_1"), var_12_0)
	elseif not arg_12_0.isUnLock_ then
		arg_12_0.btnLockText_.text = GetTips("GOLDMINER_ENTER_TIPS_2")
	end

	arg_12_0.btnController_:SetSelectedState(tostring(not arg_12_0.isActivityOpen_ or not arg_12_0.isUnLock_))

	if arg_12_0.isFirstClear_ then
		arg_12_0.hideDropPanelController_:SetSelectedState("false")

		arg_12_0.rewardList_ = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.systemCfg_.first_reward) do
			table.insert(arg_12_0.rewardList_, {
				id = iter_12_1[1],
				num = iter_12_1[2]
			})
		end

		arg_12_0.uiList_:StartScroll(#arg_12_0.rewardList_)
	else
		arg_12_0.hideDropPanelController_:SetSelectedState("true")
	end

	arg_12_0.threeStarDataList_ = {}

	local var_12_1 = GodEaterData:GetStageStar(arg_12_0.activityID_)

	for iter_12_2 = 1, 3 do
		arg_12_0.threeStarDataList_[iter_12_2] = {
			iter_12_2 <= var_12_1,
			arg_12_0.systemCfg_.score[iter_12_2],
			arg_12_0.systemCfg_.reward[iter_12_2][1][2]
		}
	end

	arg_12_0.sectionInfoThreeStarBar_:SetData(arg_12_0.threeStarDataList_)
end

function var_0_0.RefreshData(arg_13_0)
	if ActivityData:GetActivityIsOpen(arg_13_0.activityID_) then
		arg_13_0.lock_ = false
	else
		arg_13_0.lock_ = true
	end

	arg_13_0.cost_ = 0

	if GodEaterData:GetStageStar(arg_13_0.activityID_) > 0 then
		arg_13_0.isFirstClear_ = false
	else
		arg_13_0.isFirstClear_ = true
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.sectionInfoThreeStarBar_:Dispose()

	arg_14_0.sectionInfoThreeStarBar_ = nil

	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
