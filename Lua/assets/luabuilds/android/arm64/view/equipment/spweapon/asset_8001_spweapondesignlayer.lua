local SpWeaponDesignLayer = class("SpWeaponDesignLayer", import("view.base.BaseUI"))

function SpWeaponDesignLayer:getUIName()
	return "SpWeaponDesignUI"
end

function SpWeaponDesignLayer:SetCraftList(arg_2_1)
	self.craftList = arg_2_1

	return
end

function SpWeaponDesignLayer:SetSpWeapons(arg_3_1)
	assert(self.craftList)

	if self.craftList then
		_.each(self.craftList, function(arg_4_0)
			arg_4_0.owned = not not (arg_4_0:IsUnique() and table.Find(arg_3_1, function(arg_5_0, arg_5_1)
				return arg_5_1:GetOriginID() == arg_4_0:GetConfigID()
			end))

			return
		end)
	end

	return
end

function SpWeaponDesignLayer:setItems(arg_6_1)
	self.itemVOs = arg_6_1

	return
end

function SpWeaponDesignLayer:setPlayer(arg_7_1)
	self.player = arg_7_1

	return
end

function SpWeaponDesignLayer:init()
	self.designScrollView = self._tf:Find("equipment_scrollview")
	self.equipmentTpl = self._tf:Find("Template")

	setActive(self.equipmentTpl, false)

	self.equipmentContainer = self.designScrollView:Find("equipment_grid")

	local var_8_0

	if NotchAdapt.CheckNotchRatio ~= 2 then
		if not getProxy(SettingsProxy):CheckLargeScreen() then
			var_8_0 = self.designScrollView.rect.width > 2000

			goto label_8_0
		end
	end

	::label_8_0::

	self.equipmentContainer:GetComponent(typeof(GridLayoutGroup)).constraintCount = NotchAdapt.CheckNotchRatio >= 2 and 8 or 7
	self.top = self._tf:Find("top")
	self.toggleOwned = self._tf:Find("toggle_owned")
	self.sortBtn = self.top:Find("sort_button")
	self.indexBtn = self.top:Find("index_button")
	self.decBtn = self.sortBtn:Find("dec_btn")
	self.sortImgAsc = self.decBtn:Find("desc")
	self.sortImgDec = self.decBtn:Find("asc")
	self.indexPanel = self._tf:Find("index")
	self.tagContainer = self.indexPanel:Find("adapt/mask/panel")
	self.tagTpl = self.tagContainer:Find("tpl")
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_equipmentdesignui"))
	self:OverlayPanel(self.indexPanel)

	return
end

function SpWeaponDesignLayer:SetParentTF(arg_9_1)
	self.parentTF = arg_9_1
	self.equipmentView = self.parentTF:Find("adapt/equipment_scrollview")

	setActive(self.equipmentView, false)

	return
end

function SpWeaponDesignLayer:SetTopContainer(arg_10_1)
	self.topPanel = arg_10_1

	return
end

function SpWeaponDesignLayer:SetTopItems(arg_11_1)
	self.topItems = arg_11_1

	return
end

local var_0_1 = {
	"sort_rarity"
}

