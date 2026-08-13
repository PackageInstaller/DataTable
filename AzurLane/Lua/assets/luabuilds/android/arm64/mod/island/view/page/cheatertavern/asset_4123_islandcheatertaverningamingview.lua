class = var_0_10000

local var_0_0 = "IslandCheaterTavernInGamingView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCheaterTavernBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

local var_0_2 = {
	129,
	-52
}
local var_0_3 = {
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
local var_0_4 = {
	{
		-741,
		197
	},
	{
		-209.9,
		400
	},
	{
		680,
		300
	}
}

function var_0_1.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.playerHudTFDic = {}
	UIItemList = var_1
	arg_2_0.uiplayerHudInfoList = var_1.New(arg_2_0.uiplayerInfoList, arg_2_0.uiplayerInfoItem)

	local var_2_0 = arg_2_0.uiplayerHudInfoList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventInit then
			local var_3_0 = arg_2_0

			var_3.OnInitPlayerHudInfoItem(var_3_0, arg_3_1, arg_3_2)
		else
			UIItemList = var_3

			if arg_3_0 == var_3.EventUpdate then
				local var_3_1 = arg_2_0

				var_3.OnUpdatePlayerHudInfoItem(var_3_1, arg_3_1, arg_3_2)
			end
		end

		return
	end)

	local var_2_1 = arg_2_0.uiplayerHudInfoList

	var_1.each(var_2_1, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnInitPlayerHudInfoItem(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	pg = var_1

	local var_2_2 = var_1.gameset.bar_punishment_limit.key_value

	setText = var_1_10002

	local var_2_3 = arg_2_0.uicurHpNum

	string = var_1_10005

	var_1_10002(var_2_3, var_1_10005.format("%s/%s", var_2_2, var_2_2))

	onButton = var_1_10002

	var_1_10002(arg_2_0, arg_2_0.uiqueryBtn, function()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_5_2 = var_2_10003.CHEATER_TAVERN_OPERATE

		IslandCheaterTavernConst = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.PlayerOperateType.Query)

		return
	end)

	GetOrAddComponent = var_1_10002

	local var_2_4 = var_1_10002(arg_2_0.uishootBtn, "EventTriggerListener")
	local var_2_5 = 10

	var_2_4:AddPointDownFunc(function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1.position
		local var_6_1 = startPos
		local var_6_2 = false
		local var_6_3 = hasTriggered

		return
	end)
	var_2_4:AddDragFunc(function(arg_7_0, arg_7_1)
		hasTriggered = var_2_10002

		if not var_2_10002 then
			startPos = var_2_10002

			if not var_2_10002 then
				return
			end

			local var_7_0 = arg_7_1.position

			startPos = var_2_10003

			if (var_7_0 - var_2_10003).magnitude >= var_2_5 then
				local var_7_1 = true
				local var_7_2 = hasTriggered
				local var_7_3 = arg_2_0
				local var_7_4 = var_3.emit

				IslandMediator = var_2_10006

				local var_7_5 = var_2_10006.CHEATER_TAVERN_OPERATE

				IslandCheaterTavernConst = var_2_10007

				var_7_4(var_7_3, var_7_5, var_2_10007.PlayerOperateType.Shoot)
			end

			return
		end
	end)
	var_2_4:AddPointUpFunc(function(arg_8_0, arg_8_1)
		local var_8_0
		local var_8_1 = startPos

		return
	end)

	onButton = var_4

	var_4(arg_2_0, arg_2_0.uiDelegate, function()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		IslandMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.CHEATER_TAVERN_CANCEL_DELEGATE)

		return
	end)

	onButton = var_4

	var_4(arg_2_0, arg_2_0.uiputCardBtn, function()
		local var_10_0 = arg_2_0.cardViewManager
		local var_10_1 = var_0.GetSelectCardKeyList(var_10_0)

		IslandCheaterTavernConst = var_2_10001

		if var_2_10001.putCardTest then
			local var_10_2 = arg_2_0.cardViewManager

			var_1.PutDownMainCard(var_10_2, var_10_1)

			return
		end

		if #var_10_1 ~= 0 then
			IslandCheaterTavernConst = var_10_0

			if var_1 > var_10_0.putCountMax then
				return
			end

			local var_10_3 = arg_2_0
			local var_10_4 = var_2.emit

			IslandMediator = var_2_10005

			local var_10_5 = var_2_10005.CHEATER_TAVERN_OPERATE

			IslandCheaterTavernConst = var_2_10006

			var_10_4(var_10_3, var_10_5, var_2_10006.PlayerOperateType.PutCard, var_10_1)

			return
		end
	end)

	pg = var_4
	arg_2_0.timeMgr = var_4.TimeMgr.GetInstance()
	IslandCheaterTavernCardViewManager = var_4
	arg_2_0.cardViewManager = var_4.New(arg_2_0.uicardList)
	PlayRoomTools = var_4

	local var_2_6 = var_4.GetPtScrore

	PlayRoomTools = var_6

	local var_2_7 = var_2_6(var_6.GetGameTypeID())

	setText = var_5

	var_5(arg_2_0.uiScoreNum, var_2_7)

	setText = var_5

	local var_2_8 = arg_2_0.uireakCardbgText

	i18n = var_8

	var_5(var_2_8, var_8("bar_ui_start2"))

	setText = var_5

	local var_2_9 = arg_2_0.uireakCardTipText

	i18n = var_8

	var_5(var_2_9, var_8("bar_ui_start1"))

	setText = var_5

	local var_2_10 = arg_2_0.uiScoreTitle

	i18n = var_8

	var_5(var_2_10, var_8("bar_ui_game3"))

	setText = var_5

	local var_2_11 = arg_2_0.uishootText

	i18n = var_8

	var_5(var_2_11, var_8("bar_ui_game4"))

	setText = var_5

	local var_2_12 = arg_2_0.uiOutText

	i18n = var_8

	var_5(var_2_12, var_8("bar_ui_game1"))

	setActive = var_5

	var_5(arg_2_0.uiTipsTf, false)

	setParent = var_5

	local var_2_13 = arg_2_0.uiTipsTf

	pg = var_8

	var_5(var_2_13, var_8.UIMgr.GetInstance().OverlayToast)

	local var_2_14 = arg_2_0.cheaterTavernAgency

	var_5.SetUILoadOver(var_2_14, true)

	return
