local FishingGameQteView = class("FishingGameQteView", ReduxView)

function FishingGameQteView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingHomeUI"
end

function FishingGameQteView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingGameQteView:Init()
	self:BindCfgUI()

	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
	self.winBar = KagutsuchiSpecialWinBarItem.New(self, self.winBar_)

	self:InitBtnListeners()
end

function FishingGameQteView:Dispose()
	if self.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(self.gameTicker)

		self.gameTicker = nil
	end

	FishingGameQteView.super.Dispose(self)
	self.winBar:Dispose()
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

function FishingGameQteView:InitBtnListeners()
	self:AddBtnListener(self.qteBtn_, nil, var_0_1(handler(self, FishingGameQteView.OnQTE), {}))
end

local function var_0_2(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = unpack(GameDisplayCfg.activity_kagutsuchi_fish_qte.value[HanafudaCardCfg[arg_9_0].qte_type])

	return var_9_0 / 100, var_9_1, var_9_2
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

function FishingGameQteView:EndFishingGame(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.gameTicker then
		FuncTimerManager.inst:RemoveFuncTimer(self.gameTicker)

		self.gameTicker = nil
	end

	self.gameStarted = false

	if arg_12_2 ~= nil then
		var_0_3(arg_12_1, arg_12_2, arg_12_4, arg_12_3, JumpTools.Back)
	else
		JumpTools.Back()
	end
end

local var_0_4 = 4

function FishingGameQteView:OnEnter()
	self.fishID = self.params_.fishID
	self.factor = 0

	local var_13_0, var_13_1, var_13_2 = var_0_2(self.fishID)

	self.pause = false
	self.gameStarted = true

	local var_13_3 = var_0_4

	self.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		var_13_3 = var_13_3 - Time.deltaTime

		if var_13_3 <= 0 and not self.pause then
			FuncTimerManager.inst:RemoveFuncTimer(self.gameTicker)

			self.gameTicker = nil

			self:InitGame(var_13_2, var_13_0, var_13_1)
		end
	end, -1, true)

	self.modeController:SetSelectedState("wait")
	self:RegisterEvents()
	self:ResetWindowBar()
end

function FishingGameQteView:OnExit()
	self:RemoveAllEventListener()
end

function FishingGameQteView:RegisterEvents()
	return
end

function FishingGameQteView:ResetWindowBar()
	manager.windowBar:HideBar()

	if self.backFunc == nil then
		function self.backFunc()
			self.pause = true

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_KAGUTSUCHI_FISH_EXIT"),
				OkCallback = function()
					self.gameStarted = false

					self.modeController:SetSelectedState("waitResult")
					manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, self.fishID, nil)
				end,
				CancelCallback = function()
					self.pause = false
				end,
				MaskCallback = function()
					self.pause = false
				end
			})
		end
	end

	self.winBar:RegistBackCallBack(self.backFunc)
end

function FishingGameQteView:InitGame(arg_22_1, arg_22_2, arg_22_3)
	if not self.gameStarted then
		return
	end

	self.factor, self.sign = 0, 1
	arg_22_3 = math.min(math.max(arg_22_3, 0), 1)
	self.qteSpan = arg_22_3
	self.gameTime = arg_22_1

	local var_22_0 = math.random() * (1 - arg_22_3)

	self.range = {
		left = var_22_0,
		right = var_22_0 + arg_22_3
	}
	self.pointerInRange = nil

	local function var_22_1()
		local var_23_0 = self.pause and 0 or Time.deltaTime

		self:UpdateFactorValue(self.pause and 0 or Time.deltaTime, 1 / arg_22_2)
		self:UpdateDrawGameBar()
		self:UpdateTimeCountdown(var_23_0)
	end

	self.gameTicker = FuncTimerManager.inst:CreateFuncFrameTimer(var_22_1, -1, true)

	self.modeController:SetSelectedState("game")
	self:ResetWindowBar()
	var_22_1()
	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_START)
end

function FishingGameQteView:UpdateFactorValue(arg_24_1, arg_24_2)
	local var_24_0 = self.factor + arg_24_1 * arg_24_2 * self.sign

	if self.factor + arg_24_1 * arg_24_2 * self.sign > 1 then
		self.sign = -1
		var_24_0 = 2 - var_24_0
	elseif var_24_0 < 0 then
		self.sign = 1
		var_24_0 = -var_24_0
	end

	self.factor = var_24_0
end

local function var_0_5(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.localPosition = arg_25_0.parent:InverseTransformPoint((arg_25_1:TransformPoint(arg_25_2)))
end

local function var_0_6(arg_26_0, arg_26_1)
	return arg_26_0 >= arg_26_1.left and arg_26_0 <= arg_26_1.right
end

function FishingGameQteView:UpdateDrawGameBar()
	local var_27_0 = var_0_6(self.factor, self.range)

	if self.pointerInRange ~= var_27_0 then
		self.successAreaAnimator_:Play(var_27_0 and "JapanRegionFishingHomeUI_glow" or "JapanRegionFishingHomeUI_glow02")
	end

	self.pointerInRange = var_27_0

	var_0_5(self.area_, self.qteIndicator_, Vector2(self.range.left * self.qteIndicator_.rect.width, 0))

	self.area_.sizeDelta = Vector2(self.qteSpan * self.qteIndicator_.rect.width, self.qteIndicator_.rect.height)

	var_0_5(self.pointer_, self.qteIndicator_, Vector2(self.qteIndicator_.rect.width * self.factor, 0))
end

function FishingGameQteView:UpdateTimeCountdown(arg_28_1)
	self.gameTime = self.gameTime - arg_28_1
	self.countdown_.text = math.floor(math.max(self.gameTime, 0))

	if self.gameStarted and self.gameTime <= 0 and not self.pause then
		self.gameStarted = false

		self.modeController:SetSelectedState("waitResult")
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, self.fishID, false)
	end
end

function FishingGameQteView:OnQTE(arg_29_1)
	self.pause = true

	self.modeController:SetSelectedState("waitResult")

	self.gameStarted = false

	if var_0_6(self.factor, self.range) then
		KagutsuchiFishingEventAction.SendFishingSuccess(self.fishID, arg_29_1)
	else
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, self.fishID, false)
		arg_29_1()
	end
end

return FishingGameQteView
