local SpringFestivalZumaGameView = class("SpringFestivalZumaGameView", (import("game.views.activity.Submodule.Zuma.Normal.View.ZumaGameView")))

function SpringFestivalZumaGameView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaGameUI"
end

function SpringFestivalZumaGameView:CloseGame()
	local var_2_0 = ZumaData:GetZumaGameId()

	ZumaAction.QueryZumaCompelet(ActivityZumaLevelCfg[var_2_0].main_activity_id, var_2_0, 3, ZumaData:GetZumaScore(), (ZumaToLuaBridge.GetZumaGamePlayTime()))
	DestroyLua()
	LaunchQWorld(true)
end

function SpringFestivalZumaGameView:Init()
	self:InitUI()
	self:AddBtnListener(self.backBtn_, nil, function()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("springFestivalZumaTipsView", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				self:CloseGame()
				self:SendSDK(false)
			end,
			cancelCallback = function()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end,
			battleAction = function()
				ZumaAction.ReChallengeZumaGame()
				JumpTools.Back()
				self:SendSDK(true)
			end
		})
	end)
end

function SpringFestivalZumaGameView:SendSDK(arg_8_1)
	local var_8_0 = ActivityZumaLevelCfg[ZumaData:GetZumaGameId()]
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(ZumaData:GetTalentList()) do
		if iter_8_1 then
			table.insert(var_8_1, iter_8_0)
		end
	end

	table.sort(var_8_1)

	local var_8_2, var_8_3 = ZumaData:GetRecordPointData()
	local var_8_4 = {}
	local var_8_5 = ZumaData:GetZumaSkillID()

	if var_8_5 > 0 then
		var_8_4 = string.format("[%s,%s]", var_8_5, var_8_3)
	end

	local var_8_6 = ""

	for iter_8_2, iter_8_3 in pairs(var_8_2) do
		local var_8_7 = iter_8_3[2]

		if not score then
			local var_8_8 = iter_8_2 - 1

			var_8_7 = var_8_8 > 0 and ZumaData:GetZumaScore() - ((var_8_2[iter_8_2 - 1] or nil) and (var_8_2[var_8_8][2] or 0)) or ZumaData:GetZumaScore()
		end

		var_8_6 = iter_8_2 == 1 and string.format("[%s,%s]", iter_8_3[1], var_8_7) or string.format("%s,[%s,%s]", var_8_6, iter_8_3[1], var_8_7)
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_8_0.main_activity_id,
		stage_id = var_8_0.id,
		result = arg_8_1 and 4 or 3,
		use_seconds = ZumaToLuaBridge.GetZumaGamePlayTime(),
		score = ZumaData:GetZumaScore(),
		activity_talent_list = var_8_1,
		skill_list = var_8_4,
		total_score = ZumaData:GetEndlessScore(),
		sequence_id = #var_8_2,
		other_data = var_8_6
	})
end

function SpringFestivalZumaGameView:InitUI()
	self.super.InitUI(self)

	self.buffInfoNode = SpringFestivalZumaBuffNodeView.New(self.buffnodeGo_, self)
	self.useSkillStateController = self.Controllerexcollection_:GetController("useSkill")
	self.talentDetailsController = self.Controllerexcollection_:GetController("TalentDetails")
	self.skillCountShowController = self.Controllerexcollection_:GetController("skillCountShow")
	self.skillChargeStateController = self.Controllerexcollection_:GetController("skillChargeState")
	self.skillItem = SpringFestivalBuffItem.New(self.skillObj_)
	self.skillInfoView = SpringFestivalZumaTalentInfoView.New(self.skillInfoObj_)

	self:AddBtnListener(self.skillBtn_, nil, function()
		ZumaLuaBridge.UseZumaSkill()
	end)
	self:AddBtnListener(self.skillTipsBtn_, nil, function()
		self:OnSkillTipsBtn()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.skillInfoView:Show(false)
		ZumaLuaBridge.ReStartZumaGame()
		self.talentDetailsController:SetSelectedState("off")
	end)

	self.skillChargeImgList = {}

	for iter_9_0 = 1, 3 do
		self.skillChargeImgList[iter_9_0] = self[string.format("skillChargeImg%s_", iter_9_0)]
	end

	self.skillChargeGlowList = {}

	for iter_9_1 = 1, 3 do
		self.skillChargeGlowList[iter_9_1] = self[string.format("skillChargeGlowObj%s_", iter_9_1)]
	end
end

function SpringFestivalZumaGameView:UpdateStarProgrss(arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(self.scoreStageList) do
		if arg_13_1 < iter_13_1 then
			break
		end

		var_13_0 = var_13_0 + 1
	end

	if var_13_0 == 0 then
		self.progressStateController:SetSelectedState("state0")
	elseif var_13_0 == 1 then
		self.progressStateController:SetSelectedState("state1")
	elseif var_13_0 == 2 then
		self.progressStateController:SetSelectedState("state2")
	elseif var_13_0 == 3 then
		self.progressStateController:SetSelectedState("state3")
	end

	local var_13_1 = {
		0.4,
		0.7,
		1
	}

	if self.scoreStageList and #self.scoreStageList > 0 then
		local var_13_2 = var_13_1[var_13_0] or 0
		local var_13_3 = self.scoreStageList[var_13_0] or 0

		self.sliderSlr_.value = (arg_13_1 - var_13_3) / ((self.scoreStageList[var_13_0 + 1] or 0) - var_13_3) * ((var_13_1[var_13_0 + 1] or 0) - var_13_2) + var_13_2
	else
		self.sliderSlr_.value = 0
	end
end

function SpringFestivalZumaGameView:OnSkillTipsBtn()
	self.talentDetailsController:SetSelectedState("on")
	ZumaLuaBridge.PauseZumaGame()
	self.skillInfoView:RefreshTalentInfoUI(ZumaData:GetZumaSkillID(), true)
end

function SpringFestivalZumaGameView:ZumaAdaptiveMask()
	local var_15_0 = GameObject.Find("ZumaPlayEnter/Bg").transform:GetComponent("SpriteRenderer").sprite.bounds
	local var_15_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_15_3, var_15_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_15_0.max), var_15_1, nil)
	local var_15_5, var_15_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(manager.ui.canvas.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_15_0.min), var_15_1, nil)

	self.rightmaskTrs_.anchoredPosition = Vector2(var_15_4.x, 0)
	self.leftmaskTrs_.anchoredPosition = Vector2(var_15_6.x, 0)
	self.topmaskTrs_.anchoredPosition = Vector2(0, var_15_4.y)
	self.bottommaskTrs_.anchoredPosition = Vector2(0, var_15_6.y)
	self.stopEffectImgTrs_.sizeDelta = Vector2(var_15_4.x - var_15_6.x, var_15_4.y - var_15_6.y)
