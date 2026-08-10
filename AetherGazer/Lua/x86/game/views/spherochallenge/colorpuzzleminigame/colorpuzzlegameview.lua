local var_0_0 = class("ColorPuzzleGameView", ReduxView)
local var_0_1 = 53100

function var_0_0.GetLevelRoot(arg_1_0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/Levels/"
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleGameView"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	arg_4_0.level = nil
	arg_4_0.letMeTry, arg_4_0.totalTry = nil
	arg_4_0.gameLevel = nil
	arg_4_0.useAutoComplete = nil
	arg_4_0.time = nil
end

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:InitUI()
end

local function var_0_2()
	return nullable(GameSetting, "activity_hero_challenge_color_cost", "value", 1) or 0
end

local function var_0_3(arg_7_0)
	if var_0_2() <= ItemTools.getItemNum(var_0_1) then
		return true
	elseif arg_7_0 then
		ShowTips("ACTIVITY_HERO_CHALLENGE_COIN_LACK")
	end

	return false
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0.costItemIcon_.sprite = ItemTools.getItemLittleSprite(var_0_1)

	local var_8_0 = var_0_2()

	if not var_0_3() then
		var_8_0 = "<color=#FF0000>" .. var_8_0 .. "</color>"
	end

	arg_8_0.costAmount_.text = var_8_0
	arg_8_0.autoCompleteController = arg_8_0.controllers_:GetController("autoComplete")
	arg_8_0.completeHighlightController = arg_8_0.controllers_:GetController("complete")

	arg_8_0:AddBtnListenerScale(arg_8_0.autoCompleteBtn_, nil, function()
		if arg_8_0.gameLevel and not arg_8_0.gameLevel:CheckComplete() and arg_8_0.autoCompleteController:GetSelectedState() == "ready" and var_0_3(true) then
			arg_8_0.gameLevel:AutoComplete()

			arg_8_0.useAutoComplete = true

			arg_8_0.completeHighlightController:SetSelectedState("true")
		end
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.clearAllBtn_, nil, function()
		if arg_8_0.gameLevel then
			arg_8_0.gameLevel:ClearNodes()

			if not arg_8_0.reset then
				arg_8_0.reset = true

				arg_8_0:ReportClear()
			end
		end
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.checkCompleteBtn_, nil, function()
		if arg_8_0.gameLevel and arg_8_0.gameLevel:CheckComplete(true) then
			arg_8_0:StopTimeWatch()
			arg_8_0:EndGame()
		end
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.level = arg_12_0.params_.level

	local var_12_0 = ActivityHeroChallengeColor[arg_12_0.level]
	local var_12_1 = Asset.Load(arg_12_0:GetLevelRoot() .. var_12_0.level_asset_name)

	arg_12_0:DisposeGame()

	arg_12_0.gameLevel = Object.Instantiate(var_12_1, arg_12_0.levelContainer_):GetComponent("ColorPuzzle")

	arg_12_0.autoCompleteController:SetSelectedState("lock")

	arg_12_0.letMeTry, arg_12_0.totalTry = var_12_0.attempt, var_12_0.attempt

	arg_12_0:SetupGameCallbacks()
	arg_12_0:ResetGame()

	arg_12_0.pause = false

	arg_12_0:StartTimeWatch()
	arg_12_0:SetTips(var_12_0)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:StopTimeWatch()
	arg_13_0:DisposeGame()
end

local function var_0_4(arg_14_0)
	if not arg_14_0.pause then
		arg_14_0.pause = true

		ShowMessageBox({
			content = GetTips("ACTIVITY_HERO_COLOR_EXIT"),
			OkCallback = function()
				arg_14_0.pause = false

				arg_14_0:EndGame(true)
			end,
			CancelCallback = function()
				arg_14_0.pause = false
			end
		})
	end
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		var_0_1
	})
	manager.windowBar:RegistBackCallBack(handler(arg_17_0, var_0_4))
end

