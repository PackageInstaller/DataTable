local var_0_0 = import("game.views.autoChess.view.AutoChessPrepareView")
local var_0_1 = class("AutoChessPrepareView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_FightReadyUI"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_2_0.timerGo_)
	arg_2_0.scoreBoardController_ = arg_2_0.controllerEx_:GetController("scoreBoard")
	arg_2_0.prepareReadyController_ = arg_2_0.controllerEx_:GetController("prepareReady")
	arg_2_0.btnStatusController_ = arg_2_0.controllerEx_:GetController("btnStatus")
	arg_2_0.prepareNumHandler_ = handler(arg_2_0, arg_2_0.UpdatePrepareNum)
end

function var_0_1.AddListener(arg_3_0)
	arg_3_0.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.PropPointerEnter)))
	arg_3_0.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.PropPointerExit)))
	arg_3_0:AddBtnListener(arg_3_0.tipsMask_, nil, function()
		arg_3_0:ResetShopSelectItem()
	end)
	arg_3_0:AddBtnListener(arg_3_0.battleBtn_, nil, function()
		if AutoChessData:GetIsInPrepareEnd() then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_ready_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_3_0.prepareData_:GetUUID()
		})

		local var_5_0 = getData("auto_chess_pop", "skip_" .. arg_3_0.gameType_) or false

		if arg_3_0.prepareData_:GetAttributeList()[AutoChessConst.ATTR_KEY.NOW_MONEY] <= 0 or var_5_0 then
			AutoChessMatchAction.StopPrepare(AutoChessTools.GetCurRound(arg_3_0.gameType_))
		else
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = arg_3_0.gameType_,
				type = AutoChessConst.POP_TYPE.REMAIN_MONEY,
				okCb = function()
					AutoChessMatchAction.StopPrepare(AutoChessTools.GetCurRound(arg_3_0.gameType_))
				end
			})
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnIllustrat_, nil, function()
		if AutoChessData:GetIsInPrepareEndAction() then
			return
		end

		JumpTools.OpenPageByJump("/autoChessIllustratedWindow", {
			isInGame = true
		})
		OperationRecorder.RecordButtonTouch({
			source = 3,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnScore_, nil, function()
		if AutoChessTools.GetCurRound(arg_3_0.gameType_) == 1 or AutoChessData:GetIsInPrepareEndAction() then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_score_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_3_0.prepareData_:GetUUID()
		})
		AutoChessMatchAction.CheckScoreBoard()
	end)
end

function var_0_1.OnEnter(arg_9_0)
	var_0_1.super.OnEnter(arg_9_0)
	manager.notify:RegistListener(AUTO_CHESS_PREPARE_NUM, arg_9_0.prepareNumHandler_)
	arg_9_0.autoChessCountDownView_:RegisterEvent()
end

