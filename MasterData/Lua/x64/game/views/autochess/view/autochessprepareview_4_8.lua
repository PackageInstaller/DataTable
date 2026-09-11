local AutoChessPrepareView_4_8 = class("AutoChessPrepareView_4_8", (import("game.views.autoChess.view.AutoChessPrepareView")))

function AutoChessPrepareView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_FightReadyUI"
end

function AutoChessPrepareView_4_8:InitUI()
	AutoChessPrepareView_4_8.super.InitUI(self)

	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
	self.scoreBoardController_ = self.controllerEx_:GetController("scoreBoard")
	self.prepareReadyController_ = self.controllerEx_:GetController("prepareReady")
	self.btnStatusController_ = self.controllerEx_:GetController("btnStatus")
	self.prepareNumHandler_ = handler(self, self.UpdatePrepareNum)
end

function AutoChessPrepareView_4_8:AddListener()
	self.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(self, self.PropPointerEnter)))
	self.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(self, self.PropPointerExit)))
	self:AddBtnListener(self.tipsMask_, nil, function()
		self:ResetShopSelectItem()
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if AutoChessData:GetIsInPrepareEnd() then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_ready_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.prepareData_:GetUUID()
		})

		if self.prepareData_:GetAttributeList()[AutoChessConst.ATTR_KEY.NOW_MONEY] <= 0 or getData("auto_chess_pop", "skip_" .. self.gameType_) or false then
			AutoChessMatchAction.StopPrepare(AutoChessTools.GetCurRound(self.gameType_))
		else
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = self.gameType_,
				type = AutoChessConst.POP_TYPE.REMAIN_MONEY,
				okCb = function()
					AutoChessMatchAction.StopPrepare(AutoChessTools.GetCurRound(self.gameType_))
				end
			})
		end
	end)
	self:AddBtnListener(self.btnIllustrat_, nil, function()
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
	self:AddBtnListener(self.btnScore_, nil, function()
		if AutoChessTools.GetCurRound(self.gameType_) == 1 or AutoChessData:GetIsInPrepareEndAction() then
			return
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_score_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.prepareData_:GetUUID()
		})
		AutoChessMatchAction.CheckScoreBoard()
	end)
end

function AutoChessPrepareView_4_8:OnEnter()
	AutoChessPrepareView_4_8.super.OnEnter(self)
	manager.notify:RegistListener(AUTO_CHESS_PREPARE_NUM, self.prepareNumHandler_)
	self.autoChessCountDownView_:RegisterEvent()
end

function AutoChessPrepareView_4_8:UpdatePrepareNum(arg_10_1, arg_10_2)
	if arg_10_2 > 0 then
		AutoChessData:SetIsInPrepareEnd(true)

		self.prepareNumText_.text = string.format("%d/%d", arg_10_1, arg_10_2)

		self.prepareReadyController_:SetSelectedState("show")
		self.statusController_:SetSelectedState("ready")
	else
		AutoChessData:SetIsInPrepareEnd(false)
		self.prepareReadyController_:SetSelectedState("hide")
		self.statusController_:SetSelectedState("show")
	end
end

function AutoChessPrepareView_4_8:Update()
	self.prepareData_ = AutoChessData:GetPrepareData(self.gameType_)

	self.scoreBoardController_:SetSelectedState(AutoChessTools.GetCurRound(self.gameType_) == 1 and "gray" or "normal")
	self:CheckEnterPopView()
	self:RefreshStageInfo()
	self:RefreshLookEnemyBtn()
	self.autoChessCountDownView_:UpdateCountDownTime()
	self:UpdatePrepareNum(self.prepareData_.prepareReadyNum, self.prepareData_.prepareTotalNum)
end