function var_0_0.OnBehind(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.DisposeGame(arg_20_0)
	if arg_20_0.gameLevel then
		Object.Destroy(arg_20_0.gameLevel.gameObject)

		arg_20_0.gameLevel = nil
	end
end

function var_0_0.SetupGameCallbacks(arg_21_0)
	arg_21_0.gameLevel:SetBeforeApplyValueCallback(function(arg_22_0, arg_22_1)
		if arg_22_0 ~= arg_22_1 then
			arg_21_0.letMeTry = arg_21_0.letMeTry - 1

			arg_21_0:UpdateAutoComplete()
		end
	end)
	arg_21_0.gameLevel:SetOnNodeClickCallback(function(arg_23_0)
		arg_21_0.completeHighlightController:SetSelectedState(arg_23_0 and "true" or "false")
	end)
end

function var_0_0.UpdateAutoComplete(arg_24_0)
	if arg_24_0.letMeTry > 0 then
		local var_24_0 = 1 - arg_24_0.letMeTry / arg_24_0.totalTry

		arg_24_0.autoCompleteProgress_.fillAmount = var_24_0

		arg_24_0.autoCompleteController:SetSelectedState("lock")
	else
		arg_24_0.autoCompleteProgress_.fillAmount = 1

		if not arg_24_0.gameLevel:CheckComplete() then
			arg_24_0.autoCompleteController:SetSelectedState("ready")
		else
			arg_24_0.autoCompleteController:SetSelectedState("lock")
		end
	end
end

function var_0_0.StartTimeWatch(arg_25_0)
	arg_25_0:StopTimeWatch()

	arg_25_0.time = 0
	arg_25_0.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(handler(arg_25_0, arg_25_0.Update), -1, true)
end

function var_0_0.StopTimeWatch(arg_26_0)
	if arg_26_0.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(arg_26_0.updateTicker)

		arg_26_0.updateTicker = nil
	end
end

function var_0_0.Update(arg_27_0)
	local var_27_0 = arg_27_0.pause and 0 or Time.unscaledDeltaTime

	arg_27_0.time = (arg_27_0.time or 0) + var_27_0
end

function var_0_0.EndGame(arg_28_0, arg_28_1)
	local var_28_0 = {
		stage_id = arg_28_0.level,
		result = arg_28_1 and 3 or 1,
		useseconds = arg_28_0.time,
		auto_completed = arg_28_0.useAutoComplete and 1 or 0
	}
	local var_28_1

	arg_28_0:ResetGame()

	if not arg_28_1 then
		local function var_28_2(arg_29_0, arg_29_1)
			JumpTools.OpenPageByJump("colorPuzzleResultPopup", {
				level = arg_29_0.stage_id,
				time = arg_29_0.useseconds,
				autoComplete = arg_29_0.auto_completed == 1,
				rewards = arg_29_1.reward_list,
				okCallback = JumpTools.Back
			})
		end

		ColorPuzzleAction.LevelClearAction(var_28_0, var_28_2)
	else
		JumpTools.Back()
	end

	arg_28_0:SendSdkMsg(var_28_0)
end

function var_0_0.ResetGame(arg_30_0)
	arg_30_0.time = 0
	arg_30_0.useAutoComplete = false

	arg_30_0.gameLevel:ClearNodes()
	arg_30_0:UpdateAutoComplete()
	arg_30_0.completeHighlightController:SetSelectedState("false")
end

function var_0_0.ReportClear(arg_31_0)
	local var_31_0 = {
		auto_completed = 0,
		result = 4,
		stage_id = arg_31_0.level,
		useseconds = arg_31_0.time
	}

	arg_31_0:SendSdkMsg(var_31_0)
end

function var_0_0.SendSdkMsg(arg_32_0, arg_32_1)
	local var_32_0 = SPHeroChallengeData:GetActivityID()
	local var_32_1 = SPHeroChallengeData.activityCfg[var_32_0].colorPuzzleActiVityTemplate
	local var_32_2 = ActivityTools.GetAllSubActivityByTemplate(var_32_0, var_32_1)[1]

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_32_2,
		stage_id = arg_32_1.stage_id,
		result = arg_32_1.result,
		use_seconds = arg_32_1.useseconds,
		is_help = arg_32_0.useAutoComplete or false
	})
end

function var_0_0.SetTips(arg_33_0, arg_33_1)
	local var_33_0 = nullable(arg_33_1, "tips_icon")

	if var_33_0 == "" then
		SetActive(arg_33_0.tipsIcon_, false)
	else
		SetActive(arg_33_0.tipsIcon_, true)

		arg_33_0.tipsIcon_.sprite = pureGetSpriteWithoutAtlas(var_33_0)
	end

	arg_33_0.tipsContent_.text = GetI18NText(arg_33_1.tips)
end

return var_0_0
