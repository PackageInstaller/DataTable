local var_0_0 = class("StrategyMatrixThorView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/EmptyDream/ThorRoguelike/ThorRoguelikeMapUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.showDropDownConrtoller = ControllerUtil.GetController(arg_4_0.m_dropDownBtn.transform, "showDropDown")
	arg_4_0.difficultyController = ControllerUtil.GetController(arg_4_0.m_dropDownBtn.transform, "difficulty")
	arg_4_0.hardLockController = ControllerUtil.GetController(arg_4_0.m_levelBtn2.transform, "lock")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.map = nil
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				StrategyMatrixAction.QueryMatrixGiveUp(arg_6_0.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_infoBtn, nil, function()
		local var_10_0 = StrategyMatrixData:GetMatrixHeroTeam(arg_6_0.matrix_activity_id)

		JumpTools.OpenPageByJump("/strategyMatrixHero_new", {
			isEnter = true,
			matrix_activity_id = arg_6_0.matrix_activity_id,
			type = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX,
			tempHeroList = var_10_0,
			hid = var_10_0[1]
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("strategyMatrixRward", {
			matrix_activity_id = arg_6_0.matrix_activity_id
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_dropDownBtn, nil, function()
		if arg_6_0.showDropDownConrtoller:GetSelectedState() == "hide" then
			arg_6_0.showDropDownConrtoller:SetSelectedState("show")
		else
			arg_6_0.showDropDownConrtoller:SetSelectedState("hide")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_levelBtn1, nil, function()
		arg_6_0.showDropDownConrtoller:SetSelectedState("hide")
		arg_6_0:OnDropDownClick(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_levelBtn2, nil, function()
		arg_6_0.showDropDownConrtoller:SetSelectedState("hide")

		if ActivityTools.GetActivityIsOpenWithTip(ActivityConst.STRATEGY_MATRIX_THOR_HARD) then
			if StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
				arg_6_0:OnDropDownClick(2)
			else
				ShowTips("THOR_STRATEGY_UNLOCK")
			end
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_mask, nil, function()
		arg_6_0.showDropDownConrtoller:SetSelectedState("hide")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_storyBtn, nil, function()
		JumpTools.OpenPageByJump("/strategyMatrixThorStoryReview")
	end)
end

function var_0_0.InitBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_17_0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_17_0.matrix_activity_id)
	manager.windowBar:RegistBackCallBack(function()
		arg_17_0:Back()
	end)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:Refresh()

	local var_19_0 = arg_19_0.params_.matrix_activity_id

	arg_19_0.timer = Timer.New(function()
		arg_19_0:RefrenTime()
	end, 1, -1)

	arg_19_0.timer:Start()
end

function var_0_0.OnUpdate(arg_21_0)
	arg_21_0:Refresh()
	arg_21_0:InitBar()
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:InitBar()

	if arg_22_0.map then
		arg_22_0.map:OnTop()
	end
end

function var_0_0.Refresh(arg_23_0)
	if arg_23_0.matrix_activity_id == arg_23_0.params_.matrix_activity_id then
		return
	end

	arg_23_0.showDropDownConrtoller:SetSelectedState("hide")

	arg_23_0.matrix_activity_id = arg_23_0.params_.matrix_activity_id
	arg_23_0.mapId = StrategyMatrixData:GetMapId(arg_23_0.matrix_activity_id)

	if arg_23_0.map and arg_23_0.mapId ~= arg_23_0.map:GetMapId() then
		arg_23_0.map:Dispose()

		arg_23_0.map = nil
	end

	arg_23_0.map = arg_23_0.map or StrategyMatrixMap.New(arg_23_0.mapId, arg_23_0.m_content)

	arg_23_0.map:SetData(arg_23_0.matrix_activity_id)

	if arg_23_0.params_.playerAnim then
		arg_23_0.m_animator:Play("StrategyMatrixMapUI", 0, 0)

		arg_23_0.params_.playerAnim = nil

		arg_23_0.map:PlayerAnim(true)
	else
		arg_23_0.m_animator:Play("StrategyMatrixMapUI", 0, 9999999)
		arg_23_0.map:PlayerAnim(false)
	end

	arg_23_0:RefrenTime()
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR)
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR_HARD)
	manager.redPoint:bindUIandKey(arg_23_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, arg_23_0.matrix_activity_id))

	local var_23_0 = ActivityConst.STRATEGY_MATRIX_THOR_HARD == arg_23_0.matrix_activity_id
	local var_23_1 = StrategyMatrixData:GetTierID(arg_23_0.matrix_activity_id)

	if var_23_1 and StrategyMatrixTierTemplateCfg[var_23_1] then
		local var_23_2 = StrategyMatrixTierTemplateCfg[var_23_1]

		arg_23_0.m_title.text = GetTips("THOR_STRATEGY_TITLE_" .. var_23_2.tier)

		local var_23_3 = {
			"EDream_bg_0137",
			"EDream_bg_0138",
			"EDream_bg_0139",
			"EDream_bg_0140"
		}
		local var_23_4 = {
			"EDream_bg_0147",
			"EDream_bg_0148",
			"EDream_bg_0149",
			"EDream_bg_0150"
		}

		if var_23_0 then
			arg_23_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/" .. var_23_4[var_23_2.tier])
		else
			arg_23_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/" .. var_23_3[var_23_2.tier])
		end
	else
		arg_23_0.m_title.text = ""
	end

	local var_23_5 = var_23_0 and GetTips("HARDLEVEL_HARD") or GetTips("HARDLEVEL_EASY")

	arg_23_0.m_difficultyLab.text = var_23_5

	arg_23_0.difficultyController:SetSelectedIndex(var_23_0 and 1 or 0)
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()

	if arg_24_0.map then
		arg_24_0.map:Exit()
	end

	if arg_24_0.timer then
		arg_24_0.timer:Stop()

		arg_24_0.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_24_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, arg_24_0.matrix_activity_id))

	arg_24_0.matrix_activity_id = nil
end

function var_0_0.RefrenTime(arg_25_0)
	local var_25_0 = ActivityData:GetActivityData(arg_25_0.matrix_activity_id)

	if var_25_0 and var_25_0:IsActivitying() then
		arg_25_0.m_timeLab.text = manager.time:GetLostTimeStr(var_25_0.stopTime)
	else
		arg_25_0.m_timeLab.text = GetTips("TIME_OVER")
	end

	if ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) and StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
		arg_25_0.hardLockController:SetSelectedIndex(0)
	else
		arg_25_0.hardLockController:SetSelectedIndex(1)
	end
end

function var_0_0.OnDropDownClick(arg_26_0, arg_26_1)
	StrategyMatrixData:SetDifficultySelect(arg_26_1)

	local var_26_0

	if arg_26_1 == 2 and ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) then
		var_26_0 = ActivityConst.STRATEGY_MATRIX_THOR_HARD
	else
		var_26_0 = ActivityConst.STRATEGY_MATRIX_THOR
	end

	StrategyMatrixAction.GotoStrategyMatrix(var_26_0, true)
end

function var_0_0.Dispose(arg_27_0)
	if arg_27_0.map then
		arg_27_0.map:Dispose()
	end

	arg_27_0.map = nil

	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0
