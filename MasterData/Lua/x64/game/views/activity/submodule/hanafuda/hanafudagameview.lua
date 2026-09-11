local HanafudaGameView = class("HanafudaGameView", ReduxView)

function HanafudaGameView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaGameUI"
end

function HanafudaGameView:UIParent()
	return manager.ui.uiMain.transform
end

function HanafudaGameView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitCardPoolItem()

	self.winBar = KagutsuchiSpecialWinBarItem.New(self, self.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	HanafudaData:InitTotalCardsList()
end

function HanafudaGameView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "gameState")
	self.bellController_ = ControllerUtil.GetController(self.transform_, "bell")
	self.turnController_ = ControllerUtil.GetController(self.trunChangeTrs_, "turn")
end

function HanafudaGameView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		SetActive(self.playBtn_.gameObject, false)
		self:PlayCardByIndex(self.selectedCardIndex_)
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_7_0 = ActivityData:GetActivityData(HanafudaData:GetActivityID())

		self.startTime_ = var_7_0.startTime
		self.stopTime_ = var_7_0.stopTime

		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(self.startTime_, nil, true)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		self:RefreshEnemyScoreUI()
		self:RefreshPlayerScoreUI()
		JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
			type = 2,
			callback = function()
				self:StartDealCards()
			end
		})

		self.leftCardNumText_.text = 24
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaDescView")
	end)
	self:AddBtnListener(self.cardBtn_, nil, function()
		JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaRewardView")
	end)
	self:AddBtnListener(self.enemyCombineBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function()
				self.isOpenCheck = false
			end
		})

		self.isOpenCheck = true
	end)
	self:AddBtnListener(self.enemyCombineCardBackBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function()
				self.isOpenCheck = false
			end
		})

		self.isOpenCheck = true
	end)
	self:AddBtnListener(self.playerCombineBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function()
				self.isOpenCheck = false
			end
		})

		self.isOpenCheck = true
	end)
	self:AddBtnListener(self.combineCardBackBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function()
				self.isOpenCheck = false
			end
		})

		self.isOpenCheck = true
	end)
	self:AddBtnListener(self.bellBtn_, nil, function()
		self.bellAni_.enabled = true

		self.bellAni_:Play("Fx_bell_cx", 0, 0)
		self.bellAni_:Update(0)

		if self.isOpenDetail then
			self.isOpenDetail = false

			self.bellController_:SetSelectedState("off")
		else
			self.isOpenDetail = true

			self.bellController_:SetSelectedState("on")
		end
	end)
	self:AddBtnListener(self.descGameBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaDescView", {
			callback = function()
				self.isOpenDesc = false
			end
		})

		self.isOpenDesc = true
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		self:Back()
	end)
end

function HanafudaGameView:InitCardPoolItem()
	self.cardItemPool_ = {}

	for iter_24_0 = 1, 24 do
		local var_24_0 = HanafudaCardView.New((GameObject.Instantiate(self.cardGo_, self.cardPoolList_)))

		table.insert(self.cardItemPool_, var_24_0)
		var_24_0:SetPlayerClickCallBack(function()
			if not self.isDealingCard then
				self:ClickPlayerCard(var_24_0.index_)
			end
		end)
		var_24_0:SetPlaceClickCallBack(function()
			if not self.isDealingCard then
				self:ClickPlaceCard(var_24_0.index_)
			end
		end)
	end
end

function HanafudaGameView:PlayCardByIndex(arg_27_1)
	if not self.cardItemPool_[arg_27_1].isFaceUp_ then
		self.cardItemPool_[arg_27_1]:FlipToFaceUp()
	end

	self:MoveCardToList(self.cardItemPool_[arg_27_1].gameObject_, self.playAreaCardList_)
	HanafudaData:MoveCardToList(self.cardItemPool_[arg_27_1].data_.placeType, HanafudaData.CARD_PLACE_TYPE.PLACE, arg_27_1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_intable", "")

	if self.cardItemPool_[arg_27_1].data_.placeType ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		self:CheckPoolCards(self.cardItemPool_[arg_27_1])
	else
		self.selectedCardIndex_ = 0

		HanafudaData:NextTurn()
		self:ShowChangeTrun()
	end
end

function HanafudaGameView:ClickPlayerCard(arg_28_1)
	if self.cardItemPool_[self.selectedCardIndex_] and self.cardItemPool_[self.selectedCardIndex_].data_.placeType == HanafudaData.CARD_PLACE_TYPE.POOL then
		return
	end

	self:ShowMatchingCard(arg_28_1)

	if self.cardItemPool_[self.selectedCardIndex_] then
		self.cardItemPool_[self.selectedCardIndex_]:RefreshUI(arg_28_1)
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_click", "")
	self.cardItemPool_[arg_28_1]:RefreshUI(arg_28_1)

	self.selectedCardIndex_ = arg_28_1
end

function HanafudaGameView:ShowMatchingCard(arg_29_1)
	local var_29_0 = HanafudaData:GetMatchingCardsIndexList(arg_29_1)

	self.gameState = HanafudaData:GetGameState()

	if arg_29_1 ~= 0 and self.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		SetActive(self.playBtn_.gameObject, table.isEmpty(var_29_0))
	end

	for iter_29_0, iter_29_1 in ipairs((HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE))) do
		if table.indexof(var_29_0, iter_29_1.index) then
			self.cardItemPool_[iter_29_1.index]:RefreshUI(iter_29_1.index, true, arg_29_1)
		else
			self.cardItemPool_[iter_29_1.index]:RefreshUI(0)
		end
	end
