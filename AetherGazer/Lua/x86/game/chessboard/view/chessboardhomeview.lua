local var_0_0 = class("ChessBoardHomeView", ReduxView)
local var_0_1 = {
	LOSE = 2,
	UNFINISH = 0,
	WIN = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ChessGameHUDUI"
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

	arg_4_0.taskList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.taskListGo_, ChessBoardHomeTaskItem)
	arg_4_0.propList = ChessBoardPropList.New(arg_4_0.propListGo_, true)
	arg_4_0.propItemClickHandle_ = handler(arg_4_0, arg_4_0.OnPropItemClick)

	arg_4_0.propList:SetClickHandle(arg_4_0.propItemClickHandle_)

	arg_4_0.homeTips = ChessBoardHomeTips.New(arg_4_0.tipsRootGo_)
	arg_4_0.diceAniTimer_ = nil
	arg_4_0.diceAniCount_ = 0
	arg_4_0.diceAniType_ = 0
	arg_4_0.haveBuff_ = false
	arg_4_0.buffIconController_ = arg_4_0.buffControllerEx_:GetController("status")
	arg_4_0.viewController_ = arg_4_0.controllerEx_:GetController("viewState")
	arg_4_0.isFastController_ = arg_4_0.fastControllerEx_:GetController("isFast")
	arg_4_0.isShowDice = false
	arg_4_0.isCanContinueMove_ = false
	arg_4_0.cacheAuraDiceNum_ = 0
	arg_4_0.cacheAuraNum_ = 0
	arg_4_0.cacheAuraFunCallTime_ = 0
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.lookatBtn_, nil, function()
		arg_5_0.homeTips:ClearBubbleTips()
		ChessBoardLuaBridge.LookAtPlayer()
		SetActive(arg_5_0.lookatBtn_.gameObject, false)

		if manager.ChessBoardManager:GetIsArenaChance() then
			-- block empty
		else
			arg_5_0:OnChessBoardStepUpdate()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rollDiceBtn_, nil, function()
		arg_5_0.homeTips:ClearBubbleTips()

		if manager.ChessBoardManager:GetIsArenaChance() then
			arg_5_0.curAuraDiceNumText_.text = "×" .. arg_5_0.cacheAuraDiceNum_ - 1
		end

		manager.ChessBoardManager:HeroRollDice()
	end)
	arg_5_0:AddBtnListener(arg_5_0.mapBtn_, nil, function()
		if arg_5_0.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		else
			JumpTools.OpenPageByJump("/chessBoardSmallMapView")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		if arg_5_0.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		else
			local var_9_0 = ChessBoardTools.GetChessBoardGameSetting("chessboard_describe")
			local var_9_1 = "gameHelpPro"
			local var_9_2 = {
				isPrefab = true,
				pages = var_9_0
			}

			JumpTools.OpenPageByJump(var_9_1, var_9_2)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.buffBtn_, nil, function()
		local var_10_0, var_10_1 = manager.ChessBoardManager.heroEntity_:GetBuffData()

		if var_10_1 then
			local var_10_2 = var_10_1.id

			JumpTools.OpenPageByJump("/chessBoardBuffView", {
				buffData = var_10_0
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.continueMoveBtn_, nil, function()
		arg_5_0.homeTips:ClearBubbleTips()

		arg_5_0.isCanContinueMove_ = false

		ChessBoardLuaBridge.LookAtPlayer()
		SetActive(arg_5_0.lookatBtn_.gameObject, false)
		manager.ChessBoardManager:SendTmpPropToServer(nil, function()
			manager.ChessBoardManager:HeroTryToMove()
			arg_5_0.viewController_:SetSelectedState("normal")
			arg_5_0.dicebtnAni_:Play("DiceBtn_enter", -1, 1)
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.fastBtn_, nil, function()
		local var_13_0 = manager.ChessBoardManager:ChangeFastModule()

		arg_5_0:OnChessBoardFastModuleUpdate(var_13_0)
	end)
end

function var_0_0.StopDiceTimer(arg_14_0)
	if arg_14_0.diceAniTimer_ then
		arg_14_0.diceAniTimer_:Stop()

		arg_14_0.diceAniTimer_ = nil
	end
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_0.taskIDList_[arg_15_1])
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_16_0.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		elseif not manager.ChessBoardManager.blockerManager_:CheckIsShowBlocker() and (arg_16_0.isShowDice or manager.ChessBoardManager:GetIsArenaChance() or arg_16_0.isCanContinueMove_ or manager.ChessBoardManager.isSelectPosing_) then
			JumpTools.OpenPageByJump("/chessBoardExploreView")
		end
	end)
	manager.ChessBoardManager:FixBGM()
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.goldNum_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")

	arg_18_0:RefreshTaskList()
	arg_18_0.propList:OnEnter()
	arg_18_0.homeTips:OnEnter()
	arg_18_0:OnChessBoardBuffUpdate()

	local var_18_0 = ChessBoardData:GetIsFastModule()

	manager.ChessBoardManager:ApplyFastModule(var_18_0)
	arg_18_0:OnChessBoardFastModuleUpdate(var_18_0)
	SetActive(arg_18_0.arenaGo_, false)
	SetActive(arg_18_0.curAuraDiceNumGo_, false)
	SetActive(arg_18_0.auraTipsGo_, false)

	local var_18_1 = manager.ChessBoardManager:GetCurChanceInfo()

	if var_18_1.chanceID > 0 and ChessBoardChanceCfg[var_18_1.chanceID].type == ChessBoardConst.CHANCE_TYPE.ARENA then
		arg_18_0:RefreshArenaUI()

		return
	end

	if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START and manager.ChessBoardManager.NPCManager_:GetMovingNPC() == -1 then
		arg_18_0:UpdateDiceState(true)
	else
		arg_18_0:UpdateDiceState(false)
	end

	if manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
		arg_18_0.propList:SetUnInteractable()
	end
end

function var_0_0.RefreshArenaUI(arg_19_0, arg_19_1)
	SetActive(arg_19_0.arenaGo_, true)
	SetActive(arg_19_0.curAuraDiceNumGo_, true)
	SetActive(arg_19_0.auraTipsGo_, true)
	arg_19_0.dicebtnAni_:Play("DiceBtn_out")

	arg_19_0.auraTipsText_.text = GetTips("CHESSBOARD_ARENA_TIPS")

	local var_19_0 = manager.ChessBoardManager:GetCurChanceInfo()
	local var_19_1 = ChessBoardChanceCfg[var_19_0.chanceID]

	if arg_19_1 then
		manager.ChessBoardManager.blockerManager_:ShowBlocker()

		arg_19_0.cacheAuraFunCallTime_ = 0
		arg_19_0.auraAddTimer_ = Timer.New(function()
			arg_19_0.cacheAuraFunCallTime_ = arg_19_0.cacheAuraFunCallTime_ + 1

			local var_20_0 = var_19_1.params[1]
			local var_20_1 = arg_19_0.cacheAuraNum_ + (var_19_0.chanceChooseList[2] - arg_19_0.cacheAuraNum_) * 0.1 * arg_19_0.cacheAuraFunCallTime_

			arg_19_0.curAuraNumText_.text = math.ceil(var_20_1)
			arg_19_0.maxAuraNumText_.text = var_20_0
			arg_19_0.auraSlider_.value = (var_20_0 - var_20_1) / var_20_0
			arg_19_0.auraEffectSlider_.value = (var_20_0 - var_20_1) / var_20_0

			if arg_19_0.cacheAuraFunCallTime_ == 5 then
				local var_20_2 = var_19_0.chanceChooseList[1] - (arg_19_0.cacheAuraDiceNum_ - 1)

				if var_20_2 > 0 then
					SetActive(arg_19_0.auraDiceAddAniGo_, true)

					arg_19_0.auraDiceAddText_.text = "+" .. var_20_2
				end
			end

			if arg_19_0.cacheAuraFunCallTime_ >= 10 then
				arg_19_0.curAuraDiceNumText_.text = "×" .. var_19_0.chanceChooseList[1]
				arg_19_0.cacheAuraDiceNum_ = var_19_0.chanceChooseList[1]

				local var_20_3 = var_19_0.chanceChooseList[2]

				arg_19_0.cacheAuraNum_ = var_20_3

				local var_20_4 = var_19_1.params[1]

				arg_19_0.curAuraNumText_.text = var_20_3
				arg_19_0.maxAuraNumText_.text = var_20_4
				arg_19_0.auraSlider_.value = (var_20_4 - var_20_3) / var_20_4
				arg_19_0.auraEffectSlider_.value = (var_20_4 - var_20_3) / var_20_4

				if var_19_0.chanceChooseList[3] > 0 then
					arg_19_0.propList:SetUnInteractable()
				else
					arg_19_0.propList:StartArenaChance()
				end

				SetActive(arg_19_0.auraDiceAddAniGo_, false)
				arg_19_0:StopAuraAddTimer()

				local var_20_5 = manager.ChessBoardManager:CheckArenaChance()

				if var_20_5 == var_0_1.WIN then
					arg_19_0.auraAni_:Play("succeed")
					manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_finish")
					manager.ChessBoardManager:AddDelayTimer(1, function()
						manager.ChessBoardManager.blockerManager_:HideBlocker()
						manager.ChessBoardManager:FinishArenaChance(true)
					end)
				elseif var_20_5 == var_0_1.LOSE then
					arg_19_0.auraAni_:Play("defeat")
					manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_fail")
					manager.ChessBoardManager:AddDelayTimer(1, function()
						manager.ChessBoardManager.blockerManager_:HideBlocker()
						manager.ChessBoardManager:FinishArenaChance(false)
					end)
				elseif var_20_5 == var_0_1.UNFINISH then
					manager.ChessBoardManager.blockerManager_:HideBlocker()
				end
			end
		end, 0.1, -1)

		arg_19_0.auraAddTimer_:Start()
		manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_up")
	else
		arg_19_0.curAuraDiceNumText_.text = "×" .. var_19_0.chanceChooseList[1]
		arg_19_0.cacheAuraDiceNum_ = var_19_0.chanceChooseList[1]

		local var_19_2 = var_19_0.chanceChooseList[2]

		arg_19_0.cacheAuraNum_ = var_19_2

		local var_19_3 = var_19_1.params[1]

		arg_19_0.curAuraNumText_.text = var_19_2
		arg_19_0.maxAuraNumText_.text = var_19_3
		arg_19_0.auraSlider_.value = (var_19_3 - var_19_2) / var_19_3
		arg_19_0.auraEffectSlider_.value = (var_19_3 - var_19_2) / var_19_3

		if var_19_0.chanceChooseList[3] > 0 then
			arg_19_0.propList:SetUnInteractable()
		else
			arg_19_0.propList:StartArenaChance()
		end

		local var_19_4 = manager.ChessBoardManager:CheckArenaChance()

		if var_19_4 == var_0_1.WIN then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
			arg_19_0.auraAni_:Play("succeed")
			manager.ChessBoardManager:AddDelayTimer(1, function()
				manager.ChessBoardManager.blockerManager_:HideBlocker()
				manager.ChessBoardManager:FinishArenaChance(true)
			end)
		elseif var_19_4 == var_0_1.LOSE then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
			arg_19_0.auraAni_:Play("defeat")
			manager.ChessBoardManager:AddDelayTimer(1, function()
				manager.ChessBoardManager.blockerManager_:HideBlocker()
				manager.ChessBoardManager:FinishArenaChance(false)
			end)
		elseif var_19_4 == var_0_1.UNFINISH then
			-- block empty
		end
	end
end

function var_0_0.StopAuraAddTimer(arg_25_0)
	if arg_25_0.auraAddTimer_ then
		arg_25_0.auraAddTimer_:Stop()

		arg_25_0.auraAddTimer_ = nil
	end
end

function var_0_0.OnExit(arg_26_0)
	manager.windowBar:HideBar()
	arg_26_0.taskList_:StopRender()
	arg_26_0:StopDiceTimer()
	arg_26_0:StopAuraAddTimer()
end

function var_0_0.OnChessBoardGoldUpdate(arg_27_0, arg_27_1)
	arg_27_0.goldNum_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")

	if arg_27_1 then
		arg_27_0:OnChessBoardTipsShow(ChessBoardConst.TIPS_TYPE.NUM_TIPS, {
			num = arg_27_1
		})
	end
end

function var_0_0.OnChessBoardCameraZoomScale(arg_28_0)
	arg_28_0.homeTips:ClearBubbleTips()
end

function var_0_0.OnChessBoardTipsShow(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.homeTips:UpdateTipsShow(arg_29_1, arg_29_2)

	if arg_29_1 == ChessBoardConst.TIPS_TYPE.GET_PROP then
		if arg_29_2.isGet == true then
			arg_29_0.propList:CheckGetEffect()
		end
	elseif arg_29_1 == ChessBoardConst.TIPS_TYPE.EVENT_TIPS then
		arg_29_0:OnChessBoardStepUpdate()
	end
end

function var_0_0.OnChessBoardViewStateUpdate(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.NORMAL then
		arg_30_0.viewController_:SetSelectedState("normal")

		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START then
			arg_30_0:UpdateDiceState(true)
		else
			arg_30_0:UpdateDiceState(false)
		end
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.USE_PROP then
		arg_30_0.viewController_:SetSelectedState("useProp")
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE then
		arg_30_0.isCanContinueMove_ = true

		arg_30_0.viewController_:SetSelectedState("continueMove")

		if arg_30_2 then
			arg_30_0:OnChessBoardStepUpdate()
		end
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.DICE_SHOW then
		arg_30_0:UpdateDiceState(true)
	end
end

function var_0_0.UpdateDiceState(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 then
		arg_31_0.isShowDice = true

		arg_31_0.dicebtnAni_:Play("DiceBtn_out")
		arg_31_0.propList:OnEnter()
		arg_31_0:AddIdleTimer()
	else
		arg_31_0.isShowDice = false

		arg_31_0.propList:SetUnInteractable()

		if arg_31_2 then
			arg_31_0.dicebtnAni_:Play("DiceBtn_enter")
		else
			arg_31_0.dicebtnAni_:Play("DiceBtn_enter", -1, 1)
		end

		arg_31_0:DelIdleTimer()
	end
end

function var_0_0.AddIdleTimer(arg_32_0)
	arg_32_0:DelIdleTimer()

	arg_32_0.idleTimer = Timer.New(function()
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.IDLE)
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.BUBBLE, {
			actionType = ChessBoardConst.ACTIONTYPE.IDLE
		})
	end, 5, -1)

	arg_32_0.idleTimer:Start()
end

function var_0_0.DelIdleTimer(arg_34_0)
	if arg_34_0.idleTimer then
		arg_34_0.idleTimer:Stop()

		arg_34_0.idleTimer = nil
	end
end

function var_0_0.OnChessBoardPropUpdate(arg_35_0)
	arg_35_0.propList:RefreshList()

	if manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
		arg_35_0.propList:SetUnInteractable()
	end
end

function var_0_0.OnPropItemClick(arg_36_0, arg_36_1, arg_36_2)
	if manager.ChessBoardManager:GetIsArenaChance() then
		if not arg_36_1 then
			return
		end

		local var_36_0 = ChessBoardTools.GetChessBoardGameSetting("chessboard_dice_type_prop")

		if not table.indexof(var_36_0, arg_36_1) then
			return
		end

		if manager.ChessBoardManager.heroEntity_:GetCurChanceInfo().chanceChooseList[3] > 0 then
			ShowTips("CHESSBOARD_TURN_USED_PROP")

			return
		end

		JumpTools.OpenPageByJump("/ChessBoardPropView", {
			propID = arg_36_1,
			index = arg_36_2,
			viewType = ChessBoardConst.VIEW_TYPE.USE_PROP
		})
	else
		if not arg_36_0.isShowDice then
			return
		end

		if manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
			ShowTips("CHESSBOARD_TURN_USED_PROP")

			return
		end

		if arg_36_1 then
			JumpTools.OpenPageByJump("/ChessBoardPropView", {
				propID = arg_36_1,
				index = arg_36_2,
				viewType = ChessBoardConst.VIEW_TYPE.USE_PROP
			})
		end
	end
end

function var_0_0.OnChessBoardBuffUpdate(arg_37_0)
	local var_37_0, var_37_1 = manager.ChessBoardManager.heroEntity_:GetBuffData()

	if arg_37_0.haveBuff_ == false and var_37_0 then
		arg_37_0.buffIconAni_:Play("StateNotice")
	else
		arg_37_0.buffIconAni_:Play("empty")
	end

	if var_37_0 and var_37_1 then
		arg_37_0.haveBuff_ = true
		arg_37_0.buffIconImg_.sprite = ChessBoardTools.GetBuffImage(var_37_1.id)

		if var_37_1.remainround == -1 then
			arg_37_0.buffIconController_:SetSelectedState("noRound")
		else
			arg_37_0.buffIconController_:SetSelectedState("normal")

			if var_37_1.remainround > 0 then
				arg_37_0.buffTimeText_.text = var_37_1.remainround - var_37_0.duration_
			else
				arg_37_0.buffTimeText_.text = ""
			end
		end
	else
		arg_37_0.haveBuff_ = false

		arg_37_0.buffIconController_:SetSelectedState("empty")
	end
end

function var_0_0.OnChessBoardUpdateTask(arg_38_0)
	arg_38_0:RefreshTaskList()
end

function var_0_0.RefreshTaskList(arg_39_0)
	arg_39_0.taskIDList_ = {}

	local var_39_0 = manager.ChessBoardManager.taskManager_:GetTaskList()
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		if ChessBoardTaskPoolCfg[iter_39_0].type == ChessBoardConst.TASKTYPE.MAIN then
			table.insert(arg_39_0.taskIDList_, iter_39_0)
		else
			table.insert(var_39_1, iter_39_0)
		end
	end

	for iter_39_2, iter_39_3 in pairs(var_39_1) do
		table.insert(arg_39_0.taskIDList_, iter_39_3)
	end

	arg_39_0.taskList_:StartScroll(#arg_39_0.taskIDList_)
end

function var_0_0.OnChessBoardCameraMove(arg_40_0, arg_40_1)
	arg_40_0.homeTips:ClearBubbleTips()
	SetActive(arg_40_0.lookatBtn_.gameObject, arg_40_1)

	if arg_40_1 then
		arg_40_0.homeTips:SetDiceUIShow(false)
	end

	arg_40_0.homeTips:UpdateCameraMove()
end

function var_0_0.OnPlayDiceAni(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:UpdateDiceState(false, true)
	manager.ChessBoardManager.blockerManager_:ShowBlocker()

	local var_41_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE")

	if var_41_0 == 6 then
		manager.ChessBoardManager.diceManager_:PlayDiceAni(0, ChessBoardConst.DICE_TYPE.DICE_1_6, arg_41_1)
	elseif var_41_0 == 3 then
		manager.ChessBoardManager.diceManager_:PlayDiceAni(0, ChessBoardConst.DICE_TYPE.DICE_1_3, arg_41_1)
	else
		error("骰子点数控制到了一个模型不支持的范围，点数：", var_41_0)
	end

	arg_41_0.diceAniCount_ = 0

	local var_41_1 = #arg_41_1

	if var_41_1 == 1 then
		arg_41_0.diceAniType_ = ChessBoardConst.DICE_ANI_TYPE.DICE_ONE
	elseif var_41_1 == 2 then
		arg_41_0.diceAniType_ = ChessBoardConst.DICE_ANI_TYPE.DICE_TWO
	else
		error("骰子个数控制到了一个动效不支持的范围，个数：", var_41_1)
	end

	if arg_41_0.diceAniTimer_ then
		arg_41_0:StopDiceTimer()
	else
		local var_41_2 = 0.5

		if ChessBoardData:GetIsFastModule() then
			var_41_2 = var_41_2 / 2
		end

		arg_41_0.diceAniTimer_ = Timer.New(function()
			arg_41_0.diceAniCount_ = arg_41_0.diceAniCount_ + 1

			if arg_41_0.diceAniType_ == ChessBoardConst.DICE_ANI_TYPE.DICE_ONE then
				if arg_41_0.diceAniCount_ == 3 then
					local var_42_0 = 0

					for iter_42_0, iter_42_1 in pairs(arg_41_1) do
						if iter_42_1 == 6 then
							var_42_0 = var_42_0 + 1
						end
					end

					if var_42_0 > 0 then
						ShowTips("CHESSBOARD_MOVE_AGAIN_" .. var_42_0)
					end

					manager.ChessBoardManager.diceManager_:HideAllDice()
					arg_41_0.homeTips:SetDiceUIShow(true)
					arg_41_0.homeTips:SetDiceController("OneDice")
					arg_41_0.homeTips:PlayOneDiceAni(arg_41_1[1])
				elseif arg_41_0.diceAniCount_ == 5 then
					local var_42_1 = 0

					for iter_42_2, iter_42_3 in pairs(arg_41_1) do
						var_42_1 = var_42_1 + iter_42_3
					end

					manager.ChessBoardManager.blockerManager_:HideBlocker()
					arg_41_0:StopDiceTimer()

					if manager.ChessBoardManager:GetIsArenaChance() then
						local var_42_2 = manager.ChessBoardManager:GetCurChanceInfo()

						var_42_2.chanceChooseList[1] = arg_41_2.curAuraDiceNum
						var_42_2.chanceChooseList[2] = var_42_2.chanceChooseList[2] + var_42_1
						var_42_2.chanceChooseList[3] = 0

						arg_41_0:RefreshArenaUI(true)
						arg_41_0.homeTips:SetDiceUIShow(false)
					else
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", var_42_1)
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE)
						manager.ChessBoardManager:HeroTryToMove()
					end
				end
			elseif arg_41_0.diceAniType_ == ChessBoardConst.DICE_ANI_TYPE.DICE_TWO then
				if arg_41_0.diceAniCount_ == 3 then
					local var_42_3 = 0

					for iter_42_4, iter_42_5 in pairs(arg_41_1) do
						if iter_42_5 == 6 then
							var_42_3 = var_42_3 + 1
						end
					end

					if var_42_3 > 0 then
						ShowTips("CHESSBOARD_MOVE_AGAIN_" .. var_42_3)
					end

					manager.ChessBoardManager.diceManager_:HideAllDice()
					arg_41_0.homeTips:SetDiceUIShow(true)
					arg_41_0.homeTips:SetDiceController("TwoDice")
					arg_41_0.homeTips:PlayTwoDiceAni(arg_41_1)
				elseif arg_41_0.diceAniCount_ == 5 then
					arg_41_0.homeTips:SetDiceController("OneDice")

					local var_42_4 = 0

					for iter_42_6, iter_42_7 in pairs(arg_41_1) do
						var_42_4 = var_42_4 + iter_42_7
					end

					arg_41_0.homeTips:PlayOneDiceAni(var_42_4)
				elseif arg_41_0.diceAniCount_ == 7 then
					local var_42_5 = 0

					for iter_42_8, iter_42_9 in pairs(arg_41_1) do
						var_42_5 = var_42_5 + iter_42_9
					end

					arg_41_0:StopDiceTimer()
					manager.ChessBoardManager.blockerManager_:HideBlocker()

					if manager.ChessBoardManager:GetIsArenaChance() then
						local var_42_6 = manager.ChessBoardManager:GetCurChanceInfo()

						var_42_6.chanceChooseList[1] = arg_41_2.curAuraDiceNum
						var_42_6.chanceChooseList[2] = var_42_6.chanceChooseList[2] + var_42_5
						var_42_6.chanceChooseList[3] = 0

						arg_41_0:RefreshArenaUI(true)
						arg_41_0.homeTips:SetDiceUIShow(false)
					else
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", var_42_5)
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE)
						manager.ChessBoardManager:HeroTryToMove()
					end
				end
			end
		end, var_41_2, 8)
	end

	arg_41_0.diceAniTimer_:Start()
end

function var_0_0.OnPlayNPCDiceAni(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_2 <= 0 then
		return
	end

	local var_43_0 = {}

	if arg_43_2 > 0 and arg_43_2 <= 6 then
		var_43_0 = {
			arg_43_2
		}
	elseif arg_43_2 > 6 then
		var_43_0 = {
			6,
			arg_43_2 - 6
		}
	end

	local var_43_1 = 0

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		var_43_1 = var_43_1 + iter_43_1
	end

	arg_43_0.homeTips:SetNPCDiceUIShow(true)
	arg_43_0.homeTips:SetNPCDiceController("NPCOneDice")
	arg_43_0.homeTips:SetNPCMoveStepNum(var_43_1)
	manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
end

function var_0_0.OnChessBoardStepUpdate(arg_44_0)
	local var_44_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")

	if var_44_0 > 0 then
		arg_44_0.homeTips:SetDiceUIShow(true)
		arg_44_0.homeTips:SetDiceController("OneDice")
		arg_44_0.homeTips:SetMoveStepNum(var_44_0)
	else
		arg_44_0.homeTips:SetDiceUIShow(false)
	end
end

function var_0_0.OnChessBoardNPCStepUpdate(arg_45_0, arg_45_1)
	if arg_45_1 > 0 then
		arg_45_0.homeTips:SetNPCDiceUIShow(true)
		arg_45_0.homeTips:SetNPCDiceController("NPCOneDice")
		arg_45_0.homeTips:SetNPCMoveStepNum(arg_45_1)
	else
		arg_45_0.homeTips:SetNPCDiceUIShow(false)
	end
end

function var_0_0.OnChessBoardFastModuleUpdate(arg_46_0, arg_46_1)
	if arg_46_1 then
		arg_46_0.isFastController_:SetSelectedState("fast")

		arg_46_0.auraAni_.speed = 2
	else
		arg_46_0.isFastController_:SetSelectedState("normal")

		arg_46_0.auraAni_.speed = 1
	end

	arg_46_0.homeTips:OnChessBoardFastModuleUpdate(arg_46_1)
end

function var_0_0.OnChessBoardArenaUIUpdate(arg_47_0, arg_47_1)
	if arg_47_1 then
		arg_47_0:RefreshArenaUI()
		arg_47_0.homeTips:SetDiceUIShow(false)
	else
		SetActive(arg_47_0.arenaGo_, false)
		SetActive(arg_47_0.curAuraDiceNumGo_, false)
		SetActive(arg_47_0.auraTipsGo_, false)
		arg_47_0.propList:RefreshList()
	end
end

function var_0_0.Dispose(arg_48_0)
	arg_48_0:DelIdleTimer()
	arg_48_0.homeTips:Dispose()

	arg_48_0.homeTips = nil

	arg_48_0.propList:Dispose()

	arg_48_0.propList = nil

	if arg_48_0.taskList_ then
		arg_48_0.taskList_:Dispose()

		arg_48_0.taskList_ = nil
	end

	arg_48_0.super.Dispose(arg_48_0)
end

return var_0_0
