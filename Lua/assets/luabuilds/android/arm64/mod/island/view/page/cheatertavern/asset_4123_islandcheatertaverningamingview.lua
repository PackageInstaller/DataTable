local IslandCheaterTavernInGamingView = class("IslandCheaterTavernInGamingView", import(".IslandCheaterTavernBaseView"))

function IslandCheaterTavernInGamingView:Ctor(arg_1_1)
	IslandCheaterTavernInGamingView.super.Ctor(self, arg_1_1)

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

function IslandCheaterTavernInGamingView:Init()
	self.super.Init(self)

	self.playerHudTFDic = {}
	self.uiplayerHudInfoList = UIItemList.New(self.uiplayerInfoList, self.uiplayerInfoItem)

	self.uiplayerHudInfoList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			self:OnInitPlayerHudInfoItem(arg_3_1, arg_3_2)
		elseif arg_3_0 == UIItemList.EventUpdate then
			self:OnUpdatePlayerHudInfoItem(arg_3_1, arg_3_2)
		end

		return
	end)
	self.uiplayerHudInfoList:each(function(arg_4_0, arg_4_1)
		self:OnInitPlayerHudInfoItem(arg_4_0, arg_4_1)

		return
	end)
	setText(self.uicurHpNum, string.format("%s/%s", pg.gameset.bar_punishment_limit.key_value, pg.gameset.bar_punishment_limit.key_value))
	onButton(self, self.uiqueryBtn, function()
		self:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.Query)

		return
	end)

	local var_2_0 = GetOrAddComponent(self.uishootBtn, "EventTriggerListener")
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

			self:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.Shoot)
		end

		return
	end)
	var_2_0:AddPointUpFunc(function(arg_8_0, arg_8_1)
		startPos = nil

		return
	end)
	onButton(self, self.uiDelegate, function()
		self:emit(IslandMediator.CHEATER_TAVERN_CANCEL_DELEGATE)

		return
	end)
	onButton(self, self.uiputCardBtn, function()
		local var_10_0 = self.cardViewManager:GetSelectCardKeyList()

		if IslandCheaterTavernConst.putCardTest then
			self.cardViewManager:PutDownMainCard(var_10_0)

			return
		end

		if #var_10_0 == 0 or #var_10_0 > IslandCheaterTavernConst.putCountMax then
			return
		end

		self:emit(IslandMediator.CHEATER_TAVERN_OPERATE, IslandCheaterTavernConst.PlayerOperateType.PutCard, var_10_0)

		return
	end)

	self.timeMgr = pg.TimeMgr.GetInstance()
	self.cardViewManager = IslandCheaterTavernCardViewManager.New(self.uicardList)

	setText(self.uiScoreNum, (PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID())))
	setText(self.uireakCardbgText, i18n("bar_ui_start2"))
	setText(self.uireakCardTipText, i18n("bar_ui_start1"))
	setText(self.uiScoreTitle, i18n("bar_ui_game3"))
	setText(self.uishootText, i18n("bar_ui_game4"))
	setText(self.uiOutText, i18n("bar_ui_game1"))
	setActive(self.uiTipsTf, false)
	setParent(self.uiTipsTf, pg.UIMgr.GetInstance().OverlayToast)
	self.cheaterTavernAgency:SetUILoadOver(true)

	return
end

function IslandCheaterTavernInGamingView:OnCheaterOperateDone(arg_11_1)
	if arg_11_1.type == IslandCheaterTavernConst.PlayerOperateType.PutCard then
		setActive(self.uiopBtn, false)
		self:PutMainCardDone(arg_11_1.arg_list)
	elseif arg_11_1.type == IslandCheaterTavernConst.PlayerOperateType.Shoot then
		setActive(self.uishootOp, false)
	else
		setActive(self.uiopBtn, false)
	end

	return
end

function IslandCheaterTavernInGamingView:PutMainCardDone(arg_12_1)
	self.cardViewManager:PutDownMainCard(arg_12_1)

	self.cardDataList = self.cheaterTavernAgency:GetMainPlayerCards()

	self.cardViewManager:RefreshMainCard(self.cardDataList)

	return
end

