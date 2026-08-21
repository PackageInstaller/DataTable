local var_0_0 = class("RogueCardGameIllustratedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_IllustratedUI"
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

	arg_4_0.contentCon_ = arg_4_0.controller_:GetController("content")
	arg_4_0.tabConList_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.tabConList_[iter_4_0] = arg_4_0["tabController_" .. iter_4_0]:GetController("select")
	end

	arg_4_0.jokerCardTagList_ = {}
	arg_4_0.jokerTabConList_ = {}
	arg_4_0.jokerCardLockCon_ = arg_4_0.jokerCardController_:GetController("lock")

	for iter_4_1 = 1, 4 do
		arg_4_0.jokerTabConList_[iter_4_1] = arg_4_0["jokeTabController_" .. iter_4_1]:GetController("default0")
	end

	arg_4_0.wcTabConList_ = {}
	arg_4_0.wcLockCon_ = arg_4_0.wcController_:GetController("lock")
	arg_4_0.wuchangsuitCon_ = arg_4_0.wcController_:GetController("wuchangsuit")

	for iter_4_2 = 1, 2 do
		arg_4_0.wcTabConList_[iter_4_2] = arg_4_0["wcTabController_" .. iter_4_2]:GetController("default0")
	end

	arg_4_0.cardBuffConList_ = {}
	arg_4_0.cardBuffListCon_ = arg_4_0.contBuffController_:GetController("list")
	arg_4_0.cardCardListCon_ = arg_4_0.contBuffController_:GetController("card")
	arg_4_0.cardBuffItemLockCon_ = arg_4_0.cardBuffItemInfo_:GetController("lock")
	arg_4_0.cardJokerItemLockCon_ = arg_4_0.cardJokerItemInfo_:GetController("lock")

	for iter_4_3 = 1, 3 do
		arg_4_0.cardBuffConList_[iter_4_3] = arg_4_0["contBuffController_" .. iter_4_3]:GetController("default0")
	end

	arg_4_0.eliminated_list = {}
	arg_4_0.nonactivated_list = {}
	arg_4_0.tabSelectIndex = 1
	arg_4_0.jokerCardIndex = 1
	arg_4_0.wuChangIndex = 1
	arg_4_0.buffIndex = 1
	arg_4_0.cardIndex = 1
	arg_4_0.jokerCardSel = 1
	arg_4_0.wcSel = 1
	arg_4_0.cardBuffSel = 1
	arg_4_0.jokerCardUiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem1), arg_4_0.jokerCardListGo_, RogueCardJokerCardItem)
	arg_4_0.wcUiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem2), arg_4_0.wuChangListGo_, RogueCardWuChangItem)
	arg_4_0.carBUffList_ = {}

	for iter_4_4 = 1, 5 do
		local var_4_0 = arg_4_0["cardBuffItem_" .. iter_4_4]
		local var_4_1 = RogueCardGameCardBuffItem.New(var_4_0)

		var_4_1:SetClickHandle(function(arg_5_0, arg_5_1)
			arg_4_0.cardBuffSel = arg_5_1

			arg_4_0:RefreshCardBuffItemInfo(arg_5_0)

			for iter_5_0 = 1, #arg_4_0.carBUffList_ do
				arg_4_0.carBUffList_[iter_5_0]:SetSelected(arg_5_1)
			end

			arg_4_0:RefreshCardEnhanceRedPoint()
		end)
		table.insert(arg_4_0.carBUffList_, var_4_1)
	end

	arg_4_0.carBUffStyleList_ = {}

	for iter_4_5 = 1, 4 do
		local var_4_2 = arg_4_0["cardJokerItem_" .. iter_4_5]
		local var_4_3 = RogueCardGameCardBuffStyleItem.New(var_4_2)

		var_4_3:SetClickHandle(function(arg_6_0, arg_6_1)
			arg_4_0.cardBuffSel = arg_6_1

			arg_4_0:RefreshCardBuffItemInfo(arg_6_0)

			for iter_6_0 = 1, #arg_4_0.carBUffStyleList_ do
				arg_4_0.carBUffStyleList_[iter_6_0]:SetSelected(arg_6_1)
			end

			arg_4_0:RefreshCardEnhanceRedPoint()
		end)
		table.insert(arg_4_0.carBUffStyleList_, var_4_3)
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.jokerBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.tabSelectIndex = 1

		arg_7_0:RefreshView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.wuchangBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.tabSelectIndex = 2

		arg_7_0:RefreshView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buffBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.tabSelectIndex = 3

		arg_7_0:RefreshView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cardBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.tabSelectIndex = 4

		arg_7_0:RefreshView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.allBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.jokerCardIndex = 1

		arg_7_0:RefreshJockerCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.ordinaryBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.jokerCardIndex = 2

		arg_7_0:RefreshJockerCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.rareBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.jokerCardIndex = 4

		arg_7_0:RefreshJockerCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.preciousBtn_, nil, function()
		arg_7_0.jokerCardSel = 1
		arg_7_0.jokerCardIndex = 3

		arg_7_0:RefreshJockerCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.blackBtn_, nil, function()
		arg_7_0.wcSel = 1
		arg_7_0.wuChangIndex = 1

		arg_7_0:RefreshWuChang()
	end)
	arg_7_0:AddBtnListener(arg_7_0.whiteBtn_, nil, function()
		arg_7_0.wcSel = 1
		arg_7_0.wuChangIndex = 2

		arg_7_0:RefreshWuChang()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cardPowerBtn_, nil, function()
		arg_7_0.cardBuffSel = 1
		arg_7_0.cardIndex = 1

		arg_7_0:RefreshCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cardSealBtn_, nil, function()
		arg_7_0.cardBuffSel = 1
		arg_7_0.cardIndex = 2

		arg_7_0:RefreshCard()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cardStyleBtn_, nil, function()
		arg_7_0.cardBuffSel = 1
		arg_7_0.cardIndex = 3

		arg_7_0:RefreshCard()
	end)