end

function HanafudaGameView:ClickPlaceCard(arg_30_1)
	if self.selectedCardIndex_ == 0 then
		return
	end

	self.gameState = HanafudaData:GetGameState()

	local var_30_0
	local var_30_1

	if self.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		var_30_0 = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE
		var_30_1 = self.playerCombineCardList_
	elseif self.gameState == HanafudaData.GAME_STATE.COMPUTER_TURN then
		var_30_0 = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE
		var_30_1 = self.enemyCombineCardList_
	end

	local var_30_2 = self.cardItemPool_[self.selectedCardIndex_]
	local var_30_3 = self.cardItemPool_[self.selectedCardIndex_].data_.placeType

	if self.cardItemPool_[arg_30_1].data_.race == self.cardItemPool_[self.selectedCardIndex_].data_.race then
		self:ShowMatchingCard(0)

		if not var_30_2.isFaceUp_ then
			var_30_2:FlipToFaceUp()
		end

		local var_30_4 = HanafudaData:GetNewCombineList(var_30_0, {
			self.selectedCardIndex_
		}, true)

		HanafudaData:MoveCardToList(var_30_2.data_.placeType, var_30_0, self.selectedCardIndex_)

		local var_30_5 = HanafudaData:GetNewCombineList(var_30_0, {
			arg_30_1
		}, true)

		HanafudaData:MoveCardToList(self.cardItemPool_[arg_30_1].data_.placeType, var_30_0, arg_30_1)
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_inbook", "")
		self:MoveCardToList(self.cardItemPool_[arg_30_1].gameObject_, var_30_1)
		self:MoveCardToList(var_30_2.gameObject_, var_30_1)

		if self.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and (not table.isEmpty(var_30_4) or not table.isEmpty(var_30_5)) then
			for iter_30_0, iter_30_1 in ipairs(var_30_5) do
				table.insert(var_30_4, iter_30_1)
			end

			self.isShowingCombine = true

			JumpTools.OpenPageByJump("hanafudaShowCombinePopView", {
				combineIdList = var_30_4,
				callback = function()
					self.isShowingCombine = false

					self:RefreshPlayerScoreUI()
					self:RefreshUI()

					if var_30_3 == HanafudaData.CARD_PLACE_TYPE.POOL then
						self.selectedCardIndex_ = 0

						HanafudaData:NextTurn()
						self:ShowChangeTrun()
					end
				end
			})
		else
			self:RefreshEnemyScoreUI()
			self:RefreshPlayerScoreUI()
		end

		if var_30_3 ~= HanafudaData.CARD_PLACE_TYPE.POOL then
			self:CheckPoolCards(var_30_2)
		elseif not self.isShowingCombine then
			self.selectedCardIndex_ = 0

			HanafudaData:NextTurn()
			self:ShowChangeTrun()
		end

		self:RefreshPoolLeftCardUI()
	end
end

function HanafudaGameView:ShowChangeTrun()
	local var_32_0 = HanafudaData:GetGameState()

	if self.turnTimer_ then
		SetActive(self.trunChangeTrs_.gameObject, false)
		self.turnTimer_:Stop()
	end

	if var_32_0 == HanafudaData.GAME_STATE.PLAYER_TURN then
		self.turnController_:SetSelectedState("player")
		SetActive(self.trunChangeTrs_.gameObject, true)
	elseif var_32_0 == HanafudaData.GAME_STATE.COMPUTER_TURN then
		self.turnController_:SetSelectedState("enemy")
		SetActive(self.trunChangeTrs_.gameObject, true)
	end

	self.turnTimer_ = Timer.New(function()
		SetActive(self.trunChangeTrs_.gameObject, false)
	end, 1, 1, true)

	self.turnTimer_:Start()
	self:RefreshUI()
end

