local var_0_0 = class("CowboyGameView", ReduxView)
local var_0_1 = require("cjson")

function var_0_0.UIName(arg_1_0)
	return CowboyTools.GetGameUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.onSenceLoadedHandler_ = handler(arg_4_0, arg_4_0.OnCowboySenceLoaded)
	arg_4_0.onTimeChangeHandler_ = handler(arg_4_0, arg_4_0.OnTimeChange)
	arg_4_0.onScoreChangeHandler_ = handler(arg_4_0, arg_4_0.OnScoreChange)
	arg_4_0.onAttackHandler_ = handler(arg_4_0, arg_4_0.OnAttack)
	arg_4_0.OnGameFocusChange_ = handler(arg_4_0, arg_4_0.OnGameFocusChange1)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.catchBtn_, nil, function()
		CowboyTools:Attack()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		if arg_5_0.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		arg_5_0:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGameBack", {
			mainActivityID = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.stopBtn_, nil, function()
		if arg_5_0.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		arg_5_0:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGamePause", {
			mainActivityID = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideBtn_, nil, function()
		CowboyTools:Hide()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.mainActivityID_ = arg_10_0.params_.mainActivityID
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.isPause_ = false

	SetActive(arg_10_0.cdImg_, false)

	arg_10_0.attackMask_.fillAmount = 0

	arg_10_0:RegisterEvents()
	arg_10_0:InitializeCowboy()
end

function var_0_0.InitializeCowboy(arg_11_0)
	manager.ui:SetMainCamera("cowboy")

	manager.ui.mainCameraCom_.orthographic = true

	CowboyTools:LoadCowboyLevel(arg_11_0.onSenceLoadedHandler_, arg_11_0.onTimeChangeHandler_, arg_11_0.onScoreChangeHandler_, arg_11_0.onAttackHandler_)
end

function var_0_0.OnCowboySenceLoaded(arg_12_0)
	CowboyTools:InitCowboySence(arg_12_0.mainActivityID_, arg_12_0.activityID_)
end

function var_0_0.OnTimeChange(arg_13_0, arg_13_1)
	arg_13_0.time_.text = arg_13_1
end

function var_0_0.OnScoreChange(arg_14_0, arg_14_1)
	arg_14_0.scoreText_.text = arg_14_1
end

function var_0_0.OnAttack(arg_15_0, arg_15_1)
	arg_15_0:StopTimer()
	SetActive(arg_15_0.cdImg_, true)

	local var_15_0 = 0

	arg_15_0.timer_ = Timer.New(function()
		if var_15_0 > arg_15_1 then
			arg_15_0:StopTimer()
			SetActive(arg_15_0.cdImg_, false)
		end

		arg_15_0.attackMask_.fillAmount = 1 - var_15_0 / arg_15_1

		if not arg_15_0.isPause_ then
			var_15_0 = var_15_0 + 0.01
		end
	end, 0.01, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.OnGameFocusChange1(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 or not arg_17_1 then
		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		CowboyTools:Pause()
	elseif arg_17_0.isPause_ == false then
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		CowboyTools:Continue()
	end
end

function var_0_0.OnCowboyPause(arg_18_0)
	arg_18_0.isPause_ = true

	CowboyTools:Pause()
end

function var_0_0.OnCowboyContinue(arg_19_0)
	arg_19_0.isPause_ = false

	SetActive(arg_19_0.cdImg_, false)
	CowboyTools:Continue()
end

function var_0_0.OnCowboyRestart(arg_20_0)
	arg_20_0:StopTimer()

	arg_20_0.isPause_ = false

	SetActive(arg_20_0.cdImg_, false)
	CowboyTools:Restart()
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end

	arg_21_0.attackMask_.fillAmount = 0
end

function var_0_0.RegisterEvents(arg_22_0)
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, arg_22_0.OnGameFocusChange_)
end

function var_0_0.RemoveEvents(arg_23_0)
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, arg_23_0.OnGameFocusChange_)
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:RemoveEvents()
	arg_24_0:StopTimer()
	CowboyTools:GameOver()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	CowboyTools:UnLoadCowboyLevel()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
