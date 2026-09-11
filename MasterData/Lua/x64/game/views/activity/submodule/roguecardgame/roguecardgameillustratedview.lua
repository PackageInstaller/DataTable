local RogueCardGameIllustratedView = class("RogueCardGameIllustratedView", ReduxView)

function RogueCardGameIllustratedView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_IllustratedUI"
end

function RogueCardGameIllustratedView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameIllustratedView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RogueCardGameIllustratedView:InitUI()
	self:BindCfgUI()

	self.contentCon_ = self.controller_:GetController("content")
	self.tabConList_ = {}

	for iter_4_0 = 1, 4 do
		self.tabConList_[iter_4_0] = self["tabController_" .. iter_4_0]:GetController("select")
	end

	self.jokerCardTagList_ = {}
	self.jokerTabConList_ = {}
	self.jokerCardLockCon_ = self.jokerCardController_:GetController("lock")

	for iter_4_1 = 1, 4 do
		self.jokerTabConList_[iter_4_1] = self["jokeTabController_" .. iter_4_1]:GetController("default0")
	end

	self.wcTabConList_ = {}
	self.wcLockCon_ = self.wcController_:GetController("lock")
	self.wuchangsuitCon_ = self.wcController_:GetController("wuchangsuit")

	for iter_4_2 = 1, 2 do
		self.wcTabConList_[iter_4_2] = self["wcTabController_" .. iter_4_2]:GetController("default0")
	end

	self.cardBuffConList_ = {}
	self.cardBuffListCon_ = self.contBuffController_:GetController("list")
	self.cardCardListCon_ = self.contBuffController_:GetController("card")
	self.cardBuffItemLockCon_ = self.cardBuffItemInfo_:GetController("lock")
	self.cardJokerItemLockCon_ = self.cardJokerItemInfo_:GetController("lock")

	for iter_4_3 = 1, 3 do
		self.cardBuffConList_[iter_4_3] = self["contBuffController_" .. iter_4_3]:GetController("default0")
	end

	self.eliminated_list = {}
	self.nonactivated_list = {}
	self.tabSelectIndex = 1
	self.jokerCardIndex = 1
	self.wuChangIndex = 1
	self.buffIndex = 1
	self.cardIndex = 1
	self.jokerCardSel = 1
	self.wcSel = 1
	self.cardBuffSel = 1
	self.jokerCardUiList_ = LuaList.New(handler(self, self.IndexItem1), self.jokerCardListGo_, RogueCardJokerCardItem)
	self.wcUiList_ = LuaList.New(handler(self, self.IndexItem2), self.wuChangListGo_, RogueCardWuChangItem)
	self.carBUffList_ = {}

	for iter_4_4 = 1, 5 do
		local var_4_0 = RogueCardGameCardBuffItem.New(self["cardBuffItem_" .. iter_4_4])

		var_4_0:SetClickHandle(function(arg_5_0, arg_5_1)
			self.cardBuffSel = arg_5_1

			self:RefreshCardBuffItemInfo(arg_5_0)

			for iter_5_0 = 1, #self.carBUffList_ do
				self.carBUffList_[iter_5_0]:SetSelected(arg_5_1)
			end

			self:RefreshCardEnhanceRedPoint()
		end)
		table.insert(self.carBUffList_, var_4_0)
	end

	self.carBUffStyleList_ = {}

	for iter_4_5 = 1, 4 do
		local var_4_1 = RogueCardGameCardBuffStyleItem.New(self["cardJokerItem_" .. iter_4_5])

		var_4_1:SetClickHandle(function(arg_6_0, arg_6_1)
			self.cardBuffSel = arg_6_1

			self:RefreshCardBuffItemInfo(arg_6_0)

			for iter_6_0 = 1, #self.carBUffStyleList_ do
				self.carBUffStyleList_[iter_6_0]:SetSelected(arg_6_1)
			end

			self:RefreshCardEnhanceRedPoint()
		end)
		table.insert(self.carBUffStyleList_, var_4_1)
	end
