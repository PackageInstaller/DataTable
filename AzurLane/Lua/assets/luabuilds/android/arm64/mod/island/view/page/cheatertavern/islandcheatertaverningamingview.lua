local var_0_0 = class("IslandCheaterTavernInGamingView", import(".IslandCheaterTavernBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

local var_0_1 = {
	129,
	-52
}
local var_0_2 = {
	{
		-406,
		205
	},
	{
		243,
		356
	},
	{
		406,
		152
	}
}

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.playerHudTFDic = {}
	arg_2_0.uiplayerHudInfoList = UIItemList.New(arg_2_0.uiplayerInfoList, arg_2_0.uiplayerInfoItem)

	arg_2_0.uiplayerHudInfoList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			arg_2_0:OnInitPlayerHudInfoItem(arg_3_1, arg_3_2)
		elseif arg_3_0 == UIItemList.EventUpdate then
			arg_2_0:OnUpdatePlayerHudInfoItem(arg_3_1, arg_3_2)
		end

		return
	end)
	arg_2_0.uiplayerHudInfoList:each(function(arg_4_0, arg_4_1)
		arg_2_0:OnInitPlayerHudInfoItem(arg_4_0, arg_4_1)

		return
	end)
	setText(arg_2_0.uicurHpNum, string.format("%s/%s", pg.gameset.bar_punishment_limit.key_value, pg.gameset.bar_punishment_limit.key_value))
	onButton(arg_2_0, arg_2_0.uiqueryBtn, function()
		arg_2_0:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.Query)

		return
	end)

	local var_2_0 = GetOrAddComponent(arg_2_0.uishootBtn, "EventTriggerListener")
	local var_2_1 = 10

	var_2_0:AddPointDownFunc(function(arg_6_0, arg_6_1)
		startPos = arg_6_1.position
		hasTriggered = false

		return
	end)
	var_2_0:AddDragFunc(function(arg_7_0, arg_7_1)
		if hasTriggered or not startPos then
			return
		end

		if (arg_7_1.position - startPos).magnitude >= var_2_1 then
			hasTriggered = true

			arg_2_0:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.Shoot)
		end

		return
	end)
	var_2_0:AddPointUpFunc(function(arg_8_0, arg_8_1)
		startPos = nil

		return
	end)
	onButton(arg_2_0, arg_2_0.uiDelegate, function()
		arg_2_0:emit(IslandMediator.CHEATER_TAVERN_CANCEL_DELEGATE)

		return
	end)
	onButton(arg_2_0, arg_2_0.uiputCardBtn, function()
		local var_10_0 = arg_2_0.cardViewManager:GetSelectCardKeyList()

		if IslandCheaterTavernConst.putCardTest then
			arg_2_0.cardViewManager:PutDownMainCard(var_10_0)

			return
		end

		local var_10_1 = #var_10_0

		if #var_10_0 == 0 or var_10_1 > IslandCheaterTavernConst.putCountMax then
			return
		end

		arg_2_0:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.PutCard, var_10_0)

		return
	end)

	arg_2_0.timeMgr = pg.TimeMgr.GetInstance()
	arg_2_0.cardViewManager = IslandCheaterTavernCardViewManager.New(arg_2_0.uicardList)

	setText(arg_2_0.uiScoreNum, (PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID())))
	setText(arg_2_0.uireakCardbgText, i18n("bar_ui_start2"))
	setText(arg_2_0.uireakCardTipText, i18n("bar_ui_start1"))
	setText(arg_2_0.uiScoreTitle, i18n("bar_ui_game3"))
	setText(arg_2_0.uishootText, i18n("bar_ui_game4"))
	setText(arg_2_0.uiOutText, i18n("bar_ui_game1"))
	setActive(arg_2_0.uiTipsTf, false)
	setParent(arg_2_0.uiTipsTf, pg.UIMgr.GetInstance().OverlayToast)
	arg_2_0.cheaterTavernAgency:SetUILoadOver(true)

	return
end

