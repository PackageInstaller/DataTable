local IslandBookItemPage = class("IslandBookItemPage", import("...base.IslandBasePage"))

function IslandBookItemPage:getUIName()
	return "IslandBookItemUI"
end

function IslandBookItemPage:GetIllustrationType()
	return IslandIllustration.TYPES.ITEM
end

function IslandBookItemPage:GetHelpTip()
	return i18n("island_guide_help_item")
end

function IslandBookItemPage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_guide"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_guide_en"))

	self.viewTF = self._tf:Find("view")

	setActive(self._tf:Find("tpl"), false)

	self.scrollRect = self.viewTF:GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	self.rightTF = self._tf:Find("right")
	self.rightNameTF = self.rightTF:Find("name")
	self.rightEnNameTF = self.rightTF:Find("zs/Text")
	self.rightDescTF = self.rightTF:Find("desc")
	self.rightProgressTF = self.rightTF:Find("progress")
	self.unlockBtn = self.rightTF:Find("unlock_btn")

	setText(self.unlockBtn:Find("Text"), i18n("island_guide_do_active"))

	self.getPointBtn = self.rightTF:Find("get_btn")

	setText(self.getPointBtn:Find("Text"), i18n("island_guide_collectionpoint"))

	self.pointPanel = self._tf:Find("point_panel")
	self.pointLevelTF = self.pointPanel:Find("Text")
	self.pointAwardTF = self.pointPanel:Find("award")
	self.pointAwardIcon = self.pointPanel:Find("award/icon")
	self.getPointAwardBtn = self.pointPanel:Find("award/get")
	self.gotAllPointAwardTF = self.pointPanel:Find("award/got")
	self.openAwardWinBtn = self.pointPanel:Find("award_btn")
	self.pointSliderTF = self.pointPanel:Find("slider")
	self.pointProgressTF = self.pointPanel:Find("slider/progress")
	self.awardListBox = IslandBookAwardListBox.New(self._tf, self.event, setmetatable({
		ShowMsgBox = function(arg_7_0, arg_7_1)
			self:ShowMsgBox(arg_7_1)

			return
		end,
		type = self:GetIllustrationType()
	}, {
		__index = self.contextData
	}))

	return
end

function IslandBookItemPage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.unlockBtn, function()
		local var_10_0 = self:GetCanUnlockIds()

		if #var_10_0 > 0 then
			self:emit(IslandMediator.UNLOCK_ILLUSTRATION, var_10_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.getPointBtn, function()
		self.getPointBtn:GetComponent(typeof(Animation)):Play()
		self:emit(IslandMediator.GET_COLLECT_POINT, self.canGetPointIds)

		return
	end, SFX_PANEL)
	onButton(self, self.openAwardWinBtn, function()
		self.openAwardWinBtn:GetComponent(typeof(Animation)):Play()
		self.awardListBox:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.getPointAwardBtn, function()
		self.pointAwardTF:GetComponent(typeof(Animation)):Play()
		self:emit(IslandMediator.GET_POINT_AWARD, self.curLevelId)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = self:GetHelpTip(),
			title = i18n("island_guide_character_help")
		})

		return
	end, SFX_PANEL)

	self.cards = {}

	return
end

function IslandBookItemPage:AddListeners()
	self:AddListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, self.OnUnlockDone)
	self:AddListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_GET_POINT_AWARD_DONE, self.OnGetPointAwardDone)

	return
end

function IslandBookItemPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, self.OnUnlockDone)
	self:RemoveListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_GET_POINT_AWARD_DONE, self.OnGetPointAwardDone)

	return
end

function IslandBookItemPage:OnInitItem(arg_17_1)
	local var_17_0 = IslandIllustrationCard.New(arg_17_1)

	self.cards[arg_17_1] = var_17_0

	onButton(self, var_17_0._go, function()
		for iter_18_0, iter_18_1 in pairs(self.cards) do
			iter_18_1:UpdateSelected(nil)
		end

		self.showIllustration = var_17_0.illustration

		var_17_0:UpdateSelected(self.showIllustration.id)
		self:FlushRightPanel()

		return
	end, SFX_PANEL)

	return
end

function IslandBookItemPage:OnUpdateItem(arg_19_1, arg_19_2)
	local var_19_0 = self.cards[arg_19_2]

	if not self.cards[arg_19_2] then
		self:OnInitItem(arg_19_2)

		var_19_0 = self.cards[arg_19_2]
	end

	if self.showList[arg_19_1 + 1] then
		var_19_0:Update(self.showList[arg_19_1 + 1], self.showIllustration and self.showIllustration.id)
	end

	if self.triggerFirstCard and arg_19_1 == 0 then
		self.triggerFirstCard = nil

		triggerButton(var_19_0._go)
	end

	return
