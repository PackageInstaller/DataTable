local var_0_0 = class("SnowballGameSelectLevelUI", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameSelectLevelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = {
	hard = 2,
	inf = 3,
	normal = 1
}
local var_0_2 = -1

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AdaptScreen()
	arg_3_0:InitLevels()

	arg_3_0.readyController = ControllerUtil.GetController(arg_3_0.transform_, "levelSelected")
	arg_3_0.hardLevelLockedController = ControllerUtil.GetController(arg_3_0.transform_, "hardLevelLocked")
	arg_3_0.modeController = ControllerUtil.GetController(arg_3_0.transform_, "mode")
	arg_3_0.hardLevelBonusController = ControllerUtil.GetController(arg_3_0.transform_, "bonus")
	arg_3_0.showLevelCostController = ControllerUtil.GetController(arg_3_0.transform_, "cost")
	arg_3_0.lastSelect = {}

	arg_3_0:AddBtnListener(arg_3_0.normalBtn_, nil, function()
		if arg_3_0.select == var_0_2 then
			return
		end

		if arg_3_0.mode ~= var_0_1.normal then
			arg_3_0.modeChangeAnimator_:Play("normal")
		end

		arg_3_0.mode = var_0_1.normal
		arg_3_0.select = nullable(arg_3_0.lastSelect, var_0_1.normal) or 1

		arg_3_0:RefreshLevelsUI()
	end)
	arg_3_0:AddBtnListener(arg_3_0.hardBtn_, nil, function()
		if arg_3_0.select == var_0_2 then
			return
		end

		if not arg_3_0:CheckAnyHardLevelUnlocked() then
			ShowTips("ACTIVITY_SNOWBALL_LEVEL_MODE_TIPS")

			return
		end

		if arg_3_0.mode ~= var_0_1.hard then
			arg_3_0.modeChangeAnimator_:Play("hard")
		end

		arg_3_0.mode = var_0_1.hard
		arg_3_0.select = nullable(arg_3_0.lastSelect, var_0_1.hard) or 1

		arg_3_0:RefreshLevelsUI()
	end)
	arg_3_0:AddBtnListener(arg_3_0.startBtn_, nil, handler(arg_3_0, arg_3_0.GoToGame))
	arg_3_0:AddBtnListener(arg_3_0.iceBtn_, nil, function()
		JumpTools.OpenPageByJump("/SnowBallInfinityMainView", {
			activityID = SnowballGameData.activityID
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.changePlayerBtn_, nil, function()
		JumpTools.OpenPageByJump("/snowballGameChangePlayer")
	end)
	arg_3_0:AddBtnListener(arg_3_0.questBtn_, nil, function()
		JumpTools.OpenPopUp("snowballQuestPopup")
	end)
end

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	arg_9_0:BindCfgUI(arg_9_1, var_9_0)

	var_9_0.idx = arg_9_2
	var_9_0.difficultyController = ControllerUtil.GetController(arg_9_1.transform, "difficulty")
	var_9_0.modeController = ControllerUtil.GetController(arg_9_1.transform, "mode")
	var_9_0.selectController = ControllerUtil.GetController(arg_9_1.transform, "select")

	arg_9_0:AddBtnListener(var_9_0.btn_, nil, function()
		if var_0_0.CheckLevel(arg_9_0:GetLevel(arg_9_2), false, true) then
			arg_9_0.select = arg_9_2

			if arg_9_2 == var_0_2 then
				arg_9_0.lastSelect[var_0_1.inf] = arg_9_2
			else
				arg_9_0.lastSelect[arg_9_0.mode] = arg_9_2
			end

			arg_9_0:RefreshLevelsUI()
		end
	end)

	return var_9_0
end

function var_0_0.InitLevels(arg_11_0)
	arg_11_0.levels = {}

	for iter_11_0 = 1, arg_11_0.levelsRoot_.childCount do
		local var_11_0 = arg_11_0.levelsRoot_:GetChild(iter_11_0 - 1)
		local var_11_1 = GameObject.Instantiate(arg_11_0.levelPrefab_, var_11_0)
		local var_11_2 = var_0_3(arg_11_0, var_11_1, iter_11_0)

		arg_11_0.levels[iter_11_0] = var_11_2
	end

	local var_11_3 = var_0_3(arg_11_0, arg_11_0.infLevelBtn_.gameObject, var_0_2)

	var_11_3.lockByTime = ControllerUtil.GetController(arg_11_0.infLevelBtn_.transform, "lockByTime")
	arg_11_0.levels[var_0_2] = var_11_3
end

function var_0_0.StartTimer(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0:RefreshTimeText()

	if manager.time:GetServerTime() > arg_12_0.infLevelStop then
		return
	end

	local var_12_0 = manager.time:GetServerTime() < arg_12_0.infLevelStart

	arg_12_0.timer = Timer.New(function()
		local var_13_0 = manager.time:GetServerTime()

		if var_13_0 > arg_12_0.infLevelStop then
			arg_12_0:RefreshLevelsUI()
		elseif var_12_0 and var_13_0 >= arg_12_0.infLevelStart then
			var_12_0 = false

			arg_12_0:RefreshLevelsUI()
		end

		arg_12_0:RefreshTimeText()
	end, 1, -1)

	arg_12_0.timer:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end
end

function var_0_0.RefreshTimeText(arg_15_0)
	local var_15_0 = arg_15_0.levels[var_0_2]
	local var_15_1 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL)

	var_15_0.lockByTime:SetSelectedState(var_15_1 and "false" or "true")

	arg_15_0.activityCountdown_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(SnowballGameData.activityID).stopTime, nil, true)

	if not var_15_1 and arg_15_0.infLevelCountdown_ then
		local var_15_2 = manager.time:GetLostTimeStr2(arg_15_0.infLevelStart)

		arg_15_0.infLevelCountdown_.text = var_15_2
	end
end

function var_0_0.OnEnter(arg_16_0)
	local var_16_0 = ActivityConst.ACTIVITY_SNOWBALL_INF_LEVEL
	local var_16_1 = ActivityData:GetActivityData(var_16_0)

	arg_16_0.infLevelStart = var_16_1.startTime
	arg_16_0.infLevelStop = var_16_1.stopTime
	arg_16_0.mode = arg_16_0.mode or var_0_1.normal

	local var_16_2 = arg_16_0.select or 1

	if var_0_0.CheckLevel(arg_16_0:GetLevel(var_16_2), false, false) then
		arg_16_0.select = var_16_2
	else
		arg_16_0.select = nil
	end

	arg_16_0:RefreshLevelsUI()
	arg_16_0:StartTimer()
	arg_16_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_16_0, arg_16_0.OnActivityUpdate))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL, 0)
	manager.redPoint:bindUIandKey(arg_16_0.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:bindUIandKey(arg_16_0.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
	arg_17_0:RemoveAllEventListener()
	arg_17_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_17_0.iceBtn_.transform, SnowballGameData:GetInfPoolRedPointKey(1))
	manager.redPoint:unbindUIandKey(arg_17_0.questBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE)
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC")
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		local var_19_0 = SnowballGameData.activityID

		ActivityTools.JumpBackToActivityMainViewByActivityID(var_19_0)
	end)
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.GetLevel(arg_21_0, arg_21_1)
	if arg_21_1 == var_0_2 then
		return nullable(SnowballGameCfg.get_id_list_by_level_mode, var_0_1.inf, 1)
	end

	local var_21_0 = SnowballGameCfg.get_id_list_by_level_mode[arg_21_0.mode]

	return nullable(var_21_0, arg_21_1)
