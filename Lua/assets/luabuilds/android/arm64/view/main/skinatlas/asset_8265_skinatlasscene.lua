local SkinAtlasScene = class("SkinAtlasScene", import("...base.BaseUI"))

SkinAtlasScene.PAGE_ALL = -1
SkinAtlasScene.ON_NEXT_SKIN = "SkinAtlasScene:ON_NEXT_SKIN"
SkinAtlasScene.ON_PREV_SKIN = "SkinAtlasScene:ON_PREV_SKIN"

function SkinAtlasScene:getUIName()
	return "SkinAtlasUI"
end

function SkinAtlasScene:init()
	self.canvasGroup = self._tf:GetComponent(typeof(CanvasGroup))
	self.backBtn = self._tf:Find("adapt/top_panel/back_btn")
	self.homeBtn = self._tf:Find("adapt/top_panel/option")
	self.indexBtn = self._tf:Find("adapt/top_panel/index_btn")
	self.indexBtnSel = self.indexBtn:Find("sel")
	self.inptuTr = self._tf:Find("adapt/top_panel/search")
	self.emptyTr = self._tf:Find("adapt/main_panel/empty")
	self.rollingCircleRect = RollingCircleRect.New(self._tf:Find("adapt/left_panel/mask/content/0"), (self._tf:Find("adapt/left_panel")))

	self.rollingCircleRect:SetCallback(self, SkinAtlasScene.OnSelectSkinPage, SkinAtlasScene.OnConfirmSkinPage)

	self.scrollrect = self._tf:Find("adapt/main_panel/scrollrect"):GetComponent("LScrollRect")
	self.previewPage = SkinAtlasPreviewPage.New(self._tf, self.event)

	setText(self._tf:Find("adapt/main_panel/empty/Text1"), i18n("skinatlas_search_result_is_empty"))
	setText(self._tf:Find("adapt/top_panel/search/holder"), i18n("skinatlas_search_holder"))

	self.defaultIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = SkinAtlasIndexLayer.ExtraALL
	}

	return
end