function AutoChessPrepareView_4_8:CheckEnterPopView()
	local var_12_0 = AutoChessData:GetOnlineShopLevel()
	local var_12_1 = var_12_0 and var_12_0 - 1
	local var_12_2 = self.prepareData_:GetHeroUpgradeInfo()
	local var_12_3 = var_12_2.oldLevel

	if var_12_2.oldLevel then
		if var_12_2.oldLevel ~= 0 then
			var_12_3 = var_12_2.newLevel and var_12_2.newLevel ~= 0

			if AutoChessData:GetIsOnlineShopUpgrade() then
				AutoChessData:SetIsOnlineShopUpgrade(false)
				self:GotoShopLevelUpPopView(var_12_1, var_12_0, var_12_2, var_12_3)
			elseif var_12_3 then
				self:GotoHeroUpgradePopView(var_12_2, var_12_3)
			end
		end
	end

	self:RefreshPrepareView()
end

function AutoChessPrepareView_4_8:UpdateBtnStatus(arg_13_1)
	self.isInPop_ = arg_13_1

	self.statusController_:SetSelectedState(arg_13_1 and "hide" or "show")
	self.btnStatusController_:SetSelectedState(arg_13_1 and "hide" or "show")
	self.autoChessShopItemView_:ChangeBtnStatus(arg_13_1 and "hide" or "refresh")

	if arg_13_1 then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
	end
end

function AutoChessPrepareView_4_8:GotoHeroUpgradePopView(arg_14_1, arg_14_2)
	self:UpdateUI()
	JumpTools.OpenPageByJump("autoChessHeroUpgradePopView_4_8", {
		heroUpgradeInfo = arg_14_1,
		gameType = self.gameType_,
		upgradeBackCb = function()
			local var_15_0 = AutoChessData:GetCatchPrepareActionList(self.gameType_)

			if var_15_0 and #var_15_0 > 0 then
				self.prepareData_:UpdatePrepareActionList(var_15_0)
				AutoChessData:ResetCatchPrepareActionList(self.gameType_)
			end
		end
	})
end

function AutoChessPrepareView_4_8:RefreshPrepareView()
	self:UpdateUI()

	local var_16_0 = AutoChessData:GetCatchPrepareActionList(self.gameType_)

	if var_16_0 and #var_16_0 > 0 then
		self.prepareData_:UpdatePrepareActionList(var_16_0)
		AutoChessData:ResetCatchPrepareActionList(self.gameType_)
	end
end

function AutoChessPrepareView_4_8:RefreshBg()
	local var_17_0, var_17_1, var_17_2 = AutoChessTools.GetRandomBgPath()

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_17_0)
	self.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_17_1)
	self.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_17_2)
end

function AutoChessPrepareView_4_8:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("autoChessQuitPopView", {
			gameType = self.gameType_,
			type = AutoChessConst.POP_TYPE.PVP_SYNC,
			okCb = function()
				AutoChessTools.CancelGame(self.gameType_)
			end
		})
	end)
	manager.windowBar:RegistInfoCallBack(function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_pvp_rules",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.prepareData_:GetUUID(),
			type = AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 and 1 or 2
		})
		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			isPrefab = true,
			pages = GameSetting.auto_chess_2_sync_desc.value
		})
	end)
end

function AutoChessPrepareView_4_8:SetDragGoActive(arg_22_1)
	AutoChessPrepareView_4_8.super.SetDragGoActive(self, arg_22_1)

	if arg_22_1 and self.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP and AutoChessData:GetSunglassFlag(AutoChessConst.PLAYER_TYPE.SELF) == AutoChessConst.SUNGLASS_FLAG.UNLOCK then
		local var_22_0, var_22_1, var_22_2 = AutoChessTools.GetChessBody(self.pointerChessData_.chessId, AutoChessConst.PLAYER_TYPE.SELF)

		self.dragRoleSunglassImg_.sprite = var_22_2

		SetActive(self.dragRoleSunglassImg_.gameObject, true)
	else
		SetActive(self.dragRoleSunglassImg_.gameObject, false)
	end
end

function AutoChessPrepareView_4_8:OnExit()
	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:OnExit()
	end

	manager.notify:RemoveListener(AUTO_CHESS_PREPARE_NUM, self.prepareNumHandler_)
	AutoChessPrepareView_4_8.super.OnExit(self)
end

function AutoChessPrepareView_4_8:Dispose()
	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:Dispose()
	end

	AutoChessPrepareView_4_8.super.Dispose(self)
end

return AutoChessPrepareView_4_8
