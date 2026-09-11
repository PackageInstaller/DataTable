local AutoChessPrepareView = class("AutoChessPrepareView", ReduxView)

function AutoChessPrepareView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_FightReadyUI"
end

function AutoChessPrepareView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessPrepareView:Init()
	self:InitUI()

	self.context_ = {
		curVictoryRoundCount = 0,
		lastHP = 0,
		curRound = 0,
		maxVictoryRoundCount = 0
	}
end

function AutoChessPrepareView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.autoChessFormationItemView_ = AutoChessFormationItemView.New(self.formationItem_)

	for iter_4_0, iter_4_1 in pairs((self.autoChessFormationItemView_:GetChessItemList())) do
		iter_4_1:RegisterEvent("PointerClick", handler(self, self.OnPointerClick))
		iter_4_1:RegisterEvent("BeginDrag", handler(self, self.OnBeginDrag))
		iter_4_1:RegisterEvent("Drag", handler(self, self.OnDrag))
		iter_4_1:RegisterEvent("EndDrag", handler(self, self.OnEndDrag))
		iter_4_1:RegisterEvent("PointerEnter", handler(self, self.OnPointerEnter))
		iter_4_1:RegisterEvent("PointerExit", handler(self, self.OnPointerExit))
	end

	self.autoChessShopItemView_ = AutoChessShopItemView.New(self.shopItem_, self)
	self.playerInfoView_ = AutoChessPlayerInfoView.New(self.playerInfoGo_)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
	self.updateHandler_ = handler(self, self.Update)
	self.updateRoundHandler_ = handler(self, self.UpdateRoundInfo)
	self.updateShopHandler_ = handler(self, self.UpdateShopInfo)
	self.updateLockShopAnimHandler_ = handler(self, self.UpdateLockShopAnim)
	self.updateRemoveShopAnimHandler_ = handler(self, self.UpdateRemoveShopAnim)
	self.refreshShopAnimHandler_ = handler(self, self.RefreshShopAnim)
	self.updateFormationHandler_ = handler(self, self.UpdateTeamInfo)
	self.tipsPanelCloseHandler_ = handler(self, self.OnTipsPanelClose)
	self.buyChessBackHandler_ = handler(self, self.OnBuyChessBack)
	self.updateBtnHandler_ = handler(self, self.UpdateBtnStatus)
	self.propUseController_ = self.controllerEx_:GetController("UseArea")
	self.shopLevelController_ = self.controllerEx_:GetController("shopLv")
	self.showDistortionController_ = self.controllerEx_:GetController("distortion")
	self.showDetailController_ = self.controllerEx_:GetController("detalsPanel")
	self.showEnemyInfoController_ = self.controllerEx_:GetController("FormationBtn")
	self.currencyPanelController_ = self.controllerEx_:GetController("currencyPanel")
	self.statusController_ = self.controllerEx_:GetController("status")
	self.lineShopController_ = self.controllerEx_:GetController("line")
	self.bossTipsController_ = self.controllerEx_:GetController("BossTips")
	self.showReplayController_ = self.replayController_:GetController("default0")
	self.isExpandDistortion_ = false
	self.addedChessList_ = {}
end

function AutoChessPrepareView:AddListener()
	self.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(self, self.PropPointerEnter)))
	self.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(self, self.PropPointerExit)))
	self:AddBtnListener(self.tipsMask_, nil, function()
		self:ResetShopSelectItem()
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if self.isBossBattle_ and self.autoChessFormationItemView_:GetChessNum() < GameSetting.auto_chess_prepare_grid_num.value[1] then
			ShowTips("AUTO_CHESS_BOSS_BUY_TIPS")

			return
		end

		self.showDetailController_:SetSelectedState("off")

		if not AutoChessData:GetIsInPrepareEnd() then
			if self.prepareData_:GetAttributeList()[AutoChessConst.ATTR_KEY.NOW_MONEY] <= 0 or getData("auto_chess_pop", "skip_" .. self.gameType_) or false then
				AutoChessTools.PrepareEnd(self.gameType_)
			else
				JumpTools.OpenPageByJump("autoChessQuitPopView", {
					gameType = self.gameType_,
					type = AutoChessConst.POP_TYPE.REMAIN_MONEY,
					okCb = function()
						AutoChessTools.PrepareEnd(self.gameType_)
					end
				})
			end
		end
	end)
	self:AddBtnListener(self.btnLookEnemy_, nil, function()
		self.showDetailController_:SetSelectedState("off")
		AutoChessAction.LookEnemyInfo(self.stageCfg_.group_id, AutoChessTools.GetCurRound(self.gameType_))
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_team_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.playerData_.battleUID
		})
	end)
	self:AddBtnListener(self.btnDetail_, nil, function()
		if AutoChessTools.GetCurRound(self.gameType_) == 1 then
			self.showReplayController_:SetSelectedState("disabled")
		else
			self.showReplayController_:SetSelectedState("enabled")
		end

		self.showDetailController_:SetSelectedState("on")
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self.showDetailController_:SetSelectedState("off")
	end)
	self:AddBtnListener(self.btnBook_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow", {
			isInGame = true
		})
		OperationRecorder.RecordButtonTouch({
			source = 3,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.distortionBtn_, nil, function()
		if self.isExpandDistortion_ then
			self.distortionAnim_:Play("collapse")

			self.distortionText_.text = AutoChessBuffCfg[self.stageCfg_.scene_buff[1]].name
			self.isExpandDistortion_ = false
		else
			self.distortionAnim_:Play("expand")

			self.distortionText_.text = AutoChessBuffCfg[self.stageCfg_.scene_buff[1]].desc
			self.isExpandDistortion_ = true
		end
	end)
	self:AddBtnListener(self.btnReply_, nil, function()
		AutoChessAction.LookReplay(self.gameType_)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_video_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = self.playerData_.battleUID
		})
	end)