end

function RogueCardGameIllustratedView:AddUIListener()
	self:AddBtnListener(self.jokerBtn_, nil, function()
		self.jokerCardSel = 1
		self.tabSelectIndex = 1

		self:RefreshView()
	end)
	self:AddBtnListener(self.wuchangBtn_, nil, function()
		self.jokerCardSel = 1
		self.tabSelectIndex = 2

		self:RefreshView()
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		self.jokerCardSel = 1
		self.tabSelectIndex = 3

		self:RefreshView()
	end)
	self:AddBtnListener(self.cardBtn_, nil, function()
		self.jokerCardSel = 1
		self.tabSelectIndex = 4

		self:RefreshView()
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self.jokerCardSel = 1
		self.jokerCardIndex = 1

		self:RefreshJockerCard()
	end)
	self:AddBtnListener(self.ordinaryBtn_, nil, function()
		self.jokerCardSel = 1
		self.jokerCardIndex = 2

		self:RefreshJockerCard()
	end)
	self:AddBtnListener(self.rareBtn_, nil, function()
		self.jokerCardSel = 1
		self.jokerCardIndex = 4

		self:RefreshJockerCard()
	end)
	self:AddBtnListener(self.preciousBtn_, nil, function()
		self.jokerCardSel = 1
		self.jokerCardIndex = 3

		self:RefreshJockerCard()
	end)
	self:AddBtnListener(self.blackBtn_, nil, function()
		self.wcSel = 1
		self.wuChangIndex = 1

		self:RefreshWuChang()
	end)
	self:AddBtnListener(self.whiteBtn_, nil, function()
		self.wcSel = 1
		self.wuChangIndex = 2

		self:RefreshWuChang()
	end)
	self:AddBtnListener(self.cardPowerBtn_, nil, function()
		self.cardBuffSel = 1
		self.cardIndex = 1

		self:RefreshCard()
	end)
	self:AddBtnListener(self.cardSealBtn_, nil, function()
		self.cardBuffSel = 1
		self.cardIndex = 2

		self:RefreshCard()
	end)
	self:AddBtnListener(self.cardStyleBtn_, nil, function()
		self.cardBuffSel = 1
		self.cardIndex = 3

		self:RefreshCard()
	end)
end

