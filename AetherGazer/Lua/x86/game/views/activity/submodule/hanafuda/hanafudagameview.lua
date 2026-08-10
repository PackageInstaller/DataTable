local var_0_0 = class("HanafudaGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:InitCardPoolItem()

	arg_3_0.winBar = KagutsuchiSpecialWinBarItem.New(arg_3_0, arg_3_0.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	HanafudaData:InitTotalCardsList()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = ControllerUtil.GetController(arg_4_0.transform_, "gameState")
	arg_4_0.bellController_ = ControllerUtil.GetController(arg_4_0.transform_, "bell")
	arg_4_0.turnController_ = ControllerUtil.GetController(arg_4_0.trunChangeTrs_, "turn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.playBtn_, nil, function()
		SetActive(arg_5_0.playBtn_.gameObject, false)
		arg_5_0:PlayCardByIndex(arg_5_0.selectedCardIndex_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		local var_7_0 = ActivityData:GetActivityData(HanafudaData:GetActivityID())

		arg_5_0.startTime_ = var_7_0.startTime
		arg_5_0.stopTime_ = var_7_0.stopTime

		if manager.time:GetServerTime() < arg_5_0.startTime_ then
			local var_7_1 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_7_1, manager.time:GetLostTimeStr2(arg_5_0.startTime_, nil, true)))

			return
		end

		if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		arg_5_0:RefreshEnemyScoreUI()
		arg_5_0:RefreshPlayerScoreUI()
		JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
			type = 2,
			callback = function()
				arg_5_0:StartDealCards()
			end
		})

		arg_5_0.leftCardNumText_.text = 24
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaDescView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.cardBtn_, nil, function()
		JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaRewardView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.enemyCombineBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function()
				arg_5_0.isOpenCheck = false
			end
		})

		arg_5_0.isOpenCheck = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.enemyCombineCardBackBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE,
			callback = function()
				arg_5_0.isOpenCheck = false
			end
		})

		arg_5_0.isOpenCheck = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.playerCombineBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function()
				arg_5_0.isOpenCheck = false
			end
		})

		arg_5_0.isOpenCheck = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.combineCardBackBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaCheckCombineView", {
			playerType = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE,
			callback = function()
				arg_5_0.isOpenCheck = false
			end
		})

		arg_5_0.isOpenCheck = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.bellBtn_, nil, function()
		arg_5_0.bellAni_.enabled = true

		arg_5_0.bellAni_:Play("Fx_bell_cx", 0, 0)
		arg_5_0.bellAni_:Update(0)

		if arg_5_0.isOpenDetail then
			arg_5_0.isOpenDetail = false

			arg_5_0.bellController_:SetSelectedState("off")
		else
			arg_5_0.isOpenDetail = true

			arg_5_0.bellController_:SetSelectedState("on")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.descGameBtn_, nil, function()
		JumpTools.OpenPageByJump("hanafudaDescView", {
			callback = function()
				arg_5_0.isOpenDesc = false
			end
		})

		arg_5_0.isOpenDesc = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.giveUpBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.InitCardPoolItem(arg_24_0)
	arg_24_0.cardItemPool_ = {}

	for iter_24_0 = 1, 24 do
		local var_24_0 = GameObject.Instantiate(arg_24_0.cardGo_, arg_24_0.cardPoolList_)
		local var_24_1 = HanafudaCardView.New(var_24_0)

		table.insert(arg_24_0.cardItemPool_, var_24_1)
		var_24_1:SetPlayerClickCallBack(function()
			if not arg_24_0.isDealingCard then
				arg_24_0:ClickPlayerCard(var_24_1.index_)
			end
		end)
		var_24_1:SetPlaceClickCallBack(function()
			if not arg_24_0.isDealingCard then
				arg_24_0:ClickPlaceCard(var_24_1.index_)
			end
		end)
	end
end