function var_0_0.OnCheaterOperateDone(arg_11_0, arg_11_1)
	if arg_11_1.type == IslandCheaterTavernConst.PlayerOperateType.PutCard then
		setActive(arg_11_0.uiopBtn, false)
		arg_11_0:PutMainCardDone(arg_11_1.arg_list)
	elseif arg_11_1.type == IslandCheaterTavernConst.PlayerOperateType.Shoot then
		setActive(arg_11_0.uishootOp, false)
	else
		setActive(arg_11_0.uiopBtn, false)
	end

	return
end

function var_0_0.PutMainCardDone(arg_12_0, arg_12_1)
	arg_12_0.cardViewManager:PutDownMainCard(arg_12_1)

	arg_12_0.cardDataList = arg_12_0.cheaterTavernAgency:GetMainPlayerCards()

	arg_12_0.cardViewManager:RefreshMainCard(arg_12_0.cardDataList)

	return
end

function var_0_0.StartLastBountPerformTimer(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 <= 0 then
		existCall(arg_13_2)

		return
	end

	arg_13_0.lastBountPerformTimer = Timer.New(function()
		existCall(arg_13_2)

		return
	end, arg_13_1, 1)

	arg_13_0.lastBountPerformTimer:Start()

	return
end

function var_0_0.StopLastBountPerformTimer(arg_15_0)
	if arg_15_0.lastBountPerformTimer then
		arg_15_0.lastBountPerformTimer:Stop()

		arg_15_0.lastBountPerformTimer = nil
	end

	return
end

function var_0_0.HideCurrentBoutCoundDown(arg_16_0)
	setActive(arg_16_0.uicountDown, false)
	arg_16_0:StopRoundCoundDown()

	return
end

function var_0_0.UpdataLastBoutDisplay(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.user_id
	local var_17_1 = 0
	local var_17_2
	local var_17_3 = getProxy(PlayerProxy)
	local var_17_4

	if arg_17_1.user_id ~= var_17_3:getRawData().id or not arg_17_0.cheaterTavernAgency:GetMainPlayer() then
		var_17_4 = arg_17_0.cheaterTavernAgency:GetPlayerData(arg_17_1.user_id)
	end

	local var_17_5 = getProxy(PlayerProxy)
	local var_17_6 = var_17_5:getRawData().id

	local function var_17_7()
		if var_0 then
			setActive(arg_17_0.uiopBtn, false)
		end

		return
	end

	switch(arg_17_1.type, {
		[IslandCheaterTavernConst.PlayerOperateType.PutCard] = function()
			var_17_7()
			arg_17_0.cardViewManager:ClearTableCard()

			if var_0 then
				if arg_17_2 then
					arg_17_0.cardViewManager:PutDownMainCard(arg_17_2)

					arg_17_0.cardDataList = arg_17_0.cheaterTavernAgency:GetMainPlayerCards()

					arg_17_0.cardViewManager:RefreshMainCard(arg_17_0.cardDataList)
				end
			else
				arg_17_0.cardViewManager:OtherPlayerPutCard(var_17_0, arg_17_1.return_list[2])
			end

			arg_17_0.tableCardNum = arg_17_1.return_list[2]

			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Query] = function()
			var_17_7()

			arg_17_0.tableCardNum = 0
			arg_17_0.deskCardList = {}

			local var_20_0 = arg_17_1.return_list[1]

			setActive(arg_17_0.uiqueryEffect, true)

			if var_0 then
				setAnchoredPosition(arg_17_0.uiqueryEffect, Vector2(var_0_1[1], var_0_1[2]))
			else
				setAnchoredPosition(arg_17_0.uiqueryEffect, Vector2(var_0_2[arg_17_0.playerUserIndexDic[var_17_0]][1], var_0_2[arg_17_0.playerUserIndexDic[var_17_0]][2]))
			end

			local var_20_2

			if var_0 then
				var_20_2 = var_17_4.seat

				CheatTavernCameraMgr.instance:ActiveVirtualCamera("questSeet0" .. var_17_4.seat)
				onNextTick(function()
					arg_17_0:UpdatePlayerHudInfo()

					return
				end)
			else
				arg_17_0.cardViewManager:PlayerCardSetActive(var_17_0, false)
			end

			arg_17_0.parent:emitCore(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, var_17_0, var_0, var_20_2)

			local function var_20_3()
				if var_0 then
					CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. var_20_2)
					onNextTick(function()
						arg_17_0:UpdatePlayerHudInfo()

						return
					end)
				else
					arg_17_0.cardViewManager:PlayerCardSetActive(var_17_0, true)
				end

				setActive(arg_17_0.uiqueryEffect, false)
				CheatTavernCameraMgr.instance:ActiveVirtualCamera("shootSeet0" .. arg_17_0.cheaterTavernAgency:GetMainPlayer().seat)
				arg_17_0.cardViewManager:PlayerCardSetActive(var_17_6, false)

				for iter_22_0 = 2, #arg_17_1.return_list do
					table.insert({}, arg_17_1.return_list[iter_22_0])
				end

				arg_17_0.cardViewManager:FlipTableCard({})

				return
			end

			local function var_20_4()
				local var_24_0 = arg_17_0.cheaterTavernAgency:GetPlayerData(var_17_0):GetName()
				local var_24_1 = arg_17_0.cheaterTavernAgency:GetPlayerData(arg_17_1.next_user_id):GetName()

				arg_17_0:ShowTips(i18n(var_20_0 == 1 and "bar_tips_game1" or "bar_tips_game2", var_24_0), i18n("bar_tips_game5", var_20_0 == 1 and var_24_1 or var_24_0))

				return
			end

			if arg_17_0.questionTimer then
				arg_17_0.questionTimer:Stop()
			end

			arg_17_0.questionTimer = Timer.New(function()
				var_20_3()

				return
			end, 2, 1)

			if arg_17_0.tipsTimer then
				arg_17_0.tipsTimer:Stop()
			end

			arg_17_0.tipsTimer = Timer.New(function()
				var_20_4()

				return
			end, 3.5, 1)

			arg_17_0.questionTimer:Start()
			arg_17_0.tipsTimer:Start()

			var_17_1 = pg.gameset.bar_question_time.key_value

			function var_17_2()
				setActive(arg_17_0.uiTipsTf, false)

				return
			end

			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Shoot] = function()
			var_17_7()

			if var_0 then
				setActive(arg_17_0.uishootOp, false)
			end

			arg_17_0.cardViewManager:ClearTableCard()

			local var_28_0 = arg_17_1.return_list[2]
			local var_28_1 = arg_17_0.cheaterTavernAgency:GetMainPlayer().seat
			local var_28_2, var_28_3 = var_17_4:GetCurrentBombId()

			arg_17_0.parent:emitCore(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, var_0, var_17_4.seat, var_28_2, var_28_3, var_28_0 == 1)

			var_17_1 = pg.gameset.bar_punishment_turntable_time.key_value

			function var_17_2()
				CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. var_28_1)
				arg_17_0.cardViewManager:PlayerCardSetActive(var_17_6, true)
				arg_17_0:ShowTips(i18n(var_28_0 == 1 and "bar_tips_game3" or "bar_tips_game4", (var_17_4:GetName())))

				if var_28_0 == 1 then
					local var_29_0, var_29_1, var_29_2, var_29_3, var_29_4

					if var_0 then
						arg_17_0.cardViewManager:DestroyMainCard()
					else
						arg_17_0.cardViewManager:OtherPlayerCardDestroy(var_17_0)

						var_29_0 = arg_17_0.parent
						var_29_1 = arg_17_0.parent.emitCore
						var_29_2 = CheaterTavernEvent.PLAYER_OUT_ANIMATION
						var_29_3 = var_17_0
						var_29_4 = getProxy(PlayerProxy)
					end

					var_29_1(var_29_0, var_29_2, var_29_3, var_17_4.seat, var_17_0 == var_29_4:getRawData().id)
				end

				if arg_17_0.playerUserIndexDic[var_17_0] then
					if var_28_0 == 1 then
						setActive(arg_17_0.playerHudTFDic[var_29_5]:Find("out"), (arg_17_0.playerList[var_29_5]:IsOut()))
					end
				end

				onNextTick(function()
					arg_17_0:UpdatePlayerHudInfo()

					return
				end)

				return
			end

			return
		end
	}, function()
		return
	end)

	return var_17_1, var_17_2