function IslandCheaterTavernInGamingView:StartLastBountPerformTimer(arg_13_1, arg_13_2)
	if arg_13_1 <= 0 then
		existCall(arg_13_2)

		return
	end

	self.lastBountPerformTimer = Timer.New(function()
		existCall(arg_13_2)

		return
	end, arg_13_1, 1)

	self.lastBountPerformTimer:Start()

	return
end

function IslandCheaterTavernInGamingView:StopLastBountPerformTimer()
	if self.lastBountPerformTimer then
		self.lastBountPerformTimer:Stop()

		self.lastBountPerformTimer = nil
	end

	return
end

function IslandCheaterTavernInGamingView:HideCurrentBoutCoundDown()
	setActive(self.uicountDown, false)
	self:StopRoundCoundDown()

	return
end

function IslandCheaterTavernInGamingView:UpdataLastBoutDisplay(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.user_id
	local var_17_1 = 0
	local var_17_2
	local var_17_3 = arg_17_1.user_id == getProxy(PlayerProxy):getRawData().id

	if var_17_3 then
		local var_17_4 = self.cheaterTavernAgency:GetMainPlayer() or self.cheaterTavernAgency:GetPlayerData(arg_17_1.user_id)
	end

	local var_17_5 = getProxy(PlayerProxy):getRawData().id

	local function var_17_6()
		if var_17_3 then
			setActive(self.uiopBtn, false)
		end

		return
	end

	switch(arg_17_1.type, {
		[IslandCheaterTavernConst.PlayerOperateType.PutCard] = function()
			var_17_6()
			self.cardViewManager:ClearTableCard()

			if var_17_3 then
				if arg_17_2 then
					self.cardViewManager:PutDownMainCard(arg_17_2)

					self.cardDataList = self.cheaterTavernAgency:GetMainPlayerCards()

					self.cardViewManager:RefreshMainCard(self.cardDataList)
				end
			else
				self.cardViewManager:OtherPlayerPutCard(var_17_0, arg_17_1.return_list[2])
			end

			self.tableCardNum = arg_17_1.return_list[2]

			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Query] = function()
			var_17_6()

			self.tableCardNum = 0
			self.deskCardList = {}

			local var_20_0 = arg_17_1.return_list[1]

			setActive(self.uiqueryEffect, true)

			if var_17_3 then
				setAnchoredPosition(self.uiqueryEffect, Vector2(var_0_1[1], var_0_1[2]))
			else
				setAnchoredPosition(self.uiqueryEffect, Vector2(var_0_2[self.playerUserIndexDic[var_17_0]][1], var_0_2[self.playerUserIndexDic[var_17_0]][2]))
			end

			local var_20_2

			if var_17_3 then
				var_20_2 = var_17_4.seat

				CheatTavernCameraMgr.instance:ActiveVirtualCamera("questSeet0" .. var_17_4.seat)
				onNextTick(function()
					self:UpdatePlayerHudInfo()

					return
				end)
			else
				self.cardViewManager:PlayerCardSetActive(var_17_0, false)
			end

			self.parent:emitCore(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, var_17_0, var_17_3, var_20_2)

			local function var_20_3()
				if var_17_3 then
					CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. var_20_2)
					onNextTick(function()
						self:UpdatePlayerHudInfo()

						return
					end)
				else
					self.cardViewManager:PlayerCardSetActive(var_17_0, true)
				end

				setActive(self.uiqueryEffect, false)
				CheatTavernCameraMgr.instance:ActiveVirtualCamera("shootSeet0" .. self.cheaterTavernAgency:GetMainPlayer().seat)
				self.cardViewManager:PlayerCardSetActive(var_17_5, false)

				local var_22_0 = {}

				for iter_22_0 = 2, #arg_17_1.return_list do
					table.insert(var_22_0, arg_17_1.return_list[iter_22_0])
				end

				self.cardViewManager:FlipTableCard(var_22_0)

				return
			end

			local function var_20_4()
				local var_24_0 = self.cheaterTavernAgency:GetPlayerData(var_17_0):GetName()

				self:ShowTips(i18n(var_20_0 == 1 and "bar_tips_game1" or "bar_tips_game2", var_24_0), i18n("bar_tips_game5", var_20_0 == 1 and self.cheaterTavernAgency:GetPlayerData(arg_17_1.next_user_id):GetName() or var_24_0))

				return
			end

			if self.questionTimer then
				self.questionTimer:Stop()
			end

			self.questionTimer = Timer.New(function()
				var_20_3()

				return
			end, 2, 1)

			if self.tipsTimer then
				self.tipsTimer:Stop()
			end

			self.tipsTimer = Timer.New(function()
				var_20_4()

				return
			end, 3.5, 1)

			self.questionTimer:Start()
			self.tipsTimer:Start()

			var_17_1 = pg.gameset.bar_question_time.key_value

			function var_17_2()
				setActive(self.uiTipsTf, false)

				return
			end

			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Shoot] = function()
			var_17_6()

			if var_17_3 then
				setActive(self.uishootOp, false)
			end

			self.cardViewManager:ClearTableCard()

			local var_28_0 = arg_17_1.return_list[2]
			local var_28_1 = self.cheaterTavernAgency:GetMainPlayer().seat
			local var_28_2, var_28_3 = var_17_4:GetCurrentBombId()

			self.parent:emitCore(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, var_17_3, var_17_4.seat, var_28_2, var_28_3, var_28_0 == 1)

			var_17_1 = pg.gameset.bar_punishment_turntable_time.key_value

			function var_17_2()
				CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. var_28_1)
				self.cardViewManager:PlayerCardSetActive(var_17_5, true)
				self:ShowTips(i18n(var_28_0 == 1 and "bar_tips_game3" or "bar_tips_game4", (var_17_4:GetName())))

				if var_28_0 == 1 then
					if var_17_3 then
						self.cardViewManager:DestroyMainCard()
					end

					local var_29_1
					local var_29_2
					local var_29_0

					do
						self.cardViewManager:OtherPlayerCardDestroy(var_17_0)

						var_29_0 = CheaterTavernEvent.PLAYER_OUT_ANIMATION
						var_29_1 = var_17_0
						var_29_2 = getProxy(PlayerProxy)
					end

					self.parent:emitCore(var_29_0, var_29_1, var_17_4.seat, var_17_0 == var_29_2:getRawData().id)
				end

				local var_29_3 = self.playerUserIndexDic[var_17_0]

				if self.playerUserIndexDic[var_17_0] then
					if var_28_0 == 1 then
						setActive(self.playerHudTFDic[var_29_3]:Find("out"), (self.playerList[var_29_3]:IsOut()))
					end
				end

				onNextTick(function()
					self:UpdatePlayerHudInfo()

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

function IslandCheaterTavernInGamingView:UpdateCurrentBoutDisplay(arg_32_1)
	local var_32_0 = {
		user_id = arg_32_1.next_user_id
	}

	if var_32_0.user_id == 0 then
		return
	end

	local var_32_1 = arg_32_1.next_type == 1 and IslandCheaterTavernConst.PlayerCurrentOperateType.PutCardOrQuery or arg_32_1.next_type == 2 and IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther or IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOwn

	if var_32_1 >= IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther then
		local var_32_2, var_32_3 = self.cheaterTavernAgency:GetPlayerData(var_32_0.user_id):GetCurrentAndAllHp()

		if var_32_2 ~= var_32_3 then
			return
		end
	end

	var_32_0.operationType = var_32_1
	var_32_0.auto_time = arg_32_1.auto_time

	self:UpdateOneBout(var_32_0)

	return
end

function IslandCheaterTavernInGamingView:OnCheaterOperateDoneNotify(arg_33_1)
	local var_33_0 = arg_33_1.data

	self:HideCurrentBoutCoundDown()

	local var_33_1, var_33_2 = self:UpdataLastBoutDisplay(arg_33_1.data, arg_33_1.putCard)

	self:StopLastBountPerformTimer()
	self:StartLastBountPerformTimer(var_33_1, function()
		existCall(var_33_2)
		self:UpdateCurrentBoutDisplay(var_33_0)

		return
	end)

	return
end

function IslandCheaterTavernInGamingView:OnPlayerEscape(arg_35_1)
	local var_35_0 = self.cheaterTavernAgency:GetPlayerData(arg_35_1)

	if var_35_0:IsOut() then
		return
	end

	var_35_0:SetOutState()
	setActive(self.playerHudTFDic[self.playerUserIndexDic[arg_35_1]]:Find("out"), true)
	setActive(self.playerHudTFDic[self.playerUserIndexDic[arg_35_1]]:Find("hp"), false)
	self.cardViewManager:OtherPlayerCardDestroy(arg_35_1)
	self.parent:emitCore(CheaterTavernEvent.PLAYER_OUT_ANIMATION, arg_35_1, var_35_0.seat, arg_35_1 == getProxy(PlayerProxy):getRawData().id)

	return
end

function IslandCheaterTavernInGamingView:Show()
	return
end

function IslandCheaterTavernInGamingView:OnInitPlayerHudInfoItem(arg_37_1, arg_37_2)
	local var_37_0 = tf(arg_37_2)

	self.playerHudTFDic[arg_37_1 + 1] = var_37_0

	setActive(var_37_0:Find("out"), false)
	setText(var_37_0:Find("out/outText"), i18n("bar_ui_game1"))
	setText(var_37_0:Find("hp/hpNum"), string.format("%s/%s", pg.gameset.bar_punishment_limit.key_value, pg.gameset.bar_punishment_limit.key_value))
	setActive(self.uiOutGo, false)
	setActive(self.uiHpGo, true)

	return
end

function IslandCheaterTavernInGamingView:OnUpdatePlayerHudInfoItem(arg_38_1, arg_38_2)
	local var_38_0 = tf(arg_38_2)

	var_38_0.localPosition = self:WorldPosition2LocalPosition(self.uiplayerInfoList, (Vector3(pg.island_world_objects[10110000 + self.playerList[arg_38_1 + 1].seat].param.position[1] + ({
		1,
		0,
		-1,
		0
	})[self.playerList[arg_38_1 + 1].seat] * 2, IslandCheaterTavernConst.hudHeight + ((math.abs(self.cheaterTavernAgency:GetMainPlayer().seat - self.playerList[arg_38_1 + 1].seat) == 2 or nil) and 0.3), pg.island_world_objects[10110000 + self.playerList[arg_38_1 + 1].seat].param.position[3] + ({
		0,
		-1,
		0,
		1
	})[self.playerList[arg_38_1 + 1].seat] * 2)))

	setText(var_38_0:Find("adapt/name"), tostring(self.playerList[arg_38_1 + 1].player_info.name))

	local var_38_2, var_38_3 = self.playerList[arg_38_1 + 1]:GetCurrentAndAllHp()

	setText(var_38_0:Find("hp/hpNum"), var_38_2 .. "/" .. var_38_3)
	setActive(var_38_0:Find("in_process"), self.operation and self.operation.user_id == self.playerList[arg_38_1 + 1].user_id)
	setActive(var_38_0:Find("hp"), not self.playerList[arg_38_1 + 1]:IsOut())
	setActive(var_38_0:Find("adapt/delegate"), self.playerList[arg_38_1 + 1]:IsDelegate())

	return
end

function IslandCheaterTavernInGamingView:StartRounCountDown(arg_39_1)
	self:StopRoundCoundDown()

	self.randCoundDownTimer = Timer.New(function()
		local var_40_0 = arg_39_1 - self.timeMgr:GetServerTime()

		setActive(self.uiFirstTimeImg, true)
		setActive(self.uiSecondTimeImg, true)

		if var_40_0 < 0 then
			var_40_0 = 0

			setImageSprite(self.uiFirstTimeImg, self.parent:GetNumSpriteByIndex(0), true)
			setImageSprite(self.uiSecondTimeImg, self.parent:GetNumSpriteByIndex(0), true)
			self:StopRoundCoundDown()

			return
		end

		local var_40_1 = math.floor(var_40_0 % 60)
		local var_40_2 = math.floor(var_40_1 / 10)

		if var_40_2 <= 0 then
			setActive(self.uiFirstTimeImg, false)
			setImageSprite(self.uiSecondTimeImg, self.parent:GetNumSpriteByIndex(var_40_1 % 10), true)

			return
		end

		setImageSprite(self.uiFirstTimeImg, self.parent:GetNumSpriteByIndex(var_40_2), true)
		setImageSprite(self.uiSecondTimeImg, self.parent:GetNumSpriteByIndex(var_40_1 % 10), true)

		return
	end, 1, -1)

	self.randCoundDownTimer.func()

	if self.randCoundDownTimer then
		self.randCoundDownTimer:Start()
	end

	return
end

function IslandCheaterTavernInGamingView:StopRoundCoundDown()
	if self.randCoundDownTimer then
		self.randCoundDownTimer:Stop()

		self.randCoundDownTimer = nil
	end

	return
end

function IslandCheaterTavernInGamingView:RemoveRealCardTipShowTime()
	if self.realCardTipShowTimer then
		self.realCardTipShowTimer:Stop()

		self.realCardTipShowTimer = nil
	end

	return
end

function IslandCheaterTavernInGamingView:OnCheaterEveryRoundStart()
	self.tableCardNum = 0

	self.cardViewManager:SetMainPlayerSeat(self.cheaterTavernAgency:GetMainPlayer().seat)
	self:SetActiveState(false)
	setActive(self.uiRondRealCardTips, false)
	setActive(self.uiputCardDestList, false)
	setActive(self.uiqueryEffect, false)
	setActive(self.uicountDown, false)
	setActive(self.uiDelegate, false)
	self:StopLastBountPerformTimer()

	return
end

function IslandCheaterTavernInGamingView:OnCheaterEveryRoundStartDone(arg_44_1)
	CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. self.cheaterTavernAgency:GetMainPlayer().seat)
	self:HideCurrentBoutCoundDown()
	self:SetActiveState(true)
	setActive(self.uiRondRealCardTips, true)

	local var_44_0 = pg.bar_card[self.cheaterTavernAgency:GetRealCard()]

	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_44_0.card_res, "", self.uirealCard)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_44_0.card_res, "", self.uirealCardTip)
	self:RemoveRealCardTipShowTime()

	self.realCardTipShowTimer = Timer.New(function()
		setActive(self.uiRondRealCardTips, false)
		self:UpdateOneBout(arg_44_1)

		return
	end, pg.gameset.bar_refreshcard_time.key_value, 1)

	self.realCardTipShowTimer:Start()
	self:ResetBountOp()
	self:InitPlayerHudInfo()
	self:InitMainCard()
	self:InitOtherPlayerCard()
	self:UpdateDelegateState()

	return
