local var_0_0 = class("SpWeaponDesignLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SpWeaponDesignUI"
end

function var_0_0.SetCraftList(arg_2_0, arg_2_1)
	arg_2_0.craftList = arg_2_1

	return
end

function var_0_0.SetSpWeapons(arg_3_0, arg_3_1)
	assert(arg_3_0.craftList)

	if arg_3_0.craftList then
		_.each(arg_3_0.craftList, function(arg_4_0)
			arg_4_0.owned = not not (arg_4_0:IsUnique() and table.Find(arg_3_1, function(arg_5_0, arg_5_1)
				return arg_5_1:GetOriginID() == arg_4_0:GetConfigID()
			end))

			return
		end)
	end

	return
end

function var_0_0.setItems(arg_6_0, arg_6_1)
	arg_6_0.itemVOs = arg_6_1

	return
end

function var_0_0.setPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_0.init(arg_8_0)
	arg_8_0.designScrollView = arg_8_0._tf:Find("equipment_scrollview")
	arg_8_0.equipmentTpl = arg_8_0._tf:Find("Template")

	setActive(arg_8_0.equipmentTpl, false)

	arg_8_0.equipmentContainer = arg_8_0.designScrollView:Find("equipment_grid")

	local var_8_0

	if NotchAdapt.CheckNotchRatio ~= 2 then
		var_8_0 = not getProxy(SettingsProxy):CheckLargeScreen() and arg_8_0.designScrollView.rect.width > 2000 or NotchAdapt.CheckNotchRatio >= 2
		arg_8_0.equipmentContainer:GetComponent(typeof(GridLayoutGroup)).constraintCount = var_8_0 and 8 or 7
		arg_8_0.top = arg_8_0._tf:Find("top")
		arg_8_0.toggleOwned = arg_8_0._tf:Find("toggle_owned")
		arg_8_0.sortBtn = arg_8_0.top:Find("sort_button")
		arg_8_0.indexBtn = arg_8_0.top:Find("index_button")
		arg_8_0.decBtn = arg_8_0.sortBtn:Find("dec_btn")
		arg_8_0.sortImgAsc = arg_8_0.decBtn:Find("desc")
		arg_8_0.sortImgDec = arg_8_0.decBtn:Find("asc")
		arg_8_0.indexPanel = arg_8_0._tf:Find("index")
		arg_8_0.tagContainer = arg_8_0.indexPanel:Find("adapt/mask/panel")
		arg_8_0.tagTpl = arg_8_0.tagContainer:Find("tpl")
		arg_8_0.listEmptyTF = arg_8_0._tf:Find("empty")

		setActive(arg_8_0.listEmptyTF, false)

		arg_8_0.listEmptyTxt = arg_8_0.listEmptyTF:Find("Text")

		setText(arg_8_0.listEmptyTxt, i18n("list_empty_tip_equipmentdesignui"))
		arg_8_0:OverlayPanel(arg_8_0.indexPanel)

		return
	end
end

function var_0_0.SetParentTF(arg_9_0, arg_9_1)
	arg_9_0.parentTF = arg_9_1
	arg_9_0.equipmentView = arg_9_0.parentTF:Find("adapt/equipment_scrollview")

	setActive(arg_9_0.equipmentView, false)

	return
end

function var_0_0.SetTopContainer(arg_10_0, arg_10_1)
	arg_10_0.topPanel = arg_10_1

	return
end

function var_0_0.SetTopItems(arg_11_0, arg_11_1)
	arg_11_0.topItems = arg_11_1

	return
end

local var_0_1 = {
	"sort_rarity"
}

function var_0_0.didEnter(arg_12_0)
	setParent(arg_12_0._tf, arg_12_0.parentTF)
	arg_12_0._tf:SetSiblingIndex((arg_12_0.equipmentView:GetSiblingIndex()))

	arg_12_0.contextData.indexDatas = arg_12_0.contextData.indexDatas or {}
	arg_12_0.contextData.index = arg_12_0.contextData.index or 1

	setParent(arg_12_0.top, arg_12_0.topPanel)
	setParent(arg_12_0.toggleOwned, arg_12_0.topItems:Find("adapt/bottom_back"))
	arg_12_0:initDesigns()
	onToggle(arg_12_0, arg_12_0.sortBtn, function(arg_13_0)
		setActive(arg_12_0.indexPanel, arg_13_0)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.indexPanel, function()
		triggerToggle(arg_12_0.sortBtn, false)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.indexBtn, function()
		arg_12_0:emit(SpWeaponDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, {
			indexDatas = Clone(arg_12_0.contextData.indexDatas),
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
			callback = function(arg_16_0)
				if not isActive(arg_12_0._tf) then
					return
				end

				arg_12_0.contextData.indexDatas.typeIndex = arg_16_0.typeIndex
				arg_12_0.contextData.indexDatas.rarityIndex = arg_16_0.rarityIndex

				arg_12_0:filter()

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_12_0.contextData.showOwned = defaultValue(arg_12_0.contextData.showOwned, false)

	triggerToggle(arg_12_0.toggleOwned, arg_12_0.contextData.showOwned)
	onToggle(arg_12_0, arg_12_0.toggleOwned, function(arg_17_0)
		arg_12_0.contextData.showOwned = arg_17_0

		arg_12_0:filter()

		return
	end)
	arg_12_0:initTags()

	return
end

function var_0_0.isDefaultStatus(arg_18_0)
	return (not arg_18_0.contextData.indexDatas.typeIndex or arg_18_0.contextData.indexDatas.typeIndex == IndexConst.SpWeaponTypeAll) and (not arg_18_0.contextData.indexDatas.rarityIndex or arg_18_0.contextData.indexDatas.rarityIndex == IndexConst.SpWeaponRarityAll)
end

function var_0_0.initTags(arg_19_0)
	onButton(arg_19_0, arg_19_0.decBtn, function()
		arg_19_0.contextData.asc = not arg_19_0.contextData.asc

		arg_19_0:filter()

		return
	end)

	arg_19_0.tagTFs = {}

	eachChild(arg_19_0.tagContainer, function(arg_21_0)
		setActive(arg_21_0, false)

		return
	end)

	for iter_19_0, iter_19_1 in ipairs(var_0_1) do
		local var_19_0 = iter_19_0 <= arg_19_0.tagContainer.childCount and arg_19_0.tagContainer:GetChild(iter_19_0 - 1) or cloneTplTo(arg_19_0.tagTpl, arg_19_0.tagContainer)

		setActive(var_19_0, true)
		setImageSprite(findTF(var_19_0, "Image"), GetSpriteFromAtlas("ui/equipmentdesignui_atlas", iter_19_1))
		onToggle(arg_19_0, var_19_0, function(arg_22_0)
			if arg_22_0 then
				arg_19_0.contextData.index = iter_19_0

				arg_19_0:filter()
			end

			triggerButton(arg_19_0.indexPanel)

			return
		end, SFX_PANEL)
		table.insert(arg_19_0.tagTFs, var_19_0)
	end

	triggerToggle(arg_19_0.tagTFs[arg_19_0.contextData.index], true)

	return
end

function var_0_0.initDesigns(arg_23_0)
	arg_23_0.scollRect = arg_23_0.designScrollView:GetComponent("LScrollRect")
	arg_23_0.scollRect.decelerationRate = 0.07

	function arg_23_0.scollRect.onInitItem(arg_24_0)
		arg_23_0:initDesign(arg_24_0)

		return
	end

	function arg_23_0.scollRect.onUpdateItem(arg_25_0, arg_25_1)
		arg_23_0:updateDesign(arg_25_0, arg_25_1)

		return
	end

	function arg_23_0.scollRect.onReturnItem(arg_26_0, arg_26_1)
		arg_23_0:returnDesign(arg_26_0, arg_26_1)

		return
	end

	arg_23_0.desgins = {}

	return
end

function var_0_0.initDesign(arg_27_0, arg_27_1)
	local var_27_0 = SpWeaponItemView.New(arg_27_1)

	onButton(arg_27_0, var_27_0.go, function()
		arg_27_0:emit(SpWeaponDesignMediator.ON_COMPOSITE, var_27_0.spWeaponVO:GetConfigID())

		return
	end)

	arg_27_0.desgins[arg_27_1] = var_27_0

	return
end

function var_0_0.updateDesign(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.desgins[arg_29_2] then
		arg_29_0:initDesign(arg_29_2)
	end

	arg_29_0.desgins[arg_29_2]:update(arg_29_0.filterCraftList[arg_29_1 + 1])

	return
end

function var_0_0.returnDesign(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.exited then
		return
	end

	if arg_30_0.desgins[arg_30_2] then
		var_30_0:clear()
	end

	return
end

function var_0_0.getDesignVO(arg_31_0, arg_31_1)
	return arg_31_1
end

local var_0_2 = require("view.equipment.SpWeaponSortCfg")

function var_0_0.filter(arg_32_0)
	GetSpriteFromAtlasAsync("ui/share/index_atlas", arg_32_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_33_0)
		setImageSprite(arg_32_0.indexBtn, arg_33_0, true)

		return
	end)

	for iter_32_0, iter_32_1 in pairs(arg_32_0.craftList) do
		if IndexConst.filterSpWeaponByType(iter_32_1, arg_32_0.contextData.indexDatas.typeIndex) and IndexConst.filterSpWeaponByRarity(iter_32_1, arg_32_0.contextData.indexDatas.rarityIndex) and (arg_32_0.contextData.showOwned or not iter_32_1.owned) then
			table.insert({}, iter_32_1)
		end
	end

	local var_32_0 = arg_32_0.contextData.index or 1

	table.sort({}, CompareFuncs(var_0_2.sortFunc(var_0_2.sort[1], arg_32_0.contextData.asc)))

	arg_32_0.filterCraftList = {}

	arg_32_0:UpdateCraftList()
	setImageSprite(arg_32_0.sortBtn:Find("Image"), (GetSpriteFromAtlas("ui/equipmentdesignui_atlas", var_0_1[var_32_0])))
	setActive(arg_32_0.sortImgAsc, arg_32_0.contextData.asc)
	setActive(arg_32_0.sortImgDec, not arg_32_0.contextData.asc)

	return
end

function var_0_0.UpdateCraftList(arg_34_0)
	arg_34_0.scollRect:SetTotalCount(#arg_34_0.filterCraftList)
	setActive(arg_34_0.listEmptyTF, #arg_34_0.filterCraftList <= 0)
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.onBackPressed(arg_35_0)
	if isActive(arg_35_0.indexPanel) then
		triggerButton(arg_35_0.indexPanel)

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	arg_35_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_36_0)
	arg_36_0:UnOverlayPanel(arg_36_0.indexPanel, arg_36_0._tf)
	setParent(arg_36_0.toggleOwned, arg_36_0._tf)
	setParent(arg_36_0.top, arg_36_0._tf)

	return
end

return var_0_0