end

function var_0_0.UpdateCurrentBoutDisplay(arg_32_0, arg_32_1)
	if ({
		user_id = arg_32_1.next_user_id
	}).user_id == 0 then
		return
	end

	local var_32_0 = arg_32_1.next_type == 1 and IslandCheaterTavernConst.PlayerCurrentOperateType.PutCardOrQuery or arg_32_1.next_type == 2 and IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther or IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOwn

	if var_32_0 >= IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther then
		local var_32_1, var_32_2 = arg_32_0.cheaterTavernAgency:GetPlayerData(({
			user_id = arg_32_1.next_user_id
		}).user_id):GetCurrentAndAllHp()

		if var_32_1 ~= var_32_2 then
			return
		end
	end

	;({
		user_id = arg_32_1.next_user_id
	}).operationType = var_32_0
	;({
		user_id = arg_32_1.next_user_id
	}).auto_time = arg_32_1.auto_time

	arg_32_0:UpdateOneBout({
		user_id = arg_32_1.next_user_id
	})

	return
end

function var_0_0.OnCheaterOperateDoneNotify(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.data

	arg_33_0:HideCurrentBoutCoundDown()

	local var_33_1, var_33_2 = arg_33_0:UpdataLastBoutDisplay(arg_33_1.data, arg_33_1.putCard)

	arg_33_0:StopLastBountPerformTimer()
	arg_33_0:StartLastBountPerformTimer(var_33_1, function()
		existCall(var_33_2)
		arg_33_0:UpdateCurrentBoutDisplay(var_33_0)

		return
	end)

	return
end

function var_0_0.OnPlayerEscape(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.cheaterTavernAgency:GetPlayerData(arg_35_1)

	if var_35_0:IsOut() then
		return
	end

	var_35_0:SetOutState()
	setActive(arg_35_0.playerHudTFDic[arg_35_0.playerUserIndexDic[arg_35_1]]:Find("out"), true)
	setActive(arg_35_0.playerHudTFDic[arg_35_0.playerUserIndexDic[arg_35_1]]:Find("hp"), false)
	arg_35_0.cardViewManager:OtherPlayerCardDestroy(arg_35_1)

	local var_35_1 = getProxy(PlayerProxy)

	arg_35_0.parent:emitCore(CheaterTavernEvent.PLAYER_OUT_ANIMATION, arg_35_1, var_35_0.seat, arg_35_1 == var_35_1:getRawData().id)

	return
end

function var_0_0.Show(arg_36_0)
	return
end

function var_0_0.OnInitPlayerHudInfoItem(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = tf(arg_37_2)

	arg_37_0.playerHudTFDic[arg_37_1 + 1] = var_37_0

	setActive(var_37_0:Find("out"), false)
	setText(var_37_0:Find("out/outText"), i18n("bar_ui_game1"))
	setText(var_37_0:Find("hp/hpNum"), string.format("%s/%s", pg.gameset.bar_punishment_limit.key_value, pg.gameset.bar_punishment_limit.key_value))
	setActive(arg_37_0.uiOutGo, false)
	setActive(arg_37_0.uiHpGo, true)

	return
end

function var_0_0.OnUpdatePlayerHudInfoItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = tf(arg_38_2)
	local var_38_1 = 0

	if math.abs(arg_38_0.cheaterTavernAgency:GetMainPlayer().seat - arg_38_0.playerList[arg_38_1 + 1].seat) == 2 then
		var_38_1 = 0.3
	end

	var_38_0.localPosition = arg_38_0:WorldPosition2LocalPosition(arg_38_0.uiplayerInfoList, (Vector3(pg.island_world_objects[10110000 + arg_38_0.playerList[arg_38_1 + 1].seat].param.position[1] + ({
		1,
		0,
		-1,
		0
	})[arg_38_0.playerList[arg_38_1 + 1].seat] * 2, IslandCheaterTavernConst.hudHeight + var_38_1, pg.island_world_objects[10110000 + arg_38_0.playerList[arg_38_1 + 1].seat].param.position[3] + ({
		0,
		-1,
		0,
		1
	})[arg_38_0.playerList[arg_38_1 + 1].seat] * 2)))

	setText(var_38_0:Find("adapt/name"), tostring(arg_38_0.playerList[arg_38_1 + 1].player_info.name))

	local var_38_2, var_38_3 = arg_38_0.playerList[arg_38_1 + 1]:GetCurrentAndAllHp()

	setText(var_38_0:Find("hp/hpNum"), var_38_2 .. "/" .. var_38_3)

	local var_38_4 = arg_38_0.operation and arg_38_0.operation.user_id == arg_38_0.playerList[arg_38_1 + 1].user_id

	setActive(var_38_0:Find("in_process"), var_38_4)
	setActive(var_38_0:Find("hp"), not arg_38_0.playerList[arg_38_1 + 1]:IsOut())
	setActive(var_38_0:Find("adapt/delegate"), arg_38_0.playerList[arg_38_1 + 1]:IsDelegate())

	return
end

function var_0_0.StartRounCountDown(arg_39_0, arg_39_1)
	arg_39_0:StopRoundCoundDown()

	arg_39_0.randCoundDownTimer = Timer.New(function()
		local var_40_0 = arg_39_1 - arg_39_0.timeMgr:GetServerTime()

		setActive(arg_39_0.uiFirstTimeImg, true)
		setActive(arg_39_0.uiSecondTimeImg, true)

		if var_40_0 < 0 then
			var_40_0 = 0

			setImageSprite(arg_39_0.uiFirstTimeImg, arg_39_0.parent:GetNumSpriteByIndex(0), true)
			setImageSprite(arg_39_0.uiSecondTimeImg, arg_39_0.parent:GetNumSpriteByIndex(0), true)
			arg_39_0:StopRoundCoundDown()

			return
		end

		local var_40_1 = math.floor(var_40_0 % 60)
		local var_40_2 = math.floor(var_40_1 / 10)

		if var_40_2 <= 0 then
			setActive(arg_39_0.uiFirstTimeImg, false)
			setImageSprite(arg_39_0.uiSecondTimeImg, arg_39_0.parent:GetNumSpriteByIndex(var_40_1 % 10), true)

			return
		end

		setImageSprite(arg_39_0.uiFirstTimeImg, arg_39_0.parent:GetNumSpriteByIndex(var_40_2), true)
		setImageSprite(arg_39_0.uiSecondTimeImg, arg_39_0.parent:GetNumSpriteByIndex(var_40_1 % 10), true)

		return
	end, 1, -1)

	arg_39_0.randCoundDownTimer.func()

	if arg_39_0.randCoundDownTimer then
		arg_39_0.randCoundDownTimer:Start()
	end

	return
end

function var_0_0.StopRoundCoundDown(arg_41_0)
	if arg_41_0.randCoundDownTimer then
		arg_41_0.randCoundDownTimer:Stop()

		arg_41_0.randCoundDownTimer = nil
	end

	return
end

function var_0_0.RemoveRealCardTipShowTime(arg_42_0)
	if arg_42_0.realCardTipShowTimer then
		arg_42_0.realCardTipShowTimer:Stop()

		arg_42_0.realCardTipShowTimer = nil
	end

	return
end

function var_0_0.OnCheaterEveryRoundStart(arg_43_0)
	arg_43_0.tableCardNum = 0

	arg_43_0.cardViewManager:SetMainPlayerSeat(arg_43_0.cheaterTavernAgency:GetMainPlayer().seat)
	arg_43_0:SetActiveState(false)
	setActive(arg_43_0.uiRondRealCardTips, false)
	setActive(arg_43_0.uiputCardDestList, false)
	setActive(arg_43_0.uiqueryEffect, false)
	setActive(arg_43_0.uicountDown, false)
	setActive(arg_43_0.uiDelegate, false)
	arg_43_0:StopLastBountPerformTimer()

	return
end

function var_0_0.OnCheaterEveryRoundStartDone(arg_44_0, arg_44_1)
	CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_44_0.cheaterTavernAgency:GetMainPlayer().seat)
	arg_44_0:HideCurrentBoutCoundDown()
	arg_44_0:SetActiveState(true)
	setActive(arg_44_0.uiRondRealCardTips, true)

	local var_44_0 = pg.bar_card[arg_44_0.cheaterTavernAgency:GetRealCard()]

	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_44_0.card_res, "", arg_44_0.uirealCard)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_44_0.card_res, "", arg_44_0.uirealCardTip)
	arg_44_0:RemoveRealCardTipShowTime()

	arg_44_0.realCardTipShowTimer = Timer.New(function()
		setActive(arg_44_0.uiRondRealCardTips, false)
		arg_44_0:UpdateOneBout(arg_44_1)

		return
	end, pg.gameset.bar_refreshcard_time.key_value, 1)

	arg_44_0.realCardTipShowTimer:Start()
	arg_44_0:ResetBountOp()
	arg_44_0:InitPlayerHudInfo()
	arg_44_0:InitMainCard()
	arg_44_0:InitOtherPlayerCard()
	arg_44_0:UpdateDelegateState()

	return
