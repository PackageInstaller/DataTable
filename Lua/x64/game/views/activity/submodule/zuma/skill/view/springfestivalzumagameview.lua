local var_0_0 = import("game.views.activity.Submodule.Zuma.Normal.View.ZumaGameView")
local var_0_1 = class("SpringFestivalZumaGameView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaGameUI"
end

function var_0_1.CloseGame(arg_2_0)
	local var_2_0 = ZumaData:GetZumaGameId()
	local var_2_1 = ActivityZumaLevelCfg[var_2_0]
	local var_2_2 = ZumaToLuaBridge.GetZumaGamePlayTime()
	local var_2_3 = ZumaData:GetZumaScore()

	ZumaAction.QueryZumaCompelet(var_2_1.main_activity_id, var_2_0, 3, var_2_3, var_2_2)
	DestroyLua()
	LaunchQWorld(true)
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, function()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("springFestivalZumaTipsView", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				arg_3_0:CloseGame()
				arg_3_0:SendSDK(false)
			end,
			cancelCallback = function()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end,
			battleAction = function()
				ZumaAction.ReChallengeZumaGame()
				JumpTools.Back()
				arg_3_0:SendSDK(true)
			end
		})
	end)
end

function var_0_1.SendSDK(arg_8_0, arg_8_1)
	local var_8_0 = ZumaData:GetZumaGameId()
	local var_8_1 = ActivityZumaLevelCfg[var_8_0]
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(ZumaData:GetTalentList()) do
		if iter_8_1 then
			table.insert(var_8_2, iter_8_0)
		end
	end

	table.sort(var_8_2)

	local var_8_3, var_8_4 = ZumaData:GetRecordPointData()
	local var_8_5 = {}
	local var_8_6 = ZumaData:GetZumaSkillID()

	if var_8_6 > 0 then
		var_8_5 = string.format("[%s,%s]", var_8_6, var_8_4)
	end

	local var_8_7 = ""

	for iter_8_2, iter_8_3 in pairs(var_8_3) do
		local var_8_8 = iter_8_3[1]
		local var_8_9 = iter_8_3[2]

		if not score then
			local var_8_10 = iter_8_2 - 1
			local var_8_11 = var_8_3[var_8_10] and var_8_3[var_8_10][2] or 0

			var_8_9 = var_8_10 > 0 and ZumaData:GetZumaScore() - var_8_11 or ZumaData:GetZumaScore()
		end

		if iter_8_2 == 1 then
			var_8_7 = string.format("[%s,%s]", var_8_8, var_8_9)
		else
			var_8_7 = string.format("%s,[%s,%s]", var_8_7, var_8_8, var_8_9)
		end
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_8_1.main_activity_id,
		stage_id = var_8_1.id,
		result = arg_8_1 and 4 or 3,
		use_seconds = ZumaToLuaBridge.GetZumaGamePlayTime(),
		score = ZumaData:GetZumaScore(),
		activity_talent_list = var_8_2,
		skill_list = var_8_5,
		total_score = ZumaData:GetEndlessScore(),
		sequence_id = #var_8_3,
		other_data = var_8_7
	})
end

function var_0_1.InitUI(arg_9_0)
	arg_9_0.super.InitUI(arg_9_0)

	arg_9_0.buffInfoNode = SpringFestivalZumaBuffNodeView.New(arg_9_0.buffnodeGo_, arg_9_0)
	arg_9_0.useSkillStateController = arg_9_0.Controllerexcollection_:GetController("useSkill")
	arg_9_0.talentDetailsController = arg_9_0.Controllerexcollection_:GetController("TalentDetails")
	arg_9_0.skillCountShowController = arg_9_0.Controllerexcollection_:GetController("skillCountShow")
	arg_9_0.skillChargeStateController = arg_9_0.Controllerexcollection_:GetController("skillChargeState")
	arg_9_0.skillItem = SpringFestivalBuffItem.New(arg_9_0.skillObj_)
	arg_9_0.skillInfoView = SpringFestivalZumaTalentInfoView.New(arg_9_0.skillInfoObj_)

	arg_9_0:AddBtnListener(arg_9_0.skillBtn_, nil, function()
		ZumaLuaBridge.UseZumaSkill()
	end)
	arg_9_0:AddBtnListener(arg_9_0.skillTipsBtn_, nil, function()
		arg_9_0:OnSkillTipsBtn()
	end)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0.skillInfoView:Show(false)
		ZumaLuaBridge.ReStartZumaGame()
		arg_9_0.talentDetailsController:SetSelectedState("off")
	end)

	arg_9_0.skillChargeImgList = {}

	for iter_9_0 = 1, 3 do
		arg_9_0.skillChargeImgList[iter_9_0] = arg_9_0[string.format("skillChargeImg%s_", iter_9_0)]
	end

	arg_9_0.skillChargeGlowList = {}

	for iter_9_1 = 1, 3 do
		arg_9_0.skillChargeGlowList[iter_9_1] = arg_9_0[string.format("skillChargeGlowObj%s_", iter_9_1)]
	end
