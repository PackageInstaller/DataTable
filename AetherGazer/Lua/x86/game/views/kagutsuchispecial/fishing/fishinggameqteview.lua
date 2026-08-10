local var_0_0 = class("FishingGameQteView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingHomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.modeController = ControllerUtil.GetController(arg_3_0.transform_, "mode")
	arg_3_0.winBar = KagutsuchiSpecialWinBarItem.New(arg_3_0, arg_3_0.winBar_)

	arg_3_0:InitBtnListeners()
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(arg_4_0.gameTicker)

		arg_4_0.gameTicker = nil
	end

	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.winBar:Dispose()
end

local function var_0_1(arg_5_0, arg_5_1)
	local function var_5_0()
		arg_5_1[arg_5_0] = nil
	end

	return function()
		if not arg_5_1[arg_5_0] then
			arg_5_1[arg_5_0] = true

			arg_5_0(var_5_0)
		end
	end
end

function var_0_0.InitBtnListeners(arg_8_0)
	local var_8_0 = {}

	arg_8_0:AddBtnListener(arg_8_0.qteBtn_, nil, var_0_1(handler(arg_8_0, var_0_0.OnQTE), var_8_0))
end

local function var_0_2(arg_9_0)
	local var_9_0 = HanafudaCardCfg[arg_9_0].qte_type
	local var_9_1, var_9_2, var_9_3 = unpack(GameDisplayCfg.activity_kagutsuchi_fish_qte.value[var_9_0])

	return var_9_1 / 100, var_9_2, var_9_3
end

local function var_0_3(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local function var_10_0()
		if arg_10_4 then
			arg_10_4()
		end

		if arg_10_1 then
			JumpTools.OpenPageByJump("kagutsuchiFishingGet", {
				fishID = arg_10_0,
				staminaRecover = arg_10_3,
				lastRarity = arg_10_2
			})
		else
			JumpTools.OpenPageByJump("kagutsuchiFishingGetFailed")
		end
	end

	if arg_10_2 == KagutsuchiFishingEventData.EnumFishRarity.B then
		JumpTools.OpenPageByJump("kagutsuchiFishingGetNew", {
			fishID = arg_10_0,
			staminaRecover = arg_10_3,
			callback = var_10_0
		})
	else
		var_10_0()
	end
end

function var_0_0.EndFishingGame(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(arg_12_0.gameTicker)

		arg_12_0.gameTicker = nil
	end

	arg_12_0.gameStarted = false

	if arg_12_2 ~= nil then
		var_0_3(arg_12_1, arg_12_2, arg_12_4, arg_12_3, JumpTools.Back)
	else
		JumpTools.Back()
	end
end

local var_0_4 = 4

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.fishID = arg_13_0.params_.fishID
	arg_13_0.factor = 0

	local var_13_0, var_13_1, var_13_2 = var_0_2(arg_13_0.fishID)

	arg_13_0.pause = false
	arg_13_0.gameStarted = true

	local var_13_3 = var_0_4

	arg_13_0.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		local var_14_0 = Time.deltaTime

		var_13_3 = var_13_3 - var_14_0

		if var_13_3 <= 0 and not arg_13_0.pause then
			FuncTimerManager.inst:RemoveFuncTimer(arg_13_0.gameTicker)

			arg_13_0.gameTicker = nil

			arg_13_0:InitGame(var_13_2, var_13_0, var_13_1)
		end
	end, -1, true)

	arg_13_0.modeController:SetSelectedState("wait")
	arg_13_0:RegisterEvents()
	arg_13_0:ResetWindowBar()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.RegisterEvents(arg_16_0)
	return
end

function var_0_0.ResetWindowBar(arg_17_0)
	manager.windowBar:HideBar()

	if arg_17_0.backFunc == nil then
		function arg_17_0.backFunc()
			arg_17_0.pause = true

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_KAGUTSUCHI_FISH_EXIT"),
				OkCallback = function()
					arg_17_0.gameStarted = false

					arg_17_0.modeController:SetSelectedState("waitResult")
					manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, arg_17_0.fishID, nil)
				end,
				CancelCallback = function()
					arg_17_0.pause = false
				end,
				MaskCallback = function()
					arg_17_0.pause = false
				end
			})
		end
	end

	arg_17_0.winBar:RegistBackCallBack(arg_17_0.backFunc)