end

function var_0_0.OnCheaterReconected(arg_46_0, arg_46_1)
	setActive(arg_46_0.uiRondRealCardTips, false)

	arg_46_0.tableCardNum = 0

	arg_46_0.cardViewManager:SetMainPlayerSeat(arg_46_0.cheaterTavernAgency:GetMainPlayer().seat)
	arg_46_0:SetActiveState(true)
	arg_46_0:HideCurrentBoutCoundDown()

	local var_46_0 = pg.bar_card[arg_46_0.cheaterTavernAgency:GetRealCard()]

	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_46_0.card_res, "", arg_46_0.uirealCard)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_46_0.card_res, "", arg_46_0.uirealCardTip)
	arg_46_0:ResetBountOp()
	arg_46_0:InitPlayerHudInfo()
	arg_46_0:InitMainCard()
	arg_46_0:InitOtherPlayerCard()
	arg_46_0:UpdateDelegateState()
	arg_46_0:UpdateOneBout(arg_46_1)

	return
end

function var_0_0.InitMainCard(arg_47_0)
	arg_47_0.cardDataList = arg_47_0.cheaterTavernAgency:GetMainPlayerCards()

	arg_47_0.cardViewManager:DestroyMainCard()
	arg_47_0.cardViewManager:InitMainCard(arg_47_0.cardDataList)

	return