end

function AutoChessPrepareView:OnEnter()
	AutoChessBattleRenderer.GetInstance():SetPrepareView(self)
	self.bossTipsController_:SetSelectedState("hide")
	self.viewAnim_:Play("UI_Enter_cx")

	self.isExit_ = false
	self.gameType_ = self.params_.gameType
	self.targetIndex_ = 0
	self.lastEnterIndex_ = 0
	self.pointerChessData_ = nil
	self.isCanMerge_ = false
	self.isCanSell_ = false
	self.isEnterNotTargetPropArea_ = false
	self.isInPop_ = false

	manager.notify:RegistListener(AUTO_CHESS_UPDATE, self.updateHandler_)
	manager.notify:RegistListener(AUTO_CHESS_ROUND_UPDATE, self.updateRoundHandler_)
	manager.notify:RegistListener(AUTO_CHESS_LOCK_SHOP_SHOW, self.updateLockShopAnimHandler_)
	manager.notify:RegistListener(AUTO_CHESS_REFRESH_SHOP_SHOW, self.refreshShopAnimHandler_)
	manager.notify:RegistListener(AUTO_CHESS_SHOP_UPDATE, self.updateShopHandler_)
	manager.notify:RegistListener(AUTO_CHESS_FORMATION_UPDATE, self.updateFormationHandler_)
	manager.notify:RegistListener(AUTO_CHESS_SHOP_BUY_CHESS, self.buyChessBackHandler_)
	manager.notify:RegistListener(AUTO_CHESS_IS_IN_SKILL_POP, self.updateBtnHandler_)
	self:Update()
end

function AutoChessPrepareView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if manager.guide:IsPlaying() then
			return
		end

		if self.stageId_ and table.indexof(AutoChessConst.TEACH_STAGE, self.stageId_) then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = self.gameType_,
				type = AutoChessConst.POP_TYPE.TEACHING,
				okCb = function()
					AutoChessData:SetStageStoryId(self.stageCfg_.post_story)
					AutoChessTools.CancelGame(self.gameType_)
				end
			})
		else
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = self.gameType_,
				type = AutoChessConst.POP_TYPE.PVE,
				okCb = function()
					AutoChessTools.QuitGame(self.gameType_)
					AutoChessAction.SetGamePause(self.gameType_, AutoChessConst.GAME_PAUSE_TYPE.PAUSE)
				end
			})
		end
	end)

	local var_16_0 = ""

	if self.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		var_16_0 = "auto_chess_PVE_desc"
	elseif AutoChessTools.GetIsPVPGame(self.gameType_) then
		var_16_0 = "auto_chess_2_async_desc"
	elseif self.gameType_ == AutoChessConst.GAME_TYPE.ONLINE then
		var_16_0 = "auto_chess_2_sync_desc"
	end

	local var_16_1 = GameSetting[var_16_0].value

	if #GameSetting[var_16_0].value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_16_1
			}
		})
	end
end