end

function var_0_0.InitGame(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_0.gameStarted then
		return
	end

	arg_22_0.factor, arg_22_0.sign = 0, 1
	arg_22_3 = math.min(math.max(arg_22_3, 0), 1)
	arg_22_0.qteSpan = arg_22_3
	arg_22_0.gameTime = arg_22_1

	local var_22_0 = math.random() * (1 - arg_22_3)

	arg_22_0.range = {
		left = var_22_0,
		right = var_22_0 + arg_22_3
	}
	arg_22_0.pointerInRange = nil

	local function var_22_1()
		local var_23_0 = arg_22_0.pause and 0 or Time.deltaTime

		arg_22_0:UpdateFactorValue(var_23_0, 1 / arg_22_2)
		arg_22_0:UpdateDrawGameBar()
		arg_22_0:UpdateTimeCountdown(var_23_0)
	end

	arg_22_0.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(var_22_1, -1, true)

	arg_22_0.modeController:SetSelectedState("game")
	arg_22_0:ResetWindowBar()
	var_22_1()
	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_START)
end

function var_0_0.UpdateFactorValue(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.factor + arg_24_1 * arg_24_2 * arg_24_0.sign

	if var_24_0 > 1 then
		arg_24_0.sign = -1
		var_24_0 = 2 - var_24_0
	elseif var_24_0 < 0 then
		arg_24_0.sign = 1
		var_24_0 = -var_24_0
	end

	arg_24_0.factor = var_24_0
end

local function var_0_5(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:TransformPoint(arg_25_2)

	arg_25_0.localPosition = arg_25_0.parent:InverseTransformPoint(var_25_0)
end

local function var_0_6(arg_26_0, arg_26_1)
	return arg_26_0 >= arg_26_1.left and arg_26_0 <= arg_26_1.right
end

function var_0_0.UpdateDrawGameBar(arg_27_0)
	local var_27_0 = var_0_6(arg_27_0.factor, arg_27_0.range)

	if arg_27_0.pointerInRange ~= var_27_0 then
		arg_27_0.successAreaAnimator_:Play(var_27_0 and "JapanRegionFishingHomeUI_glow" or "JapanRegionFishingHomeUI_glow02")
	end

	arg_27_0.pointerInRange = var_27_0

	local var_27_1 = arg_27_0.qteIndicator_.rect

	var_0_5(arg_27_0.area_, arg_27_0.qteIndicator_, Vector2(arg_27_0.range.left * var_27_1.width, 0))

	arg_27_0.area_.sizeDelta = Vector2(arg_27_0.qteSpan * var_27_1.width, var_27_1.height)

	local var_27_2 = arg_27_0.qteIndicator_.rect

	var_0_5(arg_27_0.pointer_, arg_27_0.qteIndicator_, Vector2(var_27_2.width * arg_27_0.factor, 0))
end

function var_0_0.UpdateTimeCountdown(arg_28_0, arg_28_1)
	arg_28_0.gameTime = arg_28_0.gameTime - arg_28_1
	arg_28_0.countdown_.text = math.floor(math.max(arg_28_0.gameTime, 0))

	if arg_28_0.gameStarted and arg_28_0.gameTime <= 0 and not arg_28_0.pause then
		arg_28_0.gameStarted = false

		arg_28_0.modeController:SetSelectedState("waitResult")
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, arg_28_0.fishID, false)
	end
end

function var_0_0.OnQTE(arg_29_0, arg_29_1)
	arg_29_0.pause = true

	arg_29_0.modeController:SetSelectedState("waitResult")

	arg_29_0.gameStarted = false

	if var_0_6(arg_29_0.factor, arg_29_0.range) then
		KagutsuchiFishingEventAction.SendFishingSuccess(arg_29_0.fishID, arg_29_1)
	else
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, arg_29_0.fishID, false)
		arg_29_1()
	end
end

return var_0_0