function var_0_0.PlayCardByIndex(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.cardItemPool_[arg_27_1]
	local var_27_1 = arg_27_0.cardItemPool_[arg_27_1].data_.placeType

	if not var_27_0.isFaceUp_ then
		var_27_0:FlipToFaceUp()
	end

	arg_27_0:MoveCardToList(var_27_0.gameObject_, arg_27_0.playAreaCardList_)
	HanafudaData:MoveCardToList(var_27_1, HanafudaData.CARD_PLACE_TYPE.PLACE, arg_27_1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_intable", "")

	if var_27_1 ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		arg_27_0:CheckPoolCards(var_27_0)
	else
		arg_27_0.selectedCardIndex_ = 0

		HanafudaData:NextTurn()
		arg_27_0:ShowChangeTrun()
	end
end

function var_0_0.ClickPlayerCard(arg_28_0, arg_28_1)
	if arg_28_0.cardItemPool_[arg_28_0.selectedCardIndex_] and arg_28_0.cardItemPool_[arg_28_0.selectedCardIndex_].data_.placeType == HanafudaData.CARD_PLACE_TYPE.POOL then
		return
	end

	arg_28_0:ShowMatchingCard(arg_28_1)

	if arg_28_0.cardItemPool_[arg_28_0.selectedCardIndex_] then
		arg_28_0.cardItemPool_[arg_28_0.selectedCardIndex_]:RefreshUI(arg_28_1)
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_click", "")
	arg_28_0.cardItemPool_[arg_28_1]:RefreshUI(arg_28_1)

	arg_28_0.selectedCardIndex_ = arg_28_1
end

function var_0_0.ShowMatchingCard(arg_29_0, arg_29_1)
	local var_29_0 = HanafudaData:GetMatchingCardsIndexList(arg_29_1)
	local var_29_1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE)

	arg_29_0.gameState = HanafudaData:GetGameState()

	if arg_29_1 ~= 0 and arg_29_0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		SetActive(arg_29_0.playBtn_.gameObject, table.isEmpty(var_29_0))
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		if table.indexof(var_29_0, iter_29_1.index) then
			arg_29_0.cardItemPool_[iter_29_1.index]:RefreshUI(iter_29_1.index, true, arg_29_1)
		else
			arg_29_0.cardItemPool_[iter_29_1.index]:RefreshUI(0)
		end
	end
end

function var_0_0.ClickPlaceCard(arg_30_0, arg_30_1)
	if arg_30_0.selectedCardIndex_ == 0 then
		return
	end

	arg_30_0.gameState = HanafudaData:GetGameState()

	local var_30_0
	local var_30_1

	if arg_30_0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
		var_30_0 = HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE
		var_30_1 = arg_30_0.playerCombineCardList_
	elseif arg_30_0.gameState == HanafudaData.GAME_STATE.COMPUTER_TURN then
		var_30_0 = HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE
		var_30_1 = arg_30_0.enemyCombineCardList_
	end

	local var_30_2 = arg_30_0.cardItemPool_[arg_30_0.selectedCardIndex_]
	local var_30_3 = var_30_2.data_.placeType
	local var_30_4 = arg_30_0.cardItemPool_[arg_30_1]

	if var_30_4.data_.race == var_30_2.data_.race then
		arg_30_0:ShowMatchingCard(0)

		if not var_30_2.isFaceUp_ then
			var_30_2:FlipToFaceUp()
		end

		local var_30_5 = HanafudaData:GetNewCombineList(var_30_0, {
			arg_30_0.selectedCardIndex_
		}, true)

		HanafudaData:MoveCardToList(var_30_2.data_.placeType, var_30_0, arg_30_0.selectedCardIndex_)

		local var_30_6 = HanafudaData:GetNewCombineList(var_30_0, {
			arg_30_1
		}, true)

		HanafudaData:MoveCardToList(var_30_4.data_.placeType, var_30_0, arg_30_1)
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_inbook", "")
		arg_30_0:MoveCardToList(var_30_4.gameObject_, var_30_1)
		arg_30_0:MoveCardToList(var_30_2.gameObject_, var_30_1)

		if arg_30_0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and (not table.isEmpty(var_30_5) or not table.isEmpty(var_30_6)) then
			for iter_30_0, iter_30_1 in ipairs(var_30_6) do
				table.insert(var_30_5, iter_30_1)
			end

			arg_30_0.isShowingCombine = true

			JumpTools.OpenPageByJump("hanafudaShowCombinePopView", {
				combineIdList = var_30_5,
				callback = function()
					arg_30_0.isShowingCombine = false

					arg_30_0:RefreshPlayerScoreUI()
					arg_30_0:RefreshUI()

					if var_30_3 == HanafudaData.CARD_PLACE_TYPE.POOL then
						arg_30_0.selectedCardIndex_ = 0

						HanafudaData:NextTurn()
						arg_30_0:ShowChangeTrun()
					end
				end
			})
		else
			arg_30_0:RefreshEnemyScoreUI()
			arg_30_0:RefreshPlayerScoreUI()
		end

		if var_30_3 ~= HanafudaData.CARD_PLACE_TYPE.POOL then
			arg_30_0:CheckPoolCards(var_30_2)
		elseif not arg_30_0.isShowingCombine then
			arg_30_0.selectedCardIndex_ = 0

			HanafudaData:NextTurn()
			arg_30_0:ShowChangeTrun()
		end

		arg_30_0:RefreshPoolLeftCardUI()
	end
end

function var_0_0.ShowChangeTrun(arg_32_0)
	local var_32_0 = HanafudaData:GetGameState()

	if arg_32_0.turnTimer_ then
		SetActive(arg_32_0.trunChangeTrs_.gameObject, false)
		arg_32_0.turnTimer_:Stop()
	end

	if var_32_0 == HanafudaData.GAME_STATE.PLAYER_TURN then
		arg_32_0.turnController_:SetSelectedState("player")
		SetActive(arg_32_0.trunChangeTrs_.gameObject, true)
	elseif var_32_0 == HanafudaData.GAME_STATE.COMPUTER_TURN then
		arg_32_0.turnController_:SetSelectedState("enemy")
		SetActive(arg_32_0.trunChangeTrs_.gameObject, true)
	end

	arg_32_0.turnTimer_ = Timer.New(function()
		SetActive(arg_32_0.trunChangeTrs_.gameObject, false)
	end, 1, 1, true)

	arg_32_0.turnTimer_:Start()
	arg_32_0:RefreshUI()
end

function var_0_0.RefreshEnemyScoreUI(arg_34_0)
	arg_34_0.enemyScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)
