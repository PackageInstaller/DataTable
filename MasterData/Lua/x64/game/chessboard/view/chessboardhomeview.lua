local ChessBoardHomeView = class("ChessBoardHomeView", ReduxView)
local var_0_1 = {
	LOSE = 2,
	UNFINISH = 0,
	WIN = 1
}

function ChessBoardHomeView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ChessGameHUDUI"
end

function ChessBoardHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessBoardHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardHomeView:InitUI()
	self:BindCfgUI()

	self.taskList_ = LuaList.New(handler(self, self.IndexItem), self.taskListGo_, ChessBoardHomeTaskItem)
	self.propList = ChessBoardPropList.New(self.propListGo_, true)
	self.propItemClickHandle_ = handler(self, self.OnPropItemClick)

	self.propList:SetClickHandle(self.propItemClickHandle_)

	self.homeTips = ChessBoardHomeTips.New(self.tipsRootGo_)
	self.diceAniTimer_ = nil
	self.diceAniCount_ = 0
	self.diceAniType_ = 0
	self.haveBuff_ = false
	self.buffIconController_ = self.buffControllerEx_:GetController("status")
	self.viewController_ = self.controllerEx_:GetController("viewState")
	self.isFastController_ = self.fastControllerEx_:GetController("isFast")
	self.isShowDice = false
	self.isCanContinueMove_ = false
	self.cacheAuraDiceNum_ = 0
	self.cacheAuraNum_ = 0
	self.cacheAuraFunCallTime_ = 0
end

function ChessBoardHomeView:AddUIListener()
	self:AddBtnListener(self.lookatBtn_, nil, function()
		self.homeTips:ClearBubbleTips()
		ChessBoardLuaBridge.LookAtPlayer()
		SetActive(self.lookatBtn_.gameObject, false)

		if manager.ChessBoardManager:GetIsArenaChance() then
			-- block empty
		else
			self:OnChessBoardStepUpdate()
		end
	end)
	self:AddBtnListener(self.rollDiceBtn_, nil, function()
		self.homeTips:ClearBubbleTips()

		if manager.ChessBoardManager:GetIsArenaChance() then
			self.curAuraDiceNumText_.text = "×" .. self.cacheAuraDiceNum_ - 1
		end

		manager.ChessBoardManager:HeroRollDice()
	end)
	self:AddBtnListener(self.mapBtn_, nil, function()
		if self.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		else
			JumpTools.OpenPageByJump("/chessBoardSmallMapView")
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		else
			local var_9_0 = {
				isPrefab = true
			}

			var_9_0.pages = ChessBoardTools.GetChessBoardGameSetting("chessboard_describe")

			JumpTools.OpenPageByJump("gameHelpPro", var_9_0)
		end
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		local var_10_0, var_10_1 = manager.ChessBoardManager.heroEntity_:GetBuffData()

		if var_10_1 then
			JumpTools.OpenPageByJump("/chessBoardBuffView", {
				buffData = var_10_0
			})
		end
	end)
	self:AddBtnListener(self.continueMoveBtn_, nil, function()
		self.homeTips:ClearBubbleTips()

		self.isCanContinueMove_ = false

		ChessBoardLuaBridge.LookAtPlayer()
		SetActive(self.lookatBtn_.gameObject, false)
		manager.ChessBoardManager:SendTmpPropToServer(nil, function()
			manager.ChessBoardManager:HeroTryToMove()
			self.viewController_:SetSelectedState("normal")
			self.dicebtnAni_:Play("DiceBtn_enter", -1, 1)
		end)
	end)
	self:AddBtnListener(self.fastBtn_, nil, function()
		self:OnChessBoardFastModuleUpdate((manager.ChessBoardManager:ChangeFastModule()))
	end)
end

function ChessBoardHomeView:StopDiceTimer()
	if self.diceAniTimer_ then
		self.diceAniTimer_:Stop()

		self.diceAniTimer_ = nil
	end
end

function ChessBoardHomeView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.taskIDList_[arg_15_1])
end

function ChessBoardHomeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.viewController_:GetSelectedState() == "useProp" then
			-- block empty
		elseif not manager.ChessBoardManager.blockerManager_:CheckIsShowBlocker() and (self.isShowDice or manager.ChessBoardManager:GetIsArenaChance() or self.isCanContinueMove_ or manager.ChessBoardManager.isSelectPosing_) then
			JumpTools.OpenPageByJump("/chessBoardExploreView")
		end
	end)
	manager.ChessBoardManager:FixBGM()
end

function ChessBoardHomeView:OnEnter()
	self.goldNum_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")

	self:RefreshTaskList()
	self.propList:OnEnter()
	self.homeTips:OnEnter()
	self:OnChessBoardBuffUpdate()

	local var_18_0 = ChessBoardData:GetIsFastModule()

	manager.ChessBoardManager:ApplyFastModule(var_18_0)
	self:OnChessBoardFastModuleUpdate(var_18_0)
	SetActive(self.arenaGo_, false)
	SetActive(self.curAuraDiceNumGo_, false)
	SetActive(self.auraTipsGo_, false)

	local var_18_1 = manager.ChessBoardManager:GetCurChanceInfo()

	if var_18_1.chanceID > 0 and ChessBoardChanceCfg[var_18_1.chanceID].type == ChessBoardConst.CHANCE_TYPE.ARENA then
		self:RefreshArenaUI()

		return
	end

	if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START and manager.ChessBoardManager.NPCManager_:GetMovingNPC() == -1 then
		self:UpdateDiceState(true)
	else
		self:UpdateDiceState(false)
	end

	if manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
		self.propList:SetUnInteractable()
	end
end