end

function var_0_0.InitPlayerHudInfo(arg_48_0)
	arg_48_0.playerList, arg_48_0.playerUserIndexDic = arg_48_0.cheaterTavernAgency:GetPlayerList()

	return
end

function var_0_0.InitOtherPlayerCard(arg_49_0)
	arg_49_0.cardViewManager:InitOtherPlayerCard(arg_49_0.playerList)

	return
end

function var_0_0.UpdatePlayerHudInfo(arg_50_0)
	arg_50_0.uiplayerHudInfoList:align(#arg_50_0.playerList)

	return
end

function var_0_0.ResetBountOp(arg_51_0)
	setActive(arg_51_0.uiopBtn, false)
	setActive(arg_51_0.uishootOp, false)

	return
end

function var_0_0.UpdateOneBout(arg_52_0, arg_52_1)
	setActive(arg_52_0.uiopBtn, false)
	setActive(arg_52_0.uishootOp, false)

	arg_52_0.operation = arg_52_1

	arg_52_0:UpdatePlayerHudInfo()
	arg_52_0:UpdataHp()

	if IslandCheaterTavernConst.putCardTest then
		setActive(arg_52_0.uiopBtn, true)
		setActive(arg_52_0.uiopBtn:Find("putCard"), true)

		return
	end

	setActive(arg_52_0.uicountDown, true)
	arg_52_0:StartRounCountDown(arg_52_1.auto_time)

	if not arg_52_0:IsSelf(arg_52_1.user_id) then
		return
	end

	if arg_52_1.operationType >= IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther then
		local var_52_0 = arg_52_0.cheaterTavernAgency:GetMainPlayer()
		local var_52_1, var_52_2 = var_52_0:GetCurrentAndAllHp()

		if var_52_1 == var_52_2 then
			arg_52_0.cardViewManager:ClearTableCard()
			setActive(arg_52_0.uishootOp, true)
			arg_52_0.parent:emitCore(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, var_52_0.seat)
		end

		return
	end

	setActive(arg_52_0.uiopBtn, true)
	IslandCheaterTavernRecordTools.StartPutCardTime()
	setActive(arg_52_0.uiopBtn:Find("putCard"), not arg_52_0.cheaterTavernAgency:CheckCanOnlyQurey())
	setActive(arg_52_0.uiopBtn:Find("query"), arg_52_0.tableCardNum > 0)

	return
end

function var_0_0.UpdataHp(arg_53_0)
	local var_53_0 = arg_53_0.cheaterTavernAgency:GetMainPlayer()

	if var_53_0:IsOut() then
		setActive(arg_53_0.uiOutGo, true)
		setActive(arg_53_0.uiHpGo, false)
	else
		setActive(arg_53_0.uiOutGo, false)
		setActive(arg_53_0.uiHpGo, true)

		local var_53_1, var_53_2 = var_53_0:GetCurrentAndAllHp()

		setText(arg_53_0.uicurHpNum, var_53_1 .. "/" .. var_53_2)
	end

	return
end

function var_0_0.OnInit(arg_54_0)
	return
end

function var_0_0.OnHide(arg_55_0)
	setParent(arg_55_0.uiTipsTf, arg_55_0._tf)

	if arg_55_0.cardViewManager then
		arg_55_0.cardViewManager:Destroy()

		arg_55_0.cardViewManager = nil
	end

	arg_55_0:StopRoundCoundDown()
	arg_55_0:RemoveRealCardTipShowTime()
	arg_55_0:StopLastBountPerformTimer()

	if arg_55_0.questionTimer then
		arg_55_0.questionTimer:Stop()

		arg_55_0.questionTimer = nil
	end

	if arg_55_0.tipsTimer then
		arg_55_0.tipsTimer:Stop()

		arg_55_0.tipsTimer = nil
	end

	arg_55_0:StopHideTipsTimer()

	return
end

function var_0_0.WorldPosition2LocalPosition(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = pg.UIMgr.GetInstance().overlayCameraComp

	return (LuaHelper.ScreenToLocal(arg_56_1:GetComponent("RectTransform"), var_56_0:ViewportToScreenPoint((CheatTavernCameraMgr.instance._mainCamera:WorldToViewportPoint(arg_56_2))), var_56_0))
end

function var_0_0.UpdateDelegateState(arg_57_0)
	setActive(arg_57_0.uiDelegate, arg_57_0.cheaterTavernAgency:GetMainPlayer():IsDelegate())
	arg_57_0:UpdatePlayerHudInfo()

	return
end

function var_0_0.DestroyMainCard(arg_58_0)
	if arg_58_0.cardViewManager then
		arg_58_0.cardViewManager:DestroyMainCard()
	end

	return
end

function var_0_0.ShowTips(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_2 == nil then
		setText(arg_59_0.uiResultText, arg_59_1)
		setActive(arg_59_0.uiResultText, true)
		setActive(arg_59_0.uiQueryText, false)
		setActive(arg_59_0.uiPunishmentText, false)
	else
		setText(arg_59_0.uiQueryText, arg_59_1)
		setText(arg_59_0.uiPunishmentText, arg_59_2)
		setActive(arg_59_0.uiResultText, false)
		setActive(arg_59_0.uiQueryText, true)
		setActive(arg_59_0.uiPunishmentText, true)
	end

	arg_59_0:StopHideTipsTimer()
	setActive(arg_59_0.uiTipsTf, false)
	setActive(arg_59_0.uiTipsTf, true)

	arg_59_0.hideTipsTimer = Timer.New(function()
		arg_59_0.uiTipsAnimator:SetTrigger("hide")

		return
	end, 2, 1)

	arg_59_0.hideTipsTimer:Start()

	return
end

function var_0_0.StopHideTipsTimer(arg_61_0)
	if arg_61_0.hideTipsTimer then
		arg_61_0.hideTipsTimer:Stop()

		arg_61_0.hideTipsTimer = nil
	end

	return
end

return var_0_0