end

function var_0_0.RefreshPlayerScoreUI(arg_35_0)
	arg_35_0.playerScoreText_.text = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
end

function var_0_0.RefreshPoolLeftCardUI(arg_36_0, arg_36_1)
	if arg_36_0.isDealingCard then
		arg_36_0.leftCardNumText_.text = arg_36_1
	else
		arg_36_0.leftCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL)
	end

	arg_36_0.enemyCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE)
	arg_36_0.playerCombineCardNumText_.text = #HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)

	local var_36_0 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMYCOMBINE)
	local var_36_1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE)

	SetActive(arg_36_0.enemyCombineGo_, #var_36_0 > 0)
	SetActive(arg_36_0.enemyCombineRaceTypeGo_, #var_36_0 > 0)
	SetActive(arg_36_0.playerCombineGo_, #var_36_1 > 0)
	SetActive(arg_36_0.playerCombineRaceTypeGo_, #var_36_1 > 0)

	if #var_36_0 > 0 then
		local var_36_2 = var_36_0[#var_36_0]
		local var_36_3 = string.format("icon_group_%d_c", var_36_2.race)

		arg_36_0.enemyCombineIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. var_36_2.id)
		arg_36_0.enemyCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", var_36_3)
	end

	if #var_36_1 > 0 then
		local var_36_4 = var_36_1[#var_36_1]
		local var_36_5 = string.format("icon_group_%d_c", var_36_4.race)

		arg_36_0.playerCombineIconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. var_36_4.id)
		arg_36_0.playerCombineRaceTypeImg_.sprite = getSprite("Atlas/CampItemAtlas", var_36_5)
	end
end

function var_0_0.CheckPoolCards(arg_37_0, arg_37_1)
	local var_37_0 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL)
	local var_37_1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.PLACE)

	arg_37_0.gameState = HanafudaData:GetGameState()

	if #var_37_0 > 0 and #var_37_1 > 0 and arg_37_1.data_.type ~= HanafudaData.CARD_PLACE_TYPE.POOL then
		local var_37_2 = var_37_0[#var_37_0].index

		arg_37_0.selectedCardIndex_ = var_37_2

		arg_37_0:ShowMatchingCard(var_37_2)

		if arg_37_0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN then
			arg_37_0.cardItemPool_[var_37_2]:SetFlipCallBack(function()
				arg_37_0:MovePoolCardToList(arg_37_0.cardItemPool_[var_37_2].gameObject_, arg_37_0.playerCardList_)
			end)
		else
			arg_37_0.cardItemPool_[var_37_2]:SetFlipCallBack(function()
				arg_37_0:MovePoolCardToList(arg_37_0.cardItemPool_[var_37_2].gameObject_, arg_37_0.enemyCardList_)
			end)
		end

		arg_37_0.cardItemPool_[var_37_2]:PlayFlipCardAni()
	end
end

function var_0_0.UpdateSelectCardIndex(arg_40_0, arg_40_1)
	arg_40_0.selectedCardIndex_ = arg_40_1
end

function var_0_0.OnEnter(arg_41_0)
	local var_41_0 = HanafudaData:GetActivityID()

	arg_41_0.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_CARD_DESCRIBE")
	arg_41_0.winBar:RegistBackCallBack(function()
		arg_41_0:Back()
	end)
	arg_41_0:ResetAnimator(arg_41_0.bellAni_, "Fx_bell_cx")

	arg_41_0.isOpenCheck = false
	arg_41_0.isOpenDesc = false
	arg_41_0.isOpenDetail = false

	SetActive(arg_41_0.playBtn_.gameObject, false)
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	arg_41_0:ResetCardUI()
	arg_41_0:RefreshUI()

	arg_41_0.leftCardNumText_.text = 24

	if (getData("HanafudaGame", "hasPop") or 0) == 0 then
		saveData("HanafudaGame", "hasPop", 1)
		JumpTools.OpenPageByJump("hanafudaDescView")
	end

	manager.redPoint:bindUIandKey(arg_41_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, var_41_0))
	arg_41_0:AddTimer()
end

function var_0_0.AddTimer(arg_43_0)
	local var_43_0 = KagutsuchiFishingEventData.activityID
	local var_43_1 = ActivityData:GetActivityData(var_43_0).stopTime

	arg_43_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_43_1)
	arg_43_0.leftTimeTimer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_43_1 then
			arg_43_0.leftTimeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_43_0.leftTimeText_.text = manager.time:GetLostTimeStr2(var_43_1)
	end, 1, -1, true)

	arg_43_0.leftTimeTimer_:Start()
