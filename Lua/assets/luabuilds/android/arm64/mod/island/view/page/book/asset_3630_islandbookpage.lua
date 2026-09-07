local IslandBookPage = class("IslandBookPage", import("...base.IslandBasePage"))

function IslandBookPage:getUIName()
	return "IslandBookUI"
end

function IslandBookPage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_guide"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_guide_en"))

	self.charBtn = self._tf:Find("view/content/char")
	self.charTip = self.charBtn:Find("tip")
	self.npcBtn = self._tf:Find("view/content/npc")
	self.npcTip = self.npcBtn:Find("tip")
	self.itemBtn = self._tf:Find("view/content/item")
	self.itemTip = self.itemBtn:Find("tip")
	self.fishBtn = self._tf:Find("view/content/fish")
	self.fishTip = self.fishBtn:Find("tip")

	return
end

function IslandBookPage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.charBtn, function()
		self:OpenPage(IslandBookCharPage)

		return
	end, SFX_PANEL)
	onButton(self, self.npcBtn, function()
		self:OpenPage(IslandBookNpcPage)

		return
	end, SFX_PANEL)
	onButton(self, self.itemBtn, function()
		self:OpenPage(IslandBookItemPage)

		return
	end, SFX_PANEL)
	onButton(self, self.fishBtn, function()
		self:OpenPage(IslandBookFishPage)

		return
	end, SFX_PANEL)

	return
end

function IslandBookPage:AddListeners()
	self:AddListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, self.FlushTips)
	self:AddListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, self.FlushTips)
	self:AddListener(GAME.ISLAND_GET_POINT_AWARD_DONE, self.FlushTips)

	return
end

function IslandBookPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, self.FlushTips)
	self:RemoveListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, self.FlushTips)
	self:RemoveListener(GAME.ISLAND_GET_POINT_AWARD_DONE, self.FlushTips)

	return
end

function IslandBookPage:OnShow()
	self:FlushTips()

	return
end

function IslandBookPage:FlushTips()
	setActive(self.fishBtn, IslandMainBtnTipHelper.IsUnlock("book_fish"))

	self.bookAgency = getProxy(IslandProxy):GetIsland():GetBookAgency()

	setActive(self.charTip, self.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.CHAR
	}))
	setActive(self.npcTip, self.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.NPC
	}))
	setActive(self.itemTip, self.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.ITEM
	}))
	setActive(self.fishTip, self.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.FISH
	}))

	return
end

return IslandBookPage