function var_0_1.UpdatePrepareNum(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 > 0 then
		AutoChessData:SetIsInPrepareEnd(true)

		arg_10_0.prepareNumText_.text = string.format("%d/%d", arg_10_1, arg_10_2)

		arg_10_0.prepareReadyController_:SetSelectedState("show")
		arg_10_0.statusController_:SetSelectedState("ready")
	else
		AutoChessData:SetIsInPrepareEnd(false)
		arg_10_0.prepareReadyController_:SetSelectedState("hide")
		arg_10_0.statusController_:SetSelectedState("show")
	end
end

function var_0_1.Update(arg_11_0)
	arg_11_0.prepareData_ = AutoChessData:GetPrepareData(arg_11_0.gameType_)

	arg_11_0.scoreBoardController_:SetSelectedState(AutoChessTools.GetCurRound(arg_11_0.gameType_) == 1 and "gray" or "normal")
	arg_11_0:CheckEnterPopView()
	arg_11_0:RefreshStageInfo()
	arg_11_0:RefreshLookEnemyBtn()
	arg_11_0.autoChessCountDownView_:UpdateCountDownTime()
	arg_11_0:UpdatePrepareNum(arg_11_0.prepareData_.prepareReadyNum, arg_11_0.prepareData_.prepareTotalNum)
end

function var_0_1.CheckEnterPopView(arg_12_0)
	local var_12_0 = AutoChessData:GetOnlineShopLevel()
	local var_12_1 = var_12_0 and var_12_0 - 1
	local var_12_2 = AutoChessData:GetIsOnlineShopUpgrade()
	local var_12_3 = arg_12_0.prepareData_:GetHeroUpgradeInfo()
	local var_12_4 = var_12_3.oldLevel and var_12_3.oldLevel ~= 0 and var_12_3.newLevel and var_12_3.newLevel ~= 0

	if var_12_2 then
		AutoChessData:SetIsOnlineShopUpgrade(false)
		arg_12_0:GotoShopLevelUpPopView(var_12_1, var_12_0, var_12_3, var_12_4)
	elseif var_12_4 then
		arg_12_0:GotoHeroUpgradePopView(var_12_3, var_12_4)
	else
		arg_12_0:RefreshPrepareView()
	end
end

function var_0_1.UpdateBtnStatus(arg_13_0, arg_13_1)
	arg_13_0.isInPop_ = arg_13_1

	arg_13_0.statusController_:SetSelectedState(arg_13_1 and "hide" or "show")
	arg_13_0.btnStatusController_:SetSelectedState(arg_13_1 and "hide" or "show")
	arg_13_0.autoChessShopItemView_:ChangeBtnStatus(arg_13_1 and "hide" or "refresh")

	if arg_13_1 then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
	end
end

function var_0_1.GotoHeroUpgradePopView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:UpdateUI()
	JumpTools.OpenPageByJump("autoChessHeroUpgradePopView_4_8", {
		heroUpgradeInfo = arg_14_1,
		gameType = arg_14_0.gameType_,
		upgradeBackCb = function()
			local var_15_0 = AutoChessData:GetCatchPrepareActionList(arg_14_0.gameType_)

			if var_15_0 and #var_15_0 > 0 then
				arg_14_0.prepareData_:UpdatePrepareActionList(var_15_0)
				AutoChessData:ResetCatchPrepareActionList(arg_14_0.gameType_)
			end
		end
	})
end

function var_0_1.RefreshPrepareView(arg_16_0)
	arg_16_0:UpdateUI()

	local var_16_0 = AutoChessData:GetCatchPrepareActionList(arg_16_0.gameType_)

	if var_16_0 and #var_16_0 > 0 then
		arg_16_0.prepareData_:UpdatePrepareActionList(var_16_0)
		AutoChessData:ResetCatchPrepareActionList(arg_16_0.gameType_)
	end
end

function var_0_1.RefreshBg(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = AutoChessTools.GetRandomBgPath()

	arg_17_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_17_0)
	arg_17_0.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_17_1)
	arg_17_0.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_17_2)
end

function var_0_1.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = arg_18_0.gameType_,
			type = AutoChessConst.POP_TYPE.PVP_SYNC,
			okCb = function()
				AutoChessTools.CancelGame(arg_18_0.gameType_)
			end
		})
	end)
	manager.windowBar:RegistInfoCallBack(function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_rules",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_18_0.prepareData_:GetUUID(),
			type = AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 and 1 or 2
		})

		local var_21_0 = GameSetting.auto_chess_2_sync_desc.value

		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = var_21_0
		})
	end)
end

function var_0_1.SetDragGoActive(arg_22_0, arg_22_1)
	var_0_1.super.SetDragGoActive(arg_22_0, arg_22_1)

	local var_22_0 = AutoChessData:GetSunglassFlag(AutoChessConst.PLAYER_TYPE.SELF) == AutoChessConst.SUNGLASS_FLAG.UNLOCK

	if arg_22_1 and arg_22_0.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP and var_22_0 then
		local var_22_1, var_22_2, var_22_3 = AutoChessTools.GetChessBody(arg_22_0.pointerChessData_.chessId, AutoChessConst.PLAYER_TYPE.SELF)

		arg_22_0.dragRoleSunglassImg_.sprite = var_22_3

		SetActive(arg_22_0.dragRoleSunglassImg_.gameObject, true)
	else
		SetActive(arg_22_0.dragRoleSunglassImg_.gameObject, false)
	end
end

function var_0_1.OnExit(arg_23_0)
	if arg_23_0.autoChessCountDownView_ then
		arg_23_0.autoChessCountDownView_:OnExit()
	end

	manager.notify:RemoveListener(AUTO_CHESS_PREPARE_NUM, arg_23_0.prepareNumHandler_)
	var_0_1.super.OnExit(arg_23_0)
end

function var_0_1.Dispose(arg_24_0)
	if arg_24_0.autoChessCountDownView_ then
		arg_24_0.autoChessCountDownView_:Dispose()
	end

	var_0_1.super.Dispose(arg_24_0)
end

return var_0_1