end

function var_0_0.ResetAnimator(arg_45_0, arg_45_1, arg_45_2)
	arg_45_1:Play(arg_45_2, 0, 0)
	arg_45_1:Update(0)

	arg_45_1.enabled = false
end

function var_0_0.StartDealCards(arg_46_0)
	local var_46_0 = 24
	local var_46_1 = HanafudaData:GetTotoalCardsList()
	local var_46_2 = HanafudaData:ShuffleCardList(var_46_1)

	arg_46_0.selectedCardIndex_ = 0

	local var_46_3 = HanafudaData:DealCards(var_46_2)

	arg_46_0:RefreshUI()

	arg_46_0.isDealingCard = true

	arg_46_0:RefreshPoolLeftCardUI(var_46_0)

	for iter_46_0 = 24, 1, -1 do
		arg_46_0.cardItemPool_[iter_46_0]:SetData(iter_46_0, var_46_3[iter_46_0])
		arg_46_0.cardItemPool_[iter_46_0]:FlipToBackUp()
	end

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_start", "")

	arg_46_0.timer_ = Timer.New(function()
		local var_47_0 = arg_46_0.cardItemPool_[var_46_0].gameObject_

		if var_46_0 > 20 then
			arg_46_0:MoveCardToList(var_47_0, arg_46_0.playerCardList_)
			arg_46_0.cardItemPool_[var_46_0]:PlayFlipCardAni()
		elseif var_46_0 > 16 then
			arg_46_0:MoveCardToList(var_47_0, arg_46_0.enemyCardList_)
		elseif var_46_0 > 8 then
			arg_46_0:MoveCardToList(var_47_0, arg_46_0.playAreaCardList_)
			arg_46_0.cardItemPool_[var_46_0]:PlayFlipCardAni()
		end

		var_46_0 = var_46_0 - 1

		arg_46_0:RefreshPoolLeftCardUI(var_46_0)

		if var_46_0 == 8 then
			if arg_46_0.isOpenCheck or arg_46_0.isOpenDesc then
				arg_46_0:Back()

				arg_46_0.isOpenCheck = false
				arg_46_0.isOpenDesc = false
			end

			arg_46_0.isDealingCard = false

			arg_46_0:CheckPlayerCards()

			if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
				JumpTools.OpenPageByJump("hanafudaSelectFirstPopView", {
					type = 1,
					callback = function()
						arg_46_0:RefreshEnemyCardsUI()
						arg_46_0:ShowChangeTrun()
					end
				})
			end
		end
	end, 0.2, 16, false)
	arg_46_0.aniTimer_ = Timer.New(function()
		arg_46_0.timer_:Start()
	end, 0.7, 1, true)

	arg_46_0.aniTimer_:Start()
end