function AutoChessPrepareView:OnExit()
	self.isExit_ = true
	self.addedChessList_ = {}

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(AUTO_CHESS_UPDATE, self.updateHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_ROUND_UPDATE, self.updateRoundHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_SHOP_UPDATE, self.updateShopHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_FORMATION_UPDATE, self.updateFormationHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_LOCK_SHOP_SHOW, self.updateLockShopAnimHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_REFRESH_SHOP_SHOW, self.refreshShopAnimHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_SHOP_BUY_CHESS, self.buyChessBackHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_IS_IN_SKILL_POP, self.updateBtnHandler_)

	self.isExpandDistortion_ = false

	self:SetDragGoActive(false)
	AnimatorTools.Stop()
	self.showDetailController_:SetSelectedState("off")
	self.autoChessShopItemView_:ResetShopItem()
	self.currencyPanelController_:SetSelectedState("normal")
	self.autoChessFormationItemView_:EndDragFunc()
	self.autoChessFormationItemView_:OnExit()
	self.propUseController_:SetSelectedState("hide")
	self.autoChessShopItemView_:SetStatus(0)
	SetActive(self.tipsMask_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
	self.bossTipsController_:SetSelectedState("hide")

	if self.enterIndex_ then
		self.autoChessFormationItemView_:RefreshEnterStatus(self.enterIndex_, false)

		self.enterIndex_ = nil
	end
end

function AutoChessPrepareView:Dispose()
	self.autoChessShopItemView_:Dispose()
	self.autoChessFormationItemView_:Dispose()
	self.playerInfoView_:Dispose()
	self.tipsPanelView_:Dispose()
	AutoChessPrepareView.super.Dispose(self)
end

function AutoChessPrepareView:Update()
	if self.params_.isBattleBack then
		self.params_.isBattleBack = false

		return
	end

	self.prepareData_ = AutoChessData:GetPrepareData(self.gameType_)
	self.stageId_ = AutoChessTools.GetCurStageId(self.gameType_)
	self.stageCfg_ = AutoChessStageCfg[self.stageId_]

	local var_22_0 = self.stageId_

	if self.stageId_ then
		var_22_0 = table.indexof(AutoChessConst.TEACH_STAGE, self.stageId_)
		var_22_0 = var_22_0 and AutoChessTools.GetCurRound(self.gameType_) <= AutoChessConst.TEACH_ROUND_NUM
	end

	self.isTeaching_ = var_22_0

	self:CheckEnterPopView()
	self:RefreshStageInfo()
	self:RefreshLookEnemyBtn()
end

function AutoChessPrepareView:RefreshLookEnemyBtn()
	if self.gameType_ == AutoChessConst.GAME_TYPE.PVE and not self.isInPop_ then
		self.showEnemyInfoController_:SetSelectedState("active")
	else
		self.showEnemyInfoController_:SetSelectedState("inactive")
	end
end

function AutoChessPrepareView:CheckEnterPopView()
	local var_24_0 = AutoChessData:GetLastShopLevel(self.gameType_)
	local var_24_1 = AutoChessData:GetNowShopLevel(self.gameType_)
	local var_24_2 = self.prepareData_:GetHeroUpgradeInfo()
	local var_24_3 = var_24_2.oldLevel and var_24_2.oldLevel ~= 0 and var_24_2.newLevel and var_24_2.newLevel ~= 0 or var_24_2.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA

	if var_24_0 and var_24_0 ~= var_24_1 then
		self:GotoShopLevelUpPopView(var_24_0, var_24_1, var_24_2, var_24_3)
	elseif var_24_3 then
		self:GotoHeroUpgradePopView(var_24_2, var_24_3)
	else
		self:RefreshPrepareView()
	end
end

function AutoChessPrepareView:GotoHeroUpgradePopView(arg_25_1, arg_25_2)
	self:UpdateUI()

	if arg_25_1.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA then
		JumpTools.OpenPageByJump("autoChessBrahmaUpgradePop", {
			heroUpgradeInfo = arg_25_1,
			gameType = self.gameType_
		})
	elseif arg_25_2 then
		JumpTools.OpenPageByJump("autoChessHeroUpgradePop", {
			heroUpgradeInfo = arg_25_1,
			gameType = self.gameType_
		})
	end
end

function AutoChessPrepareView:GotoShopLevelUpPopView(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	JumpTools.OpenPageByJump("autoChessShopLevelUpPop", {
		backFunc = function()
			if arg_26_4 then
				self:GotoHeroUpgradePopView(arg_26_3, arg_26_4)
			else
				self:RefreshPrepareView()
			end
		end,
		lastShopLevel = arg_26_1,
		nowShopLevel = arg_26_2
	})
end

function AutoChessPrepareView:RefreshPrepareView()
	self:UpdateUI()
	AutoChessData:SaveLastShopLevel(self.gameType_)
end

function AutoChessPrepareView:RefreshStageInfo()
	self:RefreshBg()

	if self.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		SetActive(self.btnBook_.gameObject, not self.isTeaching_)

		local var_29_0 = self.stageCfg_.scene_buff ~= "" and #self.stageCfg_.scene_buff > 0

		self.showDistortionController_:SetSelectedState(self.stageCfg_.scene_buff ~= "" and #self.stageCfg_.scene_buff > 0 and "show" or "hide")

		if self.stageId_ >= GameSetting.auto_chess_item_unlock.value[1] then
			self.lineShopController_:SetSelectedState("show")
		else
			self.lineShopController_:SetSelectedState("hide")
		end

		if var_29_0 then
			self.distortionText_.text = AutoChessBuffCfg[self.stageCfg_.scene_buff[1]].name
			self.distortionIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Buff_icon/" .. AutoChessBuffCfg[self.stageCfg_.scene_buff[1]].icon)

			if self.params_.isStageEnter then
				self.bossBuffText_.text = AutoChessBuffCfg[self.stageCfg_.scene_buff[1]].desc
				self.params_.isStageEnter = false

				self.bossTipsController_:SetSelectedState("show")
			else
				self.bossTipsController_:SetSelectedState("hide")
			end
		end
	else
		self.lineShopController_:SetSelectedState("show")
		self.showDistortionController_:SetSelectedState("hide")
		self.bossTipsController_:SetSelectedState("hide")
	end
end

function AutoChessPrepareView:RefreshBg()
	local var_30_0, var_30_1, var_30_2 = AutoChessTools.GetStagBgPath(self.stageId_)

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_30_0)
	self.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_30_1)
	self.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_30_2)
end

function AutoChessPrepareView:UpdateUI()
	self:UpdateUserInfo()
	self:UpdateRoundInfo()
	self:UpdateTeamInfo()
	self:UpdateShopInfo()
end

function AutoChessPrepareView:UpdateBtnStatus(arg_32_1)
	self.isInPop_ = arg_32_1

	self.statusController_:SetSelectedState(arg_32_1 and "hide" or "show")
	self.autoChessShopItemView_:ChangeBtnStatus(arg_32_1 and "hide" or "refresh")

	if arg_32_1 then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
	end
