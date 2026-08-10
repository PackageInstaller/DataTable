local var_0_0 = class("CivilizationGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_PlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillController_ = arg_4_0.mainControllerEx_:GetController("tips")
	arg_4_0.mapController_ = arg_4_0.mainControllerEx_:GetController("Base")
	arg_4_0.infoController_ = arg_4_0.mainControllerEx_:GetController("infoTips")
	arg_4_0.sourceController_ = arg_4_0.mainControllerEx_:GetController("sourceTips")
	arg_4_0.foodController_ = arg_4_0.foodControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("civilizationGameHeroView", {
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsMaskBtn_, nil, function()
		arg_5_0.skillController_:SetSelectedState("off")
	end)
	arg_5_0:AddBtnListener(arg_5_0.explainBtn_, nil, function()
		arg_5_0:ShowInfoTips(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoTipsMask_, nil, function()
		arg_5_0:ShowInfoTips(false)
	end)

	for iter_5_0 = 1, 3 do
		arg_5_0:AddBtnListenerScale(arg_5_0["resourceBtn_" .. iter_5_0], nil, function()
			arg_5_0:ShowSourceTips(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.resourceMaskBtn_, nil, function()
		arg_5_0:ShowSourceTips(0)
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.heroID_ = arg_12_0.params_.heroID
	arg_12_0.stageID_ = arg_12_0.params_.stageID
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.gameType_ = arg_12_0.params_.gameType

	arg_12_0.mapController_:SetSelectedState("content01")

	for iter_12_0 = 1, 3 do
		arg_12_0["hexController" .. iter_12_0] = arg_12_0["hexControllerEx_" .. iter_12_0]:GetController("lock")

		arg_12_0["hexController" .. iter_12_0]:SetSelectedState("off")
	end

	CivilizationGameTools.PreLoadCfg(arg_12_0.gameType_)
	arg_12_0:RefreshUI()
	SetActive(arg_12_0.foodTipsGo_, false)
	arg_12_0.foodController_:SetSelectedIndex(0)

	local var_12_0 = false

	if manager.guide:IsPlaying() then
		var_12_0 = true
	end

	civilization.CivilizationLuaBridge.StartGame(arg_12_0.stageID_, arg_12_0.heroID_, arg_12_0.activityID_, var_12_0)
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = ActivityCivilizationHeroCfg[arg_13_0.heroID_]

	arg_13_0.heroImg_.sprite = getSprite("Atlas/V4_2_GodEaterUIAtlas", var_13_0.icon)

	local var_13_1 = ActivityCivilizationSettingCfg.get_id_list_by_type[arg_13_0.gameType_][1]
	local var_13_2 = ActivityCivilizationSettingCfg[var_13_1]

	arg_13_0.titleText_.text = var_13_2.note

	local var_13_3 = ActivityCivilizationStageCfg[arg_13_0.stageID_]

	arg_13_0.winText_.text = var_13_3.victory_desc
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("GODEATER_CIVILIZATION_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				civilization.CivilizationLuaBridge.EndGame()
			end
		})
	end)
	arg_14_0.infoController_:SetSelectedState("off")
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.ShowInfoTips(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = civilization.CivilizationLuaBridge.GetInfoTips()
		local var_18_1 = ""

		for iter_18_0 = 0, 3 do
			local var_18_2 = iter_18_0 + 1

			if var_18_2 == 1 then
				var_18_1 = string.format(GetTips("GODEATER_CIVILIZATION_GAME_SETTING_" .. var_18_2), var_18_0[iter_18_0])
			else
				var_18_1 = var_18_1 .. "\n" .. string.format(GetTips("GODEATER_CIVILIZATION_GAME_SETTING_" .. var_18_2), var_18_0[2 * iter_18_0], var_18_0[2 * iter_18_0 - 1])
			end
		end

		arg_18_0.infoTipsText_.text = var_18_1

		arg_18_0.infoController_:SetSelectedState("on")
	else
		arg_18_0.infoController_:SetSelectedState("off")
	end
end

function var_0_0.ShowSourceTips(arg_19_0, arg_19_1)
	arg_19_0.sourceController_:SetSelectedIndex(arg_19_1)

	if arg_19_1 == 1 then
		arg_19_0.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_FOOD")
	elseif arg_19_1 == 2 then
		arg_19_0.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_POP")
	elseif arg_19_1 == 3 then
		arg_19_0.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_TECH")
	end
end

function var_0_0.OnCivilizationClickSkill(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		local var_20_0 = ActivityCivilizationSkillCfg[arg_20_1]

		arg_20_0.skillNameText_.text = GetI18NText(var_20_0.name)
		arg_20_0.skillTimeText_.text = var_20_0.cd
		arg_20_0.skillDescText_.text = GetI18NText(var_20_0.description)
	end

	arg_20_0.skillTipsGo_.transform.position = arg_20_2.position

	arg_20_0.skillController_:SetSelectedState("on")
end

function var_0_0.OnCivilizationMapExtension(arg_21_0)
	arg_21_0.mapController_:SetSelectedState("content02")
end

function var_0_0.OnCivilizationGainHex(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 < 0 or arg_22_2 > 3 then
		return
	end

	arg_22_0["hexController" .. arg_22_2]:SetSelectedState("on")

	local var_22_0 = ActivityCivilizationFactorCfg[arg_22_1]

	arg_22_0["hexImg_" .. arg_22_2].sprite = getSpriteViaConfig("CivilizationGame", var_22_0.icon)
end

function var_0_0.OnCivilizationAgeChange(arg_23_0, arg_23_1, arg_23_2)
	JumpTools.OpenPageByJump("civilizationGameLvUpView", {
		lastAge = arg_23_2
	})

	local var_23_0 = ActivityCivilizationSettingCfg.get_id_list_by_type[arg_23_0.gameType_][arg_23_1 + 1]
	local var_23_1 = ActivityCivilizationSettingCfg[var_23_0]

	arg_23_0.titleText_.text = var_23_1.note
end

function var_0_0.OnCivilizationFoodShortage(arg_24_0, arg_24_1)
	SetActive(arg_24_0.foodTipsGo_, arg_24_1)
	arg_24_0.foodController_:SetSelectedIndex(arg_24_1 and 1 or 0)
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)
	Object.Destroy(arg_25_0.gameObject_)
end

return var_0_0