function HanafudaGameView:RefreshEnemyScoreUI()
	self.enemyScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
end

function HanafudaGameView:RefreshPlayerScoreUI()
	self.playerScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
end

function HanafudaGameView:RefreshPoolLeftCardUI(arg_36_1)
	self.leftCardNumText_.text = self.isDealingCard and arg_36_1 or #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL)
	self.enemyCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE)
	self.playerCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)

	local var_36_0 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE)
	local var_36_1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)

	SetActive(self.enemyCombineGo_, #var_36_0 > 0)
	SetActive(self.enemyCombineRaceTypeGo_, #var_36_0 > 0)
	SetActive(self.playerCombineGo_, #var_36_1 > 0)
	SetActive(self.playerCombineRaceTypeGo_, #var_36_1 > 0)

	if #var_36_0 > 0 then
		self.enemyCombineIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. var_36_0[#var_36_0].id)
		self.enemyCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", (string.format("icon_group_%d_c", var_36_0[#var_36_0].race)))
	end

	if #var_36_1 > 0 then
		self.playerCombineIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. var_36_1[#var_36_1].id)
		self.playerCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", (string.format("icon_group_%d_c", var_36_1[#var_36_1].race)))
	end
end

function HanafudaGameView:CheckPoolCards(arg_37_1)
	local var_37_0 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL)

	self.gameState = HanafudaData:GetGameState()

	if #var_37_0 > 0 and #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE) > 0 and arg_37_1.data_.type ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		local var_37_1 = var_37_0[#var_37_0].index

		self.selectedCardIndex_ = var_37_0[#var_37_0].index

		self:ShowMatchingCard(var_37_1)

		if self.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
			self.cardItemPool_[var_37_1]:SetFlipCallBack(function()
				self:MovePoolCardToList(self.cardItemPool_[var_37_1].gameObject_, self.playerCardList_)
			end)
		else
			self.cardItemPool_[var_37_1]:SetFlipCallBack(function()
				self:MovePoolCardToList(self.cardItemPool_[var_37_1].gameObject_, self.enemyCardList_)
			end)
		end

		self.cardItemPool_[var_37_1]:PlayFlipCardAni()
	end
end

function HanafudaGameView:UpdateSelectCardIndex(arg_40_1)
	self.selectedCardIndex_ = arg_40_1
end

function HanafudaGameView:OnEnter()
	self.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_CARD_DESCRIBE")
	self.winBar:RegistBackCallBack(function()
		self:Back()
	end)
	self:ResetAnimator(self.bellAni_, "Fx_bell_cx")

	self.isOpenCheck = false
	self.isOpenDesc = false
	self.isOpenDetail = false

	SetActive(self.playBtn_.gameObject, false)
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	self:ResetCardUI()
	self:RefreshUI()

	self.leftCardNumText_.text = 24

	if (getData("HanafudaGame", "hasPop") or 0) == 0 then
		saveData("HanafudaGame", "hasPop", 1)
		JumpTools.OpenPageByJump("hanafudaDescView")
	end

	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, (HanafudaData:GetActivityID())))
	self:AddTimer()
end

function HanafudaGameView:AddTimer()
	local var_43_0 = ActivityData:GetActivityData(KagutsuchiFishingEventData.activityID).stopTime

	self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_43_0)
	self.leftTimeTimer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_43_0 then
			self.leftTimeText_.text = GetTips("TIME_OVER")

			return
		end

		self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_43_0)
	end, 1, -1, true)

	self.leftTimeTimer_:Start()
end

function HanafudaGameView:ResetAnimator(arg_45_1, arg_45_2)
	arg_45_1:Play(arg_45_2, 0, 0)
	arg_45_1:Update(0)

	arg_45_1.enabled = false
end

function HanafudaGameView:StartDealCards()
	local var_46_0 = 24

	self.selectedCardIndex_ = 0

	local var_46_1 = HanafudaData:DealCards((HanafudaData:ShuffleCardList((HanafudaData:GetTotoalCardsList()))))

	self:RefreshUI()

	self.isDealingCard = true

	self:RefreshPoolLeftCardUI(24)

	for iter_46_0 = 24, 1, -1 do
		self.cardItemPool_[iter_46_0]:SetData(iter_46_0, var_46_1[iter_46_0])
		self.cardItemPool_[iter_46_0]:FlipToBackUp()
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_start", "")

	self.timer_ = Timer.New(function()
		if var_46_0 > 20 then
			self:MoveCardToList(self.cardItemPool_[var_46_0].gameObject_, self.playerCardList_)
			self.cardItemPool_[var_46_0]:PlayFlipCardAni()
		elseif var_46_0 > 16 then
			self:MoveCardToList(self.cardItemPool_[var_46_0].gameObject_, self.enemyCardList_)
		elseif var_46_0 > 8 then
			self:MoveCardToList(self.cardItemPool_[var_46_0].gameObject_, self.playAreaCardList_)
			self.cardItemPool_[var_46_0]:PlayFlipCardAni()
		end

		var_46_0 = var_46_0 - 1

		self:RefreshPoolLeftCardUI(var_46_0)

		if var_46_0 == 8 then
			if self.isOpenCheck or self.isOpenDesc then
				self:Back()

				self.isOpenCheck = false
				self.isOpenDesc = false
			end

			self.isDealingCard = false

			self:CheckPlayerCards()

			if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
				JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
					type = 1,
					callback = function()
						self:RefreshEnemyCardsUI()
						self:ShowChangeTrun()
					end
				})
			end
		end
	end, 0.2, 16, false)
	self.aniTimer_ = Timer.New(function()
		self.timer_:Start()
	end, 0.7, 1, true)

	self.aniTimer_:Start()