end

function var_0_0.StopUpdateTimer(arg_21_0)
	if arg_21_0.updateTimer then
		arg_21_0.updateTimer:Stop()

		arg_21_0.updateTimer = nil
	end
end

function var_0_0.UpdateTimeTxt(arg_22_0)
	local var_22_0 = os.time()
	local var_22_1 = os.difftime(var_22_0, os.time(os.date("!*t", var_22_0)))
	local var_22_2 = os.date("!*t", var_22_0 + var_22_1)

	arg_22_0.dayText_.text = string.format("%s/%s", var_22_2.month, var_22_2.day)
	arg_22_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_0.IndexItem1(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2:SetData(arg_23_0.jokerCardDataList_[arg_23_1], arg_23_1)
	arg_23_2:SetClickHandle(function(arg_24_0, arg_24_1)
		local var_24_0 = arg_23_0.jokerCardUiList_:GetScrolledPosition()

		arg_23_0.jokerCardSel = arg_24_1

		arg_23_0:RefreshJockerCardItemInfo(arg_24_0)
		arg_23_0.jokerCardUiList_:Refresh()
		arg_23_0:RefreshJockerCardRedPoint()
	end)
	arg_23_2:SetSelected(arg_23_0.jokerCardSel)
end

function var_0_0.IndexItem2(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2:SetData(arg_25_0.wcDataList_[arg_25_1], arg_25_1)
	arg_25_2:SetClickHandle(function(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0.wcUiList_:GetScrolledPosition()

		arg_25_0.wcSel = arg_26_1

		arg_25_0:RefreshWuChangItemInfo(arg_26_0)
		arg_25_0.wcUiList_:Refresh()
		arg_25_0:RefreshWuChangRedPoint()
	end)
	arg_25_2:SetSelected(arg_25_0.wcSel)
end

function var_0_0.RefreshJockerCardItemInfo(arg_27_0, arg_27_1)
	local var_27_0 = RogueCardItemCfg[arg_27_1]

	if RogueCardGameTools.IsUnlockJokerCard(arg_27_1) then
		arg_27_0.jokerCardLockCon_:SetSelectedIndex(1)

		arg_27_0.jokerCardIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/item/" .. var_27_0.icon)
		arg_27_0.jokerCardTitle_.text = GetI18NText(var_27_0.name)

		RichTextTools.SetMixedTextWithImage(arg_27_0.jokerCardDesc_, GetI18NText(var_27_0.desc))

		local var_27_1 = var_27_0.effect_list[1]
		local var_27_2 = RogueCardEffectCfg[var_27_1]

		if var_27_2.action_type == 4 then
			local var_27_3 = var_27_2.param2[3]

			arg_27_0.jokerCardDesc_.text = System.String.Format(GetI18NText(var_27_0.desc), var_27_3)
		elseif var_27_2.action_type == 42 then
			arg_27_0.jokerCardDesc_.text = System.String.Format(GetI18NText(var_27_0.desc), "A")
		else
			arg_27_0.jokerCardDesc_.text = GetI18NText(var_27_0.desc)
		end

		local var_27_4 = #var_27_0.tag

		for iter_27_0 = 1, var_27_4 do
			if not arg_27_0.jokerCardTagList_[iter_27_0] then
				local var_27_5 = Object.Instantiate(arg_27_0.tagItem_, arg_27_0.tagContent_)

				arg_27_0.jokerCardTagList_[iter_27_0] = RogueCardGameJokerCardTagItem.New(var_27_5)
			end

			local var_27_6 = var_27_0.tag[iter_27_0]

			arg_27_0.jokerCardTagList_[iter_27_0]:Show(true)
			arg_27_0.jokerCardTagList_[iter_27_0]:RefreshData(var_27_6)
		end

		for iter_27_1 = var_27_4 + 1, #arg_27_0.jokerCardTagList_ do
			arg_27_0.jokerCardTagList_[iter_27_1]:Show(false)
		end
	else
		arg_27_0.jokerCardLockCon_:SetSelectedIndex(0)

		arg_27_0.jokerCardTitle_.text = GetTips("ROGUE_CARD_COLLECT_TITLE")
		arg_27_0.jokerCardDesc_.text = GetTips("ROGUE_CARD_COLLECT_WORD")
		arg_27_0.jokerCardRare_.text = ""
	end
end

function var_0_0.RefreshWuChangItemInfo(arg_28_0, arg_28_1)
	local var_28_0 = RogueCardItemCfg[arg_28_1]

	if RogueCardGameTools.IsUnlockWcCard(arg_28_1) then
		arg_28_0.wcLockCon_:SetSelectedIndex(1)

		arg_28_0.wcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_28_0.icon)
		arg_28_0.wcTitle_.text = GetI18NText(var_28_0.name)

		RichTextTools.SetMixedTextWithImage(arg_28_0.wcDesc_, GetI18NText(var_28_0.desc))

		arg_28_0.wcDesc_.text = GetI18NText(var_28_0.desc)

		SetActive(arg_28_0.wcCoinGo_, true)

		arg_28_0.wcNUm_.text = var_28_0.sell_price

		if var_28_0.type == 1 then
			arg_28_0.wuchangsuitCon_:SetSelectedIndex(var_28_0.rare == 1 and 1 or 3)
		else
			arg_28_0.wuchangsuitCon_:SetSelectedIndex(var_28_0.rare == 1 and 0 or 2)
		end
	else
		arg_28_0.wcLockCon_:SetSelectedIndex(0)

		arg_28_0.wcTitle_.text = GetTips("ROGUE_CARD_COLLECT_TITLE")
		arg_28_0.wcDesc_.text = GetTips("ROGUE_CARD_COLLECT_WORD")

		SetActive(arg_28_0.wcCoinGo_, false)
	end
end

function var_0_0.OnEnter(arg_29_0)
	arg_29_0:UpdateTimeTxt()
	arg_29_0:StopUpdateTimer()

	arg_29_0.updateTimer = Timer.New(function()
		arg_29_0:UpdateTimeTxt()
	end, 1, -1)

	arg_29_0.updateTimer:Start()
	arg_29_0:RefreshView()
	manager.redPoint:bindUIandKey(arg_29_0.tabController_1.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER)
	manager.redPoint:bindUIandKey(arg_29_0.tabController_2.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG)
	manager.redPoint:bindUIandKey(arg_29_0.tabController_3.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL)
	manager.redPoint:bindUIandKey(arg_29_0.tabController_4.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE)
end

function var_0_0.RefreshView(arg_31_0)
	if arg_31_0.lastTabSelectIndex and arg_31_0.tabSelectIndex ~= arg_31_0.lastTabSelectIndex then
		arg_31_0:ClearIllustratedRedPoint(arg_31_0.lastTabSelectIndex)
	end

	arg_31_0.contentCon_:SetSelectedIndex(arg_31_0.tabSelectIndex - 1)

	for iter_31_0 = 1, 4 do
		arg_31_0.tabConList_[iter_31_0]:SetSelectedIndex(iter_31_0 == arg_31_0.tabSelectIndex and 1 or 0)
	end

	if arg_31_0.tabSelectIndex == 1 then
		arg_31_0:RefreshJockerCard()
	elseif arg_31_0.tabSelectIndex == 2 then
		arg_31_0:RefreshWuChang()
	elseif arg_31_0.tabSelectIndex == 3 then
		arg_31_0:RefreshBuff()
	elseif arg_31_0.tabSelectIndex == 4 then
		arg_31_0:RefreshCard()
	end

	arg_31_0.lastTabSelectIndex = arg_31_0.tabSelectIndex
end

function var_0_0.ClearIllustratedRedPoint(arg_32_0, arg_32_1)
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

function var_0_0.RefreshJockerCard(arg_33_0)
	for iter_33_0 = 1, 4 do
		arg_33_0.jokerTabConList_[iter_33_0]:SetSelectedIndex(iter_33_0 == arg_33_0.jokerCardIndex and 0 or 1)
	end

	arg_33_0.jokerCardDataList_ = RogueCardGameTools.GetJokerCardByRare(arg_33_0.jokerCardIndex)

	arg_33_0.jokerCardUiList_:StartScroll(#arg_33_0.jokerCardDataList_)
	arg_33_0:RefreshJockerCardItemInfo(arg_33_0.jokerCardDataList_[arg_33_0.jokerCardSel])

	arg_33_0.collectText_1.text = RogueCardGameTools.GetJokerCardNum(arg_33_0.jokerCardIndex)

	arg_33_0:RefreshJockerCardRedPoint()
end

function var_0_0.RefreshJockerCardRedPoint(arg_34_0)
	local var_34_0 = RogueCardGameTools.GetJokerCardByRare(1)
	local var_34_1 = RogueCardGameTools.GetJokerCardByRare(2)
	local var_34_2 = RogueCardGameTools.GetJokerCardByRare(4)
	local var_34_3 = RogueCardGameTools.GetJokerCardByRare(3)

	manager.redPoint:SetRedPointIndependent(arg_34_0.allBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_34_0))
	manager.redPoint:SetRedPointIndependent(arg_34_0.ordinaryBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_34_1))
	manager.redPoint:SetRedPointIndependent(arg_34_0.rareBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_34_2))
	manager.redPoint:SetRedPointIndependent(arg_34_0.preciousBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_34_3))
