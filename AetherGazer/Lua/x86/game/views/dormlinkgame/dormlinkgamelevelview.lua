local var_0_0 = class("DormLinkGameLevelView", ReduxView)

local function var_0_1(arg_1_0)
	return arg_1_0.time > arg_1_0.initialTime and arg_1_0.time <= arg_1_0.duration
end

function var_0_0.UIName(arg_2_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGStageUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

local function var_0_2(arg_6_0)
	return "stage" .. arg_6_0 .. "Tgl_"
end

local var_0_3 = 9

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.stageBtnCtrl = {}

	local var_7_0 = {
		"select",
		"lock",
		"clear"
	}

	for iter_7_0 = 1, var_0_3 do
		local var_7_1 = nullable(arg_7_0, var_0_2(iter_7_0), "transform")

		if var_7_1 then
			local var_7_2 = var_7_1:GetComponent("ControllerExCollection")
			local var_7_3 = {}

			arg_7_0:BindCfgUI(var_7_1, var_7_3)

			for iter_7_1, iter_7_2 in ipairs(var_7_0) do
				var_7_3[iter_7_2] = var_7_2:GetController(iter_7_2)
			end

			arg_7_0.stageBtnCtrl[iter_7_0] = var_7_3
		else
			break
		end
	end

	arg_7_0.modeController = arg_7_0.mode_:GetController("mode")
	arg_7_0.detailPanel = {}

	arg_7_0:BindCfgUI(arg_7_0.detailPanel_, arg_7_0.detailPanel)

	arg_7_0.detailPanel.easyLockController = arg_7_0.detailPanel.normal_:GetController("easyLevelLock")
	arg_7_0.detailPanel.hardLockController = arg_7_0.detailPanel.normal_:GetController("hardLevelLock")
	arg_7_0.detailPanel.normalLockController = arg_7_0.detailPanel.normal_:GetController("lock")
	arg_7_0.detailPanel.spLockController = arg_7_0.detailPanel.sp_:GetController("lock")
end

local function var_0_4(arg_8_0)
	local var_8_0 = GetTips("OPEN_TIME")

	return string.format(var_8_0, manager.time:GetLostTimeStr(arg_8_0))
end

local function var_0_5(arg_9_0)
	local var_9_0 = ActivityLinkGameCfg[arg_9_0].pre_stage
	local var_9_1 = ActivityCfg[var_9_0].remark

	return string.format(GetTips("ACTIVITY_LINKGAME_PRE_LIMIT"), var_9_1)
end

local function var_0_6(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = DormLinkGameTools:ChecklevelUnLock(arg_10_0)

	if var_10_0 then
		return nil
	else
		if var_10_1 == DormLinkGameConst.LevelLockType.time then
			local var_10_3 = ActivityLinkGameCfg[arg_10_0].activity_id
			local var_10_4 = ActivityData:GetActivityData(var_10_3)

			return var_0_4(var_10_4.startTime)
		elseif var_10_1 == DormLinkGameConst.LevelLockType.stop then
			return GetTips("TIME_OVER")
		elseif var_10_1 == DormLinkGameConst.LevelLockType.preLevel then
			return var_0_5(arg_10_0)
		end

		return ""
	end
end

function var_0_0.GoToGame(arg_11_0, arg_11_1)
	if arg_11_1 then
		local var_11_0 = var_0_6(arg_11_1)

		if var_11_0 then
			ShowTips(var_11_0)
		else
			DormLinkGameData:CheckToEnterDormLinkScene(arg_11_1)
			manager.audio:PlayBGM("ui_battle", "ui_battle_stopbgm", "ui_battle.awb")
		end
	end
end

function var_0_0.AddUIListener(arg_12_0)
	for iter_12_0 = 1, var_0_3 do
		arg_12_0:AddBtnListenerScale(arg_12_0[var_0_2(iter_12_0)], nil, function()
			if var_0_1(arg_12_0.enterAniDirector_) then
				arg_12_0.enterAniDirector_.time = arg_12_0.enterAniDirector_.duration

				arg_12_0.enterAniDirector_:Evaluate()
			end

			local var_13_0 = iter_12_0

			if arg_12_0.selIndex == iter_12_0 then
				var_13_0 = nil
			end

			arg_12_0:SelLevel(var_13_0)
		end)
	end

	arg_12_0:AddBtnListener(arg_12_0.emptyAreaBtn_, nil, function()
		if var_0_1(arg_12_0.enterAniDirector_) then
			return
		end

		arg_12_0:SelLevel(nil)
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.receiveBtn_, nil, function()
		JumpTools.OpenPageByJump("dormLinkGameActivityView", {
			activityID = arg_12_0.activityID
		})
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.detailPanel.goToEasy_, nil, function()
		if arg_12_0.easyLevel then
			arg_12_0:GoToGame(arg_12_0.easyLevel)
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.detailPanel.goToHard_, nil, function()
		if arg_12_0.hardLevel then
			arg_12_0:GoToGame(arg_12_0.hardLevel)
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.detailPanel.goToSp_, nil, function()
		if arg_12_0.spLevel then
			arg_12_0:GoToGame(arg_12_0.spLevel)
		end
	end)
	arg_12_0:AddBtnListener(arg_12_0.tipBtn_, nil, DormLinkGameTools.OpenGameTips)
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

local var_0_7 = 1e-14

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.activityID = arg_20_0.params_.activityID or DormLinkGameData:GetMainActivityID()
	arg_20_0.levelActivityList = DormLinkGameTools:GetLevelActivityList(arg_20_0.activityID)

	table.sort(arg_20_0.levelActivityList)
	DormLinkGameData:HideLevelRedPoint()
	arg_20_0:RefreshView()
	arg_20_0:SelLevel(nil, true)
	manager.redPoint:bindUIandKey(arg_20_0.receiveBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_LEVEL_REWARD))

	arg_20_0.enterAniDirector_.time = var_0_7

	arg_20_0.enterAniDirector_:Evaluate()
	arg_20_0:StartTimeRefresh()
end

function var_0_0.StartTimeRefresh(arg_21_0)
	arg_21_0:StopTimeRefresh()

	arg_21_0.timer = Timer.New(function()
		arg_21_0:UpdataLastTime()
	end, 1, -1)

	arg_21_0.timer:Start()
end

function var_0_0.StopTimeRefresh(arg_23_0)
	if arg_23_0.timer then
		arg_23_0.timer:Stop()

		arg_23_0.timer = nil
	end
end

function var_0_0.RefreshView(arg_24_0)
	arg_24_0:UpdataLastTime()
	arg_24_0:UpdataLevelState()

	arg_24_0.titleTxt_.text = ActivityCfg[arg_24_0.activityID].remark
	arg_24_0.uiCharacterImage_.sprite = getSpriteWithoutAtlas(DormLinkGameTools.GetVersionCharaImgPath(arg_24_0.activityID))
end

local var_0_8 = "--"

local function var_0_9(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = var_0_6(arg_25_0)

	if arg_25_0 and var_25_0 == nil then
		arg_25_1:SetSelectedState("false")

		arg_25_3.text = DormLinkGameData:GetLevelScore(arg_25_0) or var_0_8
	else
		arg_25_1:SetSelectedState("true")

		arg_25_3.text = var_0_8
		arg_25_2.text = var_25_0
	end
end

function var_0_0.UpdateSpLevelDetail(arg_26_0)
	var_0_9(arg_26_0.spLevel, arg_26_0.detailPanel.spLockController, arg_26_0.detailPanel.spLockMsg_, arg_26_0.detailPanel.spScore_)
end

function var_0_0.UpdateNormalLevelDetail(arg_27_0)
	var_0_9(arg_27_0.easyLevel, arg_27_0.detailPanel.easyLockController, arg_27_0.detailPanel.easyLockMsg_, arg_27_0.detailPanel.easyScore_)
	var_0_9(arg_27_0.hardLevel, arg_27_0.detailPanel.hardLockController, arg_27_0.detailPanel.hardLockMsg_, arg_27_0.detailPanel.hardScore_)
end

function var_0_0.SelLevel(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == nil then
		if arg_28_0.selIndex then
			arg_28_0.selIndex = nil

			arg_28_0.levelPanelAni_:Play("Fx_NorseUI_3_2_LGStageUI_right_Back", 0, arg_28_2 and 1 or 0)
		end

		arg_28_0.easyLevel, arg_28_0.hardLevel, arg_28_0.spLevel = nil
	else
		local var_28_0
		local var_28_1

		var_28_1, arg_28_0.selIndex = arg_28_0.selIndex, arg_28_1

		local var_28_2 = arg_28_0.levelActivityList[arg_28_1]

		arg_28_0.easyLevel, arg_28_0.hardLevel, arg_28_0.spLevel = DormLinkGameData:GetLevelControlledByActivity(var_28_2)

		if var_28_1 == nil then
			arg_28_0.levelPanelAni_:Play("Fx_NorseUI_3_2_LGStageUI_right_skip", 0, arg_28_2 and 1 or 0)
		end

		if arg_28_0.spLevel then
			arg_28_0.modeController:SetSelectedState("special")
			arg_28_0:UpdateSpLevelDetail()
		else
			arg_28_0.modeController:SetSelectedState("normal")
			arg_28_0:UpdateNormalLevelDetail()
		end

		local var_28_3 = ActivityCfg[var_28_2]

		arg_28_0.detailPanel.levelTitle_.text = var_28_3.remark
		arg_28_0.detailPanel.levelDesc_.text = ActivityLinkGameCfg[arg_28_0.easyLevel or arg_28_0.spLevel].linkgame_des
	end

	arg_28_0:UpdataLevelState()
end

local function var_0_10(arg_29_0)
	local var_29_0
	local var_29_1 = ActivityLinkGameCfg.get_id_list_by_activity_id[arg_29_0]

	if var_29_1 then
		for iter_29_0, iter_29_1 in ipairs(var_29_1) do
			local var_29_2 = DormLinkGameData:GetLevelScore(iter_29_1)

			if var_29_0 == nil or var_29_2 and var_29_0 < var_29_2 then
				var_29_0 = var_29_2
			end
		end
	end

	return tostring(var_29_0 or var_0_8)
end

function var_0_0.UpdateStageBtn(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_0.levelActivityList[var_30_0]
	local var_30_2 = arg_30_0.stageBtnCtrl[var_30_0]

	if DormLinkGameTools:CheckLevelActivityUnlock(var_30_1) and DormLinkGameTools:CheckAnyLevelInActivityUnlock(var_30_1) then
		var_30_2.lock:SetSelectedState("false")

		if var_30_2.clear then
			if DormLinkGameData:CheckActivityComplete(var_30_1) then
				var_30_2.clear:SetSelectedState("true")
			else
				var_30_2.clear:SetSelectedState("false")
			end
		end
	else
		var_30_2.lock:SetSelectedState("true")
	end

	var_30_2.select:SetSelectedState(arg_30_1 == arg_30_0.selIndex and "true" or "false")

	if var_30_2.score_ then
		local var_30_3 = var_0_10(var_30_1)

		var_30_2.score_.text = var_30_3
	end
end

function var_0_0.UpdataLastTime(arg_31_0)
	local var_31_0 = ActivityData:GetActivityData(arg_31_0.activityID)
	local var_31_1 = var_31_0.startTime
	local var_31_2 = var_31_0.stopTime
	local var_31_3 = manager.time:GetServerTime()

	if var_31_3 < var_31_1 then
		arg_31_0.lastTime_.text = GetTips("SOLO_NOT_OPEN")
	elseif var_31_3 < var_31_2 then
		arg_31_0.lastTime_.text = manager.time:GetLostTimeStrWith2Unit(var_31_2, true)
	else
		arg_31_0.lastTime_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.UpdataLevelState(arg_32_0)
	local var_32_0 = DormLinkGameData:GetLevelInfoList()

	if var_32_0 then
		for iter_32_0 = 1, DormLinkGameConst.LevelMax do
			arg_32_0:UpdateStageBtn(iter_32_0, var_32_0)
		end
	end
end

function var_0_0.OnBehind(arg_33_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_34_0)
	arg_34_0:StopTimeRefresh()
	arg_34_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_34_0.receiveBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_LEVEL_REWARD))
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.countTimer then
		arg_35_0.countTimer:Stop()

		arg_35_0.countTimer = nil
	end

	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
