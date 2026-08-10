local var_0_0 = class("AutoChessPrepareView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_FightReadyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.context_ = {
		curVictoryRoundCount = 0,
		lastHP = 0,
		curRound = 0,
		maxVictoryRoundCount = 0
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()

	arg_4_0.autoChessFormationItemView_ = AutoChessFormationItemView.New(arg_4_0.formationItem_)

	local var_4_0 = arg_4_0.autoChessFormationItemView_:GetChessItemList()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		iter_4_1:RegisterEvent("PointerClick", handler(arg_4_0, arg_4_0.OnPointerClick))
		iter_4_1:RegisterEvent("BeginDrag", handler(arg_4_0, arg_4_0.OnBeginDrag))
		iter_4_1:RegisterEvent("Drag", handler(arg_4_0, arg_4_0.OnDrag))
		iter_4_1:RegisterEvent("EndDrag", handler(arg_4_0, arg_4_0.OnEndDrag))
		iter_4_1:RegisterEvent("PointerEnter", handler(arg_4_0, arg_4_0.OnPointerEnter))
		iter_4_1:RegisterEvent("PointerExit", handler(arg_4_0, arg_4_0.OnPointerExit))
	end

	arg_4_0.autoChessShopItemView_ = AutoChessShopItemView.New(arg_4_0.shopItem_, arg_4_0)
	arg_4_0.playerInfoView_ = AutoChessPlayerInfoView.New(arg_4_0.playerInfoGo_)
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)
	arg_4_0.updateHandler_ = handler(arg_4_0, arg_4_0.Update)
	arg_4_0.updateRoundHandler_ = handler(arg_4_0, arg_4_0.UpdateRoundInfo)
	arg_4_0.updateShopHandler_ = handler(arg_4_0, arg_4_0.UpdateShopInfo)
	arg_4_0.updateLockShopAnimHandler_ = handler(arg_4_0, arg_4_0.UpdateLockShopAnim)
	arg_4_0.updateRemoveShopAnimHandler_ = handler(arg_4_0, arg_4_0.UpdateRemoveShopAnim)
	arg_4_0.refreshShopAnimHandler_ = handler(arg_4_0, arg_4_0.RefreshShopAnim)
	arg_4_0.updateFormationHandler_ = handler(arg_4_0, arg_4_0.UpdateTeamInfo)
	arg_4_0.tipsPanelCloseHandler_ = handler(arg_4_0, arg_4_0.OnTipsPanelClose)
	arg_4_0.buyChessBackHandler_ = handler(arg_4_0, arg_4_0.OnBuyChessBack)
	arg_4_0.updateBtnHandler_ = handler(arg_4_0, arg_4_0.UpdateBtnStatus)
	arg_4_0.propUseController_ = arg_4_0.controllerEx_:GetController("UseArea")
	arg_4_0.shopLevelController_ = arg_4_0.controllerEx_:GetController("shopLv")
	arg_4_0.showDistortionController_ = arg_4_0.controllerEx_:GetController("distortion")
	arg_4_0.showDetailController_ = arg_4_0.controllerEx_:GetController("detalsPanel")
	arg_4_0.showEnemyInfoController_ = arg_4_0.controllerEx_:GetController("FormationBtn")
	arg_4_0.currencyPanelController_ = arg_4_0.controllerEx_:GetController("currencyPanel")
	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.lineShopController_ = arg_4_0.controllerEx_:GetController("line")
	arg_4_0.bossTipsController_ = arg_4_0.controllerEx_:GetController("BossTips")
	arg_4_0.showReplayController_ = arg_4_0.replayController_:GetController("default0")
	arg_4_0.isExpandDistortion_ = false
	arg_4_0.addedChessList_ = {}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.PropPointerEnter)))
	arg_5_0.propEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.PropPointerExit)))
	arg_5_0:AddBtnListener(arg_5_0.tipsMask_, nil, function()
		arg_5_0:ResetShopSelectItem()
	end)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		if arg_5_0.isBossBattle_ and arg_5_0.autoChessFormationItemView_:GetChessNum() < GameSetting.auto_chess_prepare_grid_num.value[1] then
			ShowTips("AUTO_CHESS_BOSS_BUY_TIPS")

			return
		end

		arg_5_0.showDetailController_:SetSelectedState("off")

		local var_7_0 = arg_5_0.prepareData_:GetAttributeList()
		local var_7_1 = getData("auto_chess_pop", "skip_" .. arg_5_0.gameType_) or false

		if not AutoChessData:GetIsInPrepareEnd() then
			if var_7_0[AutoChessConst.ATTR_KEY.NOW_MONEY] <= 0 or var_7_1 then
				AutoChessTools.PrepareEnd(arg_5_0.gameType_)
			else
				JumpTools.OpenPageByJump("autoChessQuitPopView", {
					gameType = arg_5_0.gameType_,
					type = AutoChessConst.POP_TYPE.REMAIN_MONEY,
					okCb = function()
						AutoChessTools.PrepareEnd(arg_5_0.gameType_)
					end
				})
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnLookEnemy_, nil, function()
		arg_5_0.showDetailController_:SetSelectedState("off")

		local var_9_0 = arg_5_0.stageCfg_.group_id

		AutoChessAction.LookEnemyInfo(var_9_0, AutoChessTools.GetCurRound(arg_5_0.gameType_))
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_combat_team_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_5_0.playerData_.battleUID
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnDetail_, nil, function()
		if AutoChessTools.GetCurRound(arg_5_0.gameType_) == 1 then
			arg_5_0.showReplayController_:SetSelectedState("disabled")
		else
			arg_5_0.showReplayController_:SetSelectedState("enabled")
		end

		arg_5_0.showDetailController_:SetSelectedState("on")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0.showDetailController_:SetSelectedState("off")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBook_, nil, function()
		JumpTools.OpenPageByJump("/autoChessIllustratedWindow", {
			isInGame = true
		})
		OperationRecorder.RecordButtonTouch({
			source = 3,
			button_name = "activity_autochess_illustration_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.distortionBtn_, nil, function()
		local var_13_0 = AutoChessBuffCfg[arg_5_0.stageCfg_.scene_buff[1]]

		if arg_5_0.isExpandDistortion_ then
			arg_5_0.distortionAnim_:Play("collapse")

			arg_5_0.distortionText_.text = var_13_0.name
			arg_5_0.isExpandDistortion_ = false
		else
			arg_5_0.distortionAnim_:Play("expand")

			arg_5_0.distortionText_.text = var_13_0.desc
			arg_5_0.isExpandDistortion_ = true
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnReply_, nil, function()
		AutoChessAction.LookReplay(arg_5_0.gameType_)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_video_touch",
			activity_id = AutoChessData:GetActivityID(),
			polyhedron_id_str = arg_5_0.playerData_.battleUID
		})
	end)