end

function HanafudaGameView:RefreshEnemyCardsUI()
	local var_50_0 = HanafudaData:GetComputerDiffculty()

	for iter_50_0, iter_50_1 in ipairs((HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMY))) do
		if var_50_0 == 1 then
			self.cardItemPool_[iter_50_1.index]:PlayFlipCardAni()
		else
			self.cardItemPool_[iter_50_1.index].gameObject_.transform.localEulerAngles = Vector3.zero
		end
	end
end

function HanafudaGameView:CheckPlayerCards()
	HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.PLAYER)

	if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
		HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end

	self:RefreshUI()
end

function HanafudaGameView:MoveCardToList(arg_52_1, arg_52_2)
	LeanTween.move(arg_52_1, arg_52_2.position, 0.4):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if self.callback then
			self.callback()
		end

		arg_52_1.transform:SetParent(arg_52_2, false)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_2)
	end))
end

function HanafudaGameView:MovePoolCardToList(arg_54_1, arg_54_2)
	local var_54_1 = self.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and 0.2 or -0.2

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_hand", "")
	LeanTween.move(arg_54_1, Vector3(0, arg_54_2.position.y + var_54_1, arg_54_2.position.z), 0.4):setEase(LeanTweenType.easeOutCubic)
end

function HanafudaGameView:RefreshUI()
	local var_55_0 = HanafudaData:GetGameState()

	if var_55_0 == HanafudaData.GAME_STATE.STOP then
		self.stateController_:SetSelectedState("stop")
		self.bellController_:SetSelectedState("off")

		for iter_55_0, iter_55_1 in ipairs(self.cardItemPool_) do
			iter_55_1.gameObject_.transform:SetParent(self.cardPoolList_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.cardPoolList_)
		self:ResetAnimator(self.bgAni_, "Fx_JapanRegionHanafudaGameUI_cx")
	else
		self.bgAni_.enabled = true

		self.stateController_:SetSelectedState("start")
	end

	if var_55_0 == HanafudaData.GAME_STATE.GAMEOVER and not self.isShowingCombine and not self.isDealingCard then
		KagutsuchiHanafudaAction.SendHanafudaGameOver(HanafudaData:GetActivityID(), HanafudaData:GetIsSuccess(), HanafudaData:GetPlayerCombineIDList())

		if self.isOpenCheck or self.isOpenDesc then
			self:Back()

			self.isOpenCheck = false
			self.isOpenDesc = false
		end

		JumpTools.OpenPageByJump("hanafudaGameOverPopView", {
			callback = function()
				self:RefreshUI()
			end
		})
	end

	self:RefreshPoolLeftCardUI()
end

function HanafudaGameView:ResetCardUI()
	for iter_57_0, iter_57_1 in ipairs(self.cardItemPool_) do
		self:MoveCardToList(iter_57_1.gameObject_, self.cardPoolList_)

		iter_57_1.gameObject_.transform.localEulerAngles = Vector3.zero
		iter_57_1.flipCallBack = nil
	end
end

function HanafudaGameView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	if self.leftTimeTimer_ then
		self.leftTimeTimer_:Stop()

		self.leftTimeTimer_ = nil
	end

	HanafudaComputer.Stop()
	self:ResetCardUI()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, (HanafudaData:GetActivityID())))
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	self:ResetCardUI()
end

function HanafudaGameView:Dispose()
	HanafudaGameView.super.Dispose(self)

	for iter_59_0, iter_59_1 in ipairs(self.cardItemPool_) do
		iter_59_1:Dispose()
	end

	self.cardItemPool_ = nil

	self.winBar:Dispose()
end

return HanafudaGameView