end

function IslandCheaterTavernInGamingView:OnCheaterReconected(arg_46_1)
	setActive(self.uiRondRealCardTips, false)

	self.tableCardNum = 0

	self.cardViewManager:SetMainPlayerSeat(self.cheaterTavernAgency:GetMainPlayer().seat)
	self:SetActiveState(true)
	self:HideCurrentBoutCoundDown()

	local var_46_0 = pg.bar_card[self.cheaterTavernAgency:GetRealCard()]

	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_46_0.card_res, "", self.uirealCard)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. var_46_0.card_res, "", self.uirealCardTip)
	self:ResetBountOp()
	self:InitPlayerHudInfo()
	self:InitMainCard()
	self:InitOtherPlayerCard()
	self:UpdateDelegateState()
	self:UpdateOneBout(arg_46_1)

	return
end

function IslandCheaterTavernInGamingView:InitMainCard()
	self.cardDataList = self.cheaterTavernAgency:GetMainPlayerCards()

	self.cardViewManager:DestroyMainCard()
	self.cardViewManager:InitMainCard(self.cardDataList)

	return
end

function IslandCheaterTavernInGamingView:InitPlayerHudInfo()
	self.playerList, self.playerUserIndexDic = self.cheaterTavernAgency:GetPlayerList()

	return