end

function var_0_0.OnEnter(arg_15_0)
	AutoChessBattleRenderer.GetInstance():SetPrepareView(arg_15_0)
	arg_15_0.bossTipsController_:SetSelectedState("hide")
	arg_15_0.viewAnim_:Play("UI_Enter_cx")

	arg_15_0.isExit_ = false
	arg_15_0.gameType_ = arg_15_0.params_.gameType
	arg_15_0.targetIndex_ = 0
	arg_15_0.lastEnterIndex_ = 0
	arg_15_0.pointerChessData_ = nil
	arg_15_0.isCanMerge_ = false
	arg_15_0.isCanSell_ = false
	arg_15_0.isEnterNotTargetPropArea_ = false
	arg_15_0.isInPop_ = false

	manager.notify:RegistListener(AUTO_CHESS_UPDATE, arg_15_0.updateHandler_)
	manager.notify:RegistListener(AUTO_CHESS_ROUND_UPDATE, arg_15_0.updateRoundHandler_)
	manager.notify:RegistListener(AUTO_CHESS_LOCK_SHOP_SHOW, arg_15_0.updateLockShopAnimHandler_)
	manager.notify:RegistListener(AUTO_CHESS_REFRESH_SHOP_SHOW, arg_15_0.refreshShopAnimHandler_)
	manager.notify:RegistListener(AUTO_CHESS_SHOP_UPDATE, arg_15_0.updateShopHandler_)
	manager.notify:RegistListener(AUTO_CHESS_FORMATION_UPDATE, arg_15_0.updateFormationHandler_)
	manager.notify:RegistListener(AUTO_CHESS_SHOP_BUY_CHESS, arg_15_0.buyChessBackHandler_)
	manager.notify:RegistListener(AUTO_CHESS_IS_IN_SKILL_POP, arg_15_0.updateBtnHandler_)
	arg_15_0:Update()
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if manager.guide:IsPlaying() then
			return
		end

		if arg_16_0.stageId_ and table.indexof(AutoChessConst.TEACH_STAGE, arg_16_0.stageId_) then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = arg_16_0.gameType_,
				type = AutoChessConst.POP_TYPE.TEACHING,
				okCb = function()
					AutoChessData:SetStageStoryId(arg_16_0.stageCfg_.post_story)
					AutoChessTools.CancelGame(arg_16_0.gameType_)
				end
			})
		else
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = arg_16_0.gameType_,
				type = AutoChessConst.POP_TYPE.PVE,
				okCb = function()
					AutoChessTools.QuitGame(arg_16_0.gameType_)
					AutoChessAction.SetGamePause(arg_16_0.gameType_, AutoChessConst.GAME_PAUSE_TYPE.PAUSE)
				end
			})
		end
	end)

	local var_16_0 = ""

	if arg_16_0.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		var_16_0 = "auto_chess_PVE_desc"
	elseif AutoChessTools.GetIsPVPGame(arg_16_0.gameType_) then
		var_16_0 = "auto_chess_2_async_desc"
	elseif arg_16_0.gameType_ == AutoChessConst.GAME_TYPE.ONLINE then
		var_16_0 = "auto_chess_2_sync_desc"
	end

	local var_16_1 = GameSetting[var_16_0].value

	if #var_16_1 > 0 then
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

function var_0_0.OnExit(arg_20_0)
	arg_20_0.isExit_ = true
	arg_20_0.addedChessList_ = {}

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(AUTO_CHESS_UPDATE, arg_20_0.updateHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_ROUND_UPDATE, arg_20_0.updateRoundHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_SHOP_UPDATE, arg_20_0.updateShopHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_FORMATION_UPDATE, arg_20_0.updateFormationHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_LOCK_SHOP_SHOW, arg_20_0.updateLockShopAnimHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_REFRESH_SHOP_SHOW, arg_20_0.refreshShopAnimHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_SHOP_BUY_CHESS, arg_20_0.buyChessBackHandler_)
	manager.notify:RemoveListener(AUTO_CHESS_IS_IN_SKILL_POP, arg_20_0.updateBtnHandler_)

	arg_20_0.isExpandDistortion_ = false

	arg_20_0:SetDragGoActive(false)
	AnimatorTools.Stop()
	arg_20_0.showDetailController_:SetSelectedState("off")
	arg_20_0.autoChessShopItemView_:ResetShopItem()
	arg_20_0.currencyPanelController_:SetSelectedState("normal")
	arg_20_0.autoChessFormationItemView_:EndDragFunc()
	arg_20_0.autoChessFormationItemView_:OnExit()
	arg_20_0.propUseController_:SetSelectedState("hide")
	arg_20_0.autoChessShopItemView_:SetStatus(0)
	SetActive(arg_20_0.tipsMask_.gameObject, false)
	arg_20_0.tipsPanelView_:SetActive(false)
	arg_20_0.bossTipsController_:SetSelectedState("hide")

	if arg_20_0.enterIndex_ then
		arg_20_0.autoChessFormationItemView_:RefreshEnterStatus(arg_20_0.enterIndex_, false)

		arg_20_0.enterIndex_ = nil
	end
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.autoChessShopItemView_:Dispose()
	arg_21_0.autoChessFormationItemView_:Dispose()
	arg_21_0.playerInfoView_:Dispose()
	arg_21_0.tipsPanelView_:Dispose()
	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.Update(arg_22_0)
	if arg_22_0.params_.isBattleBack then
		arg_22_0.params_.isBattleBack = false

		return
	end

	arg_22_0.prepareData_ = AutoChessData:GetPrepareData(arg_22_0.gameType_)
	arg_22_0.stageId_ = AutoChessTools.GetCurStageId(arg_22_0.gameType_)
	arg_22_0.stageCfg_ = AutoChessStageCfg[arg_22_0.stageId_]
	arg_22_0.isTeaching_ = arg_22_0.stageId_ and table.indexof(AutoChessConst.TEACH_STAGE, arg_22_0.stageId_) and AutoChessTools.GetCurRound(arg_22_0.gameType_) <= AutoChessConst.TEACH_ROUND_NUM

	arg_22_0:CheckEnterPopView()
	arg_22_0:RefreshStageInfo()
	arg_22_0:RefreshLookEnemyBtn()