end

function var_0_0.LevelLocked(arg_22_0, arg_22_1)
	return not SnowballGameData:IsLevelUnlocked(arg_22_1)
end

function var_0_0.LevelComplted(arg_23_0, arg_23_1)
	return SnowballGameData:GetLevelHighScore(arg_23_1)
end

function var_0_0.OnActivityUpdate(arg_24_0, arg_24_1)
	if ActivityTools.GetActivityType(arg_24_1) == ActivityTemplateConst.MINIGAME_STAGE then
		arg_24_0:RefreshLevelsUI()
	end
end

function var_0_0.RefreshLevelsUI(arg_25_0)
	local var_25_0 = arg_25_0:GetLevel(arg_25_0.select)

	arg_25_0.hardLevelLockedController:SetSelectedState(arg_25_0:CheckAnyHardLevelUnlocked() and "false" or "true")

	if arg_25_0.select ~= var_0_2 then
		arg_25_0.modeController:SetSelectedState(arg_25_0.mode == var_0_1.normal and "normal" or "hard")
	else
		arg_25_0.modeController:SetSelectedState("lock")
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.levels) do
		if iter_25_1.difficultyController then
			iter_25_1.difficultyController:SetSelectedState(arg_25_0.mode == var_0_1.normal and "normal" or "hard")
		end

		iter_25_1.selectController:SetSelectedState(arg_25_0.select == iter_25_0 and "true" or "false")

		local var_25_1 = arg_25_0:GetLevel(iter_25_0)
		local var_25_2 = arg_25_0:LevelComplted(var_25_1)

		if var_25_1 == nil or arg_25_0:LevelLocked(var_25_1) then
			iter_25_1.modeController:SetSelectedState("lock")
		elseif var_25_2 then
			iter_25_1.modeController:SetSelectedState("completed")

			iter_25_1.score_.text = var_25_2
		else
			iter_25_1.modeController:SetSelectedState("unlock")

			if SnowballGameData:IsLevelFirstUnlocked(var_25_1) then
				DormUtils.CallOnNextUpdate(function()
					iter_25_1.unlockAnimator_:Play("unlock")
				end)
				SnowballGameData:CacheLevelAlreadyUnlocked(var_25_1)
			end
		end

		iter_25_1.name_.text = SnowballGameCfg[var_25_1].level_name
	end

	arg_25_0.readyController:SetSelectedState(var_25_0 == nil and "false" or "true")

	if var_25_0 then
		local var_25_3 = SnowballGameCfg[var_25_0]
		local var_25_4 = var_25_3.level_cost[1]
		local var_25_5 = var_25_3.level_mode

		if var_25_4 == nil then
			arg_25_0.showLevelCostController:SetSelectedState("hide")
		else
			arg_25_0.showLevelCostController:SetSelectedState("show")

			arg_25_0.consumeIcon_.sprite = ItemTools.getItemLittleSprite(var_25_4[1])
			arg_25_0.consumeText_.text = "x" .. var_25_4[2]
		end

		local var_25_6 = GameSetting.activity_snowball_score_difficulty_factor.value[var_25_5] or 1

		arg_25_0.hardLevelBonusController:SetSelectedState(var_25_6 ~= 1 and "on" or "off")

		arg_25_0.bonus_.text = "x" .. var_25_6
	end
