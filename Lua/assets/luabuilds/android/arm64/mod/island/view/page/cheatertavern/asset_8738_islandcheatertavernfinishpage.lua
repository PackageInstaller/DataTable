local IslandCheaterTavernFinishPage = class("IslandCheaterTavernFinishPage", import("...base.IslandBasePage"))

function IslandCheaterTavernFinishPage:getUIName()
	return "IslandCheaterTavernFinishUI"
end

function IslandCheaterTavernFinishPage:NeedCache()
	return false
end

function IslandCheaterTavernFinishPage:OnLoaded()
	onButton(self, self.uiquitBtn, function()
		self:Hide()
		self:emit(CheaterTavernEvent.FINSH_PAGE_QUIT)

		return
	end)
	onButton(self, self.conninueBtn, function()
		self:Hide()

		return
	end)
	setText(self.quitText, i18n("bar_ui_end1"))
	setText(self.continueText, i18n("bar_ui_end2"))
	setText(self.uiPtNameText, i18n("bar_ui_game3"))

	return
end

function IslandCheaterTavernFinishPage:AddListeners()
	self:AddListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, self.OnGameEndNotify)

	return
end

function IslandCheaterTavernFinishPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, self.OnGameEndNotify)

	return
end

function IslandCheaterTavernFinishPage:OnInit()
	self.animation = self.uirightAdapt:GetComponent(typeof(Animation))

	return
end

function IslandCheaterTavernFinishPage:OnGameEndNotify(arg_9_1)
	if arg_9_1.win_user == self:GetIsland():GetCheaterTavernAgency():GetMainPlayer().id then
		return
	end

	self:RefreshUI(IslandCheaterTavernConst.SettlementType.ByFinal)

	return
end

function IslandCheaterTavernFinishPage:RefreshUI(arg_10_1)
	IslandCheaterTavernRecordTools.RecordResult((arg_10_1 == IslandCheaterTavernConst.SettlementType.ByScore or nil) and (IslandCheaterTavernRecordTools.LOST or IslandCheaterTavernRecordTools.WIN))

	self.cheaterTavernAgency = self:GetIsland():GetCheaterTavernAgency()

	local var_10_0 = self.cheaterTavernAgency:GetMainPlayer()
	local var_10_1 = var_10_0:GetRank()
	local var_10_2 = var_10_0:GetAddScore()

	setActive(self.uiSus, var_10_1 == 1)
	setActive(self.uiFail, var_10_1 ~= 1)
	setText(self.uiWinNameText, var_10_0:GetName())
	setActive(self.conninueBtn, var_10_1 ~= 1)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(PlayRoomTools.GetGameTypeID()), "", self.uiPtIcon)
	setText(self.uiPtText, (PlayRoomTools.GetPtScrore(PlayRoomTools.GetGameTypeID())))
	setActive(self.uiScore, getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH)
	setText(self.uiPtAddText, (var_10_2 >= 0 and "+" or "") .. var_10_2)

	if var_10_1 == 1 then
		self.animation:Play("Anim_IslandCheaterTavernFinishUI_win")
	else
		self.animation:Play("Anim_IslandCheaterTavernFinishUI_los")
	end

	if arg_10_1 == IslandCheaterTavernConst.SettlementType.ByFinal then
		setActive(self.conninueBtn, false)
	end

	return
end

function IslandCheaterTavernFinishPage:Show(arg_11_1)
	IslandCheaterTavernFinishPage.super.Show(self)
	self:RefreshUI(arg_11_1)

	return
end

function IslandCheaterTavernFinishPage:OnDestroy()
	IslandCheaterTavernFinishPage.super.OnDestroy(self)

	return
end

function IslandCheaterTavernFinishPage:OnHide()
	return
end

return IslandCheaterTavernFinishPage