end

function AutoChessPrepareView:PlayExitAnim(arg_33_1)
	AnimatorTools.PlayAnimationWithCallback(self.viewAnim_, "UI_Exit_cx", function()
		self.isExit_ = true

		if arg_33_1 then
			arg_33_1()
		end
	end, -1, 0)
	self.viewAnim_:Update(0)
end

function AutoChessPrepareView:GetIsExit()
	return self.isExit_
end

function AutoChessPrepareView:UpdateShopInfo()
	self.shopLevelController_:SetSelectedIndex(AutoChessData:GetNowShopLevel(self.gameType_) - 1)
	self.autoChessShopItemView_:SetGameType(self.gameType_)

	self.isBossBattle_ = AutoChessTools.IsBossRound(self.gameType_)

	local var_36_0, var_36_1, var_36_2 = self.prepareData_:GetChessGoodDataList()

	self.autoChessShopItemView_:UpdateShopInfo(var_36_0, var_36_1, var_36_2, self.isBossBattle_, self.isTeaching_)
	self:RefreshShopChessLvAnim()
end

function AutoChessPrepareView:UpdateLockShopAnim(arg_37_1)
	self.autoChessShopItemView_:UpdateLockShopAnim(arg_37_1)
end

function AutoChessPrepareView:UpdateRemoveShopAnim()
	return
end

function AutoChessPrepareView:RefreshShopAnim()
	self.autoChessShopItemView_:RefreshShopAnim()
	self:ResetShopSelectItem()
end

function AutoChessPrepareView:RefreshCurrencyAnim()
	self.currencyAnim_:Play("currencyPanel", 0, 0)
end

function AutoChessPrepareView:RefreshShopChessLvAnim()
	local var_41_0 = {}
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs((self.prepareData_:GetTeamDataList())) do
		self.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_1.index, false)

		if iter_41_1.attributeData.level < #iter_41_1.attributeData.expTable then
			local var_41_2 = var_41_1[iter_41_1.chessId]

			if var_41_1[iter_41_1.chessId] then
				table.insert(var_41_2, iter_41_1.index)
			else
				var_41_2 = {
					iter_41_1.index
				}
			end

			var_41_1[iter_41_1.chessId] = var_41_2

			table.insert(var_41_0, iter_41_1.chessId)
		end
	end

	local var_41_3, var_41_4, var_41_5 = self.prepareData_:GetChessGoodDataList()

	for iter_41_2, iter_41_3 in pairs(var_41_3) do
		if table.indexof(var_41_0, iter_41_3.chessId) then
			self.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_3.index, true, AutoChessConst.SHOP_TYPE.NORMAL)

			for iter_41_4, iter_41_5 in ipairs(var_41_1[iter_41_3.chessId]) do
				self.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_5, true)
			end
		else
			self.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_3.index, false, AutoChessConst.SHOP_TYPE.NORMAL)
		end
	end

	for iter_41_6, iter_41_7 in pairs(var_41_4) do
		if table.indexof(var_41_0, iter_41_7.chessId) then
			self.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_7.index, true, AutoChessConst.SHOP_TYPE.REWARD)

			for iter_41_8, iter_41_9 in ipairs(var_41_1[iter_41_7.chessId]) do
				self.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_9, true)
			end
		else
			self.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_7.index, false, AutoChessConst.SHOP_TYPE.REWARD)
		end
	end
end

function AutoChessPrepareView:GetShopItemByUniqueId(arg_42_1)
	return self.autoChessShopItemView_:GetShopItemByUniqueId(arg_42_1)
end

function AutoChessPrepareView:UpdateTeamInfo()
	self.autoChessFormationItemView_:SetGameType(self.gameType_)
	self.autoChessFormationItemView_:UpdatePrepareTeamInfo((AutoChessData:GetPrepareData(self.gameType_):GetTeamDataList()))

	for iter_43_0, iter_43_1 in pairs((self.autoChessFormationItemView_:GetChessItemList())) do
		if iter_43_1.chessItemData_.uniqueId and not self.addedChessList_[iter_43_1.chessItemData_.uniqueId] then
			iter_43_1:ShowGradeEffect()

			self.addedChessList_[iter_43_1.chessItemData_.uniqueId] = true
		end
	end

	self:RefreshShopChessLvAnim()
	AutoChessData:SetIsInChangeTeam(false)
end

function AutoChessPrepareView:UpdateUserInfo()
	self.playerData_ = self.prepareData_:GetPlayerData()

	self.playerInfoView_:SetGameType(self.gameType_)
	self.playerInfoView_:SetData(self.playerData_)
end

function AutoChessPrepareView:UpdateRoundInfo()
	local var_45_0 = self.prepareData_:GetAttributeList()

	if self.currencyNum_ and self.currencyNum_ > var_45_0[AutoChessConst.ATTR_KEY.NOW_MONEY] then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_coin", "")
	end

	self.currencyNum_ = var_45_0[AutoChessConst.ATTR_KEY.NOW_MONEY]
	self.currencyText_.text = self.currencyNum_
	self.isFreeProp_ = var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT] > 0
	self.isFreeChess_ = var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_CHESS_COUNT] > 0

	self.autoChessShopItemView_:SetRefreshCost(var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_REFRESH_COUNT] > 0 and 0 or var_45_0[AutoChessConst.ATTR_KEY.REFRESH_SHOP_COST], self.currencyNum_, self.isBossBattle_)