end

function var_0_1.UpdateStarProgrss(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.scoreStageList) do
		if arg_13_1 < iter_13_1 then
			break
		end

		var_13_0 = var_13_0 + 1
	end

	if var_13_0 == 0 then
		arg_13_0.progressStateController:SetSelectedState("state0")
	elseif var_13_0 == 1 then
		arg_13_0.progressStateController:SetSelectedState("state1")
	elseif var_13_0 == 2 then
		arg_13_0.progressStateController:SetSelectedState("state2")
	elseif var_13_0 == 3 then
		arg_13_0.progressStateController:SetSelectedState("state3")
	end

	local var_13_1 = {
		0.4,
		0.7,
		1
	}

	if arg_13_0.scoreStageList and #arg_13_0.scoreStageList > 0 then
		local var_13_2 = var_13_1[var_13_0] or 0
		local var_13_3 = var_13_1[var_13_0 + 1] or 0
		local var_13_4 = arg_13_0.scoreStageList[var_13_0] or 0
		local var_13_5 = arg_13_0.scoreStageList[var_13_0 + 1] or 0
		local var_13_6 = (arg_13_1 - var_13_4) / (var_13_5 - var_13_4)

		arg_13_0.sliderSlr_.value = var_13_6 * (var_13_3 - var_13_2) + var_13_2
	else
		arg_13_0.sliderSlr_.value = 0
	end
end

function var_0_1.OnSkillTipsBtn(arg_14_0)
	arg_14_0.talentDetailsController:SetSelectedState("on")
	ZumaLuaBridge.PauseZumaGame()

	local var_14_0 = ZumaData:GetZumaSkillID()

	arg_14_0.skillInfoView:RefreshTalentInfoUI(var_14_0, true)
end

function var_0_1.ZumaAdaptiveMask(arg_15_0)
	local var_15_0 = GameObject.Find("ZumaPlayEnter/Bg").transform:GetComponent("SpriteRenderer").sprite.bounds
	local var_15_1 = manager.ui.canvas
	local var_15_2 = var_15_1:GetComponent(typeof(Canvas)).worldCamera
	local var_15_3 = UnityEngine.Camera.main
	local var_15_4, var_15_5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_15_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_15_0.max), var_15_2, nil)
	local var_15_6, var_15_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_15_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_15_0.min), var_15_2, nil)

	arg_15_0.rightmaskTrs_.anchoredPosition = Vector2(var_15_5.x, 0)
	arg_15_0.leftmaskTrs_.anchoredPosition = Vector2(var_15_7.x, 0)
	arg_15_0.topmaskTrs_.anchoredPosition = Vector2(0, var_15_5.y)
	arg_15_0.bottommaskTrs_.anchoredPosition = Vector2(0, var_15_7.y)
	arg_15_0.stopEffectImgTrs_.sizeDelta = Vector2(var_15_5.x - var_15_7.x, var_15_5.y - var_15_7.y)
end

function var_0_1.OnZumaSceneLoaded(arg_16_0)
	ZumaLuaBridge.SetZumaGameCountdownUI(arg_16_0.timeAni_, arg_16_0.timeTxt_, arg_16_0.skillCountDownTxt_, arg_16_0.skillProgressImg_)
	arg_16_0.buffInfoNode:OnEnter()

	if not arg_16_0.buffInfoNode:GetIsShowBuffNode() then
		arg_16_0:PlayStartEffect()
	end
end

function var_0_1.PlayStartEffect(arg_17_0)
	arg_17_0.startGo_:SetActive(true)

	if arg_17_0.startTimer then
		arg_17_0.startTimer:Stop()

		arg_17_0.startTimer = nil
	end

	arg_17_0.startTimer = Timer.New(function()
		ZumaLuaBridge.StartZumaGame()
		arg_17_0.startGo_:SetActive(false)
		arg_17_0.buffInfoNode:SetGameStartState(true)
	end, 2)

	arg_17_0.startTimer:Start()