end

function var_0_1.OnCheaterOperateDone(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.type

	IslandCheaterTavernConst = var_1_10003

	if var_11_0 == var_1_10003.PlayerOperateType.PutCard then
		setActive = var_11_0

		var_11_0(arg_11_0.uiopBtn, false)
		arg_11_0:PutMainCardDone(arg_11_1.arg_list)
	else
		local var_11_1 = arg_11_1.type

		IslandCheaterTavernConst = var_3

		if var_11_1 == var_3.PlayerOperateType.Shoot then
			setActive = var_11_1

			var_11_1(arg_11_0.uishootOp, false)
		else
			setActive = var_11_1

			var_11_1(arg_11_0.uiopBtn, false)
		end
	end

	return
end

function var_0_1.PutMainCardDone(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.cardViewManager

	var_2.PutDownMainCard(var_12_0, arg_12_1)

	local var_12_1 = arg_12_0.cheaterTavernAgency

	arg_12_0.cardDataList = var_2.GetMainPlayerCards(var_12_1)

	local var_12_2 = arg_12_0.cardViewManager

	var_2.RefreshMainCard(var_12_2, arg_12_0.cardDataList)

	return
end

function var_0_1.StartLastBountPerformTimer(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 <= 0 then
		existCall = var_3

		var_3(arg_13_2)

		return
	end

	Timer = var_3
	arg_13_0.lastBountPerformTimer = var_3.New(function()
		existCall = var_2_10000

		var_2_10000(arg_13_2)

		return
	end, arg_13_1, 1)

	local var_13_0 = arg_13_0.lastBountPerformTimer

	var_3.Start(var_13_0)

	return
end

function var_0_1.StopLastBountPerformTimer(arg_15_0)
	if arg_15_0.lastBountPerformTimer then
		local var_15_0 = arg_15_0.lastBountPerformTimer

		var_1.Stop(var_15_0)

		arg_15_0.lastBountPerformTimer = nil
	end

	return
end

function var_0_1.HideCurrentBoutCoundDown(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0.uicountDown, false)
	arg_16_0:StopRoundCoundDown()

	return
end

function var_0_1.UpdataLastBoutDisplay(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.user_id
	local var_17_1 = 0
	local var_17_2

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_17_3 = var_1_10006(var_1_10008)

	if var_17_0 == var_6.getRawData(var_17_3).id then
		local var_17_4 = arg_17_0.cheaterTavernAgency
		local var_17_6

		if not var_7.GetMainPlayer(var_17_4) then
			local var_17_5 = arg_17_0.cheaterTavernAgency

			var_17_6 = var_7.GetPlayerData(var_17_5, var_17_0)
		end

		getProxy = var_17_3
		PlayerProxy = var_1_10010

		local var_17_7 = var_17_3(var_1_10010)
		local var_17_8 = var_8.getRawData(var_17_7).id

		local function var_17_9()
			if var_0 then
				setActive = var_0

				var_0(arg_17_0.uiopBtn, false)
			end

			return
		end

		switch = var_17_7

		local var_17_10 = arg_17_1.type
		local var_17_11 = {}

		IslandCheaterTavernConst = var_1_10014
		var_17_11[var_1_10014.PlayerOperateType.PutCard] = function()
			var_17_9()

			local var_19_0 = arg_17_0.cardViewManager

			var_0.ClearTableCard(var_19_0)

			if var_0 then
				if arg_17_2 then
					local var_19_1 = arg_17_0.cardViewManager

					var_0.PutDownMainCard(var_19_1, arg_17_2)

					local var_19_2 = arg_17_0
					local var_19_3 = arg_17_0.cheaterTavernAgency

					var_19_2.cardDataList = var_1.GetMainPlayerCards(var_19_3)

					local var_19_4 = arg_17_0.cardViewManager

					var_0.RefreshMainCard(var_19_4, arg_17_0.cardDataList)
				end
			else
				local var_19_5 = arg_17_1.return_list[2]
				local var_19_6 = arg_17_0.cardViewManager

				var_1.OtherPlayerPutCard(var_19_6, var_17_0, var_19_5)
			end

			arg_17_0.tableCardNum = arg_17_1.return_list[2]

			return
		end
		IslandCheaterTavernConst = var_14
		var_17_11[var_14.PlayerOperateType.Query] = function()
			var_17_9()

			arg_17_0.tableCardNum = 0
			arg_17_0.deskCardList = {}

			local var_20_0 = arg_17_1.return_list[1]

			setActive = var_1

			var_1(arg_17_0.uiqueryEffect, true)

			local var_20_1

			if var_0 then
				setAnchoredPosition = var_2

				local var_20_2 = arg_17_0.uiqueryEffect

				Vector2 = var_2_10005

				var_2(var_20_2, var_2_10005(var_0_2[1], var_0_2[2]))
			else
				local var_20_3 = arg_17_0.playerUserIndexDic[var_17_0]

				setAnchoredPosition = var_2

				local var_20_4 = arg_17_0.uiqueryEffect

				Vector2 = var_2_10005

				var_2(var_20_4, var_2_10005(var_0_3[var_20_3][1], var_0_3[var_20_3][2]))
			end

			local var_20_5

			if var_0 then
				var_20_5 = var_17_6.seat

				local var_20_6 = "questSeet0" .. var_20_5

				CheatTavernCameraMgr = var_4
				var_2_10006 = var_4.instance

				var_4.ActiveVirtualCamera(var_2_10006, var_20_6)

				onNextTick = var_4

				var_4(function()
					local var_21_0 = arg_17_0

					var_0.UpdatePlayerHudInfo(var_21_0)

					return
				end)
			else
				local var_20_7 = arg_17_0.cardViewManager

				var_3.PlayerCardSetActive(var_20_7, var_17_0, false)
			end

			local var_20_8 = arg_17_0.parent
			local var_20_9 = var_3.emitCore

			CheaterTavernEvent = var_2_10006

			var_20_9(var_20_8, var_2_10006.PLAYER_QUESTION_ANIMATION, var_17_0, var_0, var_20_5)

			local function var_20_10()
				local var_22_0

				if var_0 then
					var_22_0 = "lookSeet0" .. var_20_5
					CheatTavernCameraMgr = var_1

					local var_22_1 = var_1.instance

					var_1.ActiveVirtualCamera(var_22_1, var_22_0)

					onNextTick = var_1

					var_1(function()
						local var_23_0 = arg_17_0

						var_0.UpdatePlayerHudInfo(var_23_0)

						return
					end)
				else
					local var_22_2 = arg_17_0.cardViewManager

					var_22_0.PlayerCardSetActive(var_22_2, var_17_0, true)
				end

				setActive = var_22_0

				var_22_0(arg_17_0.uiqueryEffect, false)

				local var_22_3 = arg_17_0.cheaterTavernAgency
				local var_22_4 = var_0.GetMainPlayer(var_22_3).seat
				local var_22_5 = "shootSeet0" .. var_22_4

				CheatTavernCameraMgr = var_2

				local var_22_6 = var_2.instance

				var_2.ActiveVirtualCamera(var_22_6, var_22_5)

				local var_22_7 = arg_17_0.cardViewManager

				var_2.PlayerCardSetActive(var_22_7, var_17_8, false)

				local var_22_8 = {}
				local var_22_9 = #arg_17_1.return_list

				for iter_22_0 = 2, var_22_9 do
					table = var_3_10008

					var_3_10008.insert(var_22_8, arg_17_1.return_list[iter_22_0])
				end

				local var_22_10 = arg_17_0.cardViewManager

				var_4.FlipTableCard(var_22_10, var_22_8)

				return
			end

			local function var_20_11()
				local var_24_0 = var_20_0 == 1 and "bar_tips_game1" or "bar_tips_game2"
				local var_24_1 = arg_17_0.cheaterTavernAgency
				local var_24_2 = var_1.GetPlayerData(var_24_1, var_17_0)
				local var_24_3 = var_1.GetName(var_24_2)
				local var_24_4 = arg_17_0.cheaterTavernAgency
				local var_24_5 = var_2.GetPlayerData(var_24_4, arg_17_1.next_user_id)
				local var_24_6 = var_2.GetName(var_24_5)
				local var_24_7 = arg_17_0
				local var_24_8 = var_3.ShowTips

				i18n = var_3_10006

				local var_24_9 = var_3_10006(var_24_0, var_24_3)

				i18n = var_3_10007

				var_24_8(var_24_7, var_24_9, var_3_10007("bar_tips_game5", var_20_0 == 1 and var_24_6 or var_24_3))

				return
			end

			if arg_17_0.questionTimer then
				local var_20_12 = arg_17_0.questionTimer

				var_5.Stop(var_20_12)
			end

			local var_20_13 = arg_17_0

			Timer = var_6
			var_20_13.questionTimer = var_6.New(function()
				var_20_10()

				return
			end, 2, 1)

			if arg_17_0.tipsTimer then
				local var_20_14 = arg_17_0.tipsTimer

				var_5.Stop(var_20_14)
			end

			local var_20_15 = arg_17_0

			Timer = var_6
			var_20_15.tipsTimer = var_6.New(function()
				var_20_11()

				return
			end, 3.5, 1)

			local var_20_16 = arg_17_0.questionTimer

			var_5.Start(var_20_16)

			local var_20_17 = arg_17_0.tipsTimer

			var_5.Start(var_20_17)

			pg = var_5
			var_17_1 = var_5.gameset.bar_question_time.key_value

			function var_17_2()
				setActive = var_3_10000

				var_3_10000(arg_17_0.uiTipsTf, false)

				return
			end

			return
		end
		IslandCheaterTavernConst = var_14
		var_17_11[var_14.PlayerOperateType.Shoot] = function()
			var_17_9()

			if var_0 then
				setActive = var_0

				var_0(arg_17_0.uishootOp, false)
			end

			local var_28_0 = arg_17_0.cardViewManager

			var_0.ClearTableCard(var_28_0)

			local var_28_1 = arg_17_1.return_list[2]
			local var_28_2 = arg_17_0.cheaterTavernAgency
			local var_28_3 = var_1.GetMainPlayer(var_28_2).seat
			local var_28_4 = var_17_6
			local var_28_5, var_28_6 = var_2.GetCurrentBombId(var_28_4)
			local var_28_7 = var_17_6.seat
			local var_28_8 = arg_17_0.parent
			local var_28_9 = var_5.emitCore

			CheaterTavernEvent = var_2_10008

			var_28_9(var_28_8, var_2_10008.SHOOT_AND_TURN_TABLE, var_0, var_28_7, var_28_5, var_28_6, var_28_1 == 1)

			pg = var_28_9
			var_17_1 = var_28_9.gameset.bar_punishment_turntable_time.key_value

			function var_17_2()
				local var_29_0 = "lookSeet0" .. var_28_3

				CheatTavernCameraMgr = var_1

				local var_29_1 = var_1.instance

				var_1.ActiveVirtualCamera(var_29_1, var_29_0)

				local var_29_2 = arg_17_0.cardViewManager

				var_1.PlayerCardSetActive(var_29_2, var_17_8, true)

				local var_29_3 = var_17_6
				local var_29_4 = var_1.GetName(var_29_3)
				local var_29_5 = var_28_1 == 1 and "bar_tips_game3" or "bar_tips_game4"
				local var_29_6 = arg_17_0
				local var_29_7 = var_3.ShowTips

				i18n = var_3_10006

				var_29_7(var_29_6, var_3_10006(var_29_5, var_29_4))

				if var_28_1 == 1 then
					if var_0 then
						local var_29_8 = arg_17_0.cardViewManager

						var_3.DestroyMainCard(var_29_8)
					else
						local var_29_9 = arg_17_0.cardViewManager

						var_3.OtherPlayerCardDestroy(var_29_9, var_17_0)
					end

					local var_29_10 = var_17_6.seat
					local var_29_11 = arg_17_0.parent
					local var_29_12 = var_4.emitCore

					CheaterTavernEvent = var_3_10007
					var_3_10007 = var_3_10007.PLAYER_OUT_ANIMATION

					local var_29_13 = var_17_0
					local var_29_14 = var_29_10
					local var_29_15 = var_17_0

					getProxy = var_3_10011
					PlayerProxy = var_3_10013

					local var_29_16 = var_3_10011(var_3_10013)

					var_29_12(var_29_11, var_3_10007, var_29_13, var_29_14, var_29_15 == var_11.getRawData(var_29_16).id)
				end

				local var_29_17

				if arg_17_0.playerUserIndexDic[var_17_0] then
					var_29_17 = arg_17_0.playerHudTFDic[var_3]

					if var_28_1 == 1 then
						local var_29_18 = arg_17_0.playerList[var_3]
						local var_29_19 = var_5.IsOut(var_29_18)

						setActive = var_3_10007

						var_3_10007(var_29_17:Find("out"), var_29_19)
					end
				end

				onNextTick = var_29_17

				var_29_17(function()
					local var_30_0 = arg_17_0

					var_0.UpdatePlayerHudInfo(var_30_0)

					return
				end)

				return
			end

			return
		end

		var_17_7(var_17_10, var_17_11, function()
			return
		end)

		return var_17_1, var_17_2
	end
end

function var_0_1.UpdateCurrentBoutDisplay(arg_32_0, arg_32_1)
	if ({
		user_id = arg_32_1.next_user_id
	}).user_id == 0 then
		return
	end

	local var_32_0

	if arg_32_1.next_type == 1 then
		IslandCheaterTavernConst = var_4
		var_32_0 = var_4.PlayerCurrentOperateType.PutCardOrQuery
	elseif arg_32_1.next_type == 2 then
		IslandCheaterTavernConst = var_4
		var_32_0 = var_4.PlayerCurrentOperateType.ShootByOther
	else
		IslandCheaterTavernConst = var_4
		var_32_0 = var_4.PlayerCurrentOperateType.ShootByOwn
	end

	IslandCheaterTavernConst = var_4

	if var_32_0 >= var_4.PlayerCurrentOperateType.ShootByOther then
		local var_32_1 = arg_32_0.cheaterTavernAgency
		local var_32_2 = var_4.GetPlayerData(var_32_1, var_2.user_id)
		local var_32_3, var_32_4 = var_4.GetCurrentAndAllHp(var_32_2)

		if var_32_3 ~= var_32_4 then
			return
		end
	end

	var_2.operationType = var_32_0
	var_2.auto_time = arg_32_1.auto_time

	arg_32_0:UpdateOneBout(var_2)

	return
end

function var_0_1.OnCheaterOperateDoneNotify(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.data
	local var_33_1 = arg_33_1.putCard

	arg_33_0:HideCurrentBoutCoundDown()

	local var_33_2, var_33_3 = arg_33_0:UpdataLastBoutDisplay(var_33_0, var_33_1)

	local function var_33_4()
		existCall = var_2_10000

		var_2_10000(var_33_3)

		local var_34_0 = arg_33_0

		var_0.UpdateCurrentBoutDisplay(var_34_0, var_33_0)

		return
	end

	arg_33_0:StopLastBountPerformTimer()
	arg_33_0:StartLastBountPerformTimer(var_33_2, var_33_4)

	return
end

function var_0_1.OnPlayerEscape(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.cheaterTavernAgency
	local var_35_1 = var_2.GetPlayerData(var_35_0, arg_35_1)

	if var_2.IsOut(var_35_1) then
		return
	end

	local var_35_2 = var_2

	var_2.SetOutState(var_35_2)

	local var_35_3 = arg_35_0.playerUserIndexDic[arg_35_1]
	local var_35_4 = arg_35_0.playerHudTFDic[var_35_3]

	setActive = var_35_2

	var_35_2(var_35_4:Find("out"), true)

	setActive = var_35_2

	var_35_2(var_35_4:Find("hp"), false)

	local var_35_5 = arg_35_0.cardViewManager

	var_5.OtherPlayerCardDestroy(var_35_5, arg_35_1)

	local var_35_6 = arg_35_0.parent
	local var_35_7 = var_5.emitCore

	CheaterTavernEvent = var_8

	local var_35_8 = var_8.PLAYER_OUT_ANIMATION
	local var_35_9 = arg_35_1
	local var_35_10 = var_2.seat

	getProxy = var_1_10011
	PlayerProxy = var_1_10013

	local var_35_11 = var_1_10011(var_1_10013)

	var_35_7(var_35_6, var_35_8, var_35_9, var_35_10, arg_35_1 == var_11.getRawData(var_35_11).id)

	return
end

function var_0_1.Show(arg_36_0)
	return
end

function var_0_1.OnInitPlayerHudInfoItem(arg_37_0, arg_37_1, arg_37_2)
	tf = var_1_10003

	local var_37_0 = var_1_10003(arg_37_2)
	local var_37_1 = arg_37_0.playerHudTFDic

	var_37_1[arg_37_1 + 1] = var_37_0
	setActive = var_37_1

	var_37_1(var_37_0:Find("out"), false)

	setText = var_37_1

	local var_37_2 = var_37_0
	local var_37_3 = var_37_0.Find(var_37_2, "out/outText")

	i18n = var_7

	var_37_1(var_37_3, var_7("bar_ui_game1"))

	pg = var_37_1

	local var_37_4 = var_37_1.gameset.bar_punishment_limit.key_value

	setText = var_5

	local var_37_5 = var_37_0:Find("hp/hpNum")

	string = var_37_2

	var_5(var_37_5, var_37_2.format("%s/%s", var_37_4, var_37_4))

	setActive = var_5

	var_5(arg_37_0.uiOutGo, false)

	setActive = var_5

	var_5(arg_37_0.uiHpGo, true)

	return
end

function var_0_1.OnUpdatePlayerHudInfoItem(arg_38_0, arg_38_1, arg_38_2)
	tf = var_1_10003

	local var_38_0 = var_1_10003(arg_38_2)
	local var_38_1 = arg_38_1 + 1
	local var_38_2 = 10110000 + arg_38_0.playerList[var_38_1].seat

	pg = var_1_10008

	local var_38_3 = var_1_10008.island_world_objects[var_38_2].param.position[1]
	local var_38_4 = var_8.param.position[3]
	local var_38_5 = {
		1,
		0,
		-1,
		0
	}
	local var_38_6 = {
		0,
		-1,
		0,
		1
	}
	local var_38_7 = 2
	local var_38_8 = var_38_3 + var_38_5[var_6] * var_38_7
	local var_38_9 = var_38_4 + var_38_6[var_6] * var_38_7
	local var_38_10 = arg_38_0.cheaterTavernAgency
	local var_38_11 = var_14.GetMainPlayer(var_38_10).seat
	local var_38_12 = 0

	math = var_38_10

	if var_38_10.abs(var_38_11 - var_6) == 2 then
		var_38_12 = 0.3
	end

	Vector3 = var_16

	local var_38_13 = var_38_8

	IslandCheaterTavernConst = var_1_10019

	local var_38_14 = var_16(var_38_13, var_1_10019.hudHeight + var_38_12, var_38_9)

	var_38_0.localPosition = arg_38_0:WorldPosition2LocalPosition(arg_38_0.uiplayerInfoList, var_38_14)
	setText = var_38_13

	local var_38_15 = var_38_0:Find("adapt/name")

	tostring = var_21

	var_38_13(var_38_15, var_21(var_5.player_info.name))

	local var_38_16 = var_5
	local var_38_17, var_38_18 = var_5.GetCurrentAndAllHp(var_38_16)

	setText = var_38_16

	var_38_16(var_38_0:Find("hp/hpNum"), var_38_17 .. "/" .. var_38_18)

	local var_38_19

	if arg_38_0.operation then
		var_38_19 = arg_38_0.operation.user_id == var_5.user_id
	end

	setActive = var_21

	var_21(var_38_0:Find("in_process"), var_38_19)

	local var_38_20 = var_5:IsOut()

	setActive = var_22

	var_22(var_38_0:Find("hp"), not var_38_20)

	setActive = var_22

	var_22(var_38_0:Find("adapt/delegate"), var_5:IsDelegate())

	return
end

function var_0_1.StartRounCountDown(arg_39_0, arg_39_1)
	arg_39_0:StopRoundCoundDown()

	Timer = var_2
	arg_39_0.randCoundDownTimer = var_2.New(function()
		local var_40_0 = arg_39_1
		local var_40_1 = arg_39_0.timeMgr
		local var_40_2 = var_40_0 - var_1.GetServerTime(var_40_1)

		setActive = var_1

		var_1(arg_39_0.uiFirstTimeImg, true)

		setActive = var_1

		var_1(arg_39_0.uiSecondTimeImg, true)

		if var_40_2 < 0 then
			var_40_2 = 0
			setImageSprite = var_1

			local var_40_3 = arg_39_0.uiFirstTimeImg
			local var_40_4 = arg_39_0.parent

			var_1(var_40_3, var_4.GetNumSpriteByIndex(var_40_4, 0), true)

			setImageSprite = var_1

			local var_40_5 = arg_39_0.uiSecondTimeImg
			local var_40_6 = arg_39_0.parent

			var_1(var_40_5, var_4.GetNumSpriteByIndex(var_40_6, 0), true)

			local var_40_7 = arg_39_0

			var_1.StopRoundCoundDown(var_40_7)

			return
		end

		math = var_1

		local var_40_8 = var_1.floor(var_40_2 % 60)

		math = var_2_10002

		local var_40_9 = var_2_10002.floor(var_40_8 / 10)
		local var_40_10 = var_40_8 % 10

		if var_40_9 <= 0 then
			setActive = var_4

			var_4(arg_39_0.uiFirstTimeImg, false)

			setImageSprite = var_4

			local var_40_11 = arg_39_0.uiSecondTimeImg
			local var_40_12 = arg_39_0.parent

			var_4(var_40_11, var_7.GetNumSpriteByIndex(var_40_12, var_40_10), true)

			return
		end

		setImageSprite = var_4

		local var_40_13 = arg_39_0.uiFirstTimeImg
		local var_40_14 = arg_39_0.parent

		var_4(var_40_13, var_7.GetNumSpriteByIndex(var_40_14, var_40_9), true)

		setImageSprite = var_4

		local var_40_15 = arg_39_0.uiSecondTimeImg
		local var_40_16 = arg_39_0.parent

		var_4(var_40_15, var_7.GetNumSpriteByIndex(var_40_16, var_40_10), true)

		return
	end, 1, -1)

	arg_39_0.randCoundDownTimer.func()

	if arg_39_0.randCoundDownTimer then
		local var_39_0 = arg_39_0.randCoundDownTimer

		var_2.Start(var_39_0)
	end

	return
end

function var_0_1.StopRoundCoundDown(arg_41_0)
	if arg_41_0.randCoundDownTimer then
		local var_41_0 = arg_41_0.randCoundDownTimer

		var_1.Stop(var_41_0)

		arg_41_0.randCoundDownTimer = nil
	end

	return
end

function var_0_1.RemoveRealCardTipShowTime(arg_42_0)
	if arg_42_0.realCardTipShowTimer then
		local var_42_0 = arg_42_0.realCardTipShowTimer

		var_1.Stop(var_42_0)

		arg_42_0.realCardTipShowTimer = nil
	end

	return
end

function var_0_1.OnCheaterEveryRoundStart(arg_43_0)
	arg_43_0.tableCardNum = 0

	local var_43_0 = arg_43_0.cheaterTavernAgency
	local var_43_1 = var_1.GetMainPlayer(var_43_0)
	local var_43_2 = arg_43_0.cardViewManager

	var_2.SetMainPlayerSeat(var_43_2, var_43_1.seat)
	arg_43_0:SetActiveState(false)

	setActive = var_2

	var_2(arg_43_0.uiRondRealCardTips, false)

	setActive = var_2

	var_2(arg_43_0.uiputCardDestList, false)

	setActive = var_2

	var_2(arg_43_0.uiqueryEffect, false)

	setActive = var_2

	var_2(arg_43_0.uicountDown, false)

	setActive = var_2

	var_2(arg_43_0.uiDelegate, false)
	arg_43_0:StopLastBountPerformTimer()

	return
end

function var_0_1.OnCheaterEveryRoundStartDone(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.cheaterTavernAgency
	local var_44_1 = var_2.GetMainPlayer(var_44_0).seat
	local var_44_2 = "lookSeet0" .. var_44_1

	CheatTavernCameraMgr = var_4

	local var_44_3 = var_4.instance

	var_4.ActiveVirtualCamera(var_44_3, var_44_2)
	arg_44_0:HideCurrentBoutCoundDown()
	arg_44_0:SetActiveState(true)

	setActive = var_4

	var_4(arg_44_0.uiRondRealCardTips, true)

	local var_44_4 = arg_44_0.cheaterTavernAgency
	local var_44_5 = var_4.GetRealCard(var_44_4)

	pg = var_1_10005

	local var_44_6 = var_1_10005.bar_card[var_44_5]

	GetImageSpriteFromAtlasAsync = var_44_4

	var_44_4("Island/IslandCheaterTavernIcon/" .. var_44_6.card_res, "", arg_44_0.uirealCard)

	GetImageSpriteFromAtlasAsync = var_44_4

	var_44_4("Island/IslandCheaterTavernIcon/" .. var_44_6.card_res, "", arg_44_0.uirealCardTip)
	arg_44_0:RemoveRealCardTipShowTime()

	pg = var_6

	local var_44_7 = var_6.gameset.bar_refreshcard_time.key_value

	Timer = var_7
	arg_44_0.realCardTipShowTimer = var_7.New(function()
		setActive = var_2_10000

		var_2_10000(arg_44_0.uiRondRealCardTips, false)

		local var_45_0 = arg_44_0

		var_0.UpdateOneBout(var_45_0, arg_44_1)

		return
	end, var_44_7, 1)

	local var_44_8 = arg_44_0.realCardTipShowTimer

	var_7.Start(var_44_8)
	arg_44_0:ResetBountOp()
	arg_44_0:InitPlayerHudInfo()
	arg_44_0:InitMainCard()
	arg_44_0:InitOtherPlayerCard()
	arg_44_0:UpdateDelegateState()

	return
end

function var_0_1.OnCheaterReconected(arg_46_0, arg_46_1)
	setActive = var_1_10002

	var_1_10002(arg_46_0.uiRondRealCardTips, false)

	arg_46_0.tableCardNum = 0

	local var_46_0 = arg_46_0.cheaterTavernAgency
	local var_46_1 = var_2.GetMainPlayer(var_46_0)
	local var_46_2 = arg_46_0.cardViewManager

	var_3.SetMainPlayerSeat(var_46_2, var_46_1.seat)
	arg_46_0:SetActiveState(true)
	arg_46_0:HideCurrentBoutCoundDown()

	local var_46_3 = arg_46_0.cheaterTavernAgency
	local var_46_4 = var_3.GetRealCard(var_46_3)

	pg = var_46_0

	local var_46_5 = var_46_0.bar_card[var_46_4]

	GetImageSpriteFromAtlasAsync = var_46_3

	var_46_3("Island/IslandCheaterTavernIcon/" .. var_46_5.card_res, "", arg_46_0.uirealCard)

	GetImageSpriteFromAtlasAsync = var_46_3

	var_46_3("Island/IslandCheaterTavernIcon/" .. var_46_5.card_res, "", arg_46_0.uirealCardTip)
	arg_46_0:ResetBountOp()
	arg_46_0:InitPlayerHudInfo()
	arg_46_0:InitMainCard()
	arg_46_0:InitOtherPlayerCard()
	arg_46_0:UpdateDelegateState()
	arg_46_0:UpdateOneBout(arg_46_1)

	return
end

function var_0_1.InitMainCard(arg_47_0)
	local var_47_0 = arg_47_0.cheaterTavernAgency

	arg_47_0.cardDataList = var_1.GetMainPlayerCards(var_47_0)

	local var_47_1 = arg_47_0.cardViewManager

	var_1.DestroyMainCard(var_47_1)

	local var_47_2 = arg_47_0.cardViewManager

	var_1.InitMainCard(var_47_2, arg_47_0.cardDataList)

	return
end

function var_0_1.InitPlayerHudInfo(arg_48_0)
	local var_48_0 = arg_48_0.cheaterTavernAgency

	arg_48_0.playerList, arg_48_0.playerUserIndexDic = var_1.GetPlayerList(var_48_0)

	return
end

function var_0_1.InitOtherPlayerCard(arg_49_0)
	local var_49_0 = arg_49_0.cardViewManager

	var_1.InitOtherPlayerCard(var_49_0, arg_49_0.playerList)

	return
end

function var_0_1.UpdatePlayerHudInfo(arg_50_0)
	local var_50_0 = arg_50_0.uiplayerHudInfoList

	var_1.align(var_50_0, #arg_50_0.playerList)

	return
end

function var_0_1.ResetBountOp(arg_51_0)
	setActive = var_1_10001

	var_1_10001(arg_51_0.uiopBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_51_0.uishootOp, false)

	return
end

function var_0_1.UpdateOneBout(arg_52_0, arg_52_1)
	setActive = var_1_10002

	var_1_10002(arg_52_0.uiopBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_52_0.uishootOp, false)

	arg_52_0.operation = arg_52_1

	arg_52_0:UpdatePlayerHudInfo()
	arg_52_0:UpdataHp()

	IslandCheaterTavernConst = var_2

	if var_2.putCardTest then
		setActive = var_2

		var_2(arg_52_0.uiopBtn, true)

		setActive = var_2

		local var_52_0 = arg_52_0.uiopBtn

		var_2(var_4.Find(var_52_0, "putCard"), true)

		return
	end

	setActive = var_2

	var_2(arg_52_0.uicountDown, true)
	arg_52_0:StartRounCountDown(arg_52_1.auto_time)

	if not arg_52_0:IsSelf(arg_52_1.user_id) then
		return
	end

	local var_52_1 = arg_52_1.operationType

	IslandCheaterTavernConst = var_1_10003

	local var_52_4

	if var_1_10003.PlayerCurrentOperateType.ShootByOther <= var_52_1 then
		local var_52_2 = arg_52_0.cheaterTavernAgency
		local var_52_3 = var_52_1.GetMainPlayer(var_52_2)
		local var_52_5

		var_52_4, var_52_5 = var_52_1.GetCurrentAndAllHp(var_52_3)

		if var_52_4 == var_52_5 then
			local var_52_6 = arg_52_0.cardViewManager

			var_5.ClearTableCard(var_52_6)

			setActive = var_5

			var_5(arg_52_0.uishootOp, true)

			local var_52_7 = arg_52_0.parent
			local var_52_8 = var_5.emitCore

			CheaterTavernEvent = var_8

			var_52_8(var_52_7, var_8.FIRST_TAKE_SHOOT_TIPS, var_52_1.seat)
		end

		return
	end

	setActive = var_52_1

	var_52_1(arg_52_0.uiopBtn, true)

	IslandCheaterTavernRecordTools = var_52_1

	var_52_1.StartPutCardTime()

	local var_52_9 = arg_52_0.cheaterTavernAgency
	local var_52_10 = var_2.CheckCanOnlyQurey(var_52_9)

	setActive = var_52_4

	local var_52_11 = arg_52_0.uiopBtn

	var_52_4(var_5.Find(var_52_11, "putCard"), not var_52_10)

	setActive = var_52_4

	local var_52_12 = arg_52_0.uiopBtn

	var_52_4(var_5.Find(var_52_12, "query"), arg_52_0.tableCardNum > 0)

	return
end

function var_0_1.UpdataHp(arg_53_0)
	local var_53_0 = arg_53_0.cheaterTavernAgency
	local var_53_1 = var_1.GetMainPlayer(var_53_0)

	if var_1.IsOut(var_53_1) then
		setActive = var_2

		var_2(arg_53_0.uiOutGo, true)

		setActive = var_2

		var_2(arg_53_0.uiHpGo, false)
	else
		setActive = var_2

		var_2(arg_53_0.uiOutGo, false)

		setActive = var_2

		var_2(arg_53_0.uiHpGo, true)

		local var_53_2 = var_1
		local var_53_3, var_53_4 = var_1.GetCurrentAndAllHp(var_53_2)

		setText = var_53_2

		var_53_2(arg_53_0.uicurHpNum, var_53_3 .. "/" .. var_53_4)
	end

	return
end

function var_0_1.OnInit(arg_54_0)
	return
end

function var_0_1.OnHide(arg_55_0)
	setParent = var_1_10001

	var_1_10001(arg_55_0.uiTipsTf, arg_55_0._tf)

	if arg_55_0.cardViewManager then
		local var_55_0 = arg_55_0.cardViewManager

		var_1.Destroy(var_55_0)

		arg_55_0.cardViewManager = nil
	end

	arg_55_0:StopRoundCoundDown()
	arg_55_0:RemoveRealCardTipShowTime()
	arg_55_0:StopLastBountPerformTimer()

	if arg_55_0.questionTimer then
		local var_55_1 = arg_55_0.questionTimer

		var_1.Stop(var_55_1)

		arg_55_0.questionTimer = nil
	end

	if arg_55_0.tipsTimer then
		local var_55_2 = arg_55_0.tipsTimer

		var_1.Stop(var_55_2)

		arg_55_0.tipsTimer = nil
	end

	arg_55_0:StopHideTipsTimer()

	return
end

function var_0_1.WorldPosition2LocalPosition(arg_56_0, arg_56_1, arg_56_2)
	pg = var_1_10003

	local var_56_0 = var_1_10003.UIMgr.GetInstance().overlayCameraComp

	CheatTavernCameraMgr = var_1_10004

	local var_56_1 = var_1_10004.instance._mainCamera
	local var_56_2 = var_4.WorldToViewportPoint(var_56_1, arg_56_2)
	local var_56_3 = var_56_0
	local var_56_4 = var_56_0.ViewportToScreenPoint(var_56_3, var_56_2)
	local var_56_5 = arg_56_1:GetComponent("RectTransform")

	LuaHelper = var_56_3

	return (var_56_3.ScreenToLocal(var_56_5, var_56_4, var_56_0))
end

function var_0_1.UpdateDelegateState(arg_57_0)
	local var_57_0 = arg_57_0.cheaterTavernAgency
	local var_57_1 = var_1.GetMainPlayer(var_57_0)

	setActive = var_1_10002

	var_1_10002(arg_57_0.uiDelegate, var_57_1:IsDelegate())
	arg_57_0:UpdatePlayerHudInfo()

	return
end

function var_0_1.DestroyMainCard(arg_58_0)
	if arg_58_0.cardViewManager then
		local var_58_0 = arg_58_0.cardViewManager

		var_1.DestroyMainCard(var_58_0)
	end

	return
end

function var_0_1.ShowTips(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_2 == nil then
		setText = var_1_10003

		var_1_10003(arg_59_0.uiResultText, arg_59_1)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiResultText, true)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiQueryText, false)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiPunishmentText, false)
	else
		setText = var_1_10003

		var_1_10003(arg_59_0.uiQueryText, arg_59_1)

		setText = var_1_10003

		var_1_10003(arg_59_0.uiPunishmentText, arg_59_2)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiResultText, false)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiQueryText, true)

		setActive = var_1_10003

		var_1_10003(arg_59_0.uiPunishmentText, true)
	end

	arg_59_0:StopHideTipsTimer()

	setActive = var_3

	var_3(arg_59_0.uiTipsTf, false)

	setActive = var_3

	var_3(arg_59_0.uiTipsTf, true)

	Timer = var_3
	arg_59_0.hideTipsTimer = var_3.New(function()
		local var_60_0 = arg_59_0.uiTipsAnimator

		var_0.SetTrigger(var_60_0, "hide")

		return
	end, 2, 1)

	local var_59_0 = arg_59_0.hideTipsTimer

	var_3.Start(var_59_0)

	return
end

function var_0_1.StopHideTipsTimer(arg_61_0)
	if arg_61_0.hideTipsTimer then
		local var_61_0 = arg_61_0.hideTipsTimer

		var_1.Stop(var_61_0)

		arg_61_0.hideTipsTimer = nil
	end

	return
end

return var_0_1