end

function AutoChessPrepareView:UpdateDragPos()
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	local var_46_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_46_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_46_2, var_46_3 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.itemParentTrs_, var_46_0, var_46_1, {})

	self.dragRoleGo_.transform.localPosition = var_46_3

	if self.targetIndex_ ~= 0 and not manager.guide:IsPlaying() then
		local var_46_4 = self.autoChessFormationItemView_:GetPosItem(self.targetIndex_)

		if var_46_4 and not UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(var_46_4.gameObject_:GetComponent(typeof(UnityEngine.RectTransform)), var_46_0, var_46_1) then
			self:OnPointerExit()
		end
	end
end

function AutoChessPrepareView:SetDragGoActive(arg_47_1)
	self.isBeginDrag_ = arg_47_1

	SetActive(self.dragRoleGo_, arg_47_1)

	if arg_47_1 then
		self.dragRoleImg_.sprite = self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP and AutoChessTools.GetPropIcon(AutoChessItemCfg[self.pointerChessData_.chessId].icon) or AutoChessTools.GetChessBody(self.pointerChessData_.chessId)
	end
end

function AutoChessPrepareView:OnBeginDrag(arg_48_1)
	if self.isBeginDrag_ or AutoChessData:GetIsInPrepareEnd() or AutoChessData:GetIsInChangeTeam() or AutoChessData:GetIsInBuyChess() or self.isInPop_ then
		return
	end

	if self.isBossBattle_ then
		ShowTips("AUTO_CHESS_BOSS_BUY_TIPS")

		return
	end

	self.pointerChessData_ = arg_48_1

	self:SetDragGoActive(true)
	self:UpdateDragPos()
	AutoChessData:SetPointChessData(arg_48_1)

	self.lastEnterIndex_ = 0

	self.showDetailController_:SetSelectedState("off")
	self:ResetShopSelectItem()

	if arg_48_1.shopType == nil then
		self.lastEnterIndex_ = arg_48_1.index

		AutoChessData:RemoveChess(arg_48_1.uniqueId)
		self.autoChessFormationItemView_:ClearPosData(arg_48_1)
		self.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		self.autoChessFormationItemView_:ClickChessItemFunc(arg_48_1)
		self.propUseController_:SetSelectedState("hide")

		if AutoChessCfg[arg_48_1.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
			self.autoChessShopItemView_:SetStatus(0)
		else
			self.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_48_1.chessId], arg_48_1.attributeData.level)
			self.autoChessShopItemView_:SetStatus(1)
		end

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	elseif arg_48_1.shopType == AutoChessConst.SHOP_TYPE.PROP then
		local var_48_0 = AutoChessTools.IsTargetProp(arg_48_1.chessId)

		if var_48_0 then
			self.autoChessFormationItemView_:BeginPropDragFunc(arg_48_1)
		elseif self:CheckUseShopProp(arg_48_1) then
			self.propUseController_:SetSelectedState(var_48_0 and "hide" or "normal")
		else
			self.propUseController_:SetSelectedState("null")
		end

		self:ChangeCurrency(arg_48_1)
		self.autoChessShopItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop01", "")
	elseif arg_48_1.shopType == AutoChessConst.SHOP_TYPE.REWARD then
		self.autoChessShopItemView_:SetDeleteStatus(arg_48_1.index, true)

		if self.gameType_ == AutoChessConst.GAME_TYPE.ONLINE or self.gameType_ == AutoChessConst.GAME_TYPE.PVP_5_0 then
			self.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_48_1.chessId], arg_48_1.attributeData.level)
			self.autoChessShopItemView_:SetStatus(1)
		end

		self.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	else
		self.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		self:ChangeCurrency(arg_48_1)
		self.autoChessShopItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	end
end

function AutoChessPrepareView:OnDrag()
	self:UpdateDragPos()
end