function RogueCardGameIllustratedView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameIllustratedView:UpdateTimeTxt()
	local var_22_0 = os.time()
	local var_22_1 = os.date("!*t", var_22_0 + os.difftime(var_22_0, os.time(os.date("!*t", var_22_0))))

	self.dayText_.text = string.format("%s/%s", var_22_1.month, var_22_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameIllustratedView:IndexItem1(arg_23_1, arg_23_2)
	arg_23_2:SetData(self.jokerCardDataList_[arg_23_1], arg_23_1)
	arg_23_2:SetClickHandle(function(arg_24_0, arg_24_1)
		local var_24_0 = self.jokerCardUiList_:GetScrolledPosition()

		self.jokerCardSel = arg_24_1

		self:RefreshJockerCardItemInfo(arg_24_0)
		self.jokerCardUiList_:Refresh()
		self:RefreshJockerCardRedPoint()
	end)
	arg_23_2:SetSelected(self.jokerCardSel)
end

function RogueCardGameIllustratedView:IndexItem2(arg_25_1, arg_25_2)
	arg_25_2:SetData(self.wcDataList_[arg_25_1], arg_25_1)
	arg_25_2:SetClickHandle(function(arg_26_0, arg_26_1)
		local var_26_0 = self.wcUiList_:GetScrolledPosition()

		self.wcSel = arg_26_1

		self:RefreshWuChangItemInfo(arg_26_0)
		self.wcUiList_:Refresh()
		self:RefreshWuChangRedPoint()
	end)
	arg_25_2:SetSelected(self.wcSel)
end

function RogueCardGameIllustratedView:RefreshJockerCardItemInfo(arg_27_1)
	local var_27_0 = RogueCardItemCfg[arg_27_1]

	if RogueCardGameTools.IsUnlockJokerCard(arg_27_1) then
		self.jokerCardLockCon_:SetSelectedIndex(1)

		self.jokerCardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/item/" .. var_27_0.icon)
		self.jokerCardTitle_.text = GetI18NText(var_27_0.name)

		RichTextTools.SetMixedTextWithImage(self.jokerCardDesc_, GetI18NText(var_27_0.desc))

		self.jokerCardDesc_.text = RogueCardEffectCfg[var_27_0.effect_list[1]].action_type == 4 and System.String.Format(GetI18NText(var_27_0.desc), RogueCardEffectCfg[var_27_0.effect_list[1]].param2[3]) or RogueCardEffectCfg[var_27_0.effect_list[1]].action_type == 42 and System.String.Format(GetI18NText(var_27_0.desc), "A") or GetI18NText(var_27_0.desc)

		local var_27_1 = #var_27_0.tag

		for iter_27_0 = 1, #var_27_0.tag do
			self.jokerCardTagList_[iter_27_0] = self.jokerCardTagList_[iter_27_0] or RogueCardGameJokerCardTagItem.New((Object.Instantiate(self.tagItem_, self.tagContent_)))

			local var_27_2 = var_27_0.tag[iter_27_0]

			self.jokerCardTagList_[iter_27_0]:Show(true)
			self.jokerCardTagList_[iter_27_0]:RefreshData(var_27_2)
		end

		for iter_27_1 = var_27_1 + 1, #self.jokerCardTagList_ do
			self.jokerCardTagList_[iter_27_1]:Show(false)
		end
	else
		self.jokerCardLockCon_:SetSelectedIndex(0)

		self.jokerCardTitle_.text = GetTips("ROGUE_CARD_COLLECT_TITLE")
		self.jokerCardDesc_.text = GetTips("ROGUE_CARD_COLLECT_WORD")
		self.jokerCardRare_.text = ""
	end
end

function RogueCardGameIllustratedView:RefreshWuChangItemInfo(arg_28_1)
	local var_28_0 = RogueCardItemCfg[arg_28_1]

	if RogueCardGameTools.IsUnlockWcCard(arg_28_1) then
		self.wcLockCon_:SetSelectedIndex(1)

		self.wcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_28_0.icon)
		self.wcTitle_.text = GetI18NText(var_28_0.name)

		RichTextTools.SetMixedTextWithImage(self.wcDesc_, GetI18NText(var_28_0.desc))

		self.wcDesc_.text = GetI18NText(var_28_0.desc)

		SetActive(self.wcCoinGo_, true)

		self.wcNUm_.text = var_28_0.sell_price

		if var_28_0.type == 1 then
			self.wuchangsuitCon_:SetSelectedIndex(var_28_0.rare == 1 and 1 or 3)
		else
			self.wuchangsuitCon_:SetSelectedIndex(var_28_0.rare == 1 and 0 or 2)
		end
	else
		self.wcLockCon_:SetSelectedIndex(0)

		self.wcTitle_.text = GetTips("ROGUE_CARD_COLLECT_TITLE")
		self.wcDesc_.text = GetTips("ROGUE_CARD_COLLECT_WORD")

		SetActive(self.wcCoinGo_, false)
	end
end

function RogueCardGameIllustratedView:OnEnter()
	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	self:RefreshView()
	manager.redPoint:bindUIandKey(self.tabController_1.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER)
	manager.redPoint:bindUIandKey(self.tabController_2.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG)
	manager.redPoint:bindUIandKey(self.tabController_3.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL)
	manager.redPoint:bindUIandKey(self.tabController_4.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE)
end

