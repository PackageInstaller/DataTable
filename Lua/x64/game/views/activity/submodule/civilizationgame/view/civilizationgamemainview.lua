local var_0_0 = class("CivilizationGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_MainUI"
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

	arg_4_0.selectController_ = arg_4_0.mainControllerEx_:GetController("tips")
	arg_4_0.heroEmptyController_ = arg_4_0.mainControllerEx_:GetController("empty")
	arg_4_0.heroController_ = arg_4_0.selectControllerEx_:GetController("Toggle")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn_, nil, function()
		arg_5_0.selectController_:SetSelectedState("on")
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.selectController_:SetSelectedState("off")
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("ActivityGodEaterCivilizationTaskView", {
			activityId = ActivityConst.ACTIVITY_CIVILIZATION
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.illuBtn_, nil, function()
		JumpTools.OpenPageByJump("/civilizationGameIlluView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		if arg_5_0:GetHeroID() == 0 then
			ShowTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO")
			arg_5_0.selectController_:SetSelectedState("on")
		else
			arg_5_0.selectController_:SetSelectedState("off")
			CivilizationGameTools.EnterGameView(arg_5_0:GetHeroID(), ActivityCivilizationStageCfg.all[1])
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.teachBtn_, nil, function()
		if arg_5_0:GetHeroID() == 0 then
			ShowTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO")
			arg_5_0.selectController_:SetSelectedState("on")
		else
			arg_5_0.selectController_:SetSelectedState("off")
			CivilizationGameTools.EnterGameView(arg_5_0:GetHeroID(), ActivityCivilizationStageCfg.all[2])
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.select1Btn_, nil, function()
		if arg_5_0:GetHeroID() == 1 then
			return
		end

		arg_5_0:SetHeroID(1)
		arg_5_0:UpdateView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.select2Btn_, nil, function()
		if arg_5_0:GetHeroID() == 2 then
			return
		end

		arg_5_0:SetHeroID(2)
		arg_5_0:UpdateView()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.activityID_ = arg_14_0.params_.activityID

	if not ActivityData:GetActivityData(arg_14_0.activityID_) then
		JumpTools.Back()
		ShowTips("TIME_OVER")

		return
	end

	arg_14_0:UpdateView()
	arg_14_0:BindRedPoint()
	GodEaterAction.UpdateRedPoint()
end

function var_0_0.UpdateView(arg_15_0)
	local var_15_0 = arg_15_0:GetHeroID()

	if var_15_0 == 0 then
		arg_15_0.heroEmptyController_:SetSelectedState("empty")
		arg_15_0.heroController_:SetSelectedIndex(2)

		arg_15_0.heroNameText_.text = GetTips("GODEATER_CIVILIZATION_GAME_NOT_SELECTED_HERO_TIPS")
		arg_15_0.descText_.text = ""
	else
		arg_15_0.heroEmptyController_:SetSelectedIndex(var_15_0)
		arg_15_0.heroController_:SetSelectedIndex(var_15_0 == 1 and 0 or 1)

		local var_15_1 = ActivityCivilizationHeroCfg[var_15_0]

		arg_15_0.descText_.text = var_15_1.description
	end

	for iter_15_0 = 1, 2 do
		local var_15_2 = ActivityCivilizationHeroCfg[iter_15_0]

		arg_15_0["hero" .. iter_15_0 .. "NameText_"].text = var_15_2.name
		arg_15_0["hero" .. iter_15_0 .. "DescText_"].text = var_15_2.description

		if var_15_0 == iter_15_0 then
			arg_15_0.heroNameText_.text = var_15_2.name
		end
	end

	arg_15_0.timeText_.text = GetTips("GOD_EATER_GAME_DESC_3")
end

function var_0_0.GetHeroID(arg_16_0)
	return getData("civilizationGame", "heroID") or 0
end

function var_0_0.SetHeroID(arg_17_0, arg_17_1)
	arg_17_0.selectController_:SetSelectedState("off")
	saveData("civilizationGame", "heroID", arg_17_1)
end

function var_0_0.BindRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.taskBtn_.transform, RedPointConst.ACTIVITY_CODEATER_CIVILIZATION)
end

function var_0_0.UnbindRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.taskBtn_.transform, RedPointConst.ACTIVITY_CODEATER_CIVILIZATION)
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GODEATER_CIVILIZATION_GAME_DESC")
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)
	Object.Destroy(arg_22_0.gameObject_)
end

return var_0_0