function SkinAtlasScene:didEnter()
	self.cards = {}

	onButton(self, self.homeBtn, function()
		self:emit(SkinAtlasScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.indexBtn, function()
		self:emit(SkinAtlasMediator.OPEN_INDEX, {
			OnFilter = function(arg_7_0)
				self:OnFilter(arg_7_0)

				return
			end,
			defaultIndex = self.defaultIndex
		})

		return
	end, SFX_PANEL)
	self:bind(SkinAtlasScene.ON_NEXT_SKIN, function(arg_8_0, arg_8_1)
		self:SwitchPreviewSkin(arg_8_1 + 1)

		return
	end)
	self:bind(SkinAtlasScene.ON_PREV_SKIN, function(arg_9_0, arg_9_1)
		self:SwitchPreviewSkin(arg_9_1 - 1)

		return
	end)

	function self.scrollrect.onInitItem(arg_10_0)
		self:OnInitItem(arg_10_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_11_0, arg_11_1)
		self:OnUpdateItem(arg_11_0, arg_11_1)

		return
	end

	onInputChanged(self, self.inptuTr, function()
		self:OnSearch()

		return
	end)
	self:InitSkinPages()

	return
end

function SkinAtlasScene:SwitchPreviewSkin(arg_13_1)
	if self.displays and self.displays[arg_13_1] then
		self.previewPage:ExecuteAction("Flush", self.displays[arg_13_1], arg_13_1)
	end

	return
end

local function var_0_1(arg_14_0)
	local var_14_0 = pg.skin_page_template
	local var_14_1 = arg_14_0:GetID()
	local var_14_2 = var_14_1 == SkinAtlasScene.PAGE_ALL and "text_all" or "text_" .. var_14_0[var_14_1].res

	LoadSpriteAtlasAsync("SkinClassified", (var_14_1 == SkinAtlasScene.PAGE_ALL and "text_all" or "text_" .. var_14_0[var_14_1].res) .. "01", function(arg_15_0)
		local var_15_0 = arg_14_0._tr:Find("name"):GetComponent(typeof(Image))

		var_15_0.sprite = arg_15_0

		var_15_0:SetNativeSize()

		return
	end)
	LoadSpriteAtlasAsync("SkinClassified", var_14_2, function(arg_16_0)
		local var_16_0 = arg_14_0._tr:Find("selected/Image"):GetComponent(typeof(Image))

		var_16_0.sprite = arg_16_0

		var_16_0:SetNativeSize()

		return
	end)
	setText(arg_14_0._tr:Find("eng"), var_14_1 == SkinAtlasScene.PAGE_ALL and "ALL" or var_14_0[var_14_1].english_name)

	return
end

function SkinAtlasScene:InitSkinPages(arg_17_1)
	local var_17_0 = Clone(pg.skin_page_template.all)

	table.insert(var_17_0, 1, SkinAtlasScene.PAGE_ALL)

	self.canvasGroup.blocksRaycasts = false

	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		table.insert(var_17_1, function(arg_18_0)
			var_0_1((self.rollingCircleRect:AddItem(iter_17_1)))

			if (iter_17_0 - 1) % 3 == 0 or iter_17_0 == #var_17_0 then
				onNextTick(arg_18_0)
			else
				arg_18_0()
			end

			return
		end)
	end

	seriesAsync(var_17_1, function()
		setActive(self.scrollrect.gameObject, true)
		self.rollingCircleRect:ScrollTo(SkinAtlasScene.PAGE_ALL)

		self.canvasGroup.blocksRaycasts = true

		return
	end)

	return
end

function SkinAtlasScene:OnSelectSkinPage(arg_20_1)
	if self.selectedSkinPageItem then
		setActive(self.selectedSkinPageItem._tr:Find("selected"), false)
		setActive(self.selectedSkinPageItem._tr:Find("name"), true)
	end

	setActive(arg_20_1._tr:Find("selected"), true)
	setActive(arg_20_1._tr:Find("name"), false)

	self.selectedSkinPageItem = arg_20_1

	return
end

function SkinAtlasScene:OnConfirmSkinPage(arg_21_1)
	self.skinPageID = arg_21_1:GetID()

	self:UpdateSkinCards()

	return
end

function SkinAtlasScene:OnSearch()
	self:UpdateSkinCards()

	return
end

function SkinAtlasScene:OnFilter(arg_23_1)
	self.defaultIndex = {
		typeIndex = arg_23_1.typeIndex,
		campIndex = arg_23_1.campIndex,
		rarityIndex = arg_23_1.rarityIndex,
		extraIndex = arg_23_1.extraIndex
	}

	self:UpdateSkinCards()
	setActive(self.indexBtnSel, arg_23_1.typeIndex ~= ShipIndexConst.TypeAll or arg_23_1.campIndex ~= ShipIndexConst.CampAll or arg_23_1.rarityIndex ~= ShipIndexConst.RarityAll or arg_23_1.extraIndex ~= SkinAtlasIndexLayer.ExtraALL)

	return
end

function SkinAtlasScene:ToVShip(arg_24_1)
	if not self.vship then
		self.vship = {}

		function self.vship.getNation()
			return self.vship.config.nationality
		end

		function self.vship.getShipType()
			return self.vship.config.type
		end

		function self.vship.getTeamType()
			return ShipType.GetTeamFromShipType(self.vship.config.type)
		end

		function self.vship.getRarity()
			return self.vship.config.rarity
		end
	end

	self.vship.config = arg_24_1

	return self.vship
end

function SkinAtlasScene:MatchIndex(arg_29_1)
	local var_29_0 = arg_29_1:GetDefaultShipConfig()

	if not var_29_0 then
		return false
	end

	local var_29_1 = self:ToVShip(var_29_0)

	return ShipIndexConst.filterByType(var_29_1, self.defaultIndex.typeIndex) and ShipIndexConst.filterByCamp(var_29_1, self.defaultIndex.campIndex) and ShipIndexConst.filterByRarity(var_29_1, self.defaultIndex.rarityIndex) and SkinAtlasIndexLayer.filterByExtra(arg_29_1, self.defaultIndex.extraIndex)
end

function SkinAtlasScene:GetSkinList(arg_30_1, arg_30_2)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs((getProxy(ShipSkinProxy):GetOwnSkins())) do
		if (arg_30_1 == SkinAtlasScene.PAGE_ALL or iter_30_1:IsType(arg_30_1)) and not iter_30_1:IsDefault() and iter_30_1:IsMatchKey(arg_30_2) and self:MatchIndex(iter_30_1) and iter_30_1:MatchChangeSkinMain() then
			table.insert(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function SkinAtlasScene:UpdateSkinCards()
	self.displays = self:GetSkinList(self.skinPageID, (getInputText(self.inptuTr)))

	self:SortDisplay(self.displays)
	self.scrollrect:SetTotalCount(#self.displays)
	setActive(self.emptyTr, #self.displays == 0)

	return
end

function SkinAtlasScene:SortDisplay(arg_32_1)
	table.sort(arg_32_1, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:getConfig("ship_group")
		local var_33_1 = arg_33_1:getConfig("ship_group")

		if var_33_0 == var_33_1 then
			return arg_33_0:getConfig("group_index") < arg_33_1:getConfig("group_index")
		else
			return var_33_0 < var_33_1
		end

		return
	end)

	return
end

function SkinAtlasScene:OnInitItem(arg_34_1)
	local var_34_0 = SkinAtlasCard.New(arg_34_1)

	onButton(self, var_34_0._tf, function()
		self.previewPage:ExecuteAction("Show", var_34_0.skin, var_34_0.index)

		return
	end, SFX_PANEL)
	onButton(self, var_34_0.changeSkinUI, function()
		var_34_0:changeSkinNext()

		return
	end, SFX_PANEL)

	self.cards[arg_34_1] = var_34_0

	return
end

function SkinAtlasScene:OnUpdateItem(arg_37_1, arg_37_2)
	if not self.cards[arg_37_2] then
		self:OnInitItem(arg_37_2)
	end

	self.cards[arg_37_2]:Update(self.displays[arg_37_1 + 1], arg_37_1 + 1)

	return
end

function SkinAtlasScene:onBackPressed()
	if self.previewPage and self.previewPage:GetLoaded() and self.previewPage:isShowing() then
		if self.previewPage:IsShowSelectShipView() then
			self.previewPage:CloseSelectShipView()

			return
		end

		self.previewPage:Hide()

		return
	end

	SkinAtlasScene.super.onBackPressed(self)

	return
end

function SkinAtlasScene:willExit()
	for iter_39_0, iter_39_1 in pairs(self.cards) do
		iter_39_1:Dispose()
	end

	self.cards = nil

	if self.rollingCircleRect then
		self.rollingCircleRect:Dispose()

		self.rollingCircleRect = nil
	end

	if self.previewPage then
		self.previewPage:Destroy()

		self.previewPage = nil
	end

	return
end

return SkinAtlasScene