end

function var_0_0.RefreshWuChang(arg_35_0)
	for iter_35_0 = 1, 2 do
		arg_35_0.wcTabConList_[iter_35_0]:SetSelectedIndex(iter_35_0 == arg_35_0.wuChangIndex and 0 or 1)
	end

	if arg_35_0.wuChangIndex == 1 then
		arg_35_0.wcDataList_ = RogueCardGameTools.GetBlackCardList()
	else
		arg_35_0.wcDataList_ = RogueCardGameTools.GetWhiteCardList()
	end

	arg_35_0.wcUiList_:StartScroll(#arg_35_0.wcDataList_)

	local var_35_0 = arg_35_0.wcDataList_[arg_35_0.wcSel]

	arg_35_0:RefreshWuChangItemInfo(var_35_0)

	arg_35_0.collectText_2.text = RogueCardGameTools.GetWuChangNum(arg_35_0.wuChangIndex)

	arg_35_0:RefreshWuChangRedPoint()
end

function var_0_0.RefreshWuChangRedPoint(arg_36_0)
	local var_36_0 = RogueCardGameTools.GetBlackCardList()
	local var_36_1 = RogueCardGameTools.GetWhiteCardList()

	manager.redPoint:SetRedPointIndependent(arg_36_0.blackBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_36_0))
	manager.redPoint:SetRedPointIndependent(arg_36_0.whiteBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang_Group(var_36_1))
