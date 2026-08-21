local var_0_0 = class("AutoChessPVESelectStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_CheckpointMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.curArea_ = 0
	arg_3_0.canChangeDiff_ = false
	arg_3_0.isDifficult_ = false
	arg_3_0.stageList_ = {}
	arg_3_0.tabList_ = {}
	arg_3_0.stageItemList_ = {}
	arg_3_0.selectHandle_ = handler(arg_3_0, arg_3_0.SelectStage)

	for iter_3_0 = 1, 3 do
		arg_3_0.tabList_[iter_3_0] = AutoChessPVESelectStageTabItem.New(arg_3_0["tabGo_" .. iter_3_0], function(arg_4_0)
			arg_3_0:ChangeArea(arg_4_0, false)
		end)
		arg_3_0.stageItemList_[iter_3_0] = AutoChessPVEStageItem.New(arg_3_0["stageGo_" .. iter_3_0], arg_3_0.selectHandle_)
	end

	arg_3_0.headItem_ = AutoChessHeadItemView.New(arg_3_0.headGo_, AutoChessConst.GAME_TYPE.PVE)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddListener()

	arg_5_0.tabLockController_ = arg_5_0.mainControllerEx_:GetController("tablock")
	arg_5_0.tabController_ = arg_5_0.mainControllerEx_:GetController("tabswitchover")
	arg_5_0.showTabController_ = arg_5_0.mainControllerEx_:GetController("tab")
	arg_5_0.bgController_ = arg_5_0.mainControllerEx_:GetController("bg")
	arg_5_0.disabledController_ = arg_5_0.mainControllerEx_:GetController("disabled")

	arg_5_0.tabLockController_:SetSelectedState("lock")
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.simpleBtn_, nil, function()
		arg_6_0:OnClickSimple()
	end)
	arg_6_0:AddBtnListener(arg_6_0.diffBtn_, nil, function()
		arg_6_0:OnClickDifficult()

		if arg_6_0.isDifficult_ then
			saveData("auto_chess_pve_stage", "diffcult_" .. arg_6_0.stageList_[4], 1)
			manager.redPoint:setTip(RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. arg_6_0.stageList_[4], 0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		SetActive(arg_6_0.maskBtn_.gameObject, false)
		arg_6_0:SelectStage(0)
	end)
end

function var_0_0.OnClickDifficult(arg_10_0)
	if not arg_10_0.canChangeDiff_ then
		ShowTips("AUTO_CHESS_HARD_BOSS_LOCKED")

		return
	end

	if arg_10_0.isDifficult_ then
		return
	end

	arg_10_0.isDifficult_ = true

	arg_10_0.stageItemList_[3]:SetData(arg_10_0.stageList_[4], 3)
	arg_10_0.tabController_:SetSelectedState("Difficulty")
end

function var_0_0.OnClickSimple(arg_11_0)
	if not arg_11_0.canChangeDiff_ then
		ShowTips("AUTO_CHESS_HARD_BOSS_LOCKED")

		return
	end

	if not arg_11_0.isDifficult_ then
		return
	end

	arg_11_0.isDifficult_ = false

	arg_11_0.stageItemList_[3]:SetData(arg_11_0.stageList_[3], 3)
	arg_11_0.tabController_:SetSelectedState("Simple")
end

function var_0_0.OnEnter(arg_12_0)
	AutoChessData:SetCurGameType(AutoChessConst.GAME_TYPE.PVE)

	for iter_12_0 = 1, 3 do
		local var_12_0 = AutoChessAreaCfg.all[iter_12_0]

		arg_12_0.tabList_[iter_12_0]:SetData(var_12_0)
		manager.redPoint:bindUIandKey(arg_12_0.tabList_[iter_12_0].transform_, RedPointConst.AUTO_CHESS_PVE_STAGE_AREA .. var_12_0)
	end

	local function var_12_1()
		arg_12_0.headItem_:RefreshUI()

		local var_13_0 = arg_12_0:GetCurChallengeStage()
		local var_13_1 = AutoChessStageCfg[var_13_0]

		arg_12_0:ChangeArea(var_13_1.area, true)
	end

	local var_12_2 = AutoChessData:GetStageStoryId()

	if var_12_2 then
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_12_2, function(arg_14_0)
			var_12_1()
			AutoChessData:SetStageStoryId(nil)
			JumpTools.Back()
		end)
	else
		var_12_1()
	end
end