end

function var_0_0.RefreshLookEnemyBtn(arg_23_0)
	if arg_23_0.gameType_ == AutoChessConst.GAME_TYPE.PVE and not arg_23_0.isInPop_ then
		arg_23_0.showEnemyInfoController_:SetSelectedState("active")
	else
		arg_23_0.showEnemyInfoController_:SetSelectedState("inactive")
	end
end

function var_0_0.CheckEnterPopView(arg_24_0)
	local var_24_0 = AutoChessData:GetLastShopLevel(arg_24_0.gameType_)
	local var_24_1 = AutoChessData:GetNowShopLevel(arg_24_0.gameType_)
	local var_24_2 = var_24_0 and var_24_0 ~= var_24_1
	local var_24_3 = arg_24_0.prepareData_:GetHeroUpgradeInfo()
	local var_24_4 = var_24_3.oldLevel and var_24_3.oldLevel ~= 0 and var_24_3.newLevel and var_24_3.newLevel ~= 0 or var_24_3.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA

	if var_24_2 then
		arg_24_0:GotoShopLevelUpPopView(var_24_0, var_24_1, var_24_3, var_24_4)
	elseif var_24_4 then
		arg_24_0:GotoHeroUpgradePopView(var_24_3, var_24_4)
	else
		arg_24_0:RefreshPrepareView()
	end
end

function var_0_0.GotoHeroUpgradePopView(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:UpdateUI()

	if arg_25_1.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA then
		JumpTools.OpenPageByJump("autoChessBrahmaUpgradePop", {
			heroUpgradeInfo = arg_25_1,
			gameType = arg_25_0.gameType_
		})
	elseif arg_25_2 then
		JumpTools.OpenPageByJump("autoChessHeroUpgradePop", {
			heroUpgradeInfo = arg_25_1,
			gameType = arg_25_0.gameType_
		})
	end
end

function var_0_0.GotoShopLevelUpPopView(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local function var_26_0()
		if arg_26_4 then
			arg_26_0:GotoHeroUpgradePopView(arg_26_3, arg_26_4)
		else
			arg_26_0:RefreshPrepareView()
		end
	end

	JumpTools.OpenPageByJump("autoChessShopLevelUpPop", {
		backFunc = var_26_0,
		lastShopLevel = arg_26_1,
		nowShopLevel = arg_26_2
	})
end

function var_0_0.RefreshPrepareView(arg_28_0)
	arg_28_0:UpdateUI()
	AutoChessData:SaveLastShopLevel(arg_28_0.gameType_)
end

function var_0_0.RefreshStageInfo(arg_29_0)
	arg_29_0:RefreshBg()

	if arg_29_0.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		SetActive(arg_29_0.btnBook_.gameObject, not arg_29_0.isTeaching_)

		local var_29_0 = arg_29_0.stageCfg_.scene_buff ~= "" and #arg_29_0.stageCfg_.scene_buff > 0

		arg_29_0.showDistortionController_:SetSelectedState(var_29_0 and "show" or "hide")

		if arg_29_0.stageId_ >= GameSetting.auto_chess_item_unlock.value[1] then
			arg_29_0.lineShopController_:SetSelectedState("show")
		else
			arg_29_0.lineShopController_:SetSelectedState("hide")
		end

		if var_29_0 then
			local var_29_1 = AutoChessBuffCfg[arg_29_0.stageCfg_.scene_buff[1]]

			arg_29_0.distortionText_.text = var_29_1.name
			arg_29_0.distortionIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_OsirisHorus/Buff_icon/" .. var_29_1.icon)

			if arg_29_0.params_.isStageEnter then
				arg_29_0.bossBuffText_.text = var_29_1.desc
				arg_29_0.params_.isStageEnter = false

				arg_29_0.bossTipsController_:SetSelectedState("show")
			else
				arg_29_0.bossTipsController_:SetSelectedState("hide")
			end
		end
	else
		arg_29_0.lineShopController_:SetSelectedState("show")
		arg_29_0.showDistortionController_:SetSelectedState("hide")
		arg_29_0.bossTipsController_:SetSelectedState("hide")
	end
end

function var_0_0.RefreshBg(arg_30_0)
	local var_30_0, var_30_1, var_30_2 = AutoChessTools.GetStagBgPath(arg_30_0.stageId_)

	arg_30_0.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_30_0)
	arg_30_0.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_30_1)
	arg_30_0.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_30_2)
end

function var_0_0.UpdateUI(arg_31_0)
	arg_31_0:UpdateUserInfo()
	arg_31_0:UpdateRoundInfo()
	arg_31_0:UpdateTeamInfo()
	arg_31_0:UpdateShopInfo()
end

function var_0_0.UpdateBtnStatus(arg_32_0, arg_32_1)
	arg_32_0.isInPop_ = arg_32_1

	arg_32_0.statusController_:SetSelectedState(arg_32_1 and "hide" or "show")
	arg_32_0.autoChessShopItemView_:ChangeBtnStatus(arg_32_1 and "hide" or "refresh")

	if arg_32_1 then
		manager.windowBar:HideBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			INFO_BAR
		})
	end
end

function var_0_0.PlayExitAnim(arg_33_0, arg_33_1)
	AnimatorTools.PlayAnimationWithCallback(arg_33_0.viewAnim_, "UI_Exit_cx", function()
		arg_33_0.isExit_ = true

		if arg_33_1 then
			arg_33_1()
		end
	end, -1, 0)
	arg_33_0.viewAnim_:Update(0)
end

function var_0_0.GetIsExit(arg_35_0)
	return arg_35_0.isExit_
end