function AutoChessPrepareView:OnEndDrag()
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	self:SetDragGoActive(false)

	if self.enterIndex_ then
		self.autoChessFormationItemView_:RefreshEnterStatus(self.enterIndex_, false)
	end

	if self.pointerChessData_ then
		if self:GuideCheck() then
			return
		end

		if self.targetIndex_ ~= 0 and self:CheckIsCanPlace(self.targetIndex_) then
			if self.pointerChessData_.shopType ~= nil then
				if self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
					if not self:CheckUseShopProp(self.pointerChessData_, AutoChessData:GetPlayerData(self.gameType_):GetChessDataByIndex(self.targetIndex_)) then
						ShowTips("AUTO_CHESS_INVALID_OBJECT")
						self:CancelDrag()
					else
						AutoChessTools.BuyChess(self.gameType_, self.pointerChessData_, self.targetIndex_)
						manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop02", "")
					end
				else
					AutoChessTools.BuyChess(self.gameType_, self.pointerChessData_, self.targetIndex_)
					manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess02", "")
				end
			elseif self.isCanMerge_ then
				self.autoChessFormationItemView_:MergeChessItem(self.pointerChessData_, self.targetIndex_)
				self.autoChessShopItemView_:ClearChess(self.pointerChessData_)
			elseif self.pointerChessData_.shopType == nil then
				self.autoChessFormationItemView_:SetItemToTargetIndex(self.pointerChessData_, self.targetIndex_)
			end

			self.targetIndex_ = 0
			self.isCanMerge_ = false
		elseif self.isCanSell_ then
			if self.isBossBattle_ then
				return
			end

			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_sell", "")
			AutoChessTools.SellChess(self.gameType_, self.pointerChessData_.uniqueId)
			self:RefreshShopChessLvAnim()
			self.autoChessShopItemView_:ResetSellState()

			self.isCanSell_ = false

			self.currencyPanelController_:SetSelectedState("change")

			self.currencyText_.text = AutoChessTools.GetAttrValue(self.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)

			self.currencyAnim_:Play("currencyPanel", 0, 0)
		elseif self.isEnterNotTargetPropArea_ then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop02", "")

			if not self:CheckUseShopProp(self.pointerChessData_) then
				ShowTips("AUTO_CHESS_INVALID_GLOBAL_OBJECT")
				self:CancelDrag()
			else
				AutoChessTools.BuyChess(self.gameType_, self.pointerChessData_, 0)
			end
		elseif self.lastEnterIndex_ ~= 0 and self.pointerChessData_.shopType == nil then
			self.autoChessFormationItemView_:SetItemToTargetIndex(self.pointerChessData_, self.lastEnterIndex_)
		else
			self:CancelDrag()
		end
	end

	self:EndDragResetFunc()
end

function AutoChessPrepareView:EndDragResetFunc()
	self.autoChessFormationItemView_:EndDragFunc()
	self.autoChessShopItemView_:SetStatus(0)
	self.propUseController_:SetSelectedState("hide")

	self.isEnterNotTargetPropArea_ = false

	self:ResetCurrencyState()
	self:CancelDragTips()

	self.pointerChessData_ = nil

	AutoChessData:SetPointChessData(nil)
	self.autoChessFormationItemView_:ClickChessItemFunc()
end

function AutoChessPrepareView:OnPointerClick(arg_52_1, arg_52_2)
	if self.isBeginDrag_ then
		return
	end

	if self.isInPop_ then
		if arg_52_1 and arg_52_1.chessId then
			self:OnClickChessInPop(arg_52_1, arg_52_2)
		else
			SetActive(self.tipsMask_.gameObject, false)
			self.tipsPanelView_:SetActive(false)
		end

		return
	end

	self.clickChessItemData_ = arg_52_1

	if arg_52_1 and arg_52_1.chessId then
		SetActive(self.tipsMask_.gameObject, true)
		self.showDetailController_:SetSelectedState("off")
		self.tipsPanelView_:ResetPos()
		self.tipsPanelView_:SetPivot(0, 0)
		self.tipsPanelView_:SetData(arg_52_1)
		self.tipsPanelView_:SetGoldState(true)

		if arg_52_1.shopType ~= nil then
			self.autoChessShopItemView_:SetStatus(0)
			self.autoChessFormationItemView_:ClickChessItemFunc()

			if arg_52_1.shopType == AutoChessConst.SHOP_TYPE.PROP then
				if AutoChessTools.IsTargetProp(arg_52_1.chessId) then
					self.propUseController_:SetSelectedState("hide")
					self.autoChessFormationItemView_:ClickPropItemFunc(arg_52_1)
				elseif self:CheckUseShopProp(arg_52_1) then
					self.propUseController_:SetSelectedState("normal")
				else
					self.propUseController_:SetSelectedState("null")
				end
			else
				self.propUseController_:SetSelectedState("hide")
				self.autoChessFormationItemView_:ClickShopItemFunc(arg_52_1)
			end

			self.autoChessShopItemView_:PointerClickFunc(arg_52_1)
			self:ChangeCurrency(arg_52_1)
		else
			self.propUseController_:SetSelectedState("hide")

			if AutoChessTools.IsPlayerChess(arg_52_1.chessId) then
				self.autoChessShopItemView_:SetStatus(0)
			else
				self.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_52_1.chessId], arg_52_1.attributeData.level)
				self.autoChessShopItemView_:SetStatus(self.isBossBattle_ and 0 or 1)
			end

			self.autoChessFormationItemView_:ClickChessItemFunc(arg_52_1)
			self.autoChessShopItemView_:ResetShopItem()
		end
	else
		self:ResetShopSelectItem()
	end
end