function ChessBoardHomeView:RefreshArenaUI(arg_19_1)
	SetActive(self.arenaGo_, true)
	SetActive(self.curAuraDiceNumGo_, true)
	SetActive(self.auraTipsGo_, true)
	self.dicebtnAni_:Play("DiceBtn_out")

	self.auraTipsText_.text = GetTips("CHESSBOARD_ARENA_TIPS")

	local var_19_0 = manager.ChessBoardManager:GetCurChanceInfo()
	local var_19_1 = ChessBoardChanceCfg[var_19_0.chanceID]

	if arg_19_1 then
		manager.ChessBoardManager.blockerManager_:ShowBlocker()

		self.cacheAuraFunCallTime_ = 0
		self.auraAddTimer_ = Timer.New(function()
			self.cacheAuraFunCallTime_ = self.cacheAuraFunCallTime_ + 1
			self.curAuraNumText_.text = math.ceil(self.cacheAuraNum_ + (var_19_0.chanceChooseList[2] - self.cacheAuraNum_) * 0.1 * self.cacheAuraFunCallTime_)
			self.maxAuraNumText_.text = var_19_1.params[1]
			self.auraSlider_.value = (var_19_1.params[1] - (self.cacheAuraNum_ + (var_19_0.chanceChooseList[2] - self.cacheAuraNum_) * 0.1 * self.cacheAuraFunCallTime_)) / var_19_1.params[1]
			self.auraEffectSlider_.value = (var_19_1.params[1] - (self.cacheAuraNum_ + (var_19_0.chanceChooseList[2] - self.cacheAuraNum_) * 0.1 * self.cacheAuraFunCallTime_)) / var_19_1.params[1]

			if self.cacheAuraFunCallTime_ == 5 then
				if var_19_0.chanceChooseList[1] - (self.cacheAuraDiceNum_ - 1) > 0 then
					SetActive(self.auraDiceAddAniGo_, true)

					self.auraDiceAddText_.text = "+" .. var_19_0.chanceChooseList[1] - (self.cacheAuraDiceNum_ - 1)
				end
			end

			if self.cacheAuraFunCallTime_ >= 10 then
				self.curAuraDiceNumText_.text = "×" .. var_19_0.chanceChooseList[1]
				self.cacheAuraDiceNum_ = var_19_0.chanceChooseList[1]
				self.cacheAuraNum_ = var_19_0.chanceChooseList[2]
				self.curAuraNumText_.text = var_19_0.chanceChooseList[2]
				self.maxAuraNumText_.text = var_19_1.params[1]
				self.auraSlider_.value = (var_19_1.params[1] - var_19_0.chanceChooseList[2]) / var_19_1.params[1]
				self.auraEffectSlider_.value = (var_19_1.params[1] - var_19_0.chanceChooseList[2]) / var_19_1.params[1]

				if var_19_0.chanceChooseList[3] > 0 then
					self.propList:SetUnInteractable()
				else
					self.propList:StartArenaChance()
				end

				SetActive(self.auraDiceAddAniGo_, false)
				self:StopAuraAddTimer()

				local var_20_0 = manager.ChessBoardManager:CheckArenaChance()

				if var_20_0 == var_0_1.WIN then
					self.auraAni_:Play("succeed")
					manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_finish")
					manager.ChessBoardManager:AddDelayTimer(1, function()
						manager.ChessBoardManager.blockerManager_:HideBlocker()
						manager.ChessBoardManager:FinishArenaChance(true)
					end)
				elseif var_20_0 == var_0_1.LOSE then
					self.auraAni_:Play("defeat")
					manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_fail")
					manager.ChessBoardManager:AddDelayTimer(1, function()
						manager.ChessBoardManager.blockerManager_:HideBlocker()
						manager.ChessBoardManager:FinishArenaChance(false)
					end)
				elseif var_20_0 == var_0_1.UNFINISH then
					manager.ChessBoardManager.blockerManager_:HideBlocker()
				end
			end
		end, 0.1, -1)

		self.auraAddTimer_:Start()
		manager.audio:PlayEffect("minigame_activity_3_5", "minigame_activity_3_5_chess_up")
	else
		self.curAuraDiceNumText_.text = "×" .. var_19_0.chanceChooseList[1]
		self.cacheAuraDiceNum_ = var_19_0.chanceChooseList[1]
		self.cacheAuraNum_ = var_19_0.chanceChooseList[2]
		self.curAuraNumText_.text = var_19_0.chanceChooseList[2]
		self.maxAuraNumText_.text = ChessBoardChanceCfg[var_19_0.chanceID].params[1]
		self.auraSlider_.value = (ChessBoardChanceCfg[var_19_0.chanceID].params[1] - var_19_0.chanceChooseList[2]) / ChessBoardChanceCfg[var_19_0.chanceID].params[1]
		self.auraEffectSlider_.value = (ChessBoardChanceCfg[var_19_0.chanceID].params[1] - var_19_0.chanceChooseList[2]) / ChessBoardChanceCfg[var_19_0.chanceID].params[1]

		if var_19_0.chanceChooseList[3] > 0 then
			self.propList:SetUnInteractable()
		else
			self.propList:StartArenaChance()
		end

		local var_19_2 = manager.ChessBoardManager:CheckArenaChance()

		if var_19_2 == var_0_1.WIN then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
			self.auraAni_:Play("succeed")
			manager.ChessBoardManager:AddDelayTimer(1, function()
				manager.ChessBoardManager.blockerManager_:HideBlocker()
				manager.ChessBoardManager:FinishArenaChance(true)
			end)
		elseif var_19_2 == var_0_1.LOSE then
			manager.ChessBoardManager.blockerManager_:ShowBlocker()
			self.auraAni_:Play("defeat")
			manager.ChessBoardManager:AddDelayTimer(1, function()
				manager.ChessBoardManager.blockerManager_:HideBlocker()
				manager.ChessBoardManager:FinishArenaChance(false)
			end)
		elseif var_19_2 == var_0_1.UNFINISH then
			-- block empty
		end
	end
end

function ChessBoardHomeView:StopAuraAddTimer()
	if self.auraAddTimer_ then
		self.auraAddTimer_:Stop()

		self.auraAddTimer_ = nil
	end
end

function ChessBoardHomeView:OnExit()
	manager.windowBar:HideBar()
	self.taskList_:StopRender()
	self:StopDiceTimer()
	self:StopAuraAddTimer()
end