end

function IslandBookItemPage:OnShow()
	self.triggerFirstCard = true

	self:Flush()

	return
end

function IslandBookItemPage:GetCanUnlockIds()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self.showList) do
		if iter_21_1:GetStatus() == IslandIllustration.STATUS.CAN_UNLOCK then
			table.insert(var_21_0, iter_21_1.id)
		end
	end

	return var_21_0
end

function IslandBookItemPage:OnUnlockDone(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self.cards) do
		iter_22_1:PlayUnlockAnim(arg_22_1.ids)
	end

	self:Flush()

	return
end

function IslandBookItemPage:OnGetPointAwardDone(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1.dropData.abilitys or {}) do
		pg.TipsMgr.GetInstance():ShowTips(pg.island_ability_template[iter_23_1.id].unlock_text)
	end

	self:Flush()

	return
end

function IslandBookItemPage:Flush()
	self.bookAgency = getProxy(IslandProxy):GetIsland():GetBookAgency()
	self.showList = self.bookAgency:GetListByType(self:GetIllustrationType())

	table.sort(self.showList, CompareFuncs({
		function(arg_25_0)
			return arg_25_0:GetStatus() == IslandIllustration.STATUS.CAN_UNLOCK and 0 or 1
		end,
		function(arg_26_0)
			return pg.island_illustrated_guide[arg_26_0.id].order
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))
	self.scrollRect:SetTotalCount(#self.showList, -1)
	self:FlushRightPanel()
	self:FlushPointAwardInfos()
	self:FlushPointInfos()

	return
end

function IslandBookItemPage:FlushRightPanel()
	if not self.showIllustration then
		return
	end

	local var_28_0 = self.showIllustration:GetStatus()

	setText(self.rightNameTF, self.showIllustration:GetName())
	setText(self.rightEnNameTF, self.showIllustration:GetEnName())
	setText(self.rightDescTF, var_28_0 == IslandIllustration.STATUS.UNLOCK and self.showIllustration:GetDesc() or i18n("island_guide_lock_desc"))
	setActive(self.unlockBtn, var_28_0 == IslandIllustration.STATUS.CAN_UNLOCK)
	self:FlushOnlyItem()

	return
end

function IslandBookItemPage:FlushOnlyItem()
	local var_29_0 = self:GetIllustrationType() == IslandIllustration.TYPES.ITEM

	setActive(self.rightProgressTF, var_29_0)

	if var_29_0 then
		local var_29_1 = self.showIllustration:GetHistoryCnt()
		local var_29_2 = self.showIllustration:GetCurTarget()

		setText(self.rightProgressTF, (var_29_2 or nil) and (var_29_1 .. "/" .. var_29_2 or var_29_1))
	end

	return
end

function IslandBookItemPage:FlushPointAwardInfos()
	local var_30_0 = self:GetIllustrationType()

	self.pointAwardGotIds = self.bookAgency:GetPointAwardGotIds(var_30_0)
	self.curLevelId = self.bookAgency:GetCurLevelPointAwardId(var_30_0)
	self.awardConfig = pg.island_collection_reward[self.curLevelId]

	setText(self.pointLevelTF, i18n("island_book_collection_award_title", self.awardConfig.level))

	self.curPoint, self.targetPoint = self.bookAgency:GetCurPointInfos(var_30_0)

	setText(self.pointProgressTF, self.curPoint .. "/" .. self.targetPoint)
	setSlider(self.pointSliderTF, 0, 1, self.curPoint / self.targetPoint)

	local var_30_1 = self.bookAgency:IsGotAllPointAward(var_30_0)

	setActive(self.gotAllPointAwardTF, var_30_1)
	setActive(self.getPointAwardBtn, not var_30_1 and self.curPoint >= self.targetPoint)
	GetImageSpriteFromAtlasAsync(Drop.Create(self.awardConfig.award_display):getIcon(), "", self.pointAwardIcon)

	return
end

function IslandBookItemPage:FlushPointInfos()
	self.canGetPointIds = {}

	for iter_31_0, iter_31_1 in ipairs(self.showList) do
		if iter_31_1:GetStatus() == IslandIllustration.STATUS.UNLOCK and iter_31_1:IsTip() then
			table.insert(self.canGetPointIds, iter_31_1.id)
		end
	end

	setActive(self.getPointBtn, #self.canGetPointIds > 0)

	return
end

function IslandBookItemPage:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_32_0, iter_32_1 in pairs(self.cards) do
		iter_32_1:Dispose()
	end

	self.cards = {}

	if self.awardListBox then
		self.awardListBox:Destroy()

		self.awardListBox = nil
	end

	return
end

return IslandBookItemPage