function RogueCardGameIllustratedView:RefreshView()
	if self.lastTabSelectIndex and self.tabSelectIndex ~= self.lastTabSelectIndex then
		self:ClearIllustratedRedPoint(self.lastTabSelectIndex)
	end

	self.contentCon_:SetSelectedIndex(self.tabSelectIndex - 1)

	for iter_31_0 = 1, 4 do
		self.tabConList_[iter_31_0]:SetSelectedIndex(iter_31_0 == self.tabSelectIndex and 1 or 0)
	end

	if self.tabSelectIndex == 1 then
		self:RefreshJockerCard()
	elseif self.tabSelectIndex == 2 then
		self:RefreshWuChang()
	elseif self.tabSelectIndex == 3 then
		self:RefreshBuff()
	elseif self.tabSelectIndex == 4 then
		self:RefreshCard()
	end

	self.lastTabSelectIndex = self.tabSelectIndex
end

function RogueCardGameIllustratedView:ClearIllustratedRedPoint(arg_32_1)
	if arg_32_1 == 1 then
		RogueCardGameData:ClearIllustratedRedPoint_Jocker()
	elseif arg_32_1 == 2 then
		RogueCardGameData:ClearIllustratedRedPoint_Wuchang()
	elseif arg_32_1 == 3 then
		RogueCardGameData:ClearIllustratedRedPoint_Weal()
	elseif arg_32_1 == 4 then
		RogueCardGameData:ClearIllustratedRedPoint_Enhance()
	end
end

function RogueCardGameIllustratedView:RefreshJockerCard()
	for iter_33_0 = 1, 4 do
		self.jokerTabConList_[iter_33_0]:SetSelectedIndex(iter_33_0 == self.jokerCardIndex and 0 or 1)
	end

	self.jokerCardDataList_ = RogueCardGameTools.GetJokerCardByRare(self.jokerCardIndex)

	self.jokerCardUiList_:StartScroll(#self.jokerCardDataList_)
	self:RefreshJockerCardItemInfo(self.jokerCardDataList_[self.jokerCardSel])

	self.collectText_1.text = RogueCardGameTools.GetJokerCardNum(self.jokerCardIndex)

	self:RefreshJockerCardRedPoint()
end

function RogueCardGameIllustratedView:RefreshJockerCardRedPoint()
	manager.redPoint:SetRedPointIndependent(self.allBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetJokerCardByRare(1))))
	manager.redPoint:SetRedPointIndependent(self.ordinaryBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetJokerCardByRare(2))))
	manager.redPoint:SetRedPointIndependent(self.rareBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetJokerCardByRare(4))))
	manager.redPoint:SetRedPointIndependent(self.preciousBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetJokerCardByRare(3))))
end

function RogueCardGameIllustratedView:RefreshWuChang()
	for iter_35_0 = 1, 2 do
		self.wcTabConList_[iter_35_0]:SetSelectedIndex(iter_35_0 == self.wuChangIndex and 0 or 1)
	end

	self.wcDataList_ = self.wuChangIndex == 1 and RogueCardGameTools.GetBlackCardList() or RogueCardGameTools.GetWhiteCardList()

	self.wcUiList_:StartScroll(#self.wcDataList_)
	self:RefreshWuChangItemInfo(self.wcDataList_[self.wcSel])

	self.collectText_2.text = RogueCardGameTools.GetWuChangNum(self.wuChangIndex)

	self:RefreshWuChangRedPoint()
end

function RogueCardGameIllustratedView:RefreshWuChangRedPoint()
	manager.redPoint:SetRedPointIndependent(self.blackBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetBlackCardList())))
	manager.redPoint:SetRedPointIndependent(self.whiteBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group((RogueCardGameTools.GetWhiteCardList())))
end