end

function var_0_0.RefreshBuff(arg_37_0)
	arg_37_0.eliminatedDataList_ = RogueCardGameTools.GetWealWoeListByType(2)
	arg_37_0.nonactivatedDataList_ = RogueCardGameTools.GetWealWoeListByType(1)

	local var_37_0 = #arg_37_0.eliminatedDataList_

	for iter_37_0 = 1, var_37_0 do
		if not arg_37_0.eliminated_list[iter_37_0] then
			local var_37_1 = Object.Instantiate(arg_37_0.Oppositionitem_1, arg_37_0.eliminatedTrs_)

			arg_37_0.eliminated_list[iter_37_0] = RogueCardGameOppositionItem.New(var_37_1)
		end

		local var_37_2 = arg_37_0.eliminatedDataList_[iter_37_0]

		arg_37_0.eliminated_list[iter_37_0]:Show(true)
		arg_37_0.eliminated_list[iter_37_0]:RefreshData(var_37_2)
	end

	for iter_37_1 = var_37_0 + 1, #arg_37_0.eliminated_list do
		arg_37_0.eliminated_list[iter_37_1]:Show(false)
	end

	local var_37_3 = #arg_37_0.nonactivatedDataList_

	for iter_37_2 = 1, var_37_3 do
		if not arg_37_0.nonactivated_list[iter_37_2] then
			local var_37_4 = Object.Instantiate(arg_37_0.Oppositionitem_2, arg_37_0.nonactivatedTrs_)

			arg_37_0.nonactivated_list[iter_37_2] = RogueCardGameOppositionItem.New(var_37_4)
		end

		local var_37_5 = arg_37_0.nonactivatedDataList_[iter_37_2]

		arg_37_0.nonactivated_list[iter_37_2]:Show(true)
		arg_37_0.nonactivated_list[iter_37_2]:RefreshData(var_37_5)
	end

	for iter_37_3 = var_37_3 + 1, #arg_37_0.nonactivated_list do
		arg_37_0.nonactivated_list[iter_37_3]:Show(false)
	end

	arg_37_0.collectText_3.text = RogueCardGameTools.GetWealWoeListNum(2)
	arg_37_0.collectText_4.text = RogueCardGameTools.GetWealWoeListNum(1)
