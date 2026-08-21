local var_0_0 = class("ActivitySummerSwimsuitPreheatGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.stateController_ = arg_3_0.conEx_:GetController("state")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:CreateControllerItem()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:InitBar()

	arg_6_0.cfgId_ = arg_6_0.params_.cfgId
	arg_6_0.cfg_ = ActivitySummerSwimsuitPreheatCfg[arg_6_0.cfgId_]

	arg_6_0.panelAni_:Play("New State", -1, 0)
	arg_6_0.panelAni_:Update(0)
	arg_6_0.shutterAni_:Play("shutter", -1, 0)
	arg_6_0.shutterAni_:Update(0)
	arg_6_0.stateController_:SetSelectedState("play")
	arg_6_0:RefreshUI()
	arg_6_0:StartGame()
end

function var_0_0.InitBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_7_0 = "activity_summer_swimsuit_preheat_info_describe"

	if GameSetting[var_7_0] then
		local var_7_1 = GameSetting[var_7_0].value

		if #var_7_1 > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					isPrefab = true,
					pages = var_7_1
				}
			})
		end

		if getData("ActivitySummerSwimsuitPreheatGame", "visit_tutorial") ~= 1 then
			JumpTools.OpenPageByJump("/gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_7_1
			})
			saveData("ActivitySummerSwimsuitPreheatGame", "visit_tutorial", 1)
		end
	end
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:StopGame()
	AnimatorTools.Stop()
end

function var_0_0.RefreshUI(arg_9_0)
	return
end

function var_0_0.StartTimer(arg_10_0)
	arg_10_0:StopTimer()

	if arg_10_0.updateTimer_ == nil then
		arg_10_0.updateTimer_ = Timer.New(function()
			arg_10_0:UpdateGameState()
		end, 0.11, -1)

		arg_10_0.updateTimer_:Start()
	end

	if arg_10_0.audioTimer_ == nil then
		arg_10_0.audioTimer_ = FrameTimer.New(function()
			arg_10_0:AudioTick()
		end, 1, -1)

		arg_10_0.audioTimer_:Start()
	end

	arg_10_0:StopControllerTipsTimer()

	local var_10_0 = GameSetting.summer_preheat_foolproof_time.value[1]

	arg_10_0.canShowControllerTips_ = false
	arg_10_0.controllerTipsTimer_ = Timer.New(function()
		arg_10_0.canShowControllerTips_ = true
	end, var_10_0, 1)

	arg_10_0.controllerTipsTimer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.updateTimer_ then
		arg_14_0.updateTimer_:Stop()

		arg_14_0.updateTimer_ = nil
	end

	if arg_14_0.audioTimer_ then
		arg_14_0.audioTimer_:Stop()

		arg_14_0.audioTimer_ = nil
	end

	arg_14_0:StopControllerTipsTimer()
end

function var_0_0.StopControllerTipsTimer(arg_15_0)
	if arg_15_0.controllerTipsTimer_ then
		arg_15_0.controllerTipsTimer_:Stop()

		arg_15_0.controllerTipsTimer_ = nil
	end
end

local var_0_1 = require("cjson")

function var_0_0.UpdateGameState(arg_16_0)
	local var_16_0 = FloGameLuaBridge.GetGameData()
	local var_16_1 = var_0_1.decode(var_16_0)

	AudioManager.Instance:SetAisacControlOfCategory("music", "phase_controller", var_16_1.percent)

	local var_16_2 = var_16_1.value1
	local var_16_3 = var_16_1.value2

	arg_16_0.tickAudioPlayRate_ = 0.005 / math.max(math.abs(var_16_2 - arg_16_0.lastValue1_), math.abs(var_16_3 - arg_16_0.lastValue2_))
	arg_16_0.lastValue1_ = var_16_2
	arg_16_0.lastValue2_ = var_16_3

	arg_16_0:UpdateControllerItem(var_16_1)

	if var_16_1.isWin then
		arg_16_0:WinGame()
	end
end