end

function IslandCheaterTavernInGamingView:InitOtherPlayerCard()
	self.cardViewManager:InitOtherPlayerCard(self.playerList)

	return
end

function IslandCheaterTavernInGamingView:UpdatePlayerHudInfo()
	self.uiplayerHudInfoList:align(#self.playerList)

	return
end

function IslandCheaterTavernInGamingView:ResetBountOp()
	setActive(self.uiopBtn, false)
	setActive(self.uishootOp, false)

	return
end

function IslandCheaterTavernInGamingView:UpdateOneBout(arg_52_1)
	setActive(self.uiopBtn, false)
	setActive(self.uishootOp, false)

	self.operation = arg_52_1

	self:UpdatePlayerHudInfo()
	self:UpdataHp()

	if IslandCheaterTavernConst.putCardTest then
		setActive(self.uiopBtn, true)
		setActive(self.uiopBtn:Find("putCard"), true)

		return
	end

	setActive(self.uicountDown, true)
	self:StartRounCountDown(arg_52_1.auto_time)

	if not self:IsSelf(arg_52_1.user_id) then
		return
	end

	if arg_52_1.operationType >= IslandCheaterTavernConst.PlayerCurrentOperateType.ShootByOther then
		local var_52_0 = self.cheaterTavernAgency:GetMainPlayer()
		local var_52_1, var_52_2 = var_52_0:GetCurrentAndAllHp()

		if var_52_1 == var_52_2 then
			self.cardViewManager:ClearTableCard()
			setActive(self.uishootOp, true)
			self.parent:emitCore(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, var_52_0.seat)
		end

		return
	end

	setActive(self.uiopBtn, true)
	IslandCheaterTavernRecordTools.StartPutCardTime()
	setActive(self.uiopBtn:Find("putCard"), not self.cheaterTavernAgency:CheckCanOnlyQurey())
	setActive(self.uiopBtn:Find("query"), self.tableCardNum > 0)

	return
end

function IslandCheaterTavernInGamingView:UpdataHp()
	local var_53_0 = self.cheaterTavernAgency:GetMainPlayer()

	if var_53_0:IsOut() then
		setActive(self.uiOutGo, true)
		setActive(self.uiHpGo, false)
	else
		setActive(self.uiOutGo, false)
		setActive(self.uiHpGo, true)

		local var_53_1, var_53_2 = var_53_0:GetCurrentAndAllHp()

		setText(self.uicurHpNum, var_53_1 .. "/" .. var_53_2)
	end

	return
end

function IslandCheaterTavernInGamingView:OnInit()
	return
end

function IslandCheaterTavernInGamingView:OnHide()
	setParent(self.uiTipsTf, self._tf)

	if self.cardViewManager then
		self.cardViewManager:Destroy()

		self.cardViewManager = nil
	end

	self:StopRoundCoundDown()
	self:RemoveRealCardTipShowTime()
	self:StopLastBountPerformTimer()

	if self.questionTimer then
		self.questionTimer:Stop()

		self.questionTimer = nil
	end

	if self.tipsTimer then
		self.tipsTimer:Stop()

		self.tipsTimer = nil
	end

	self:StopHideTipsTimer()

	return
end

function IslandCheaterTavernInGamingView:WorldPosition2LocalPosition(arg_56_1, arg_56_2)
	local var_56_0 = pg.UIMgr.GetInstance().overlayCameraComp

	return (LuaHelper.ScreenToLocal(arg_56_1:GetComponent("RectTransform"), var_56_0:ViewportToScreenPoint((CheatTavernCameraMgr.instance._mainCamera:WorldToViewportPoint(arg_56_2))), var_56_0))
end

function IslandCheaterTavernInGamingView:UpdateDelegateState()
	setActive(self.uiDelegate, self.cheaterTavernAgency:GetMainPlayer():IsDelegate())
	self:UpdatePlayerHudInfo()

	return
end

function IslandCheaterTavernInGamingView:DestroyMainCard()
	if self.cardViewManager then
		self.cardViewManager:DestroyMainCard()
	end

	return
end

function IslandCheaterTavernInGamingView:ShowTips(arg_59_1, arg_59_2)
	if arg_59_2 == nil then
		setText(self.uiResultText, arg_59_1)
		setActive(self.uiResultText, true)
		setActive(self.uiQueryText, false)
		setActive(self.uiPunishmentText, false)
	else
		setText(self.uiQueryText, arg_59_1)
		setText(self.uiPunishmentText, arg_59_2)
		setActive(self.uiResultText, false)
		setActive(self.uiQueryText, true)
		setActive(self.uiPunishmentText, true)
	end

	self:StopHideTipsTimer()
	setActive(self.uiTipsTf, false)
	setActive(self.uiTipsTf, true)

	self.hideTipsTimer = Timer.New(function()
		self.uiTipsAnimator:SetTrigger("hide")

		return
	end, 2, 1)

	self.hideTipsTimer:Start()

	return
end

function IslandCheaterTavernInGamingView:StopHideTipsTimer()
	if self.hideTipsTimer then
		self.hideTipsTimer:Stop()

		self.hideTipsTimer = nil
	end

	return
end

return IslandCheaterTavernInGamingView