end

function var_0_0.RefreshCard(arg_38_0)
	for iter_38_0 = 1, 3 do
		arg_38_0.cardBuffConList_[iter_38_0]:SetSelectedIndex(iter_38_0 == arg_38_0.cardIndex and 0 or 1)
	end

	arg_38_0.cardBuffDataList = {}

	if arg_38_0.cardIndex == 1 then
		arg_38_0.cardBuffListCon_:SetSelectedIndex(0)
		arg_38_0.cardCardListCon_:SetSelectedIndex(1)

		arg_38_0.cardBuffDataList_ = RogueCardGameTools.GetCardPowerList()

		arg_38_0:RefreshCardBuffItem()

		arg_38_0.collectText_5.text = RogueCardGameTools.GetCardPowerNum()
	elseif arg_38_0.cardIndex == 2 then
		arg_38_0.cardBuffListCon_:SetSelectedIndex(0)
		arg_38_0.cardCardListCon_:SetSelectedIndex(0)

		arg_38_0.cardBuffDataList_ = RogueCardGameTools.GetCardSealList()

		arg_38_0:RefreshCardBuffItem()

		arg_38_0.collectText_5.text = RogueCardGameTools.GetCardSealNum()
	else
		arg_38_0.cardBuffListCon_:SetSelectedIndex(1)

		arg_38_0.cardBuffDataList_ = RogueCardGameTools.GetCardStyleList()

		arg_38_0:RefreshCardBuffItem2()

		arg_38_0.collectText_5.text = RogueCardGameTools.GetCardStyleNum()
	end

	local var_38_0 = arg_38_0.cardBuffDataList_[arg_38_0.cardBuffSel]

	arg_38_0:RefreshCardBuffItemInfo(var_38_0)
	arg_38_0:RefreshCardEnhanceRedPoint()