end

function var_0_0.CheckLevel(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1, var_27_2 = SnowballGameData:IsLevelUnlocked(arg_27_0, arg_27_2)

	if var_27_0 then
		if not arg_27_1 or SnowballGameData:CheckLevelCost(arg_27_0) then
			return true
		elseif arg_27_2 then
			local var_27_3 = ItemTools.getItemName(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN)

			manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_COST_FAILED", var_27_3))
		end
	elseif arg_27_2 and var_27_1 == SnowballGameData.LevelLockReason.NEED_UNLOCK_OTHER_LEVEL then
		local var_27_4 = SnowballGameCfg[var_27_2].level_desc

		manager.tips:ShowTips(GetTipsF("ACTIVITY_SNOWBALL_LEVEL_LOCKED", var_27_4))
	end

	return false
end

function var_0_0.CheckAnyHardLevelUnlocked(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(SnowballGameCfg.get_id_list_by_level_mode[var_0_1.hard]) do
		if var_0_0.CheckLevel(iter_28_1) then
			return true
		end
	end

	return false
end

function var_0_0.GoToGame(arg_29_0)
	local var_29_0 = arg_29_0:GetLevel(arg_29_0.select)

	if var_0_0.CheckLevel(var_29_0, true, true) then
		JumpTools.OpenPageByJump("/snowballGameEnterUI", {
			level = var_29_0
		})
	end
end

return var_0_0