function ChessBoardHomeView:OnChessBoardGoldUpdate(arg_27_1)
	self.goldNum_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")

	if arg_27_1 then
		self:OnChessBoardTipsShow(ChessBoardConst.TIPS_TYPE.NUM_TIPS, {
			num = arg_27_1
		})
	end
end

function ChessBoardHomeView:OnChessBoardCameraZoomScale()
	self.homeTips:ClearBubbleTips()
end

function ChessBoardHomeView:OnChessBoardTipsShow(arg_29_1, arg_29_2)
	self.homeTips:UpdateTipsShow(arg_29_1, arg_29_2)

	if arg_29_1 == ChessBoardConst.TIPS_TYPE.GET_PROP then
		if arg_29_2.isGet == true then
			self.propList:CheckGetEffect()
		end
	elseif arg_29_1 == ChessBoardConst.TIPS_TYPE.EVENT_TIPS then
		self:OnChessBoardStepUpdate()
	end
end

function ChessBoardHomeView:OnChessBoardViewStateUpdate(arg_30_1, arg_30_2)
	if arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.NORMAL then
		self.viewController_:SetSelectedState("normal")

		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE") == ChessBoardConst.CHESSBOARDSTATUS_ENUM.TURN_START then
			self:UpdateDiceState(true)
		else
			self:UpdateDiceState(false)
		end
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.USE_PROP then
		self.viewController_:SetSelectedState("useProp")
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.CONTINUE_MOVE then
		self.isCanContinueMove_ = true

		self.viewController_:SetSelectedState("continueMove")

		if arg_30_2 then
			self:OnChessBoardStepUpdate()
		end
	elseif arg_30_1 == ChessBoardConst.VIEW_STATE_TYPE.DICE_SHOW then
		self:UpdateDiceState(true)
	end
end

function ChessBoardHomeView:UpdateDiceState(arg_31_1, arg_31_2)
	if arg_31_1 then
		self.isShowDice = true

		self.dicebtnAni_:Play("DiceBtn_out")
		self.propList:OnEnter()
		self:AddIdleTimer()
	else
		self.isShowDice = false

		self.propList:SetUnInteractable()

		if arg_31_2 then
			self.dicebtnAni_:Play("DiceBtn_enter")
		else
			self.dicebtnAni_:Play("DiceBtn_enter", -1, 1)
		end

		self:DelIdleTimer()
	end
end

function ChessBoardHomeView:AddIdleTimer()
	self:DelIdleTimer()

	self.idleTimer = Timer.New(function()
		manager.ChessBoardManager:PlayEntityAction(0, ChessBoardConst.ACTIONTYPE.IDLE)
		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.BUBBLE, {
			actionType = ChessBoardConst.ACTIONTYPE.IDLE
		})
	end, 5, -1)

	self.idleTimer:Start()
end

function ChessBoardHomeView:DelIdleTimer()
	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end
end

function ChessBoardHomeView:OnChessBoardPropUpdate()
	self.propList:RefreshList()

	if manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
		self.propList:SetUnInteractable()
	end
end

function ChessBoardHomeView:OnPropItemClick(arg_36_1, arg_36_2)
	if manager.ChessBoardManager:GetIsArenaChance() then
		if not arg_36_1 then
			return
		end

		if not table.indexof(ChessBoardTools.GetChessBoardGameSetting("chessboard_dice_type_prop"), arg_36_1) then
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
		if not self.isShowDice then
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

function ChessBoardHomeView:OnChessBoardBuffUpdate()
	local var_37_0, var_37_1 = manager.ChessBoardManager.heroEntity_:GetBuffData()

	if self.haveBuff_ == false and var_37_0 then
		self.buffIconAni_:Play("StateNotice")
	else
		self.buffIconAni_:Play("empty")
	end

	if var_37_0 and var_37_1 then
		self.haveBuff_ = true
		self.buffIconImg_.sprite = ChessBoardTools.GetBuffImage(var_37_1.id)

		if var_37_1.remainround == -1 then
			self.buffIconController_:SetSelectedState("noRound")
		else
			self.buffIconController_:SetSelectedState("normal")

			self.buffTimeText_.text = var_37_1.remainround > 0 and var_37_1.remainround - var_37_0.duration_ or ""
		end
	else
		self.haveBuff_ = false

		self.buffIconController_:SetSelectedState("empty")
	end
