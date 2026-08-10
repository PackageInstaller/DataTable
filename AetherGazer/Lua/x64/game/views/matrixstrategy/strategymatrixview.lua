local var_0_0 = class("StrategyMatrixView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/VolumeIIIDownUI/OceanusRoguelike/StrategyMatrixMapUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
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
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_12_0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_12_0.matrix_activity_id)
	manager.windowBar:RegistBackCallBack(function()
		if arg_12_0.map then
			arg_12_0.map:GoBack()
		else
			arg_12_0:Back()
		end
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.matrix_activity_id = arg_14_0.params_.matrix_activity_id
	arg_14_0.mapId = StrategyMatrixData:GetMapId(arg_14_0.matrix_activity_id)

	if arg_14_0.map and arg_14_0.mapId ~= arg_14_0.map:GetMapId() then
		arg_14_0.map:Dispose()

		arg_14_0.map = nil
	end

	arg_14_0.map = arg_14_0.map or StrategyMatrixMap.New(arg_14_0.mapId, arg_14_0.m_content)

	arg_14_0.map:SetData(arg_14_0.matrix_activity_id)

	if arg_14_0.params_.playerAnim then
		arg_14_0.m_animator:Play("StrategyMatrixMapUI", 0, 0)

		arg_14_0.params_.playerAnim = nil

		arg_14_0.map:PlayerAnim(true)
	else
		arg_14_0.m_animator:Play("StrategyMatrixMapUI", 0, 9999999)
		arg_14_0.map:PlayerAnim(false)
	end

	arg_14_0:RefrenTime()

	arg_14_0.timer = Timer.New(function()
		arg_14_0:RefrenTime()
	end, 1, -1)

	arg_14_0.timer:Start()
	StrategyMatrixAction.SetStrategyRead(arg_14_0.matrix_activity_id)
	manager.redPoint:bindUIandKey(arg_14_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, arg_14_0.matrix_activity_id))

	local var_14_0 = {
		"VolumeDown_bg_00418",
		"VolumeDown_bg_00419",
		"VolumeDown_bg_00420",
		"VolumeDown_bg_00421"
	}
	local var_14_1 = StrategyMatrixData:GetTierID(arg_14_0.matrix_activity_id)

	if var_14_1 and StrategyMatrixTierTemplateCfg[var_14_1] then
		local var_14_2 = StrategyMatrixTierTemplateCfg[var_14_1]

		arg_14_0.m_title.text = GetTips("ACTIVITY_STRATEGY_TITLE_" .. var_14_2.tier)
		arg_14_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. var_14_0[var_14_2.tier])
	else
		arg_14_0.m_title.text = ""
	end
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.map then
		arg_16_0.map:Exit()
	end

	if arg_16_0.timer then
		arg_16_0.timer:Stop()

		arg_16_0.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_16_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, arg_16_0.matrix_activity_id))
end

function var_0_0.RefrenTime(arg_17_0)
	local var_17_0 = ActivityData:GetActivityData(arg_17_0.matrix_activity_id)

	if var_17_0 and var_17_0:IsActivitying() then
		arg_17_0.m_timeLab.text = manager.time:GetLostTimeStr(var_17_0.stopTime)
	else
		arg_17_0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.map then
		arg_18_0.map:Dispose()
	end

	arg_18_0.map = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
