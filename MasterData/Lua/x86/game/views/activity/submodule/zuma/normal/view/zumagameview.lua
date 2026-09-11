local ZumaGameView = class("ZumaGameView", ReduxView)
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

function ZumaGameView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaGameUI"
end

function ZumaGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ZumaGameView:Init()
	self:InitUI()
	self:AddBtnListener(self.backBtn_, nil, function()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("ZumaTips", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				self:CloseGame()
			end,
			cancelCallback = function()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end
		})
	end)
end

function ZumaGameView:CloseGame()
	local var_7_0 = ZumaData:GetZumaGameId()

	ZumaAction.QueryZumaCompelet(ActivityZumaLevelCfg[var_7_0].main_activity_id, var_7_0, 3, ZumaData:GetZumaScore(), (ZumaToLuaBridge.GetZumaGamePlayTime()))
	DestroyLua()
	LuaExchangeHelper.GoToMain()
end

function ZumaGameView:ZumaAdaptiveMask()
	local var_8_0 = GameObject.Find("ZumaPlayEnter/Bg").transform
	local var_8_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_8_3, var_8_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_8_0.max), var_8_1, nil)
	local var_8_5, var_8_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_8_0:GetComponent("SpriteRenderer").sprite.bounds.min), var_8_1, nil)

	self.rightmaskTrs_.anchoredPosition = Vector2(var_8_4.x, 0)
	self.leftmaskTrs_.anchoredPosition = Vector2(var_8_6.x, 0)
	self.topmaskTrs_.anchoredPosition = Vector2(0, var_8_4.y)
	self.bottommaskTrs_.anchoredPosition = Vector2(0, var_8_6.y)
	self.stopEffectImgTrs_.sizeDelta = Vector2(var_8_4.x - var_8_6.x, var_8_4.y - var_8_6.y)
end

function ZumaGameView:OnTop()
	return
end

function ZumaGameView:InitUI()
	self:BindCfgUI()

	self.progressStateController = self.Controllerexcollection_:GetController(var_0_1.progressState.name)
	self.difficultController = self.Controllerexcollection_:GetController(var_0_1.difficultyState.name)

	self.comboEffect2Ani_:Play("Fx_x1_cx", 0, 1)
	self.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 1)
	self.comboEffect4Ani_:Play("Fx_x4_cx", 0, 1)
	self.comboEffect5Ani_:Play("Fx_x5_cx", 0, 1)
	self.comboEffect6Ani_:Play("Fx_x5_cx", 0, 1)
	self.comboEffect7Ani_:Play("Fx_x5_cx", 0, 1)
	self.comboEffect8Ani_:Play("Fx_x5_cx", 0, 1)
end

function ZumaGameView:PlayStartEffect()
	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end

	self.startTimer = Timer.New(function()
		ZumaLuaBridge.StartZumaGame()
		self.startGo_:SetActive(false)
	end, 2)

	self.startTimer:Start()
end

function ZumaGameView:OnZumaScoreUpdate()
	local var_13_0 = ZumaData:GetZumaScore()

	self.scoreTxt_.text = var_13_0

	self:UpdateStarProgrss(var_13_0)
end

function ZumaGameView:UpdateStarProgrss(arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.scoreStageList) do
		if arg_14_1 < iter_14_1 then
			break
		end

		var_14_0 = var_14_0 + 1
	end

	if var_14_0 == 0 then
		self.progressStateController:SetSelectedState(var_0_1.progressState.star0)
	elseif var_14_0 == 1 then
		self.progressStateController:SetSelectedState(var_0_1.progressState.star1)
	elseif var_14_0 == 2 then
		self.progressStateController:SetSelectedState(var_0_1.progressState.star2)
	elseif var_14_0 == 3 then
		self.progressStateController:SetSelectedState(var_0_1.progressState.star3)
	end

	self.sliderSlr_.value = self.scoreStageList and #self.scoreStageList > 0 and arg_14_1 / self.scoreStageList[#self.scoreStageList] or 0
end

function ZumaGameView:OnZumaBallCountUpdate()
	self.ballNumTxt_.text = ZumaData:GetZumaBallCount()
end

function ZumaGameView:OnZumaComboUpdate(arg_16_1)
	if arg_16_1 == 2 then
		self.comboEffect2Ani_:Play("Fx_x1_cx", 0, 0)
	elseif arg_16_1 == 3 then
		self.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 0)
	elseif arg_16_1 == 4 then
		self.comboEffect4Ani_:Play("Fx_x4_cx", 0, 0)
	elseif arg_16_1 >= 5 then
		self:PlayMaxComboEffect()
	end
end

function ZumaGameView:PlayMaxComboEffect()
	local var_17_0 = self.comboEffect5Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_0.normalizedTime <= 0 or var_17_0.normalizedTime >= 1 then
		self.comboEffect5Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_17_1 = self.comboEffect6Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_1.normalizedTime <= 0 or var_17_1.normalizedTime >= 1 then
		self.comboEffect6Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_17_2 = self.comboEffect7Ani_:GetCurrentAnimatorStateInfo(0)

	if var_17_2.normalizedTime <= 0 or var_17_2.normalizedTime >= 1 then
		self.comboEffect7Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	self.comboEffect8Ani_:Play("Fx_x5_cx", 0, 0)
end

function ZumaGameView:OnZumaStopShow(arg_18_1)
	SetActive(self.stopEffectObj_, arg_18_1)
end

function ZumaGameView:OnEnter()
	self.scoreTxt_.text = 0

	self:PlayStartEffect()

	self.sliderSlr_.value = 0
	self.zumaGameID = ZumaData:GetZumaGameId()
	self.zumaCfg = ActivityZumaLevelCfg[self.zumaGameID]
	self.scoreStageList = {}

	for iter_19_0, iter_19_1 in pairs(self.zumaCfg.activity_point_reward) do
		self.scoreStageList[iter_19_0] = ActivityPointRewardCfg[iter_19_1].need
	end

	if self.zumaCfg.difficult == 3 then
		self.difficultController:SetSelectedState(var_0_1.difficultyState.night)
	else
		self.difficultController:SetSelectedState(var_0_1.difficultyState.normal)
	end

	self:UpdateSkillState()
end

function ZumaGameView:OnExit()
	manager.ui:ResetMainCamera()
end

function ZumaGameView:Dispose()
	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end

	ZumaGameView.super.Dispose(self)
end

return ZumaGameView
