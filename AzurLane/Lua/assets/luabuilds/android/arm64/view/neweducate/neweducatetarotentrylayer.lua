local var_0_0 = class("NewEducateTarotEntryLayer", import("view.newEducate.base.NewEducateBaseUI"))

var_0_0.TYPE = {
	SHOP = 2,
	DROP = 3,
	NORMAL = 1
}

function var_0_0.getUIName(arg_1_0)
	return "NewEducateTarotEntryUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.progressPart = NewEducateTopProgress.New(arg_2_0._tf:Find("progress"), arg_2_0)
	arg_2_0.resPart = NewEducateTopRes.New(arg_2_0._tf:Find("res"), arg_2_0)
	arg_2_0.toggleTF = arg_2_0._tf:Find("toggle")

	setText(arg_2_0.toggleTF:Find("Text"), i18n("child2_show_detail_desc"))

	arg_2_0.tarotTF = arg_2_0._tf:Find("tarot")
	arg_2_0.tarotCard = NewEducateTarotCard.New(arg_2_0.tarotTF)

	setText(arg_2_0._tf:Find("all/Text"), i18n("child2_all_entry_title"))

	arg_2_0.allEntryCntText = arg_2_0._tf:Find("all/value"):GetComponent(typeof(Text))
	arg_2_0.scrollRect = arg_2_0._tf:Find("view/content"):GetComponent("LScrollRect")
	arg_2_0.detailTF = arg_2_0._tf:Find("detail")
	arg_2_0.detailEntryCard = NewEducateEntryCard.New(arg_2_0.detailTF:Find("entry"))
	arg_2_0.detailLevelText = arg_2_0.detailTF:Find("level/Text"):GetComponent(typeof(Text))
	arg_2_0.upgradeTF = arg_2_0._tf:Find("upgrade")
	arg_2_0.upgradeBtn = arg_2_0.upgradeTF:Find("btn")

	setText(arg_2_0.upgradeBtn:Find("Text"), i18n("child2_word_upgrade"))

	arg_2_0.giveupBtn = arg_2_0._tf:Find("giveup")

	setText(arg_2_0.giveupBtn:Find("Text"), i18n("child2_word_giveup"))

	arg_2_0.goBtn = arg_2_0._tf:Find("go")

	setText(arg_2_0.goBtn:Find("Text"), i18n("child2_go_shop"))

	arg_2_0.summaryTF = arg_2_0._tf:Find("summary")
	arg_2_0.summaryToggleTF = arg_2_0.summaryTF:Find("toggle")
	arg_2_0.pctUIList = UIItemList.New(arg_2_0.summaryTF:Find("list"), arg_2_0.summaryTF:Find("list/tpl"))
	arg_2_0.playerID = getProxy(PlayerProxy):getRawData().id

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf, {
		groupDelta = 3
	})
	onButton(arg_3_0, arg_3_0.progressPart._tf:Find("back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.toggleTF, function(arg_5_0)
		NewEducateHelper.SetTarotDeatilDescData(arg_5_0)
		arg_3_0:SwitchDescMode(arg_5_0)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.giveupBtn, function()
		arg_3_0:emit(NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		seriesAsync({
			function(arg_8_0)
				if arg_3_0.type == var_0_0.TYPE.SHOP then
					arg_3_0:emit(NewEducateTarotEntryMediator.ON_SHOPPING, arg_3_0.contextData.goodId, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		}, function(arg_9_0)
			arg_3_0.showpDrops = arg_9_0 or {}

			arg_3_0:emit(NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY, arg_3_0.selectId)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		if arg_3_0.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		arg_3_0:emit(var_0_0.GO_SCENE, SCENE.NEW_EDUCATE_MAP, {
			openShop = true
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("tip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_choose_help.tip
		})

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.summaryToggleTF, function(arg_12_0)
		local var_12_0 = arg_12_0 and i18n("child2_benefit_summary2") or i18n("child2_benefit_summary")

		setText(arg_3_0.summaryToggleTF:Find("Text"), var_12_0)
		arg_3_0.pctUIList:align(#arg_3_0.showPctList)
		PlayerPrefs.SetInt(arg_3_0:GetBenefitShowLocalKey(), arg_12_0 and 1 or 0)

		return
	end, SFX_PANEL)
	arg_3_0.pctUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_3_0.showPctList[arg_13_1 + 1].drop
		local var_13_1 = NewEducateHelper.GetDropConfig(arg_3_0.showPctList[arg_13_1 + 1].drop)

		if arg_13_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/neweducatecommonui_atlas", var_13_1.icon, arg_13_2:Find("Image"), true)
		elseif arg_13_0 == UIItemList.EventUpdate then
			local var_13_2 = arg_3_0.showPctList[arg_13_1 + 1].a
			local var_13_3 = arg_3_0.showPctList[arg_13_1 + 1].b

			setText(arg_13_2:Find("Text"), (arg_3_0.summaryToggleTF:GetComponent(typeof(Toggle)).isOn and var_13_3 or var_13_2) .. "%")
			setText(arg_13_2:Find("info/content/name"), var_13_1.name)
			setText(arg_13_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_13_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_13_3 .. "%")

			local var_13_4 = arg_3_0.contextData.char:GetOwnCnt(var_13_0)

			if var_13_0.type == NewEducateConst.DROP_TYPE.ATTR then
				local var_13_5, var_13_6 = NewEducateInfoPanel.GetArrtInfo(var_13_1.rank, var_13_4)

				setText(arg_13_2:Find("info/content/value"), var_13_6)
			else
				setText(arg_13_2:Find("info/content/value"), var_13_4)
			end
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_14_0)
		arg_3_0:OnInitItem(arg_14_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_15_0, arg_15_1)
		arg_3_0:OnUpdateItem(arg_15_0, arg_15_1)

		return
	end

	arg_3_0.cards = {}
	arg_3_0.triggerFirstCard = true
	arg_3_0.config = pg.child2_benefit_list
	arg_3_0.type = arg_3_0.contextData.type or var_0_0.TYPE.NORMAL

	arg_3_0:UpdateView()
	triggerToggle(arg_3_0.toggleTF, NewEducateHelper.IsShowTarotDeatilDesc())

	return
end

function var_0_0.GetBenefitShowLocalKey(arg_16_0)
	return NewEducateConst.NEW_EDUCATE_BENEFIT_SHOW_MAX .. "_" .. arg_16_0.playerID .. "_" .. arg_16_0.contextData.char.id
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.progressPart:Update(arg_17_0.contextData.char)
	arg_17_0.resPart:Update(arg_17_0.contextData.char)

	arg_17_0.tarotId = arg_17_0.contextData.char:GetTarotId()
	arg_17_0.entries = arg_17_0.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

	arg_17_0:UpdateTarotPanel()
	arg_17_0:UpdateSummary()
	arg_17_0:UpdateBtns()
	arg_17_0.scrollRect:SetTotalCount(#arg_17_0.entries)

	if #arg_17_0.entries == 0 then
		setActive(arg_17_0.detailTF, false)
		setActive(arg_17_0.upgradeTF, false)
	end

	return
end

function var_0_0.UpdateTarotPanel(arg_18_0)
	setActive(arg_18_0.tarotCard._tf, arg_18_0.tarotId)

	if arg_18_0.tarotId then
		arg_18_0.tarotCard:Update(arg_18_0.tarotId, NewEducateTarotCard.TYPE.CURRENT)
	end

	return
end

function var_0_0.UpdateRight(arg_19_0)
	local var_19_0 = arg_19_0.type ~= var_0_0.TYPE.NORMAL and arg_19_0.config[arg_19_0.selectId].next_level ~= 0

	setActive(arg_19_0.upgradeTF, arg_19_0.type ~= var_0_0.TYPE.NORMAL and arg_19_0.config[arg_19_0.selectId].next_level ~= 0)
	setActive(arg_19_0.detailTF, not var_19_0)

	if var_19_0 then
		arg_19_0:UpdataUpgrade()
	else
		arg_19_0:UpdataDetail()
	end

	return
end

function var_0_0.UpdataUpgrade(arg_20_0)
	setActive(arg_20_0.upgradeBtn:Find("res"), arg_20_0.type == var_0_0.TYPE.SHOP)

	if arg_20_0.type == var_0_0.TYPE.SHOP then
		setText(arg_20_0.upgradeBtn:Find("res/Text"), "-" .. arg_20_0.contextData.cost)
	end

	local var_20_0 = arg_20_0.config[arg_20_0.selectId]

	setText(arg_20_0.upgradeTF:Find("name"), arg_20_0.config[arg_20_0.selectId].name)
	setText(arg_20_0.upgradeTF:Find("before/level/Text"), "LV." .. var_20_0.benefit_level)
	setText(arg_20_0.upgradeTF:Find("before/desc/Text"), var_20_0.desc)
	setText(arg_20_0.upgradeTF:Find("after/level/Text"), "LV." .. arg_20_0.config[var_20_0.next_level].benefit_level)
	setText(arg_20_0.upgradeTF:Find("after/desc/Text"), var_20_0.upgrade_desc)

	return
end

function var_0_0.UpdataDetail(arg_21_0)
	setActive(arg_21_0.detailTF, arg_21_0.selectId)

	if arg_21_0.selectId then
		arg_21_0.detailLevelText.text = "Lv." .. arg_21_0.config[arg_21_0.selectId].benefit_level

		arg_21_0.detailEntryCard:Update(arg_21_0.selectId)
		arg_21_0.detailEntryCard:UpdateCountDesc()
		arg_21_0.detailEntryCard:UpdateDescMode(arg_21_0.toggleTF:GetComponent(typeof(Toggle)).isOn)
	end

	return
end

function var_0_0.UpdateSummary(arg_22_0)
	arg_22_0.allEntryCntText.text = #arg_22_0.entries .. "/" .. #underscore.select(arg_22_0.contextData.char:GetPermanentData():GetAllBuffIds(), function(arg_23_0)
		return arg_22_0.config[arg_23_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_23_0)
	end)

	local var_22_0 = arg_22_0.contextData.char:GetBenefitData()

	arg_22_0.showPctList = {}

	for iter_22_0, iter_22_1 in ipairs(NewEducateBenefit.GetDisplayPctList(arg_22_0.contextData.char)) do
		local var_22_1, var_22_2 = var_22_0:GetDisplayPctByDrop(iter_22_1)

		table.insert(arg_22_0.showPctList, {
			drop = iter_22_1,
			a = var_22_1,
			b = var_22_2
		})
	end

	triggerToggle(arg_22_0.summaryToggleTF, PlayerPrefs.GetInt(arg_22_0:GetBenefitShowLocalKey()) == 1)

	return
end

function var_0_0.UpdateBtns(arg_24_0)
	setActive(arg_24_0.giveupBtn, arg_24_0.type == var_0_0.TYPE.DROP)
	setActive(arg_24_0.goBtn, arg_24_0:GetGoBtnVisibility())

	return
end

function var_0_0.GetGoBtnVisibility(arg_25_0)
	if arg_25_0.type ~= var_0_0.TYPE.NORMAL then
		return false
	end

	if not arg_25_0.contextData.char:IsUnlock("shop") then
		return false
	end

	local var_25_0 = arg_25_0.contextData.char:GetFSM()

	if var_25_0:CheckStystem() == NewEducateFSM.SYSTEM.ENDING then
		return false
	end

	local var_25_1 = arg_25_0.contextData.char:GetFSM()

	if var_25_1:GetSystemNo() == NewEducateFSM.SYSTEM.ENDING then
		return false
	end

	if arg_25_0.contextData.inShop then
		return false
	end

	return true
end

function var_0_0.OnInitItem(arg_26_0, arg_26_1)
	arg_26_0.cards[arg_26_1] = NewEducateEntryCard.New(arg_26_1)

	return
end

function var_0_0.OnUpdateItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.cards[arg_27_2]

	if not arg_27_0.cards[arg_27_2] then
		arg_27_0:OnInitItem(arg_27_2)

		var_27_0 = arg_27_0.cards[arg_27_2]
	end

	var_27_0:Update(arg_27_0.entries[arg_27_1 + 1].id)
	setActive(var_27_0._tf:Find("sel"), false)
	onButton(arg_27_0, var_27_0._go, function()
		for iter_28_0, iter_28_1 in pairs(arg_27_0.cards) do
			setActive(iter_28_1._tf:Find("sel"), false)
		end

		arg_27_0.selectId = var_0

		setActive(var_27_0._tf:Find("sel"), true)

		if not arg_27_0.triggerFirstCard then
			setActive(var_27_0._tf:Find("sel"), true)
			var_27_0._tf:Find("sel"):GetComponent(typeof(Animation)):Play("Anim_NewEducateTarotEntryUI_tpl_sel")
		end

		arg_27_0:UpdateRight()

		return
	end, SFX_PANEL)

	if arg_27_0.triggerFirstCard and arg_27_1 == 0 then
		triggerButton(var_27_0._go)

		arg_27_0.triggerFirstCard = nil
	end

	return
end

function var_0_0.SwitchDescMode(arg_29_0, arg_29_1)
	if arg_29_0.tarotId then
		arg_29_0.tarotCard:UpdateDescMode(arg_29_1)
	end

	if arg_29_0.selectId then
		arg_29_0.detailEntryCard:UpdateDescMode(arg_29_1)
	end

	for iter_29_0, iter_29_1 in pairs(arg_29_0.cards) do
		iter_29_1:UpdateDescMode(arg_29_1)
	end

	return
end

function var_0_0.OnUpgradeDone(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.cards) do
		if iter_30_1.id == arg_30_1.entryId then
			iter_30_1._tf:Find("sel"):GetComponent(typeof(Animation)):Play("Anim_NewEducateTarotEntryUI_tpl_sel2")
		end
	end

	seriesAsync({
		function(arg_31_0)
			onDelayTick(arg_31_0, 0.2)

			return
		end,
		function(arg_32_0)
			if #arg_30_1.drops > 0 or #arg_30_0.showpDrops > 0 then
				arg_30_0:emit(var_0_0.ON_DROP, {
					items = table.mergeArray(arg_30_1.drops, arg_30_0.showpDrops),
					removeFunc = arg_32_0
				})

				arg_30_0.showpDrops = {}
			else
				arg_32_0()
			end

			return
		end
	}, function()
		arg_30_0:closeView()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_34_0)
	if arg_34_0.type == var_0_0.TYPE.DROP then
		return
	end

	arg_34_0:closeView()

	return
end

function var_0_0.willExit(arg_35_0)
	ClearLScrollrect(arg_35_0.scrollRect)

	for iter_35_0, iter_35_1 in pairs(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = {}

	arg_35_0.tarotCard:Dispose()
	arg_35_0.detailEntryCard:Dispose()
	arg_35_0.progressPart:Dispose()
	arg_35_0.resPart:Dispose()
	arg_35_0:UnOverlayPanel(arg_35_0._tf)
	existCall(arg_35_0.contextData.onExit)

	return
end

return var_0_0