function SpWeaponDesignLayer:didEnter()
	setParent(self._tf, self.parentTF)
	self._tf:SetSiblingIndex((self.equipmentView:GetSiblingIndex()))

	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.contextData.index = self.contextData.index or 1

	setParent(self.top, self.topPanel)
	setParent(self.toggleOwned, self.topItems:Find("adapt/bottom_back"))
	self:initDesigns()
	onToggle(self, self.sortBtn, function(arg_13_0)
		setActive(self.indexPanel, arg_13_0)

		return
	end, SFX_PANEL)
	onButton(self, self.indexPanel, function()
		triggerToggle(self.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(SpWeaponDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
			customPanels = {
				typeIndex = {
					mode = CustomIndexLayer.Mode.OR,
					options = IndexConst.SpWeaponTypeIndexs,
					names = IndexConst.SpWeaponTypeNames
				},
				rarityIndex = {
					mode = CustomIndexLayer.Mode.AND,
					options = IndexConst.SpWeaponRarityIndexs,
					names = IndexConst.SpWeaponRarityNames
				}
			},
			groupList = {
				{
					dropdown = false,
					titleENTxt = "indexsort_typeeng",
					titleTxt = "indexsort_type",
					tags = {
						"typeIndex"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_rarityeng",
					titleTxt = "indexsort_rarity",
					tags = {
						"rarityIndex"
					}
				}
			},
			callback = function(self)
				if not isActive(self._tf) then
					return
				end

				self.contextData.indexDatas.typeIndex = self.typeIndex
				self.contextData.indexDatas.rarityIndex = self.rarityIndex

				self:filter()

				return
			end
		})

		return
	end, SFX_PANEL)

	self.contextData.showOwned = defaultValue(self.contextData.showOwned, false)

	triggerToggle(self.toggleOwned, self.contextData.showOwned)
	onToggle(self, self.toggleOwned, function(arg_17_0)
		self.contextData.showOwned = arg_17_0

		self:filter()

		return
	end)
	self:initTags()

	return
end

function SpWeaponDesignLayer:isDefaultStatus()
	return (not self.contextData.indexDatas.typeIndex or self.contextData.indexDatas.typeIndex == IndexConst.SpWeaponTypeAll) and (not self.contextData.indexDatas.rarityIndex or self.contextData.indexDatas.rarityIndex == IndexConst.SpWeaponRarityAll)
end

function SpWeaponDesignLayer:initTags()
	onButton(self, self.decBtn, function()
		self.contextData.asc = not self.contextData.asc

		self:filter()

		return
	end)

	self.tagTFs = {}

	eachChild(self.tagContainer, function(arg_21_0)
		setActive(arg_21_0, false)

		return
	end)

	for iter_19_0, iter_19_1 in ipairs(var_0_1) do
		local var_19_0 = iter_19_0 <= self.tagContainer.childCount and self.tagContainer:GetChild(iter_19_0 - 1) or cloneTplTo(self.tagTpl, self.tagContainer)

		setActive(var_19_0, true)
		setImageSprite(findTF(var_19_0, "Image"), GetSpriteFromAtlas("ui/equipmentdesignui_atlas", iter_19_1))
		onToggle(self, var_19_0, function(arg_22_0)
			if arg_22_0 then
				self.contextData.index = iter_19_0

				self:filter()
			end

			triggerButton(self.indexPanel)

			return
		end, SFX_PANEL)
		table.insert(self.tagTFs, var_19_0)
	end

	triggerToggle(self.tagTFs[self.contextData.index], true)

	return
end

function SpWeaponDesignLayer:initDesigns()
	self.scollRect = self.designScrollView:GetComponent("LScrollRect")
	self.scollRect.decelerationRate = 0.07

	function self.scollRect.onInitItem(arg_24_0)
		self:initDesign(arg_24_0)

		return
	end

	function self.scollRect.onUpdateItem(arg_25_0, arg_25_1)
		self:updateDesign(arg_25_0, arg_25_1)

		return
	end

	function self.scollRect.onReturnItem(arg_26_0, arg_26_1)
		self:returnDesign(arg_26_0, arg_26_1)

		return
	end

	self.desgins = {}

	return
end

function SpWeaponDesignLayer:initDesign(arg_27_1)
	local var_27_0 = SpWeaponItemView.New(arg_27_1)

	onButton(self, var_27_0.go, function()
		self:emit(SpWeaponDesignMediator.ON_COMPOSITE, var_27_0.spWeaponVO:GetConfigID())

		return
	end)

	self.desgins[arg_27_1] = var_27_0

	return
end

function SpWeaponDesignLayer:updateDesign(arg_29_1, arg_29_2)
	if not self.desgins[arg_29_2] then
		self:initDesign(arg_29_2)
	end

	self.desgins[arg_29_2]:update(self.filterCraftList[arg_29_1 + 1])

	return
end

function SpWeaponDesignLayer:returnDesign(arg_30_1, arg_30_2)
	if self.exited then
		return
	end

	if self.desgins[arg_30_2] then
		self.desgins[arg_30_2]:clear()
	end

	return
end

function SpWeaponDesignLayer:getDesignVO(arg_31_1)
	return arg_31_1
end

local SpWeaponSortCfg = require("view.equipment.SpWeaponSortCfg")

function SpWeaponDesignLayer:filter()
	GetSpriteFromAtlasAsync("ui/share/index_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_33_0)
		setImageSprite(self.indexBtn, arg_33_0, true)

		return
	end)

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(self.craftList) do
		if IndexConst.filterSpWeaponByType(iter_32_1, self.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_32_1, self.contextData.indexDatas.rarityIndex) and (self.contextData.showOwned or not iter_32_1.owned) then
			table.insert(var_32_0, iter_32_1)
		end
	end

	local var_32_1 = self.contextData.index or 1

	table.sort(var_32_0, CompareFuncs(SpWeaponSortCfg.sortFunc(SpWeaponSortCfg.sort[1], self.contextData.asc)))

	self.filterCraftList = var_32_0

	self:UpdateCraftList()
	setImageSprite(self.sortBtn:Find("Image"), (GetSpriteFromAtlas("ui/equipmentdesignui_atlas", var_0_1[var_32_1])))
	setActive(self.sortImgAsc, self.contextData.asc)
	setActive(self.sortImgDec, not self.contextData.asc)

	return
end

function SpWeaponDesignLayer:UpdateCraftList()
	self.scollRect:SetTotalCount(#self.filterCraftList)
	setActive(self.listEmptyTF, #self.filterCraftList <= 0)
	Canvas.ForceUpdateCanvases()

	return
end

function SpWeaponDesignLayer:onBackPressed()
	if isActive(self.indexPanel) then
		triggerButton(self.indexPanel)

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:emit(SpWeaponDesignLayer.ON_BACK)

	return
end

function SpWeaponDesignLayer:willExit()
	self:UnOverlayPanel(self.indexPanel, self._tf)
	setParent(self.toggleOwned, self._tf)
	setParent(self.top, self._tf)

	return
end

return SpWeaponDesignLayer