function var_0_0.UpdateShopInfo(arg_36_0)
	arg_36_0.shopLevelController_:SetSelectedIndex(AutoChessData:GetNowShopLevel(arg_36_0.gameType_) - 1)
	arg_36_0.autoChessShopItemView_:SetGameType(arg_36_0.gameType_)

	arg_36_0.isBossBattle_ = AutoChessTools.IsBossRound(arg_36_0.gameType_)

	local var_36_0, var_36_1, var_36_2 = arg_36_0.prepareData_:GetChessGoodDataList()

	arg_36_0.autoChessShopItemView_:UpdateShopInfo(var_36_0, var_36_1, var_36_2, arg_36_0.isBossBattle_, arg_36_0.isTeaching_)
	arg_36_0:RefreshShopChessLvAnim()
end

function var_0_0.UpdateLockShopAnim(arg_37_0, arg_37_1)
	arg_37_0.autoChessShopItemView_:UpdateLockShopAnim(arg_37_1)
end

function var_0_0.UpdateRemoveShopAnim(arg_38_0)
	return
end

function var_0_0.RefreshShopAnim(arg_39_0)
	arg_39_0.autoChessShopItemView_:RefreshShopAnim()
	arg_39_0:ResetShopSelectItem()
end

function var_0_0.RefreshCurrencyAnim(arg_40_0)
	arg_40_0.currencyAnim_:Play("currencyPanel", 0, 0)
end

function var_0_0.RefreshShopChessLvAnim(arg_41_0)
	local var_41_0 = arg_41_0.prepareData_:GetTeamDataList()
	local var_41_1 = {}
	local var_41_2 = {}

	for iter_41_0, iter_41_1 in pairs(var_41_0) do
		arg_41_0.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_1.index, false)

		if iter_41_1.attributeData.level < #iter_41_1.attributeData.expTable then
			local var_41_3 = var_41_2[iter_41_1.chessId]

			if var_41_3 then
				table.insert(var_41_3, iter_41_1.index)
			else
				var_41_3 = {
					iter_41_1.index
				}
			end

			var_41_2[iter_41_1.chessId] = var_41_3

			table.insert(var_41_1, iter_41_1.chessId)
		end
	end

	local var_41_4, var_41_5, var_41_6 = arg_41_0.prepareData_:GetChessGoodDataList()

	for iter_41_2, iter_41_3 in pairs(var_41_4) do
		if table.indexof(var_41_1, iter_41_3.chessId) then
			arg_41_0.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_3.index, true, AutoChessConst.SHOP_TYPE.NORMAL)

			for iter_41_4, iter_41_5 in ipairs(var_41_2[iter_41_3.chessId]) do
				arg_41_0.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_5, true)
			end
		else
			arg_41_0.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_3.index, false, AutoChessConst.SHOP_TYPE.NORMAL)
		end
	end

	for iter_41_6, iter_41_7 in pairs(var_41_5) do
		if table.indexof(var_41_1, iter_41_7.chessId) then
			arg_41_0.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_7.index, true, AutoChessConst.SHOP_TYPE.REWARD)

			for iter_41_8, iter_41_9 in ipairs(var_41_2[iter_41_7.chessId]) do
				arg_41_0.autoChessFormationItemView_:RefreshChessLvAnim(iter_41_9, true)
			end
		else
			arg_41_0.autoChessShopItemView_:RefreshShopChessLvAnim(iter_41_7.index, false, AutoChessConst.SHOP_TYPE.REWARD)
		end
	end
end

function var_0_0.GetShopItemByUniqueId(arg_42_0, arg_42_1)
	return arg_42_0.autoChessShopItemView_:GetShopItemByUniqueId(arg_42_1)
end

function var_0_0.UpdateTeamInfo(arg_43_0)
	arg_43_0.autoChessFormationItemView_:SetGameType(arg_43_0.gameType_)

	local var_43_0 = AutoChessData:GetPrepareData(arg_43_0.gameType_):GetTeamDataList()

	arg_43_0.autoChessFormationItemView_:UpdatePrepareTeamInfo(var_43_0)

	local var_43_1 = arg_43_0.autoChessFormationItemView_:GetChessItemList()

	for iter_43_0, iter_43_1 in pairs(var_43_1) do
		local var_43_2 = iter_43_1.chessItemData_.uniqueId

		if var_43_2 and not arg_43_0.addedChessList_[var_43_2] then
			iter_43_1:ShowGradeEffect()

			arg_43_0.addedChessList_[var_43_2] = true
		end
	end

	arg_43_0:RefreshShopChessLvAnim()
	AutoChessData:SetIsInChangeTeam(false)
end

function var_0_0.UpdateUserInfo(arg_44_0)
	arg_44_0.playerData_ = arg_44_0.prepareData_:GetPlayerData()

	arg_44_0.playerInfoView_:SetGameType(arg_44_0.gameType_)
	arg_44_0.playerInfoView_:SetData(arg_44_0.playerData_)
end

function var_0_0.UpdateRoundInfo(arg_45_0)
	local var_45_0 = arg_45_0.prepareData_:GetAttributeList()

	if arg_45_0.currencyNum_ and arg_45_0.currencyNum_ > var_45_0[AutoChessConst.ATTR_KEY.NOW_MONEY] then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_coin", "")
	end

	arg_45_0.currencyNum_ = var_45_0[AutoChessConst.ATTR_KEY.NOW_MONEY]
	arg_45_0.currencyText_.text = arg_45_0.currencyNum_
	arg_45_0.isFreeProp_ = var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_PROP_COUNT] > 0
	arg_45_0.isFreeChess_ = var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_CHESS_COUNT] > 0

	local var_45_1 = var_45_0[AutoChessConst.ATTR_KEY.SHOP_FREE_REFRESH_COUNT] > 0 and 0 or var_45_0[AutoChessConst.ATTR_KEY.REFRESH_SHOP_COST]

	arg_45_0.autoChessShopItemView_:SetRefreshCost(var_45_1, arg_45_0.currencyNum_, arg_45_0.isBossBattle_)
end

