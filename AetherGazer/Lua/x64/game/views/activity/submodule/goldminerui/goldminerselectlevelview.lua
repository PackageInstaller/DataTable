local var_0_0 = class("GoldMinerSelectLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_StageUI"
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

	arg_4_0.curLevelID_ = 0
	arg_4_0.selectLevelItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectLevelItem)

	for iter_4_0 = 1, 8 do
		arg_4_0["stageItem" .. iter_4_0 .. "_"] = GoldMinerSelectLevelItem.New(arg_4_0["stageGo" .. iter_4_0 .. "_"], iter_4_0, arg_4_0.selectLevelItemHandler_)
	end

	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("hero")
	arg_4_0.panelController_ = arg_4_0.panelControllerEx_:GetController("showHeroPanel")
	arg_4_0.selectController1_ = arg_4_0.panelControllerEx1_:GetController("selected")
	arg_4_0.panelHeroController1_ = arg_4_0.panelControllerEx1_:GetController("hero")
	arg_4_0.selectController2_ = arg_4_0.panelControllerEx2_:GetController("selected")
	arg_4_0.panelHeroController2_ = arg_4_0.panelControllerEx2_:GetController("hero")
end

function var_0_0.OnSelectLevelItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.curLevelID_ == arg_5_2 then
		return
	end

	arg_5_0.curLevelID_ = arg_5_2

	for iter_5_0 = 1, 8 do
		arg_5_0["stageItem" .. iter_5_0 .. "_"]:RefreshSelect(arg_5_0.curLevelID_)
	end

	local var_5_0 = arg_5_0["stageItem" .. arg_5_1 .. "_"]

	if var_5_0 then
		local var_5_1 = -var_5_0.transform_.localPosition.x + arg_5_0.scrollViewTrans_.rect.width / 2 - var_5_0.transform_.rect.width / 2

		arg_5_0:RemoveTween()

		arg_5_0.scrollView_.horizontal = false
		arg_5_0.tween_ = LeanTween.value(arg_5_0.content_, arg_5_0.content_.transform.localPosition.x, var_5_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
			arg_5_0.content_.transform.localPosition = Vector3(arg_6_0, 0, 0)
		end))
	else
		arg_5_0.scrollView_.horizontal = true
	end
end