end

function ChessBoardHomeView:OnChessBoardUpdateTask()
	self:RefreshTaskList()
end

function ChessBoardHomeView:RefreshTaskList()
	self.taskIDList_ = {}

	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs((manager.ChessBoardManager.taskManager_:GetTaskList())) do
		if ChessBoardTaskPoolCfg[iter_39_0].type == ChessBoardConst.TASKTYPE.MAIN then
			table.insert(self.taskIDList_, iter_39_0)
		else
			table.insert(var_39_0, iter_39_0)
		end
	end

	for iter_39_2, iter_39_3 in pairs(var_39_0) do
		table.insert(self.taskIDList_, iter_39_3)
	end

	self.taskList_:StartScroll(#self.taskIDList_)
end

function ChessBoardHomeView:OnChessBoardCameraMove(arg_40_1)
	self.homeTips:ClearBubbleTips()
	SetActive(self.lookatBtn_.gameObject, arg_40_1)

	if arg_40_1 then
		self.homeTips:SetDiceUIShow(false)
	end

	self.homeTips:UpdateCameraMove()
end

function ChessBoardHomeView:OnPlayDiceAni(arg_41_1, arg_41_2)
	self:UpdateDiceState(false, true)
	manager.ChessBoardManager.blockerManager_:ShowBlocker()

	local var_41_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE")

	if var_41_0 == 6 then
		manager.ChessBoardManager.diceManager_:PlayDiceAni(0, ChessBoardConst.DICE_TYPE.DICE_1_6, arg_41_1)
	elseif var_41_0 == 3 then
		manager.ChessBoardManager.diceManager_:PlayDiceAni(0, ChessBoardConst.DICE_TYPE.DICE_1_3, arg_41_1)
	else
		error("骰子点数控制到了一个模型不支持的范围，点数：", var_41_0)
	end

	self.diceAniCount_ = 0

	if #arg_41_1 == 1 then
		self.diceAniType_ = ChessBoardConst.DICE_ANI_TYPE.DICE_ONE
	elseif #arg_41_1 == 2 then
		self.diceAniType_ = ChessBoardConst.DICE_ANI_TYPE.DICE_TWO
	else
		error("骰子个数控制到了一个动效不支持的范围，个数：", #arg_41_1)
	end

	if self.diceAniTimer_ then
		self:StopDiceTimer()
	else
		local var_41_1 = 0.5

		var_41_1 = ChessBoardData:GetIsFastModule() and var_41_1 / 2 or var_41_1
		self.diceAniTimer_ = Timer.New(function()
			self.diceAniCount_ = self.diceAniCount_ + 1

			if self.diceAniType_ == ChessBoardConst.DICE_ANI_TYPE.DICE_ONE then
				if self.diceAniCount_ == 3 then
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
					self.homeTips:SetDiceUIShow(true)
					self.homeTips:SetDiceController("OneDice")
					self.homeTips:PlayOneDiceAni(arg_41_1[1])
				elseif self.diceAniCount_ == 5 then
					local var_42_1 = 0

					for iter_42_2, iter_42_3 in pairs(arg_41_1) do
						var_42_1 = var_42_1 + iter_42_3
					end

					manager.ChessBoardManager.blockerManager_:HideBlocker()
					self:StopDiceTimer()

					if manager.ChessBoardManager:GetIsArenaChance() then
						local var_42_2 = manager.ChessBoardManager:GetCurChanceInfo()

						var_42_2.chanceChooseList[1] = arg_41_2.curAuraDiceNum
						var_42_2.chanceChooseList[2] = var_42_2.chanceChooseList[2] + var_42_1
						var_42_2.chanceChooseList[3] = 0

						self:RefreshArenaUI(true)
						self.homeTips:SetDiceUIShow(false)
					else
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", var_42_1)
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE)
						manager.ChessBoardManager:HeroTryToMove()
					end
				end
			elseif self.diceAniType_ == ChessBoardConst.DICE_ANI_TYPE.DICE_TWO then
				if self.diceAniCount_ == 3 then
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
					self.homeTips:SetDiceUIShow(true)
					self.homeTips:SetDiceController("TwoDice")
					self.homeTips:PlayTwoDiceAni(arg_41_1)
				elseif self.diceAniCount_ == 5 then
					self.homeTips:SetDiceController("OneDice")

					local var_42_4 = 0

					for iter_42_6, iter_42_7 in pairs(arg_41_1) do
						var_42_4 = var_42_4 + iter_42_7
					end

					self.homeTips:PlayOneDiceAni(var_42_4)
				elseif self.diceAniCount_ == 7 then
					local var_42_5 = 0

					for iter_42_8, iter_42_9 in pairs(arg_41_1) do
						var_42_5 = var_42_5 + iter_42_9
					end

					self:StopDiceTimer()
					manager.ChessBoardManager.blockerManager_:HideBlocker()

					if manager.ChessBoardManager:GetIsArenaChance() then
						local var_42_6 = manager.ChessBoardManager:GetCurChanceInfo()

						var_42_6.chanceChooseList[1] = arg_41_2.curAuraDiceNum
						var_42_6.chanceChooseList[2] = var_42_6.chanceChooseList[2] + var_42_5
						var_42_6.chanceChooseList[3] = 0

						self:RefreshArenaUI(true)
						self.homeTips:SetDiceUIShow(false)
					else
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM", var_42_5)
						manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_STATE", ChessBoardConst.CHESSBOARDSTATUS_ENUM.START_MOVE)
						manager.ChessBoardManager:HeroTryToMove()
					end
				end
			end
		end, var_41_1, 8)
	end

	self.diceAniTimer_:Start()
end

function ChessBoardHomeView:OnPlayNPCDiceAni(arg_43_1, arg_43_2)
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

	self.homeTips:SetNPCDiceUIShow(true)
	self.homeTips:SetNPCDiceController("NPCOneDice")
	self.homeTips:SetNPCMoveStepNum(var_43_1)
	manager.ChessBoardManager.NPCManager_:MoveCurNPCNextStep()
end

function ChessBoardHomeView:OnChessBoardStepUpdate()
	local var_44_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_MOVE_NUM")

	if var_44_0 > 0 then
		self.homeTips:SetDiceUIShow(true)
		self.homeTips:SetDiceController("OneDice")
		self.homeTips:SetMoveStepNum(var_44_0)
	else
		self.homeTips:SetDiceUIShow(false)
	end
end

function ChessBoardHomeView:OnChessBoardNPCStepUpdate(arg_45_1)
	if arg_45_1 > 0 then
		self.homeTips:SetNPCDiceUIShow(true)
		self.homeTips:SetNPCDiceController("NPCOneDice")
		self.homeTips:SetNPCMoveStepNum(arg_45_1)
	else
		self.homeTips:SetNPCDiceUIShow(false)
	end
end

function ChessBoardHomeView:OnChessBoardFastModuleUpdate(arg_46_1)
	if arg_46_1 then
		self.isFastController_:SetSelectedState("fast")

		self.auraAni_.speed = 2
	else
		self.isFastController_:SetSelectedState("normal")

		self.auraAni_.speed = 1
	end

	self.homeTips:OnChessBoardFastModuleUpdate(arg_46_1)
end

function ChessBoardHomeView:OnChessBoardArenaUIUpdate(arg_47_1)
	if arg_47_1 then
		self:RefreshArenaUI()
		self.homeTips:SetDiceUIShow(false)
	else
		SetActive(self.arenaGo_, false)
		SetActive(self.curAuraDiceNumGo_, false)
		SetActive(self.auraTipsGo_, false)
		self.propList:RefreshList()
	end
end

function ChessBoardHomeView:Dispose()
	self:DelIdleTimer()
	self.homeTips:Dispose()

	self.homeTips = nil

	self.propList:Dispose()

	self.propList = nil

	if self.taskList_ then
		self.taskList_:Dispose()

		self.taskList_ = nil
	end

	self.super.Dispose(self)
end

return ChessBoardHomeView