function RogueCardGameIllustratedView:RefreshBuff()
	self.eliminatedDataList_ = RogueCardGameTools.GetWealWoeListByType(2)
	self.nonactivatedDataList_ = RogueCardGameTools.GetWealWoeListByType(1)

	for iter_37_0 = 1, #self.eliminatedDataList_ do
		self.eliminated_list[iter_37_0] = self.eliminated_list[iter_37_0] or RogueCardGameOppositionItem.New((Object.Instantiate(self.Oppositionitem_1, self.eliminatedTrs_)))

		local var_37_0 = self.eliminatedDataList_[iter_37_0]

		self.eliminated_list[iter_37_0]:Show(true)
		self.eliminated_list[iter_37_0]:RefreshData(var_37_0)
	end

	for iter_37_1 = #self.eliminatedDataList_ + 1, #self.eliminated_list do
		self.eliminated_list[iter_37_1]:Show(false)
	end

	for iter_37_2 = 1, #self.nonactivatedDataList_ do
		self.nonactivated_list[iter_37_2] = self.nonactivated_list[iter_37_2] or RogueCardGameOppositionItem.New((Object.Instantiate(self.Oppositionitem_2, self.nonactivatedTrs_)))

		local var_37_1 = self.nonactivatedDataList_[iter_37_2]

		self.nonactivated_list[iter_37_2]:Show(true)
		self.nonactivated_list[iter_37_2]:RefreshData(var_37_1)
	end

	for iter_37_3 = #self.nonactivatedDataList_ + 1, #self.nonactivated_list do
		self.nonactivated_list[iter_37_3]:Show(false)
	end

	self.collectText_3.text = RogueCardGameTools.GetWealWoeListNum(2)
	self.collectText_4.text = RogueCardGameTools.GetWealWoeListNum(1)
end

function RogueCardGameIllustratedView:RefreshCard()
	for iter_38_0 = 1, 3 do
		self.cardBuffConList_[iter_38_0]:SetSelectedIndex(iter_38_0 == self.cardIndex and 0 or 1)
	end

	self.cardBuffDataList = {}

	if self.cardIndex == 1 then
		self.cardBuffListCon_:SetSelectedIndex(0)
		self.cardCardListCon_:SetSelectedIndex(1)

		self.cardBuffDataList_ = RogueCardGameTools.GetCardPowerList()

		self:RefreshCardBuffItem()

		self.collectText_5.text = RogueCardGameTools.GetCardPowerNum()
	elseif self.cardIndex == 2 then
		self.cardBuffListCon_:SetSelectedIndex(0)
		self.cardCardListCon_:SetSelectedIndex(0)

		self.cardBuffDataList_ = RogueCardGameTools.GetCardSealList()

		self:RefreshCardBuffItem()

		self.collectText_5.text = RogueCardGameTools.GetCardSealNum()
	else
		self.cardBuffListCon_:SetSelectedIndex(1)

		self.cardBuffDataList_ = RogueCardGameTools.GetCardStyleList()

		self:RefreshCardBuffItem2()

		self.collectText_5.text = RogueCardGameTools.GetCardStyleNum()
	end

	self:RefreshCardBuffItemInfo(self.cardBuffDataList_[self.cardBuffSel])
	self:RefreshCardEnhanceRedPoint()
end

function RogueCardGameIllustratedView:RefreshCardEnhanceRedPoint()
	manager.redPoint:SetRedPointIndependent(self.cardPowerBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group((RogueCardGameTools.GetCardPowerList())))
	manager.redPoint:SetRedPointIndependent(self.cardSealBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group((RogueCardGameTools.GetCardSealList())))
	manager.redPoint:SetRedPointIndependent(self.cardStyleBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group((RogueCardGameTools.GetCardStyleList())))
end

function RogueCardGameIllustratedView:RefreshCardBuffItem()
	for iter_40_0 = 1, #self.cardBuffDataList_ do
		self.carBUffList_[iter_40_0]:Show(true)
		self.carBUffList_[iter_40_0]:SetData(self.cardBuffDataList_[iter_40_0], iter_40_0)
		self.carBUffList_[iter_40_0]:SetSelected(self.cardBuffSel)
	end

	for iter_40_1 = #self.carBUffList_ + 1, #self.carBUffList_ do
		self.carBUffList_[iter_40_1]:Show(false)
	end
end

