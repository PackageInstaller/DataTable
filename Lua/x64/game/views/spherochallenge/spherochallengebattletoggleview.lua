local var_0_0 = class("SPHeroChallengeBattleToggleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBattleToggleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uitreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect))
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	local var_5_0 = SPHeroChallengeData:GetActivityID()

	arg_5_0.viewList = {
		SPHeroChallengeStoryView.New(arg_5_0.panelTrs_, var_5_0),
		SPHeroChallengeTrainView.New(arg_5_0.panelTrs_, var_5_0),
		(SPHeroChallengeBossView.New(arg_5_0.panelTrs_, var_5_0))
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.viewList) do
		iter_5_1:Show(false)
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RegisterEvents()

	arg_6_0.activityID = SPHeroChallengeData:GetActivityID()

	local var_6_0 = SPHeroChallengeData.activityCfg[arg_6_0.activityID]

	if var_6_0 then
		arg_6_0.chapterIDList = {
			var_6_0.storyChapter,
			var_6_0.trainChapter,
			var_6_0.bossChapter
		}
	end

	if arg_6_0.params_.stageID then
		local var_6_1 = BattleVerthandiExclusiveCfg[arg_6_0.params_.stageID].sub_type

		if var_6_1 == SpHeroChallengeConst.BattleSubType.story then
			arg_6_0.groupIndex = 1
		elseif var_6_1 == SpHeroChallengeConst.BattleSubType.boss then
			arg_6_0.groupIndex = 3
		else
			arg_6_0.groupIndex = 2

			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = var_6_1
			})

			return
		end
	end

	arg_6_0.groupIndex = arg_6_0.params_.groupIndex or arg_6_0.groupIndex or 1

	if not SPHeroChallengeTools:GetChapterIsOpen(arg_6_0.chapterIDList[arg_6_0.groupIndex]) then
		arg_6_0.groupIndex = 1
	end

	arg_6_0.tree_:SelectGroup(arg_6_0.groupIndex)

	if arg_6_0:IsOpenSectionView() then
		SetActive(arg_6_0.backBtn_.gameObject, true)
		SetActive(arg_6_0.uitreeGo_, false)
	else
		SetActive(arg_6_0.backBtn_.gameObject, false)
		SetActive(arg_6_0.uitreeGo_, true)
	end

	arg_6_0:RefreshLockState()
end

function var_0_0.RegisterEvents(arg_7_0)
	arg_7_0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function()
		arg_7_0:RefreshLockState()
	end)
end

function var_0_0.OnTop(arg_9_0)
	if arg_9_0.curView then
		arg_9_0.curView:OnTop()
	end
end

function var_0_0.RefreshLockState(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.chapterIDList) do
		local var_10_0 = arg_10_0.tree_:GetGroupGameObjectById(iter_10_0)

		if var_10_0 then
			local var_10_1 = ControllerUtil.GetController(var_10_0.transform, "lock")

			if SPHeroChallengeTools:GetChapterIsOpen(iter_10_1) then
				var_10_1:SetSelectedState("false")
			else
				var_10_1:SetSelectedState("true")
			end
		end
	end
end

function var_0_0.OnUpdate(arg_11_0)
	if arg_11_0.curView then
		arg_11_0.curView:SetParams(arg_11_0.params_)
		arg_11_0.curView:OnUpdate()
		arg_11_0:RefreshWinBar()
	end

	if arg_11_0:IsOpenSectionView() then
		SetActive(arg_11_0.backBtn_.gameObject, true)
		SetActive(arg_11_0.uitreeGo_, false)
	else
		SetActive(arg_11_0.backBtn_.gameObject, false)
		SetActive(arg_11_0.uitreeGo_, true)
	end
end

function var_0_0.OnBehind(arg_12_0)
	if arg_12_0.curView then
		arg_12_0.curView:OnBehind()
	end

	arg_12_0:RefreshBackBtnState()
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.curView then
		arg_13_0.curView:OnExit()
		arg_13_0.curView:Show(false)
	end

	arg_13_0.oldIndex = nil
	arg_13_0.params_.groupIndex = nil

	manager.windowBar:HideBar()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.backBtn_, nil, function()
		if arg_14_0:IsOpenSectionView() then
			arg_14_0:Back()
			arg_14_0:RefreshBackBtnState()
		end
	end)
end

function var_0_0.IsOpenSectionView(arg_16_0)
	return arg_16_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.RefreshBackBtnState(arg_17_0)
	if arg_17_0.groupIndex == SpHeroChallengeConst.BattleSubType.story then
		return
	end

	if arg_17_0:IsOpenSectionView() then
		SetActive(arg_17_0.backBtn_.gameObject, true)
	else
		SetActive(arg_17_0.backBtn_.gameObject, false)
	end
end

function var_0_0.RefreshWinBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HERO_CHALLENGE_HERO_HELP")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/spHeroChallengeMainView")
	end)
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.viewList then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.viewList) do
			iter_20_1:Dispose()
		end
	end

	if arg_20_0.tree_ then
		arg_20_0.tree_:Dispose()
	end

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnGroupSelect(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_0.oldIndex and arg_21_0.oldIndex == arg_21_1 then
		return
	end

	local var_21_0 = arg_21_0.chapterIDList[arg_21_1]
	local var_21_1, var_21_2 = SPHeroChallengeTools:GetChapterIsOpen(var_21_0)

	if not var_21_1 then
		-- block empty
	end

	arg_21_0.groupIndex = arg_21_1
	arg_21_0.oldIndex = arg_21_0.groupIndex

	arg_21_0:SwitchPage(var_21_1, var_21_2)
end

function var_0_0.IsOpenSectionInfo(arg_22_0)
	return arg_22_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.SwitchPage(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0:IsOpenSectionInfo() then
		arg_23_0:Back()
	end

	if arg_23_0.curView then
		arg_23_0.curView:OnExit()
		arg_23_0.curView:Show(false)
	end

	arg_23_0.curView = arg_23_0.viewList[arg_23_0.groupIndex]

	if arg_23_0.curView then
		arg_23_0.curView:Show(true)

		arg_23_0.params_.showFlag = arg_23_1
		arg_23_0.params_.reason = arg_23_2

		arg_23_0.curView:SetParams(arg_23_0.params_)
		arg_23_0.curView:OnEnter()
		arg_23_0.curView:OnTop()
		arg_23_0:RefreshWinBar()
	end
end

return var_0_0