end

function SpringFestivalZumaGameView:OnZumaSceneLoaded()
	ZumaLuaBridge.SetZumaGameCountdownUI(self.timeAni_, self.timeTxt_, self.skillCountDownTxt_, self.skillProgressImg_)
	self.buffInfoNode:OnEnter()

	if not self.buffInfoNode:GetIsShowBuffNode() then
		self:PlayStartEffect()
	end
end

function SpringFestivalZumaGameView:PlayStartEffect()
	self.startGo_:SetActive(true)

	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end

	self.startTimer = Timer.New(function()
		ZumaLuaBridge.StartZumaGame()
		self.startGo_:SetActive(false)
		self.buffInfoNode:SetGameStartState(true)
	end, 2)

	self.startTimer:Start()
end

function SpringFestivalZumaGameView:OnEnter()
	SetActive(self.endlessGuoChangObj_, false)

	self.scoreTxt_.text = 0
	self.sliderSlr_.value = 0
	self.zumaGameID = ZumaData:GetZumaGameId()
	self.zumaCfg = ActivityZumaLevelCfg[self.zumaGameID]
	self.scoreStageList = {}

	for iter_19_0, iter_19_1 in pairs(self.zumaCfg.activity_point_reward) do
		self.scoreStageList[iter_19_0] = ActivityPointRewardCfg[iter_19_1].need
	end

	if self.zumaCfg.difficult == 4 then
		self.difficultController:SetSelectedState("endless")
	else
		self.difficultController:SetSelectedState("normal")
	end

	self:RefreshSkillInfo()
end

function SpringFestivalZumaGameView:RefreshSkillInfo()
	local var_20_0 = ZumaData:GetZumaSkillID()

	if var_20_0 == 0 then
		self.useSkillStateController:SetSelectedState("hide")

		return
	end

	self.useSkillStateController:SetSelectedState("show")
	self.skillItem:RefreshUI(var_20_0)
	self.skillItem:UpdateBaseState()

	if self.zumaCfg.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS and ZumaData:GetZumaTalentIsOpen(ZumaData:GetFinallyTalentID()) then
		self.skillCountShowController:SetSelectedState("noCountLimit")
	else
		self.skillCountShowController:SetSelectedState("normal")
	end
end

function SpringFestivalZumaGameView:OnZumaSkillUpdate(arg_21_1, arg_21_2, arg_21_3)
	self.skillRemainTimeTxt_.text = arg_21_1

	for iter_21_0, iter_21_1 in pairs(self.skillChargeImgList) do
		if iter_21_0 <= arg_21_1 and iter_21_0 <= arg_21_2 then
			iter_21_1.fillAmount = 1

			SetActive(self.skillChargeGlowList[iter_21_0], true)
		elseif iter_21_0 <= arg_21_1 and arg_21_2 == iter_21_0 - 1 then
			iter_21_1.fillAmount = arg_21_3
		else
			SetActive(self.skillChargeGlowList[iter_21_0], false)

			iter_21_1.fillAmount = 0
		end
	end

	if arg_21_2 == 0 or arg_21_1 == 0 then
		self.skillChargeStateController:SetSelectedState("none")
	elseif arg_21_2 == 3 then
		self.skillChargeStateController:SetSelectedState("full")
	else
		self.skillChargeStateController:SetSelectedState("normal")
	end
end

function SpringFestivalZumaGameView:OnZumaSkillUseStateUpdate(arg_22_1, arg_22_2)
	if arg_22_2 == 1 then
		SetActive(self.ammoinfoGo_, arg_22_1)
	elseif arg_22_2 == 3 then
		self:OnZumaStopShow(arg_22_1)
	end
end

function SpringFestivalZumaGameView:OnZumaStopShow(arg_23_1)
	SetActive(self.stopEffectObj_, arg_23_1)
end

function SpringFestivalZumaGameView:OnZumaEndlessChangeMap(arg_24_1)
	SetActive(self.endlessGuoChangObj_, arg_24_1)
end

function SpringFestivalZumaGameView:OnExit()
	self.buffInfoNode:OnExit()
	SpringFestivalZumaGameView.super.OnExit(self)
	ZumaLuaBridge.SetZumaGameCountdownUI(nil, nil, nil, nil)
end

function SpringFestivalZumaGameView:Dispose()
	self.buffInfoNode:Dispose()

	if self.skillItem then
		self.skillItem:Dispose()

		self.skillItem = nil
	end

	if self.skillInfoView then
		self.skillInfoView:Dispose()

		self.skillInfoView = nil
	end

	SpringFestivalZumaGameView.super.Dispose(self)
end

return SpringFestivalZumaGameView