function var_0_0.RefreshEnemyCardsUI(arg_50_0)
	local var_50_0 = HanafudaData:GetComputerDiffculty()
	local var_50_1 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		if var_50_0 == 1 then
			arg_50_0.cardItemPool_[iter_50_1.index]:PlayFlipCardAni()
		else
			arg_50_0.cardItemPool_[iter_50_1.index].gameObject_.transform.localEulerAngles = Vector3.zero
		end
	end
end

function var_0_0.CheckPlayerCards(arg_51_0)
	HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.PLAYER)

	if HanafudaData:GetGameState() ~= HanafudaData.GAME_STATE.GAMEOVER then
		HanafudaData:CheckPlayerCards(HanafudaData.CARD_PLACE_TYPE.ENEMY)
	end

	arg_51_0:RefreshUI()
end

function var_0_0.MoveCardToList(arg_52_0, arg_52_1, arg_52_2)
	LeanTween.move(arg_52_1, arg_52_2.position, 0.4):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if arg_52_0.callback then
			arg_52_0.callback()
		end

		arg_52_1.transform:SetParent(arg_52_2, false)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_2)
	end))
end

function var_0_0.MovePoolCardToList(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = 0
	local var_54_1 = arg_54_0.gameState == HanafudaData.GAME_STATE.PLAYER_TURN and 0.2 or -0.2

	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_hand", "")
	LeanTween.move(arg_54_1, Vector3(0, arg_54_2.position.y + var_54_1, arg_54_2.position.z), 0.4):setEase(LeanTweenType.easeOutCubic)
end

function var_0_0.RefreshUI(arg_55_0)
	local var_55_0 = HanafudaData:GetGameState()

	if var_55_0 == HanafudaData.GAME_STATE.STOP then
		arg_55_0.stateController_:SetSelectedState("stop")
		arg_55_0.bellController_:SetSelectedState("off")

		for iter_55_0, iter_55_1 in ipairs(arg_55_0.cardItemPool_) do
			iter_55_1.gameObject_.transform:SetParent(arg_55_0.cardPoolList_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_0.cardPoolList_)
		arg_55_0:ResetAnimator(arg_55_0.bgAni_, "Fx_JapanRegionHanafudaGameUI_cx")
	else
		arg_55_0.bgAni_.enabled = true

		arg_55_0.stateController_:SetSelectedState("start")
	end

	if var_55_0 == HanafudaData.GAME_STATE.GAMEOVER and not arg_55_0.isShowingCombine and not arg_55_0.isDealingCard then
		KagutsuchiHanafudaAction.SendHanafudaGameOver(HanafudaData:GetActivityID(), HanafudaData:GetIsSuccess(), HanafudaData:GetPlayerCombineIDList())

		if arg_55_0.isOpenCheck or arg_55_0.isOpenDesc then
			arg_55_0:Back()

			arg_55_0.isOpenCheck = false
			arg_55_0.isOpenDesc = false
		end

		JumpTools.OpenPageByJump("hanafudaGameOverPopView", {
			callback = function()
				arg_55_0:RefreshUI()
			end
		})
	end

	arg_55_0:RefreshPoolLeftCardUI()
end

function var_0_0.ResetCardUI(arg_57_0)
	for iter_57_0, iter_57_1 in ipairs(arg_57_0.cardItemPool_) do
		arg_57_0:MoveCardToList(iter_57_1.gameObject_, arg_57_0.cardPoolList_)

		iter_57_1.gameObject_.transform.localEulerAngles = Vector3.zero
		iter_57_1.flipCallBack = nil
	end
end

function var_0_0.OnExit(arg_58_0)
	if arg_58_0.timer_ then
		arg_58_0.timer_:Stop()

		arg_58_0.timer_ = nil
	end

	if arg_58_0.aniTimer_ then
		arg_58_0.aniTimer_:Stop()

		arg_58_0.aniTimer_ = nil
	end

	if arg_58_0.leftTimeTimer_ then
		arg_58_0.leftTimeTimer_:Stop()

		arg_58_0.leftTimeTimer_ = nil
	end

	HanafudaComputer.Stop()
	arg_58_0:ResetCardUI()

	local var_58_0 = HanafudaData:GetActivityID()

	manager.redPoint:unbindUIandKey(arg_58_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, var_58_0))
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	arg_58_0:ResetCardUI()
end

function var_0_0.Dispose(arg_59_0)
	var_0_0.super.Dispose(arg_59_0)

	for iter_59_0, iter_59_1 in ipairs(arg_59_0.cardItemPool_) do
		iter_59_1:Dispose()
	end

	arg_59_0.cardItemPool_ = nil

	arg_59_0.winBar:Dispose()
end

return var_0_0