function var_0_0.UpdateDragPos(arg_46_0)
	if not arg_46_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	local var_46_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
	local var_46_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_46_2 = {}
	local var_46_3, var_46_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_46_0.itemParentTrs_, var_46_0, var_46_1, var_46_2)

	arg_46_0.dragRoleGo_.transform.localPosition = var_46_4

	if arg_46_0.targetIndex_ ~= 0 and not manager.guide:IsPlaying() then
		local var_46_5 = arg_46_0.autoChessFormationItemView_:GetPosItem(arg_46_0.targetIndex_)

		if var_46_5 then
			local var_46_6 = var_46_5.gameObject_:GetComponent(typeof(UnityEngine.RectTransform))

			if not UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(var_46_6, var_46_0, var_46_1) then
				arg_46_0:OnPointerExit()
			end
		end
	end
end

function var_0_0.SetDragGoActive(arg_47_0, arg_47_1)
	arg_47_0.isBeginDrag_ = arg_47_1

	SetActive(arg_47_0.dragRoleGo_, arg_47_1)

	if arg_47_1 then
		if arg_47_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			arg_47_0.dragRoleImg_.sprite = AutoChessTools.GetPropIcon(AutoChessItemCfg[arg_47_0.pointerChessData_.chessId].icon)
		else
			arg_47_0.dragRoleImg_.sprite = AutoChessTools.GetChessBody(arg_47_0.pointerChessData_.chessId)
		end
	end
end

function var_0_0.OnBeginDrag(arg_48_0, arg_48_1)
	if arg_48_0.isBeginDrag_ or AutoChessData:GetIsInPrepareEnd() or AutoChessData:GetIsInChangeTeam() or AutoChessData:GetIsInBuyChess() or arg_48_0.isInPop_ then
		return
	end

	if arg_48_0.isBossBattle_ then
		ShowTips("AUTO_CHESS_BOSS_BUY_TIPS")

		return
	end

	arg_48_0.pointerChessData_ = arg_48_1

	arg_48_0:SetDragGoActive(true)
	arg_48_0:UpdateDragPos()
	AutoChessData:SetPointChessData(arg_48_1)

	arg_48_0.lastEnterIndex_ = 0

	arg_48_0.showDetailController_:SetSelectedState("off")
	arg_48_0:ResetShopSelectItem()

	local var_48_0 = AutoChessCfg[arg_48_1.chessId].type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS

	if arg_48_1.shopType == nil then
		arg_48_0.lastEnterIndex_ = arg_48_1.index

		AutoChessData:RemoveChess(arg_48_1.uniqueId)
		arg_48_0.autoChessFormationItemView_:ClearPosData(arg_48_1)
		arg_48_0.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		arg_48_0.autoChessFormationItemView_:ClickChessItemFunc(arg_48_1)
		arg_48_0.propUseController_:SetSelectedState("hide")

		if var_48_0 then
			arg_48_0.autoChessShopItemView_:SetStatus(0)
		else
			arg_48_0.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_48_1.chessId], arg_48_1.attributeData.level)
			arg_48_0.autoChessShopItemView_:SetStatus(1)
		end

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	elseif arg_48_1.shopType == AutoChessConst.SHOP_TYPE.PROP then
		local var_48_1 = AutoChessTools.IsTargetProp(arg_48_1.chessId)

		if var_48_1 then
			arg_48_0.autoChessFormationItemView_:BeginPropDragFunc(arg_48_1)
		elseif arg_48_0:CheckUseShopProp(arg_48_1) then
			arg_48_0.propUseController_:SetSelectedState(var_48_1 and "hide" or "normal")
		else
			arg_48_0.propUseController_:SetSelectedState("null")
		end

		arg_48_0:ChangeCurrency(arg_48_1)
		arg_48_0.autoChessShopItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop01", "")
	elseif arg_48_1.shopType == AutoChessConst.SHOP_TYPE.REWARD then
		arg_48_0.autoChessShopItemView_:SetDeleteStatus(arg_48_1.index, true)

		if arg_48_0.gameType_ == AutoChessConst.GAME_TYPE.ONLINE or arg_48_0.gameType_ == AutoChessConst.GAME_TYPE.PVP_5_0 then
			arg_48_0.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_48_1.chessId], arg_48_1.attributeData.level)
			arg_48_0.autoChessShopItemView_:SetStatus(1)
		end

		arg_48_0.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	else
		arg_48_0.autoChessFormationItemView_:BeginDragFunc(arg_48_1)
		arg_48_0:ChangeCurrency(arg_48_1)
		arg_48_0.autoChessShopItemView_:BeginDragFunc(arg_48_1)
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess01", "")
	end
end

function var_0_0.OnDrag(arg_49_0)
	arg_49_0:UpdateDragPos()
end

function var_0_0.OnEndDrag(arg_50_0)
	if not arg_50_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	arg_50_0:SetDragGoActive(false)

	if arg_50_0.enterIndex_ then
		arg_50_0.autoChessFormationItemView_:RefreshEnterStatus(arg_50_0.enterIndex_, false)
	end

	if arg_50_0.pointerChessData_ then
		if arg_50_0:GuideCheck() then
			return
		end

		if arg_50_0.targetIndex_ ~= 0 and arg_50_0:CheckIsCanPlace(arg_50_0.targetIndex_) then
			if arg_50_0.pointerChessData_.shopType ~= nil then
				if arg_50_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
					if not arg_50_0:CheckUseShopProp(arg_50_0.pointerChessData_, AutoChessData:GetPlayerData(arg_50_0.gameType_):GetChessDataByIndex(arg_50_0.targetIndex_)) then
						ShowTips("AUTO_CHESS_INVALID_OBJECT")
						arg_50_0:CancelDrag()
					else
						AutoChessTools.BuyChess(arg_50_0.gameType_, arg_50_0.pointerChessData_, arg_50_0.targetIndex_)
						manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop02", "")
					end
				else
					AutoChessTools.BuyChess(arg_50_0.gameType_, arg_50_0.pointerChessData_, arg_50_0.targetIndex_)
					manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_chess02", "")
				end
			elseif arg_50_0.isCanMerge_ then
				arg_50_0.autoChessFormationItemView_:MergeChessItem(arg_50_0.pointerChessData_, arg_50_0.targetIndex_)
				arg_50_0.autoChessShopItemView_:ClearChess(arg_50_0.pointerChessData_)
			elseif arg_50_0.pointerChessData_.shopType == nil then
				arg_50_0.autoChessFormationItemView_:SetItemToTargetIndex(arg_50_0.pointerChessData_, arg_50_0.targetIndex_)
			end

			arg_50_0.targetIndex_ = 0
			arg_50_0.isCanMerge_ = false
		elseif arg_50_0.isCanSell_ then
			if arg_50_0.isBossBattle_ then
				return
			end

			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_sell", "")
			AutoChessTools.SellChess(arg_50_0.gameType_, arg_50_0.pointerChessData_.uniqueId)
			arg_50_0:RefreshShopChessLvAnim()
			arg_50_0.autoChessShopItemView_:ResetSellState()

			arg_50_0.isCanSell_ = false

			arg_50_0.currencyPanelController_:SetSelectedState("change")

			arg_50_0.currencyText_.text = AutoChessTools.GetAttrValue(arg_50_0.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)

			arg_50_0.currencyAnim_:Play("currencyPanel", 0, 0)
		elseif arg_50_0.isEnterNotTargetPropArea_ then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_prop02", "")

			if not arg_50_0:CheckUseShopProp(arg_50_0.pointerChessData_) then
				ShowTips("AUTO_CHESS_INVALID_GLOBAL_OBJECT")
				arg_50_0:CancelDrag()
			else
				AutoChessTools.BuyChess(arg_50_0.gameType_, arg_50_0.pointerChessData_, 0)
			end
		elseif arg_50_0.lastEnterIndex_ ~= 0 and arg_50_0.pointerChessData_.shopType == nil then
			arg_50_0.autoChessFormationItemView_:SetItemToTargetIndex(arg_50_0.pointerChessData_, arg_50_0.lastEnterIndex_)
		else
			arg_50_0:CancelDrag()
		end
	end

	arg_50_0:EndDragResetFunc()