function RogueCardGameIllustratedView:RefreshCardBuffItem2()
	for iter_41_0 = 1, #self.cardBuffDataList_ do
		self.carBUffStyleList_[iter_41_0]:Show(true)
		self.carBUffStyleList_[iter_41_0]:SetData(self.cardBuffDataList_[iter_41_0], iter_41_0)
		self.carBUffStyleList_[iter_41_0]:SetSelected(self.cardBuffSel)
	end

	for iter_41_1 = #self.carBUffStyleList_ + 1, #self.carBUffStyleList_ do
		self.carBUffStyleList_[iter_41_1]:Show(false)
	end
end

function RogueCardGameIllustratedView:RefreshCardBuffItemInfo(arg_42_1)
	local var_42_0 = RogueCardEnhanceCfg[arg_42_1]

	if RogueCardGameTools.IsUnlockCardBuff(arg_42_1) then
		self.cardBuffItemLockCon_:SetSelectedIndex(1)
		self.cardJokerItemLockCon_:SetSelectedIndex(1)

		if var_42_0.type == 2 then
			SetActive(self.cardBuffIcon_1.gameObject, false)
			SetActive(self.cardBuffIcon_3.gameObject, true)

			self.cardBuffIcon_3.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
		else
			SetActive(self.cardBuffIcon_1.gameObject, true)
			SetActive(self.cardBuffIcon_3.gameObject, false)

			self.cardBuffIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
			self.cardBuffIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
		end

		self.contBuffName_.text = GetI18NText(var_42_0.name)

		RichTextTools.SetMixedTextWithImage(self.contBuffDesc_, GetI18NText(var_42_0.desc))

		self.contBuffDesc_.text = GetI18NText(var_42_0.desc)
	else
		self.cardBuffItemLockCon_:SetSelectedIndex(0)
		self.cardJokerItemLockCon_:SetSelectedIndex(0)

		self.contBuffName_.text = GetTips("POLYHEDRON_HANDBOOK_NOT_COLLECT")
		self.contBuffDesc_.text = ""
	end
end

function RogueCardGameIllustratedView:OnTop()
	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RogueCardGameIllustratedView:OnExit()
	self:StopUpdateTimer()
	manager.windowBar:HideBar()

	if self.lastTabSelectIndex then
		self:ClearIllustratedRedPoint(self.lastTabSelectIndex)

		self.lastTabSelectIndex = nil
	end

	manager.redPoint:unbindUIandKey(self.tabController_1.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER)
	manager.redPoint:unbindUIandKey(self.tabController_2.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG)
	manager.redPoint:unbindUIandKey(self.tabController_3.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL)
	manager.redPoint:unbindUIandKey(self.tabController_4.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE)
end

function RogueCardGameIllustratedView:Dispose()
	if self.jokerCardUiList_ then
		self.jokerCardUiList_:Dispose()

		self.jokerCardUiList_ = nil
	end

	if self.wcUiList_ then
		self.wcUiList_:Dispose()

		self.wcUiList_ = nil
	end

	if self.eliminated_list then
		for iter_46_0, iter_46_1 in ipairs(self.eliminated_list) do
			iter_46_1:Dispose()
		end

		self.eliminated_list = nil
	end

	if self.carBUffList_ then
		for iter_46_2, iter_46_3 in ipairs(self.carBUffList_) do
			iter_46_3:Dispose()
		end

		self.carBUffList_ = nil
	end

	if self.carBUffStyleList_ then
		for iter_46_4, iter_46_5 in ipairs(self.carBUffStyleList_) do
			iter_46_5:Dispose()
		end

		self.carBUffStyleList_ = nil
	end

	if self.jokerCardTagList_ then
		for iter_46_6, iter_46_7 in ipairs(self.jokerCardTagList_) do
			iter_46_7:Dispose()
		end

		self.jokerCardTagList_ = nil
	end

	if self.nonactivated_list then
		for iter_46_8, iter_46_9 in ipairs(self.nonactivated_list) do
			iter_46_9:Dispose()
		end

		self.nonactivated_list = nil
	end

	RogueCardGameIllustratedView.super.Dispose(self)
end

return RogueCardGameIllustratedView
