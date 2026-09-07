local NewEducateTarotEntryLayer = class("NewEducateTarotEntryLayer", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateTarotEntryLayer.TYPE = {
	SHOP = 2,
	DROP = 3,
	NORMAL = 1
}

function NewEducateTarotEntryLayer:getUIName()
	return "NewEducateTarotEntryUI"
end

function NewEducateTarotEntryLayer:init()
	self.progressPart = NewEducateTopProgress.New(self._tf:Find("progress"), self)
	self.resPart = NewEducateTopRes.New(self._tf:Find("res"), self)
	self.toggleTF = self._tf:Find("toggle")

	setText(self.toggleTF:Find("Text"), i18n("child2_show_detail_desc"))

	self.tarotTF = self._tf:Find("tarot")
	self.tarotCard = NewEducateTarotCard.New(self.tarotTF)

	setText(self._tf:Find("all/Text"), i18n("child2_all_entry_title"))

	self.allEntryCntText = self._tf:Find("all/value"):GetComponent(typeof(Text))
	self.scrollRect = self._tf:Find("view/content"):GetComponent("LScrollRect")
	self.detailTF = self._tf:Find("detail")
	self.detailEntryCard = NewEducateEntryCard.New(self.detailTF:Find("entry"))
	self.detailLevelText = self.detailTF:Find("level/Text"):GetComponent(typeof(Text))
	self.upgradeTF = self._tf:Find("upgrade")
	self.upgradeBtn = self.upgradeTF:Find("btn")

	setText(self.upgradeBtn:Find("Text"), i18n("child2_word_upgrade"))

	self.giveupBtn = self._tf:Find("giveup")

	setText(self.giveupBtn:Find("Text"), i18n("child2_word_giveup"))

	self.goBtn = self._tf:Find("go")

	setText(self.goBtn:Find("Text"), i18n("child2_go_shop"))

	self.summaryTF = self._tf:Find("summary")
	self.summaryToggleTF = self.summaryTF:Find("toggle")
	self.pctUIList = UIItemList.New(self.summaryTF:Find("list"), self.summaryTF:Find("list/tpl"))
	self.playerID = getProxy(PlayerProxy):getRawData().id

	return
end

function NewEducateTarotEntryLayer:didEnter()
	self:BlurPanel(self._tf, {
		groupDelta = 3
	})
	onButton(self, self.progressPart._tf:Find("back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onToggle(self, self.toggleTF, function(arg_5_0)
		NewEducateHelper.SetTarotDeatilDescData(arg_5_0)
		self:SwitchDescMode(arg_5_0)

		return
	end, SFX_PANEL)
	onButton(self, self.giveupBtn, function()
		self:emit(NewEducateTarotEntryMediator.ON_GIVE_UP_ENTRY_UP)

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		seriesAsync({
			function(arg_8_0)
				if self.type == NewEducateTarotEntryLayer.TYPE.SHOP then
					self:emit(NewEducateTarotEntryMediator.ON_SHOPPING, self.contextData.goodId, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		}, function(arg_9_0)
			self.showpDrops = arg_9_0 or {}

			self:emit(NewEducateTarotEntryMediator.ON_UPGRADE_ENTRY, self.selectId)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		if self.contextData.char:GetFSM():CheckPriorityStystem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

			return
		end

		self:emit(NewEducateTarotEntryLayer.GO_SCENE, SCENE.NEW_EDUCATE_MAP, {
			openShop = true
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("tip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child2_choose_help.tip
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.summaryToggleTF, function(arg_12_0)
		setText(self.summaryToggleTF:Find("Text"), arg_12_0 and i18n("child2_benefit_summary2") or i18n("child2_benefit_summary"))
		self.pctUIList:align(#self.showPctList)
		PlayerPrefs.SetInt(self:GetBenefitShowLocalKey(), arg_12_0 and 1 or 0)

		return
	end, SFX_PANEL)
	self.pctUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = self.showPctList[arg_13_1 + 1].drop
		local var_13_1 = NewEducateHelper.GetDropConfig(self.showPctList[arg_13_1 + 1].drop)

		if arg_13_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/neweducatecommonui_atlas", var_13_1.icon, arg_13_2:Find("Image"), true)
		elseif arg_13_0 == UIItemList.EventUpdate then
			local var_13_2 = self.showPctList[arg_13_1 + 1].a
			local var_13_3 = self.showPctList[arg_13_1 + 1].b

			setText(arg_13_2:Find("Text"), (self.summaryToggleTF:GetComponent(typeof(Toggle)).isOn and var_13_3 or var_13_2) .. "%")
			setText(arg_13_2:Find("info/content/name"), var_13_1.name)
			setText(arg_13_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_13_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_13_3 .. "%")

			local var_13_4 = self.contextData.char:GetOwnCnt(var_13_0)

			if var_13_0.type == NewEducateConst.DROP_TYPE.ATTR then
				local var_13_5, var_13_6 = NewEducateInfoPanel.GetArrtInfo(var_13_1.rank, var_13_4)

				setText(arg_13_2:Find("info/content/value"), var_13_6)
			else
				setText(arg_13_2:Find("info/content/value"), var_13_4)
			end
		end

		return
	end)

	function self.scrollRect.onInitItem(arg_14_0)
		self:OnInitItem(arg_14_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_15_0, arg_15_1)
		self:OnUpdateItem(arg_15_0, arg_15_1)

		return
	end

	self.cards = {}
	self.triggerFirstCard = true
	self.config = pg.child2_benefit_list
	self.type = self.contextData.type or NewEducateTarotEntryLayer.TYPE.NORMAL

	self:UpdateView()
	triggerToggle(self.toggleTF, NewEducateHelper.IsShowTarotDeatilDesc())

	return
end

function NewEducateTarotEntryLayer:GetBenefitShowLocalKey()
	return NewEducateConst.NEW_EDUCATE_BENEFIT_SHOW_MAX .. "_" .. self.playerID .. "_" .. self.contextData.char.id
end

function NewEducateTarotEntryLayer:UpdateView()
	self.progressPart:Update(self.contextData.char)
	self.resPart:Update(self.contextData.char)

	self.tarotId = self.contextData.char:GetTarotId()
	self.entries = self.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

	self:UpdateTarotPanel()
	self:UpdateSummary()
	self:UpdateBtns()
	self.scrollRect:SetTotalCount(#self.entries)

	if #self.entries == 0 then
		setActive(self.detailTF, false)
		setActive(self.upgradeTF, false)
	end

	return
end

function NewEducateTarotEntryLayer:UpdateTarotPanel()
	setActive(self.tarotCard._tf, self.tarotId)

	if self.tarotId then
		self.tarotCard:Update(self.tarotId, NewEducateTarotCard.TYPE.CURRENT)
	end

	return
end

function NewEducateTarotEntryLayer:UpdateRight()
	local var_19_0 = self.type ~= NewEducateTarotEntryLayer.TYPE.NORMAL and self.config[self.selectId].next_level ~= 0

	setActive(self.upgradeTF, self.type ~= NewEducateTarotEntryLayer.TYPE.NORMAL and self.config[self.selectId].next_level ~= 0)
	setActive(self.detailTF, not var_19_0)

	if var_19_0 then
		self:UpdataUpgrade()
	else
		self:UpdataDetail()
	end

	return
end

function NewEducateTarotEntryLayer:UpdataUpgrade()
	setActive(self.upgradeBtn:Find("res"), self.type == NewEducateTarotEntryLayer.TYPE.SHOP)

	if self.type == NewEducateTarotEntryLayer.TYPE.SHOP then
		setText(self.upgradeBtn:Find("res/Text"), "-" .. self.contextData.cost)
	end

	local var_20_0 = self.config[self.selectId]

	setText(self.upgradeTF:Find("name"), self.config[self.selectId].name)
	setText(self.upgradeTF:Find("before/level/Text"), "LV." .. var_20_0.benefit_level)
	setText(self.upgradeTF:Find("before/desc/Text"), var_20_0.desc)
	setText(self.upgradeTF:Find("after/level/Text"), "LV." .. self.config[var_20_0.next_level].benefit_level)
	setText(self.upgradeTF:Find("after/desc/Text"), var_20_0.upgrade_desc)

	return
end

function NewEducateTarotEntryLayer:UpdataDetail()
	setActive(self.detailTF, self.selectId)

	if self.selectId then
		self.detailLevelText.text = "Lv." .. self.config[self.selectId].benefit_level

		self.detailEntryCard:Update(self.selectId)
		self.detailEntryCard:UpdateCountDesc()
		self.detailEntryCard:UpdateDescMode(self.toggleTF:GetComponent(typeof(Toggle)).isOn)
	end

	return
end

function NewEducateTarotEntryLayer:UpdateSummary()
	self.allEntryCntText.text = #self.entries .. "/" .. #underscore.select(self.contextData.char:GetPermanentData():GetAllBuffIds(), function(arg_23_0)
		return self.config[arg_23_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_23_0)
	end)

	local var_22_0 = self.contextData.char:GetBenefitData()

	self.showPctList = {}

	for iter_22_0, iter_22_1 in ipairs(NewEducateBenefit.GetDisplayPctList(self.contextData.char)) do
		local var_22_1, var_22_2 = var_22_0:GetDisplayPctByDrop(iter_22_1)

		table.insert(self.showPctList, {
			drop = iter_22_1,
			a = var_22_1,
			b = var_22_2
		})
	end

	triggerToggle(self.summaryToggleTF, PlayerPrefs.GetInt(self:GetBenefitShowLocalKey()) == 1)

	return
end

function NewEducateTarotEntryLayer:UpdateBtns()
	setActive(self.giveupBtn, self.type == NewEducateTarotEntryLayer.TYPE.DROP)
	setActive(self.goBtn, self:GetGoBtnVisibility())

	return
end

function NewEducateTarotEntryLayer:GetGoBtnVisibility()
	if self.type ~= NewEducateTarotEntryLayer.TYPE.NORMAL then
		return false
	end

	if not self.contextData.char:IsUnlock("shop") then
		return false
	end

	if self.contextData.char:GetFSM():CheckStystem() == NewEducateFSM.SYSTEM.ENDING then
		return false
	end

	if self.contextData.char:GetFSM():GetSystemNo() == NewEducateFSM.SYSTEM.ENDING then
		return false
	end

	if self.contextData.inShop then
		return false
	end

	return true
end

function NewEducateTarotEntryLayer:OnInitItem(arg_26_1)
	self.cards[arg_26_1] = NewEducateEntryCard.New(arg_26_1)

	return
end

function NewEducateTarotEntryLayer:OnUpdateItem(arg_27_1, arg_27_2)
	local var_27_0 = self.cards[arg_27_2]

	if not self.cards[arg_27_2] then
		self:OnInitItem(arg_27_2)

		var_27_0 = self.cards[arg_27_2]
	end

	local var_27_1 = self.entries[arg_27_1 + 1].id

	var_27_0:Update(self.entries[arg_27_1 + 1].id)
	setActive(var_27_0._tf:Find("sel"), false)
	onButton(self, var_27_0._go, function()
		for iter_28_0, iter_28_1 in pairs(self.cards) do
			setActive(iter_28_1._tf:Find("sel"), false)
		end

		self.selectId = var_27_1

		setActive(var_27_0._tf:Find("sel"), true)

		if not self.triggerFirstCard then
			setActive(var_27_0._tf:Find("sel"), true)
			var_27_0._tf:Find("sel"):GetComponent(typeof(Animation)):Play("Anim_NewEducateTarotEntryUI_tpl_sel")
		end

		self:UpdateRight()

		return
	end, SFX_PANEL)

	if self.triggerFirstCard and arg_27_1 == 0 then
		triggerButton(var_27_0._go)

		self.triggerFirstCard = nil
	end

	return
end

function NewEducateTarotEntryLayer:SwitchDescMode(arg_29_1)
	if self.tarotId then
		self.tarotCard:UpdateDescMode(arg_29_1)
	end

	if self.selectId then
		self.detailEntryCard:UpdateDescMode(arg_29_1)
	end

	for iter_29_0, iter_29_1 in pairs(self.cards) do
		iter_29_1:UpdateDescMode(arg_29_1)
	end

	return
end

function NewEducateTarotEntryLayer:OnUpgradeDone(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self.cards) do
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
			if #arg_30_1.drops > 0 or #self.showpDrops > 0 then
				self:emit(NewEducateTarotEntryLayer.ON_DROP, {
					items = table.mergeArray(arg_30_1.drops, self.showpDrops),
					removeFunc = arg_32_0
				})

				self.showpDrops = {}
			else
				arg_32_0()
			end

			return
		end
	}, function()
		self:closeView()

		return
	end)

	return
end

function NewEducateTarotEntryLayer:onBackPressed()
	if self.type == NewEducateTarotEntryLayer.TYPE.DROP then
		return
	end

	self:closeView()

	return
end

function NewEducateTarotEntryLayer:willExit()
	ClearLScrollrect(self.scrollRect)

	for iter_35_0, iter_35_1 in pairs(self.cards) do
		iter_35_1:Dispose()
	end

	self.cards = {}

	self.tarotCard:Dispose()
	self.detailEntryCard:Dispose()
	self.progressPart:Dispose()
	self.resPart:Dispose()
	self:UnOverlayPanel(self._tf)
	existCall(self.contextData.onExit)

	return
end

return NewEducateTarotEntryLayer