end

function var_0_1.OnEnter(arg_19_0)
	SetActive(arg_19_0.endlessGuoChangObj_, false)

	arg_19_0.scoreTxt_.text = 0
	arg_19_0.sliderSlr_.value = 0
	arg_19_0.zumaGameID = ZumaData:GetZumaGameId()
	arg_19_0.zumaCfg = ActivityZumaLevelCfg[arg_19_0.zumaGameID]
	arg_19_0.scoreStageList = {}

	local var_19_0 = arg_19_0.zumaCfg.activity_point_reward

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		arg_19_0.scoreStageList[iter_19_0] = ActivityPointRewardCfg[iter_19_1].need
	end

	if arg_19_0.zumaCfg.difficult == 4 then
		arg_19_0.difficultController:SetSelectedState("endless")
	else
		arg_19_0.difficultController:SetSelectedState("normal")
	end

	arg_19_0:RefreshSkillInfo()
end

function var_0_1.RefreshSkillInfo(arg_20_0)
	local var_20_0 = ZumaData:GetZumaSkillID()

	if var_20_0 == 0 then
		arg_20_0.useSkillStateController:SetSelectedState("hide")

		return
	end

	arg_20_0.useSkillStateController:SetSelectedState("show")
	arg_20_0.skillItem:RefreshUI(var_20_0)
	arg_20_0.skillItem:UpdateBaseState()

	if arg_20_0.zumaCfg.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS and ZumaData:GetZumaTalentIsOpen(ZumaData:GetFinallyTalentID()) then
		arg_20_0.skillCountShowController:SetSelectedState("noCountLimit")
	else
		arg_20_0.skillCountShowController:SetSelectedState("normal")
	end
end

function var_0_1.OnZumaSkillUpdate(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0.skillRemainTimeTxt_.text = arg_21_1

	for iter_21_0, iter_21_1 in pairs(arg_21_0.skillChargeImgList) do
		if iter_21_0 <= arg_21_1 and iter_21_0 <= arg_21_2 then
			iter_21_1.fillAmount = 1

			SetActive(arg_21_0.skillChargeGlowList[iter_21_0], true)
		elseif iter_21_0 <= arg_21_1 and arg_21_2 == iter_21_0 - 1 then
			iter_21_1.fillAmount = arg_21_3
		else
			SetActive(arg_21_0.skillChargeGlowList[iter_21_0], false)

			iter_21_1.fillAmount = 0
		end
	end

	if arg_21_2 == 0 or arg_21_1 == 0 then
		arg_21_0.skillChargeStateController:SetSelectedState("none")
	elseif arg_21_2 == 3 then
		arg_21_0.skillChargeStateController:SetSelectedState("full")
	else
		arg_21_0.skillChargeStateController:SetSelectedState("normal")
	end
end

function var_0_1.OnZumaSkillUseStateUpdate(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 == 1 then
		SetActive(arg_22_0.ammoinfoGo_, arg_22_1)
	elseif arg_22_2 == 3 then
		arg_22_0:OnZumaStopShow(arg_22_1)
	end
end

function var_0_1.OnZumaStopShow(arg_23_0, arg_23_1)
	SetActive(arg_23_0.stopEffectObj_, arg_23_1)
end

function var_0_1.OnZumaEndlessChangeMap(arg_24_0, arg_24_1)
	SetActive(arg_24_0.endlessGuoChangObj_, arg_24_1)
end

function var_0_1.OnExit(arg_25_0)
	arg_25_0.buffInfoNode:OnExit()
	var_0_1.super.OnExit(arg_25_0)
	ZumaLuaBridge.SetZumaGameCountdownUI(nil, nil, nil, nil)
end

function var_0_1.Dispose(arg_26_0)
	arg_26_0.buffInfoNode:Dispose()

	if arg_26_0.skillItem then
		arg_26_0.skillItem:Dispose()

		arg_26_0.skillItem = nil
	end

	if arg_26_0.skillInfoView then
		arg_26_0.skillInfoView:Dispose()

		arg_26_0.skillInfoView = nil
	end

	var_0_1.super.Dispose(arg_26_0)
end

return var_0_1