function AutoChessPrepareView:OnClickChessInPop(arg_53_1, arg_53_2)
	SetActive(self.tipsMask_.gameObject, true)
	self.showDetailController_:SetSelectedState("off")

	if arg_53_1.shopType == nil then
		self.tipsPanelView_:SetPivot(0, 1)
	else
		self.tipsPanelView_:SetPivot(0, 0)
	end

	self.tipsPanelView_:SetData(arg_53_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPos((arg_53_2:GetPos()))

	if arg_53_1.shopType == nil then
		AutoChessTools.ScreenAdapter(arg_53_2, self.tipsPanelView_)
	else
		AutoChessTools.ScreenAdapter(arg_53_2, self.tipsPanelView_, true)
	end
end

function AutoChessPrepareView:OnBuyChessBack(arg_54_1, arg_54_2)
	if arg_54_1.shopType == AutoChessConst.SHOP_TYPE.REWARD then
		self.autoChessShopItemView_:RefreshRewardAreaActive(false)
	end

	self.autoChessShopItemView_:ClearChess(arg_54_1)
	self.autoChessShopItemView_:ResetShopItem()
	self.currencyPanelController_:SetSelectedState("change")

	self.currencyText_.text = AutoChessTools.GetAttrValue(self.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)

	self.currencyAnim_:Play("currencyPanel", 0, 0)
	self.autoChessFormationItemView_:PlayMerge(arg_54_2, arg_54_1)
	AutoChessData:SetIsInBuyChess(false)
end

function AutoChessPrepareView:ChangeCurrency(arg_55_1, arg_55_2)
	local var_55_0 = AutoChessTools.GetAttrValue(self.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)

	if arg_55_1.shopType == nil then
		if not AutoChessTools.IsPlayerChess(arg_55_1.chessId) then
			self.currencyPanelController_:SetSelectedState("preview")

			self.currencyText_.text = var_55_0 .. "  <color=#FF000B>(+" .. AutoChessCfg[arg_55_1.chessId].sell_price[arg_55_1.attributeData.level] .. ")</color>"
		else
			self.currencyPanelController_:SetSelectedState("normal")

			self.currencyText_.text = var_55_0
		end
	else
		local var_55_1 = 0

		var_55_1 = arg_55_1.shopType == AutoChessConst.SHOP_TYPE.PROP and (self.isFreeProp_ and 0 or AutoChessItemCfg[arg_55_1.chessId].shop_price) or arg_55_1.shopType == AutoChessConst.SHOP_TYPE.REWARD and (arg_55_2 and AutoChessCfg[arg_55_1.chessId].sell_price[arg_55_1.attributeData.level] or 0) or self.isFreeChess_ and 0 or AutoChessCfg[arg_55_1.chessId].shop_price

		local var_55_2

		if arg_55_2 then
			var_55_2 = "  <color=#FF000B>(+" .. var_55_1 .. ")</color>" or "  <color=#FF000B>(-" .. var_55_1 .. ")</color>"
		end

		self.currencyPanelController_:SetSelectedState("preview")

		self.currencyText_.text = var_55_0 .. var_55_2
	end
end

function AutoChessPrepareView:OnPointerEnter(arg_56_1, arg_56_2)
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	self.targetIndex_ = arg_56_1.index or 0

	if arg_56_1.uniqueId ~= nil and self:CheckMerge(arg_56_1) then
		arg_56_2:playLvPointAnim(self.pointerChessData_, true)
	end

	if self.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP and arg_56_1.uniqueId ~= nil and not self:CheckMerge(arg_56_1) and not self.autoChessFormationItemView_:GetIsMoving() and not self.autoChessFormationItemView_:CheckIndexIsEmpty(self.targetIndex_) then
		self.autoChessFormationItemView_:ChangeItemPos(arg_56_1, self.pointerChessData_, self.lastEnterIndex_)
	end

	if self:CheckIsCanPlace(self.targetIndex_) then
		self.lastEnterIndex_ = self.targetIndex_ or self.lastEnterIndex_
	end

	if self:CheckIsCanPlace(self.targetIndex_) then
		if self.enterIndex_ then
			self.autoChessFormationItemView_:RefreshEnterStatus(self.enterIndex_, false)
		end

		self.enterIndex_ = self.targetIndex_

		self.autoChessFormationItemView_:RefreshEnterStatus(self.enterIndex_, true)
	end
end

function AutoChessPrepareView:OnPointerExit(arg_57_1, arg_57_2)
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	if self.enterIndex_ then
		self.autoChessFormationItemView_:RefreshEnterStatus(self.enterIndex_, false)
	end

	if arg_57_2 and self.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP then
		arg_57_2:playLvPointAnim(self.pointerChessData_, false)
	end

	self.targetIndex_ = 0
	self.isCanMerge_ = false
end

function AutoChessPrepareView:PropPointerEnter()
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	if self.pointerChessData_ then
		if self:CheckUseShopProp(self.pointerChessData_) then
			self.isEnterNotTargetPropArea_ = true

			self.propUseController_:SetSelectedState("active")
		else
			self.isEnterNotTargetPropArea_ = false

			self.propUseController_:SetSelectedState("null")
		end
	end
end

function AutoChessPrepareView:PropPointerExit()
	if not self.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	self.isEnterNotTargetPropArea_ = false

	if self:CheckUseShopProp(self.pointerChessData_) then
		self.propUseController_:SetSelectedState("normal")
	else
		self.propUseController_:SetSelectedState("null")
	end
end

function AutoChessPrepareView:CancelDrag()
	self.autoChessShopItemView_:ResetShopItem()
	self:ResetCurrencyState()
end

function AutoChessPrepareView:CancelDragTips()
	if self.pointerChessData_ then
		if self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP and self.autoChessFormationItemView_:CheckIndexIsPalyer(self.targetIndex_) and AutoChessItemCfg[self.pointerChessData_.chessId].relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER then
			ShowTips("AUTO_CHESS_INVALID_OBJECT")
		end

		if self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.NORMAL or self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.REWARD then
			if not self.autoChessFormationItemView_:CheckIndexIsEmpty(self.targetIndex_) and not self:CheckMerge(self.prepareData_:GetTeamDataList()[self.targetIndex_]) then
				ShowTips("AUTO_CHESS_NO_VACANCY")
			end
		end
	end
end

function AutoChessPrepareView:GuideCheck()
	if manager.guide:IsPlaying() and self.guideTargetIndex_ and self.guideTargetIndex_ ~= 0 then
		if self.guideTargetIndex_ == -1 and self.isEnterNotTargetPropArea_ then
			self.isGuideDragComplete_ = true

			return false
		end

		if self.targetIndex_ == self.guideTargetIndex_ or self.pointerChessData_.shopType == nil and self.lastEnterIndex_ == self.guideTargetIndex_ then
			self.isGuideDragComplete_ = true

			return false
		else
			self.isGuideDragComplete_ = false

			if self.lastEnterIndex_ ~= 0 and self.pointerChessData_.shopType == nil then
				self.autoChessFormationItemView_:SetItemToTargetIndex(self.pointerChessData_, self.lastEnterIndex_)
				self:EndDragResetFunc()
			end

			self:CancelDrag()

			return true
		end
	end
end

function AutoChessPrepareView:CheckMerge(arg_63_1)
	if self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		self.isCanMerge_ = false

		return
	end

	self.isCanMerge_ = arg_63_1.attributeData and not self.pointerChessData_.attributeData.isMaxLevel and not arg_63_1.attributeData.isMaxLevel and self.pointerChessData_.chessId == arg_63_1.chessId

	return self.isCanMerge_
end

function AutoChessPrepareView:CheckIsCanPlace(arg_64_1)
	local var_64_0 = self.autoChessFormationItemView_:CheckIndexIsEmpty(arg_64_1)

	if self.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		if self.autoChessFormationItemView_:CheckIndexIsPalyer(arg_64_1) and AutoChessItemCfg[self.pointerChessData_.chessId].relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER then
			return false
		end

		if not self:CheckUseShopProp(self.pointerChessData_, AutoChessData:GetPlayerData(self.gameType_):GetChessDataByIndex(arg_64_1)) then
			return false
		end

		return not var_64_0 and AutoChessTools.IsTargetProp(self.pointerChessData_.chessId)
	else
		return var_64_0 or self.isCanMerge_
	end
end

function AutoChessPrepareView:CheckUseShopProp(arg_65_1, arg_65_2)
	return AutoChessTools.CheckUseProp(arg_65_1.chessId, self.gameType_, arg_65_2)
end

function AutoChessPrepareView:ResetCurrencyState()
	self.currencyPanelController_:SetSelectedState("normal")

	self.currencyText_.text = AutoChessTools.GetAttrValue(self.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)
end

function AutoChessPrepareView:ResetShopSelectItem()
	self.autoChessShopItemView_:ResetShopItem()
	self:ResetCurrencyState()
	self.autoChessFormationItemView_:EndDragFunc()
	self.propUseController_:SetSelectedState("hide")
	self.autoChessShopItemView_:SetStatus(0)
	SetActive(self.tipsMask_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
	self.autoChessFormationItemView_:ClickChessItemFunc()
end

function AutoChessPrepareView:GetIsBeginDrag()
	return self.isBeginDrag_
end

function AutoChessPrepareView:GetPointerChessData()
	return self.pointerChessData_
end

function AutoChessPrepareView:GetClickChessItemData()
	return self.clickChessItemData_
end

function AutoChessPrepareView:GetGameType()
	return self.gameType_
end

function AutoChessPrepareView:SetSellState(arg_72_1)
	self.isCanSell_ = arg_72_1
end

function AutoChessPrepareView:SetMergeState(arg_73_1)
	self.isCanMerge_ = arg_73_1
end

function AutoChessPrepareView:GetChessItemByUniqueId(arg_74_1)
	local var_74_0 = self.autoChessFormationItemView_:GetChessItemByUniqueId(arg_74_1)

	if var_74_0 then
		return var_74_0
	else
		Debug.Log("AutoChessPrepareView:GetChessItemByUniqueId: 没有找到uniqueId为" .. arg_74_1 .. "的棋子")
	end
end

function AutoChessPrepareView:RemoveChessItemByUniqueId(arg_75_1)
	self.autoChessFormationItemView_:RemoveChessItemByUniqueId(arg_75_1)
end

function AutoChessPrepareView:GetChessItemByTargetIndex(arg_76_1)
	return self.autoChessFormationItemView_:GetChessItem(arg_76_1)
end

function AutoChessPrepareView:SetGuideTargetIndex(arg_77_1)
	self.guideTargetIndex_ = arg_77_1
end

function AutoChessPrepareView:CheckGuideDragIsComplete()
	if self.isGuideDragComplete_ then
		self.guideTargetIndex_ = 0
		self.isGuideDragComplete_ = false
	end

	return self.isGuideDragComplete_
end

function AutoChessPrepareView:PlayPropAnimator(arg_79_1)
	self.propImg_.sprite = AutoChessTools.GetPropIcon(arg_79_1)

	self.propAnim_:Play("Props", -1, 0)
	self.propAnim_:Update(0)
	Timer.New(function()
		AutoChessData:SetIsInUseProp(false)
	end, 1, 1):Start()
end

return AutoChessPrepareView