function var_0_0.AudioTick(arg_17_0)
	if not arg_17_0.tickAudioPlayRate_ then
		return
	end

	local var_17_0 = Time.time

	if arg_17_0.tickAudioPlayRate_ < var_17_0 - arg_17_0.lastAudioPlayTime_ then
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_preheat_gear", "")

		arg_17_0.lastAudioPlayTime_ = var_17_0
	end
end

function var_0_0.StartGame(arg_18_0)
	arg_18_0:InitControllerItem()

	local var_18_0 = {
		gameType = arg_18_0.cfg_.type,
		winBlur = arg_18_0.cfg_.settings,
		winDistance = arg_18_0.cfg_.settings
	}
	local var_18_1 = var_0_1.encode(var_18_0)

	FloGameLuaBridge.SetGameData(var_18_1)
	FloGameLuaBridge.StartGame()
	arg_18_0:StartTimer()

	arg_18_0.lastValue1_ = 1
	arg_18_0.lastValue2_ = 1
	arg_18_0.lastAudioPlayTime_ = 0
	arg_18_0.tickAudioPlayRate_ = nil

	for iter_18_0 = 1, 4 do
		local var_18_2 = arg_18_0["playImg_" .. iter_18_0]

		if var_18_2 then
			var_18_2.sprite = ActivitySummerSwimsuitPreheatTools.GetCfgStageImage(arg_18_0.cfg_)
		end
	end
end

function var_0_0.StopGame(arg_19_0)
	FloGameLuaBridge.StopGame()
	arg_19_0:StopTimer()
end

function var_0_0.WinGame(arg_20_0)
	arg_20_0:StopTimer()
	arg_20_0:StopGame()

	local var_20_0 = ActivitySummerSwimsuitPreheatTools.GetCfgMainActivityId(arg_20_0.cfg_)

	ActivitySummerSwimsuitPreheatAction.SendStageClear(var_20_0, arg_20_0.cfg_.id, function()
		ActivitySummerSwimsuitPreheatAction.UpdateRedPoint(var_20_0)
		arg_20_0:GotoResult()
	end)
end

function var_0_0.GotoResult(arg_22_0)
	if arg_22_0.isAniPlaying_ then
		return
	end

	arg_22_0:PlayEffects(function()
		arg_22_0:Back()
		JumpTools.GoToSystem("activitySummerSwimsuitPreheatStage", {
			isWin = true,
			cfgId = arg_22_0.cfgId_
		})
	end)
end

function var_0_0.PlayEffects(arg_24_0, arg_24_1)
	arg_24_0.isAniPlaying_ = true

	arg_24_0.stateController_:SetSelectedState("win")
	arg_24_0.signAni_:Play("SummerUI_3_3_PreheatGameUI_Dec", -1, 0)
	arg_24_0.signAni_:Update(0)
	arg_24_0.panelAni_:Play("shutter_02", -1, 0)
	arg_24_0.panelAni_:Update(0)
	manager.windowBar:HideBar()
	AnimatorTools.PlayAnimationWithCallback(arg_24_0.panelAni_, "shutter_02", function()
		arg_24_0.isAniPlaying_ = false

		arg_24_0:InitBar()
		arg_24_1()
	end)
end

function var_0_0.CreateControllerItem(arg_26_0)
	arg_26_0.controllerItemList_ = {}

	local var_26_0 = arg_26_0.controllerItemPanelTrans_.childCount

	for iter_26_0 = 1, var_26_0 do
		local var_26_1 = arg_26_0.controllerItemPanelTrans_:GetChild(iter_26_0 - 1).gameObject
		local var_26_2 = ActivitySummerSwimsuitPreheatControllerItem.New(var_26_1)

		arg_26_0.controllerItemList_[iter_26_0] = var_26_2
	end
end

function var_0_0.InitControllerItem(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.controllerItemList_) do
		iter_27_1:InitData(arg_27_0.cfgId_, iter_27_0)
	end
end

function var_0_0.UpdateControllerItem(arg_28_0, arg_28_1)
	if not arg_28_0.canShowControllerTips_ then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.controllerItemList_) do
		iter_28_1:UpdateGameData(arg_28_1)
	end
end

function var_0_0.Dispose(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.controllerItemList_) do
		iter_29_1:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