end

function var_0_0.RefreshCardEnhanceRedPoint(arg_39_0)
	local var_39_0 = RogueCardGameTools.GetCardPowerList()
	local var_39_1 = RogueCardGameTools.GetCardSealList()
	local var_39_2 = RogueCardGameTools.GetCardStyleList()

	manager.redPoint:SetRedPointIndependent(arg_39_0.cardPowerBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group(var_39_0))
	manager.redPoint:SetRedPointIndependent(arg_39_0.cardSealBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group(var_39_1))
	manager.redPoint:SetRedPointIndependent(arg_39_0.cardStyleBtn_.transform, RogueCardGameData:GetIllustratedRedPoint_Enhance_Group(var_39_2))
end

function var_0_0.RefreshCardBuffItem(arg_40_0)
	for iter_40_0 = 1, #arg_40_0.cardBuffDataList_ do
		arg_40_0.carBUffList_[iter_40_0]:Show(true)
		arg_40_0.carBUffList_[iter_40_0]:SetData(arg_40_0.cardBuffDataList_[iter_40_0], iter_40_0)
		arg_40_0.carBUffList_[iter_40_0]:SetSelected(arg_40_0.cardBuffSel)
	end

	for iter_40_1 = #arg_40_0.carBUffList_ + 1, #arg_40_0.carBUffList_ do
		arg_40_0.carBUffList_[iter_40_1]:Show(false)
	end
end

function var_0_0.RefreshCardBuffItem2(arg_41_0)
	for iter_41_0 = 1, #arg_41_0.cardBuffDataList_ do
		arg_41_0.carBUffStyleList_[iter_41_0]:Show(true)
		arg_41_0.carBUffStyleList_[iter_41_0]:SetData(arg_41_0.cardBuffDataList_[iter_41_0], iter_41_0)
		arg_41_0.carBUffStyleList_[iter_41_0]:SetSelected(arg_41_0.cardBuffSel)
	end

	for iter_41_1 = #arg_41_0.carBUffStyleList_ + 1, #arg_41_0.carBUffStyleList_ do
		arg_41_0.carBUffStyleList_[iter_41_1]:Show(false)
	end
end