end

function var_0_0.EndDragResetFunc(arg_51_0)
	arg_51_0.autoChessFormationItemView_:EndDragFunc()
	arg_51_0.autoChessShopItemView_:SetStatus(0)
	arg_51_0.propUseController_:SetSelectedState("hide")

	arg_51_0.isEnterNotTargetPropArea_ = false

	arg_51_0:ResetCurrencyState()
	arg_51_0:CancelDragTips()

	arg_51_0.pointerChessData_ = nil

	AutoChessData:SetPointChessData(nil)
	arg_51_0.autoChessFormationItemView_:ClickChessItemFunc()
end

function var_0_0.OnPointerClick(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_0.isBeginDrag_ then
		return
	end

	if arg_52_0.isInPop_ then
		if arg_52_1 and arg_52_1.chessId then
			arg_52_0:OnClickChessInPop(arg_52_1, arg_52_2)
		else
			SetActive(arg_52_0.tipsMask_.gameObject, false)
			arg_52_0.tipsPanelView_:SetActive(false)
		end

		return
	end

	arg_52_0.clickChessItemData_ = arg_52_1

	if arg_52_1 and arg_52_1.chessId then
		SetActive(arg_52_0.tipsMask_.gameObject, true)
		arg_52_0.showDetailController_:SetSelectedState("off")
		arg_52_0.tipsPanelView_:ResetPos()
		arg_52_0.tipsPanelView_:SetPivot(0, 0)
		arg_52_0.tipsPanelView_:SetData(arg_52_1)
		arg_52_0.tipsPanelView_:SetGoldState(true)

		if arg_52_1.shopType ~= nil then
			arg_52_0.autoChessShopItemView_:SetStatus(0)
			arg_52_0.autoChessFormationItemView_:ClickChessItemFunc()

			if arg_52_1.shopType == AutoChessConst.SHOP_TYPE.PROP then
				if AutoChessTools.IsTargetProp(arg_52_1.chessId) then
					arg_52_0.propUseController_:SetSelectedState("hide")
					arg_52_0.autoChessFormationItemView_:ClickPropItemFunc(arg_52_1)
				elseif arg_52_0:CheckUseShopProp(arg_52_1) then
					arg_52_0.propUseController_:SetSelectedState("normal")
				else
					arg_52_0.propUseController_:SetSelectedState("null")
				end
			else
				arg_52_0.propUseController_:SetSelectedState("hide")
				arg_52_0.autoChessFormationItemView_:ClickShopItemFunc(arg_52_1)
			end

			arg_52_0.autoChessShopItemView_:PointerClickFunc(arg_52_1)
			arg_52_0:ChangeCurrency(arg_52_1)
		else
			arg_52_0.propUseController_:SetSelectedState("hide")

			if AutoChessTools.IsPlayerChess(arg_52_1.chessId) then
				arg_52_0.autoChessShopItemView_:SetStatus(0)
			else
				arg_52_0.autoChessShopItemView_:SetSellText(AutoChessCfg[arg_52_1.chessId], arg_52_1.attributeData.level)
				arg_52_0.autoChessShopItemView_:SetStatus(arg_52_0.isBossBattle_ and 0 or 1)
			end

			arg_52_0.autoChessFormationItemView_:ClickChessItemFunc(arg_52_1)
			arg_52_0.autoChessShopItemView_:ResetShopItem()
		end
	else
		arg_52_0:ResetShopSelectItem()
	end
end

function var_0_0.OnClickChessInPop(arg_53_0, arg_53_1, arg_53_2)
	SetActive(arg_53_0.tipsMask_.gameObject, true)
	arg_53_0.showDetailController_:SetSelectedState("off")

	if arg_53_1.shopType == nil then
		arg_53_0.tipsPanelView_:SetPivot(0, 1)
	else
		arg_53_0.tipsPanelView_:SetPivot(0, 0)
	end

	arg_53_0.tipsPanelView_:SetData(arg_53_1)
	arg_53_0.tipsPanelView_:SetGoldState(false)

	local var_53_0 = arg_53_2:GetPos()

	arg_53_0.tipsPanelView_:SetPos(var_53_0)

	if arg_53_1.shopType == nil then
		AutoChessTools.ScreenAdapter(arg_53_2, arg_53_0.tipsPanelView_)
	else
		AutoChessTools.ScreenAdapter(arg_53_2, arg_53_0.tipsPanelView_, true)
	end
end

function var_0_0.OnBuyChessBack(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1.shopType == AutoChessConst.SHOP_TYPE.REWARD then
		arg_54_0.autoChessShopItemView_:RefreshRewardAreaActive(false)
	end

	arg_54_0.autoChessShopItemView_:ClearChess(arg_54_1)
	arg_54_0.autoChessShopItemView_:ResetShopItem()
	arg_54_0.currencyPanelController_:SetSelectedState("change")

	arg_54_0.currencyText_.text = AutoChessTools.GetAttrValue(arg_54_0.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)

	arg_54_0.currencyAnim_:Play("currencyPanel", 0, 0)
	arg_54_0.autoChessFormationItemView_:PlayMerge(arg_54_2, arg_54_1)
	AutoChessData:SetIsInBuyChess(false)
end

function var_0_0.ChangeCurrency(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = AutoChessTools.GetAttrValue(arg_55_0.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)
	local var_55_1 = AutoChessCfg[arg_55_1.chessId]
	local var_55_2 = arg_55_1.attributeData.level

	if arg_55_1.shopType == nil then
		if not AutoChessTools.IsPlayerChess(arg_55_1.chessId) then
			local var_55_3 = "  <color=#FF000B>(+" .. var_55_1.sell_price[var_55_2] .. ")</color>"

			arg_55_0.currencyPanelController_:SetSelectedState("preview")

			arg_55_0.currencyText_.text = var_55_0 .. var_55_3
		else
			arg_55_0.currencyPanelController_:SetSelectedState("normal")

			arg_55_0.currencyText_.text = var_55_0
		end
	else
		local var_55_4 = 0

		if arg_55_1.shopType == AutoChessConst.SHOP_TYPE.PROP then
			var_55_4 = arg_55_0.isFreeProp_ and 0 or AutoChessItemCfg[arg_55_1.chessId].shop_price
		elseif arg_55_1.shopType == AutoChessConst.SHOP_TYPE.REWARD then
			var_55_4 = arg_55_2 and var_55_1.sell_price[var_55_2] or 0
		else
			var_55_4 = arg_55_0.isFreeChess_ and 0 or var_55_1.shop_price
		end

		local var_55_5 = arg_55_2 and "  <color=#FF000B>(+" .. var_55_4 .. ")</color>" or "  <color=#FF000B>(-" .. var_55_4 .. ")</color>"

		arg_55_0.currencyPanelController_:SetSelectedState("preview")

		arg_55_0.currencyText_.text = var_55_0 .. var_55_5
	end
end

function var_0_0.OnPointerEnter(arg_56_0, arg_56_1, arg_56_2)
	if not arg_56_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	arg_56_0.targetIndex_ = arg_56_1.index or 0

	if arg_56_1.uniqueId ~= nil and arg_56_0:CheckMerge(arg_56_1) then
		arg_56_2:playLvPointAnim(arg_56_0.pointerChessData_, true)
	end

	if arg_56_0.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP and arg_56_1.uniqueId ~= nil and not arg_56_0:CheckMerge(arg_56_1) and not arg_56_0.autoChessFormationItemView_:GetIsMoving() and not arg_56_0.autoChessFormationItemView_:CheckIndexIsEmpty(arg_56_0.targetIndex_) then
		arg_56_0.autoChessFormationItemView_:ChangeItemPos(arg_56_1, arg_56_0.pointerChessData_, arg_56_0.lastEnterIndex_)
	end

	arg_56_0.lastEnterIndex_ = arg_56_0:CheckIsCanPlace(arg_56_0.targetIndex_) and arg_56_0.targetIndex_ or arg_56_0.lastEnterIndex_

	if arg_56_0:CheckIsCanPlace(arg_56_0.targetIndex_) then
		if arg_56_0.enterIndex_ then
			arg_56_0.autoChessFormationItemView_:RefreshEnterStatus(arg_56_0.enterIndex_, false)
		end

		arg_56_0.enterIndex_ = arg_56_0.targetIndex_

		arg_56_0.autoChessFormationItemView_:RefreshEnterStatus(arg_56_0.enterIndex_, true)
	end
end

function var_0_0.OnPointerExit(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	if arg_57_0.enterIndex_ then
		arg_57_0.autoChessFormationItemView_:RefreshEnterStatus(arg_57_0.enterIndex_, false)
	end

	if arg_57_2 and arg_57_0.pointerChessData_.shopType ~= AutoChessConst.SHOP_TYPE.PROP then
		arg_57_2:playLvPointAnim(arg_57_0.pointerChessData_, false)
	end

	arg_57_0.targetIndex_ = 0
	arg_57_0.isCanMerge_ = false
end

function var_0_0.PropPointerEnter(arg_58_0)
	if not arg_58_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	if arg_58_0.pointerChessData_ then
		if arg_58_0:CheckUseShopProp(arg_58_0.pointerChessData_) then
			arg_58_0.isEnterNotTargetPropArea_ = true

			arg_58_0.propUseController_:SetSelectedState("active")
		else
			arg_58_0.isEnterNotTargetPropArea_ = false

			arg_58_0.propUseController_:SetSelectedState("null")
		end
	end
end

function var_0_0.PropPointerExit(arg_59_0)
	if not arg_59_0.isBeginDrag_ then
		return
	end

	if AutoChessData:GetIsInPrepareEnd() then
		return
	end

	arg_59_0.isEnterNotTargetPropArea_ = false

	if arg_59_0:CheckUseShopProp(arg_59_0.pointerChessData_) then
		arg_59_0.propUseController_:SetSelectedState("normal")
	else
		arg_59_0.propUseController_:SetSelectedState("null")
	end
end

function var_0_0.CancelDrag(arg_60_0)
	arg_60_0.autoChessShopItemView_:ResetShopItem()
	arg_60_0:ResetCurrencyState()
end

function var_0_0.CancelDragTips(arg_61_0)
	if arg_61_0.pointerChessData_ then
		if arg_61_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP and arg_61_0.autoChessFormationItemView_:CheckIndexIsPalyer(arg_61_0.targetIndex_) and AutoChessItemCfg[arg_61_0.pointerChessData_.chessId].relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER then
			ShowTips("AUTO_CHESS_INVALID_OBJECT")
		end

		if arg_61_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.NORMAL or arg_61_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.REWARD then
			local var_61_0 = arg_61_0.prepareData_:GetTeamDataList()

			if not arg_61_0.autoChessFormationItemView_:CheckIndexIsEmpty(arg_61_0.targetIndex_) and not arg_61_0:CheckMerge(var_61_0[arg_61_0.targetIndex_]) then
				ShowTips("AUTO_CHESS_NO_VACANCY")
			end
		end
	end
end

function var_0_0.GuideCheck(arg_62_0)
	if manager.guide:IsPlaying() and arg_62_0.guideTargetIndex_ and arg_62_0.guideTargetIndex_ ~= 0 then
		if arg_62_0.guideTargetIndex_ == -1 and arg_62_0.isEnterNotTargetPropArea_ then
			arg_62_0.isGuideDragComplete_ = true

			return false
		end

		if arg_62_0.targetIndex_ == arg_62_0.guideTargetIndex_ or arg_62_0.pointerChessData_.shopType == nil and arg_62_0.lastEnterIndex_ == arg_62_0.guideTargetIndex_ then
			arg_62_0.isGuideDragComplete_ = true

			return false
		else
			arg_62_0.isGuideDragComplete_ = false

			if arg_62_0.lastEnterIndex_ ~= 0 and arg_62_0.pointerChessData_.shopType == nil then
				arg_62_0.autoChessFormationItemView_:SetItemToTargetIndex(arg_62_0.pointerChessData_, arg_62_0.lastEnterIndex_)
				arg_62_0:EndDragResetFunc()
			end

			arg_62_0:CancelDrag()

			return true
		end
	end
end

function var_0_0.CheckMerge(arg_63_0, arg_63_1)
	if arg_63_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		arg_63_0.isCanMerge_ = false

		return
	end

	local var_63_0 = arg_63_1.attributeData

	arg_63_0.isCanMerge_ = var_63_0 and not arg_63_0.pointerChessData_.attributeData.isMaxLevel and not var_63_0.isMaxLevel and arg_63_0.pointerChessData_.chessId == arg_63_1.chessId

	return arg_63_0.isCanMerge_
end

function var_0_0.CheckIsCanPlace(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0.autoChessFormationItemView_:CheckIndexIsEmpty(arg_64_1)

	if arg_64_0.pointerChessData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
		if arg_64_0.autoChessFormationItemView_:CheckIndexIsPalyer(arg_64_1) and AutoChessItemCfg[arg_64_0.pointerChessData_.chessId].relevant_type == AutoChessConst.ITEM_TARGET_TYPE.WITHOUT_PLAYER then
			return false
		end

		if not arg_64_0:CheckUseShopProp(arg_64_0.pointerChessData_, AutoChessData:GetPlayerData(arg_64_0.gameType_):GetChessDataByIndex(arg_64_1)) then
			return false
		end

		return not var_64_0 and AutoChessTools.IsTargetProp(arg_64_0.pointerChessData_.chessId)
	else
		return var_64_0 or arg_64_0.isCanMerge_
	end
end

function var_0_0.CheckUseShopProp(arg_65_0, arg_65_1, arg_65_2)
	return AutoChessTools.CheckUseProp(arg_65_1.chessId, arg_65_0.gameType_, arg_65_2)
end

function var_0_0.ResetCurrencyState(arg_66_0)
	arg_66_0.currencyPanelController_:SetSelectedState("normal")

	arg_66_0.currencyText_.text = AutoChessTools.GetAttrValue(arg_66_0.gameType_, AutoChessConst.ATTR_KEY.NOW_MONEY)
end

function var_0_0.ResetShopSelectItem(arg_67_0)
	arg_67_0.autoChessShopItemView_:ResetShopItem()
	arg_67_0:ResetCurrencyState()
	arg_67_0.autoChessFormationItemView_:EndDragFunc()
	arg_67_0.propUseController_:SetSelectedState("hide")
	arg_67_0.autoChessShopItemView_:SetStatus(0)
	SetActive(arg_67_0.tipsMask_.gameObject, false)
	arg_67_0.tipsPanelView_:SetActive(false)
	arg_67_0.autoChessFormationItemView_:ClickChessItemFunc()
end

function var_0_0.GetIsBeginDrag(arg_68_0)
	return arg_68_0.isBeginDrag_
end

function var_0_0.GetPointerChessData(arg_69_0)
	return arg_69_0.pointerChessData_
end

function var_0_0.GetClickChessItemData(arg_70_0)
	return arg_70_0.clickChessItemData_
end

function var_0_0.GetGameType(arg_71_0)
	return arg_71_0.gameType_
end

function var_0_0.SetSellState(arg_72_0, arg_72_1)
	arg_72_0.isCanSell_ = arg_72_1
end

function var_0_0.SetMergeState(arg_73_0, arg_73_1)
	arg_73_0.isCanMerge_ = arg_73_1
end

function var_0_0.GetChessItemByUniqueId(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0.autoChessFormationItemView_:GetChessItemByUniqueId(arg_74_1)

	if var_74_0 then
		return var_74_0
	else
		Debug.Log("AutoChessPrepareView:GetChessItemByUniqueId: 没有找到uniqueId为" .. arg_74_1 .. "的棋子")
	end
end

function var_0_0.RemoveChessItemByUniqueId(arg_75_0, arg_75_1)
	arg_75_0.autoChessFormationItemView_:RemoveChessItemByUniqueId(arg_75_1)
end

function var_0_0.GetChessItemByTargetIndex(arg_76_0, arg_76_1)
	return arg_76_0.autoChessFormationItemView_:GetChessItem(arg_76_1)
end

function var_0_0.SetGuideTargetIndex(arg_77_0, arg_77_1)
	arg_77_0.guideTargetIndex_ = arg_77_1
end

function var_0_0.CheckGuideDragIsComplete(arg_78_0)
	local var_78_0 = arg_78_0.isGuideDragComplete_

	if var_78_0 then
		arg_78_0.guideTargetIndex_ = 0
		arg_78_0.isGuideDragComplete_ = false
	end

	return var_78_0
end

function var_0_0.PlayPropAnimator(arg_79_0, arg_79_1)
	arg_79_0.propImg_.sprite = AutoChessTools.GetPropIcon(arg_79_1)

	arg_79_0.propAnim_:Play("Props", -1, 0)
	arg_79_0.propAnim_:Update(0)
	Timer.New(function()
		AutoChessData:SetIsInUseProp(false)
	end, 1, 1):Start()
end

return var_0_0