function var_0_0.GetCurChallengeStage(arg_15_0)
	if AutoChessTools.GetCurChallengeStage() > 0 then
		return AutoChessTools.GetCurChallengeStage()
	end

	return getData("auto_chess_pve_stage", "stage_id") or 101
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_17_0)
	SetActive(arg_17_0.maskBtn_.gameObject, false)
	manager.windowBar:HideBar()

	for iter_17_0 = 1, 3 do
		local var_17_0 = AutoChessAreaCfg.all[iter_17_0]

		manager.redPoint:unbindUIandKey(arg_17_0.tabList_[iter_17_0].transform_, RedPointConst.AUTO_CHESS_PVE_STAGE_AREA .. var_17_0)
	end

	local var_17_1 = AutoChessAreaCfg[arg_17_0.curArea_]

	if var_17_1 then
		manager.redPoint:unbindUIandKey(arg_17_0.tabBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. var_17_1.stage_list[4])
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.headItem_:Dispose()
	arg_18_0:StopTimer()

	if arg_18_0.tabLockTimer_ then
		arg_18_0.tabLockTimer_:Stop()

		arg_18_0.tabLockTimer_ = nil
	end

	for iter_18_0 = 1, 3 do
		arg_18_0.tabList_[iter_18_0]:Dispose()
		arg_18_0.stageItemList_[iter_18_0]:Dispose()
	end

	arg_18_0.tabList_ = {}
	arg_18_0.stageItemList_ = {}

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.ChangeArea(arg_19_0, arg_19_1, arg_19_2)
	SetActive(arg_19_0.maskBtn_.gameObject, false)
	arg_19_0.disabledController_:SetSelectedState("false")

	if arg_19_0.curArea_ == arg_19_1 and not arg_19_2 then
		arg_19_0:SelectStage(0)

		return
	end

	if AutoChessData:IsMedalUnlocked(AutoChessMedalCfg.all[arg_19_1]) then
		if not getData("auto_chess_pve_stage", "logo_anim") then
			saveData("auto_chess_pve_stage", "logo_anim", 1)
			arg_19_0.logoAnim_:Play("U_Logo_cx", 0, 0)
		end

		arg_19_0.bgController_:SetSelectedIndex(arg_19_1 - 1)
	else
		arg_19_0.bgController_:SetSelectedIndex(arg_19_1 - 1 + 3)
	end

	arg_19_0.curArea_ = arg_19_1

	local var_19_0 = AutoChessAreaCfg[arg_19_0.curArea_]

	arg_19_0.stageList_ = var_19_0.stage_list

	manager.redPoint:bindUIandKey(arg_19_0.tabBtn_.transform, RedPointConst.AUTO_CHESS_PVE_STAGE_ITEM .. var_19_0.stage_list[4])

	arg_19_0.isDifficult_ = false

	arg_19_0:RefreshStage()
	arg_19_0:RefreshAreaTabUI()

	local var_19_1 = arg_19_0:GetCurChallengeStage()

	if AutoChessStageCfg[var_19_1].is_challenge == 1 and table.indexof(var_19_0.stage_list, var_19_1) then
		arg_19_0:OnClickDifficult()
	end

	arg_19_0.tabController_:SetSelectedState(arg_19_0.isDifficult_ and "Difficulty" or "Simple")
end

function var_0_0.SelectStage(arg_20_0, arg_20_1)
	if arg_20_1 ~= 0 then
		SetActive(arg_20_0.maskBtn_.gameObject, true)
	end

	for iter_20_0 = 1, 3 do
		arg_20_0.stageItemList_[iter_20_0]:SetSelect(arg_20_1)
	end
end

function var_0_0.RefreshAreaTabUI(arg_21_0)
	if AutoChessTools.IsStageUnlock(arg_21_0.stageList_[3]) then
		arg_21_0.showTabController_:SetSelectedState("on")
	else
		arg_21_0.showTabController_:SetSelectedState("off")
	end

	if AutoChessTools.IsStageUnlock(arg_21_0.stageList_[4]) then
		arg_21_0.canChangeDiff_ = true

		if (getData("auto_chess_pve_stage", "difficulty_" .. arg_21_0.stageList_[4]) or 0) == 0 then
			if arg_21_0.curArea_ ~= AutoChessAreaCfg.all[#AutoChessAreaCfg.all] then
				arg_21_0.disabledController_:SetSelectedState("true")
			end

			arg_21_0.tabLockTimer_ = Timer.New(function()
				arg_21_0.difficultAnim_:Play("U_unlockDifficulty_cx", 0, 0)
			end, 1, 1):Start()
			arg_21_0.tabTimer_ = Timer.New(function()
				arg_21_0.tabLockController_:SetSelectedState("unlock")
				saveData("auto_chess_pve_stage", "difficulty_" .. arg_21_0.stageList_[4], 1)
				arg_21_0.stageItemList_[3]:SelectDifficult(handler(arg_21_0, arg_21_0.ChangeArea))
				arg_21_0:OnClickDifficult()
			end, 1.5, 1)

			arg_21_0.tabTimer_:Start()
		else
			arg_21_0.disabledController_:SetSelectedState("false")
			arg_21_0.tabLockController_:SetSelectedState("unlock")
		end
	else
		arg_21_0.canChangeDiff_ = false

		arg_21_0.disabledController_:SetSelectedState("false")
		arg_21_0.tabLockController_:SetSelectedState("lock")
		arg_21_0.difficultAnim_:Play("U_lockDifficulty_cx", 0, 0)
	end

	for iter_21_0 = 1, 3 do
		arg_21_0.tabList_[iter_21_0]:SetSelect(arg_21_0.curArea_)
	end
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.tabTimer_ then
		arg_24_0.tabTimer_:Stop()

		arg_24_0.tabTimer_ = nil
	end
end

function var_0_0.RefreshStage(arg_25_0)
	for iter_25_0 = 1, 3 do
		local var_25_0 = iter_25_0

		if iter_25_0 == 3 and arg_25_0.isDifficult_ then
			var_25_0 = iter_25_0 + 1
		end

		arg_25_0.stageItemList_[iter_25_0]:SetData(arg_25_0.stageList_[var_25_0], iter_25_0)
	end

	arg_25_0:SelectStage(0)
end

return var_0_0