function var_0_0.RefreshCardBuffItemInfo(arg_42_0, arg_42_1)
	local var_42_0 = RogueCardEnhanceCfg[arg_42_1]

	if RogueCardGameTools.IsUnlockCardBuff(arg_42_1) then
		arg_42_0.cardBuffItemLockCon_:SetSelectedIndex(1)
		arg_42_0.cardJokerItemLockCon_:SetSelectedIndex(1)

		if var_42_0.type == 2 then
			SetActive(arg_42_0.cardBuffIcon_1.gameObject, false)
			SetActive(arg_42_0.cardBuffIcon_3.gameObject, true)

			arg_42_0.cardBuffIcon_3.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
		else
			SetActive(arg_42_0.cardBuffIcon_1.gameObject, true)
			SetActive(arg_42_0.cardBuffIcon_3.gameObject, false)

			arg_42_0.cardBuffIcon_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
			arg_42_0.cardBuffIcon_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_42_0.pic)
		end

		arg_42_0.contBuffName_.text = GetI18NText(var_42_0.name)

		RichTextTools.SetMixedTextWithImage(arg_42_0.contBuffDesc_, GetI18NText(var_42_0.desc))

		arg_42_0.contBuffDesc_.text = GetI18NText(var_42_0.desc)
	else
		arg_42_0.cardBuffItemLockCon_:SetSelectedIndex(0)
		arg_42_0.cardJokerItemLockCon_:SetSelectedIndex(0)

		arg_42_0.contBuffName_.text = GetTips("POLYHEDRON_HANDBOOK_NOT_COLLECT")
		arg_42_0.contBuffDesc_.text = ""
	end
end

function var_0_0.OnTop(arg_43_0)
	arg_43_0:UpdateTimeTxt()
	arg_43_0:StopUpdateTimer()

	arg_43_0.updateTimer = Timer.New(function()
		arg_43_0:UpdateTimeTxt()
	end, 1, -1)

	arg_43_0.updateTimer:Start()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_45_0)
	arg_45_0:StopUpdateTimer()
	manager.windowBar:HideBar()

	if arg_45_0.lastTabSelectIndex then
		arg_45_0:ClearIllustratedRedPoint(arg_45_0.lastTabSelectIndex)

		arg_45_0.lastTabSelectIndex = nil
	end

	manager.redPoint:unbindUIandKey(arg_45_0.tabController_1.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_JOKER)
	manager.redPoint:unbindUIandKey(arg_45_0.tabController_2.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WUCHANG)
	manager.redPoint:unbindUIandKey(arg_45_0.tabController_3.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_WEAL)
	manager.redPoint:unbindUIandKey(arg_45_0.tabController_4.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED_ENHANCE)
end

function var_0_0.Dispose(arg_46_0)
	if arg_46_0.jokerCardUiList_ then
		arg_46_0.jokerCardUiList_:Dispose()

		arg_46_0.jokerCardUiList_ = nil
	end

	if arg_46_0.wcUiList_ then
		arg_46_0.wcUiList_:Dispose()

		arg_46_0.wcUiList_ = nil
	end

	if arg_46_0.eliminated_list then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.eliminated_list) do
			iter_46_1:Dispose()
		end

		arg_46_0.eliminated_list = nil
	end

	if arg_46_0.carBUffList_ then
		for iter_46_2, iter_46_3 in ipairs(arg_46_0.carBUffList_) do
			iter_46_3:Dispose()
		end

		arg_46_0.carBUffList_ = nil
	end

	if arg_46_0.carBUffStyleList_ then
		for iter_46_4, iter_46_5 in ipairs(arg_46_0.carBUffStyleList_) do
			iter_46_5:Dispose()
		end

		arg_46_0.carBUffStyleList_ = nil
	end

	if arg_46_0.jokerCardTagList_ then
		for iter_46_6, iter_46_7 in ipairs(arg_46_0.jokerCardTagList_) do
			iter_46_7:Dispose()
		end

		arg_46_0.jokerCardTagList_ = nil
	end

	if arg_46_0.nonactivated_list then
		for iter_46_8, iter_46_9 in ipairs(arg_46_0.nonactivated_list) do
			iter_46_9:Dispose()
		end

		arg_46_0.nonactivated_list = nil
	end

	var_0_0.super.Dispose(arg_46_0)
end

return var_0_0