function var_0_0.RemoveTween(arg_7_0)
	if arg_7_0.tween_ then
		arg_7_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_7_0.content_)

		arg_7_0.tween_ = nil
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.changeHeroBtn_, nil, function()
		arg_8_0.panelController_:SetSelectedState("true")
	end)
	arg_8_0:AddBtnListener(arg_8_0.panelBtn1_, nil, function()
		local var_10_0 = GodEaterData:GetCurHeroID()
		local var_10_1

		if var_10_0 == 1045 then
			return
		else
			var_10_1 = 1045
		end

		arg_8_0.panelController_:SetSelectedState("false")
		GodEaterAction.GoldMinerChangeHero(ActivityConst.ACTIVITY_GOLDMINER, var_10_1, function()
			GodEaterData:SetCurHeroID(var_10_1)
			arg_8_0:RefreshHeroInfo()
		end)
	end)
	arg_8_0:AddBtnListener(arg_8_0.panelBtn2_, nil, function()
		local var_12_0 = GodEaterData:GetCurHeroID()
		local var_12_1

		if var_12_0 == 1046 then
			return
		else
			var_12_1 = 1046
		end

		arg_8_0.panelController_:SetSelectedState("false")
		GodEaterAction.GoldMinerChangeHero(ActivityConst.ACTIVITY_GOLDMINER, var_12_1, function()
			GodEaterData:SetCurHeroID(var_12_1)
			arg_8_0:RefreshHeroInfo()
		end)
	end)
	arg_8_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		arg_8_0:TryToCloseSectionView()
		arg_8_0:TryToCloseHeroPanel()
	end))
	arg_8_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		arg_8_0:TryToCloseSectionView()
		arg_8_0:TryToCloseHeroPanel()
	end))
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.activityID_ = arg_16_0.params_.activityID
	arg_16_0.subActivityID_ = ActivityCfg[arg_16_0.activityID_].sub_activity_list

	arg_16_0.panelController_:SetSelectedState("false")

	if not arg_16_0:IsOpenSectionView() then
		arg_16_0.curLevelID_ = 0
	end

	for iter_16_0 = 1, 8 do
		arg_16_0["stageItem" .. iter_16_0 .. "_"]:OnEnter(ActivityGodEaterGoldminerStageCfg.all[iter_16_0])
		arg_16_0["stageItem" .. iter_16_0 .. "_"]:RefreshSelect(arg_16_0.curLevelID_)
	end

	arg_16_0:RefreshHeroInfo()
	arg_16_0:TryToCloseHeroPanel()

	arg_16_0.scrollView_.horizontal = true
	arg_16_0.timeText_.text = GetTips("GOD_EATER_GAME_DESC_1")

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_3")
	manager.windowBar:RegistBackCallBack(function()
		if arg_16_0:IsOpenSectionView() then
			arg_16_0:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_3")
	manager.windowBar:RegistBackCallBack(function()
		if arg_18_0:IsOpenSectionView() then
			arg_18_0:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.RefreshHeroInfo(arg_20_0)
	local var_20_0 = GodEaterData:GetCurHeroID()

	arg_20_0.controller_:SetSelectedState(var_20_0)

	if var_20_0 > 0 then
		local var_20_1 = ActivityGodEaterGoldminerHeroCfg[var_20_0]

		arg_20_0.heroNameText_.text = var_20_1.hero_name
		arg_20_0.heroSkillText_.text = var_20_1.skill_des
	end

	for iter_20_0 = 1, 2 do
		local var_20_2 = ActivityGodEaterGoldminerHeroCfg.all[iter_20_0]
		local var_20_3 = ActivityGodEaterGoldminerHeroCfg[var_20_2]

		arg_20_0["panelNameText" .. iter_20_0 .. "_"].text = var_20_3.hero_name
		arg_20_0["panelDesText" .. iter_20_0 .. "_"].text = var_20_3.skill_des

		if var_20_0 == var_20_2 then
			arg_20_0["selectController" .. iter_20_0 .. "_"]:SetSelectedState("true")
		else
			arg_20_0["selectController" .. iter_20_0 .. "_"]:SetSelectedState("false")
		end

		arg_20_0["panelHeroController" .. iter_20_0 .. "_"]:SetSelectedState(var_20_2)
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()

	for iter_21_0 = 1, 8 do
		arg_21_0["stageItem" .. iter_21_0 .. "_"]:OnExit()
	end

	arg_21_0:RemoveTween()
end

function var_0_0.TryToCloseSectionView(arg_22_0)
	if arg_22_0:IsOpenSectionView() then
		arg_22_0.curLevelID_ = 0

		for iter_22_0 = 1, 8 do
			arg_22_0["stageItem" .. iter_22_0 .. "_"]:RefreshSelect(arg_22_0.curLevelID_)
		end

		arg_22_0.scrollView_.horizontal = true

		JumpTools.Back()
	end
end

function var_0_0.TryToCloseHeroPanel(arg_23_0)
	arg_23_0.panelController_:SetSelectedState("false")
end

function var_0_0.IsOpenSectionView(arg_24_0)
	return arg_24_0:IsOpenRoute("goldMinerStageSectionView")
end

function var_0_0.GoldMinerOpenSelectHeroPanel(arg_25_0)
	arg_25_0.panelController_:SetSelectedState("true")
end

function var_0_0.Dispose(arg_26_0)
	for iter_26_0 = 1, 8 do
		arg_26_0["stageItem" .. iter_26_0 .. "_"]:Dispose()
	end

	arg_26_0.super.Dispose(arg_26_0)
end

return var_0_0
