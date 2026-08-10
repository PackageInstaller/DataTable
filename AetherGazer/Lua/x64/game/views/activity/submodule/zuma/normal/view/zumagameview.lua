local var_0_0 = class("ZumaGameView", ReduxView)
local var_0_1 = {
	progressState = {
		name = "progress",
		star2 = "state2",
		star1 = "state1",
		star0 = "state0",
		star3 = "state3"
	},
	difficultyState = {
		night = "night",
		name = "difficulty",
		endless = "endless",
		normal = "normal"
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, function()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("ZumaTips", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				arg_3_0:CloseGame()
			end,
			cancelCallback = function()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end
		})
	end)
end

function var_0_0.CloseGame(arg_7_0)
	local var_7_0 = ZumaData:GetZumaGameId()
	local var_7_1 = ActivityZumaLevelCfg[var_7_0]
	local var_7_2 = ZumaToLuaBridge.GetZumaGamePlayTime()
	local var_7_3 = ZumaData:GetZumaScore()

	ZumaAction.QueryZumaCompelet(var_7_1.main_activity_id, var_7_0, 3, var_7_3, var_7_2)
	DestroyLua()
	LuaExchangeHelper.GoToMain()
end

function var_0_0.ZumaAdaptiveMask(arg_8_0)
	local var_8_0 = GameObject.Find("ZumaPlayEnter/Bg").transform:GetComponent("SpriteRenderer").sprite.bounds
	local var_8_1 = manager.ui.canvas
	local var_8_2 = var_8_1:GetComponent(typeof(Canvas)).worldCamera
	local var_8_3 = UnityEngine.Camera.main
	local var_8_4, var_8_5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_8_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_8_0.max), var_8_2, nil)
	local var_8_6, var_8_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_8_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_8_0.min), var_8_2, nil)

	arg_8_0.rightmaskTrs_.anchoredPosition = Vector2(var_8_5.x, 0)
	arg_8_0.leftmaskTrs_.anchoredPosition = Vector2(var_8_7.x, 0)
	arg_8_0.topmaskTrs_.anchoredPosition = Vector2(0, var_8_5.y)
	arg_8_0.bottommaskTrs_.anchoredPosition = Vector2(0, var_8_7.y)
	arg_8_0.stopEffectImgTrs_.sizeDelta = Vector2(var_8_5.x - var_8_7.x, var_8_5.y - var_8_7.y)
end

function var_0_0.OnTop(arg_9_0)
	return
end

function var_0_0.InitUI(arg_10_0)
	arg_10_0:BindCfgUI()

	arg_10_0.progressStateController = arg_10_0.Controllerexcollection_:GetController(var_0_1.progressState.name)
	arg_10_0.difficultController = arg_10_0.Controllerexcollection_:GetController(var_0_1.difficultyState.name)

	arg_10_0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 1)
	arg_10_0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 1)
	arg_10_0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 1)
	arg_10_0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 1)
	arg_10_0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 1)
	arg_10_0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 1)
	arg_10_0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 1)
end

function var_0_0.PlayStartEffect(arg_11_0)
	if arg_11_0.startTimer then
		arg_11_0.startTimer:Stop()

		arg_11_0.startTimer = nil
	end

	arg_11_0.startTimer = Timer.New(function()
		ZumaLuaBridge.StartZumaGame()
		arg_11_0.startGo_:SetActive(false)
	end, 2)

	arg_11_0.startTimer:Start()
end

function var_0_0.OnZumaScoreUpdate(arg_13_0)
	local var_13_0 = ZumaData:GetZumaScore()

	arg_13_0.scoreTxt_.text = var_13_0

	arg_13_0:UpdateStarProgrss(var_13_0)
end

function var_0_0.UpdateStarProgrss(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.scoreStageList) do
		if arg_14_1 < iter_14_1 then
			break
		end

		var_14_0 = var_14_0 + 1
	end

	if var_14_0 == 0 then
		arg_14_0.progressStateController:SetSelectedState(var_0_1.progressState.star0)
	elseif var_14_0 == 1 then
		arg_14_0.progressStateController:SetSelectedState(var_0_1.progressState.star1)
	elseif var_14_0 == 2 then
		arg_14_0.progressStateController:SetSelectedState(var_0_1.progressState.star2)
	elseif var_14_0 == 3 then
		arg_14_0.progressStateController:SetSelectedState(var_0_1.progressState.star3)
	end

	if arg_14_0.scoreStageList and #arg_14_0.scoreStageList > 0 then
		arg_14_0.sliderSlr_.value = arg_14_1 / arg_14_0.scoreStageList[#arg_14_0.scoreStageList]
	else
		arg_14_0.sliderSlr_.value = 0
	end
end

function var_0_0.OnZumaBallCountUpdate(arg_15_0)
	arg_15_0.ballNumTxt_.text = ZumaData:GetZumaBallCount()
end

function var_0_0.OnZumaComboUpdate(arg_16_0, arg_16_1)
	if arg_16_1 == 2 then
		arg_16_0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 0)
	elseif arg_16_1 == 3 then
		arg_16_0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 0)
	elseif arg_16_1 == 4 then
		arg_16_0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 0)
	elseif arg_16_1 >= 5 then
		arg_16_0:PlayMaxComboEffect()
	end
end

function var_0_0.PlayMaxComboEffect(arg_17_0)
	local var_17_0 = arg_17_0.comboEffect5Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_0.normalizedTime <= 0 or var_17_0.normalizedTime >= 1 then
		arg_17_0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_17_1 = arg_17_0.comboEffect6Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_1.normalizedTime <= 0 or var_17_1.normalizedTime >= 1 then
		arg_17_0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_17_2 = arg_17_0.comboEffect7Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_2.normalizedTime <= 0 or var_17_2.normalizedTime >= 1 then
		arg_17_0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	arg_17_0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 0)
end

function var_0_0.OnZumaStopShow(arg_18_0, arg_18_1)
	SetActive(arg_18_0.stopEffectObj_, arg_18_1)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.scoreTxt_.text = 0

	arg_19_0:PlayStartEffect()

	arg_19_0.sliderSlr_.value = 0
	arg_19_0.zumaGameID = ZumaData:GetZumaGameId()
	arg_19_0.zumaCfg = ActivityZumaLevelCfg[arg_19_0.zumaGameID]
	arg_19_0.scoreStageList = {}

	local var_19_0 = arg_19_0.zumaCfg.activity_point_reward

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		arg_19_0.scoreStageList[iter_19_0] = ActivityPointRewardCfg[iter_19_1].need
	end

	if arg_19_0.zumaCfg.difficult == 3 then
		arg_19_0.difficultController:SetSelectedState(var_0_1.difficultyState.night)
	else
		arg_19_0.difficultController:SetSelectedState(var_0_1.difficultyState.normal)
	end

	arg_19_0:UpdateSkillState()
end

function var_0_0.OnExit(arg_20_0)
	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.startTimer then
		arg_21_0.startTimer:Stop()

		arg_21_0.startTimer = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
