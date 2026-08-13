class = var_0_10000

local var_0_0 = "SpWeaponDesignLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SpWeaponDesignUI"
end

function var_0_1.SetCraftList(arg_2_0, arg_2_1)
	arg_2_0.craftList = arg_2_1

	return
end

function var_0_1.SetSpWeapons(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_0.craftList)

	if arg_3_0.craftList then
		_ = var_2

		var_2.each(arg_3_0.craftList, function(arg_4_0)
			local var_4_0

			if arg_4_0:IsUnique() then
				table = var_1

				if var_1.Find(arg_3_1, function(arg_5_0, arg_5_1)
					local var_5_0 = arg_5_1:GetOriginID()
					local var_5_1 = arg_4_0

					return var_5_0 == var_3.GetConfigID(var_5_1)
				end) then
					var_4_0 = true

					goto label_4_0
				end
			end

			var_4_0 = false

			::label_4_0::

			arg_4_0.owned = var_4_0

			return
		end)
	end

	return
end

function var_0_1.setItems(arg_6_0, arg_6_1)
	arg_6_0.itemVOs = arg_6_1

	return
end

function var_0_1.setPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.designScrollView = var_1.Find(var_8_0, "equipment_scrollview")

	local var_8_1 = arg_8_0._tf

	arg_8_0.equipmentTpl = var_1.Find(var_8_1, "Template")
	setActive = var_1

	var_1(arg_8_0.equipmentTpl, false)

	local var_8_2 = arg_8_0.designScrollView

	arg_8_0.equipmentContainer = var_1.Find(var_8_2, "equipment_grid")

	local var_8_3

	NotchAdapt = var_1_10002

	if var_1_10002.CheckNotchRatio ~= 2 then
		getProxy = var_2
		SettingsProxy = var_4

		local var_8_4 = var_2(var_4)

		if not var_2.CheckLargeScreen(var_8_4) then
			var_8_3 = arg_8_0.designScrollView.rect.width > 2000
		else
			NotchAdapt = var_2
			var_8_3 = var_2.CheckNotchRatio >= 2
		end

		local var_8_5 = arg_8_0.equipmentContainer
		local var_8_6 = var_2.GetComponent

		typeof = var_1_10005
		GridLayoutGroup = var_1_10007
		var_8_6(var_8_5, var_1_10005(var_1_10007)).constraintCount = var_8_3 and 8 or 7

		local var_8_7 = arg_8_0._tf

		arg_8_0.top = var_3.Find(var_8_7, "top")

		local var_8_8 = arg_8_0._tf

		arg_8_0.toggleOwned = var_3.Find(var_8_8, "toggle_owned")

		local var_8_9 = arg_8_0.top

		arg_8_0.sortBtn = var_3.Find(var_8_9, "sort_button")

		local var_8_10 = arg_8_0.top

		arg_8_0.indexBtn = var_3.Find(var_8_10, "index_button")

		local var_8_11 = arg_8_0.sortBtn

		arg_8_0.decBtn = var_3.Find(var_8_11, "dec_btn")

		local var_8_12 = arg_8_0.decBtn

		arg_8_0.sortImgAsc = var_3.Find(var_8_12, "desc")

		local var_8_13 = arg_8_0.decBtn

		arg_8_0.sortImgDec = var_3.Find(var_8_13, "asc")

		local var_8_14 = arg_8_0._tf

		arg_8_0.indexPanel = var_3.Find(var_8_14, "index")

		local var_8_15 = arg_8_0.indexPanel

		arg_8_0.tagContainer = var_3.Find(var_8_15, "adapt/mask/panel")

		local var_8_16 = arg_8_0.tagContainer

		arg_8_0.tagTpl = var_3.Find(var_8_16, "tpl")

		local var_8_17 = arg_8_0._tf

		arg_8_0.listEmptyTF = var_3.Find(var_8_17, "empty")
		setActive = var_3

		var_3(arg_8_0.listEmptyTF, false)

		local var_8_18 = arg_8_0.listEmptyTF

		arg_8_0.listEmptyTxt = var_3.Find(var_8_18, "Text")
		setText = var_3

		local var_8_19 = arg_8_0.listEmptyTxt

		i18n = var_6

		var_3(var_8_19, var_6("list_empty_tip_equipmentdesignui"))
		arg_8_0:OverlayPanel(arg_8_0.indexPanel)

		return
	end
end

function var_0_1.SetParentTF(arg_9_0, arg_9_1)
	arg_9_0.parentTF = arg_9_1

	local var_9_0 = arg_9_0.parentTF

	arg_9_0.equipmentView = var_2.Find(var_9_0, "adapt/equipment_scrollview")
	setActive = var_2

	var_2(arg_9_0.equipmentView, false)

	return
end

function var_0_1.SetTopContainer(arg_10_0, arg_10_1)
	arg_10_0.topPanel = arg_10_1

	return
end

function var_0_1.SetTopItems(arg_11_0, arg_11_1)
	arg_11_0.topItems = arg_11_1

	return
end

local var_0_2 = {
	"sort_rarity"
}

function var_0_1.didEnter(arg_12_0)
	setParent = var_1_10001

	var_1_10001(arg_12_0._tf, arg_12_0.parentTF)

	local var_12_0 = arg_12_0.equipmentView
	local var_12_1 = var_1.GetSiblingIndex(var_12_0)
	local var_12_2 = arg_12_0._tf

	var_2.SetSiblingIndex(var_12_2, var_12_1)

	local var_12_3 = arg_12_0.contextData
	local var_12_4

	if not arg_12_0.contextData.indexDatas then
		var_12_4 = {}
	end

	var_12_3.indexDatas = var_12_4

	local var_12_5 = arg_12_0.contextData
	local var_12_6

	if not arg_12_0.contextData.index then
		var_12_6 = 1
	end

	var_12_5.index = var_12_6
	setParent = var_12_5

	var_12_5(arg_12_0.top, arg_12_0.topPanel)

	setParent = var_12_5

	local var_12_7 = arg_12_0.toggleOwned
	local var_12_8 = arg_12_0.topItems

	var_12_5(var_12_7, var_5.Find(var_12_8, "adapt/bottom_back"))
	arg_12_0:initDesigns()

	onToggle = var_2

	local var_12_9 = arg_12_0
	local var_12_10 = arg_12_0.sortBtn

	local function var_12_11(arg_13_0)
		setActive = var_2_10001

		var_2_10001(arg_12_0.indexPanel, arg_13_0)

		return
	end

	SFX_PANEL = var_12_8

	var_2(var_12_9, var_12_10, var_12_11, var_12_8)

	onButton = var_2

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.indexPanel

	local function var_12_14()
		triggerToggle = var_2_10000

		var_2_10000(arg_12_0.sortBtn, false)

		return
	end

	SFX_PANEL = var_12_8

	var_2(var_12_12, var_12_13, var_12_14, var_12_8)

	onButton = var_2

	local var_12_15 = arg_12_0
	local var_12_16 = arg_12_0.indexBtn

	local function var_12_17()
		local var_15_0 = {}

		Clone = var_2_10001
		var_15_0.indexDatas = var_2_10001(arg_12_0.contextData.indexDatas)

		local var_15_1 = {}
		local var_15_2 = {}

		CustomIndexLayer = var_3
		var_15_2.mode = var_3.Mode.OR
		IndexConst = var_3
		var_15_2.options = var_3.SpWeaponTypeIndexs
		IndexConst = var_3
		var_15_2.names = var_3.SpWeaponTypeNames
		var_15_1.typeIndex = var_15_2

		local var_15_3 = {}

		CustomIndexLayer = var_3
		var_15_3.mode = var_3.Mode.AND
		IndexConst = var_3
		var_15_3.options = var_3.SpWeaponRarityIndexs
		IndexConst = var_3
		var_15_3.names = var_3.SpWeaponRarityNames
		var_15_1.rarityIndex = var_15_3
		var_15_0.customPanels = var_15_1
		var_15_0.groupList = {
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
		}

		function var_15_0.callback(arg_16_0)
			isActive = var_3_10001

			if not var_3_10001(arg_12_0._tf) then
				return
			end

			arg_12_0.contextData.indexDatas.typeIndex = arg_16_0.typeIndex
			arg_12_0.contextData.indexDatas.rarityIndex = arg_16_0.rarityIndex

			local var_16_0 = arg_12_0

			var_1.filter(var_16_0)

			return
		end

		local var_15_4 = arg_12_0
		local var_15_5 = var_1.emit

		SpWeaponDesignMediator = var_2_10004

		var_15_5(var_15_4, var_2_10004.OPEN_EQUIPMENTDESIGN_INDEX, var_15_0)

		return
	end

	SFX_PANEL = var_12_8

	var_2(var_12_15, var_12_16, var_12_17, var_12_8)

	local var_12_18 = arg_12_0.contextData

	defaultValue = var_12_6
	var_12_18.showOwned = var_12_6(arg_12_0.contextData.showOwned, false)
	triggerToggle = var_12_18

	var_12_18(arg_12_0.toggleOwned, arg_12_0.contextData.showOwned)

	onToggle = var_12_18

	var_12_18(arg_12_0, arg_12_0.toggleOwned, function(arg_17_0)
		arg_12_0.contextData.showOwned = arg_17_0

		local var_17_0 = arg_12_0

		var_1.filter(var_17_0)

		return
	end)
	arg_12_0:initTags()

	return
end

function var_0_1.isDefaultStatus(arg_18_0)
	if arg_18_0.contextData.indexDatas.typeIndex then
		local var_18_0 = arg_18_0.contextData.indexDatas.typeIndex

		IndexConst = var_1_10002

		if var_18_0 == var_1_10002.SpWeaponTypeAll then
			local var_18_2

			if arg_18_0.contextData.indexDatas.rarityIndex then
				local var_18_1 = arg_18_0.contextData.indexDatas.rarityIndex

				IndexConst = var_1_10002

				if var_18_1 ~= var_1_10002.SpWeaponRarityAll then
					var_18_2 = false

					goto label_18_0
				end
			end

			var_18_2 = true

			::label_18_0::

			return var_18_2
		end
	end
end

function var_0_1.initTags(arg_19_0)
	onButton = var_1_10001

	var_1_10001(arg_19_0, arg_19_0.decBtn, function()
		arg_19_0.contextData.asc = not arg_19_0.contextData.asc

		local var_20_0 = arg_19_0

		var_0.filter(var_20_0)

		return
	end)

	arg_19_0.tagTFs = {}
	eachChild = var_1

	var_1(arg_19_0.tagContainer, function(arg_21_0)
		setActive = var_2_10001

		var_2_10001(arg_21_0, false)

		return
	end)

	ipairs = var_1

	for iter_19_0, iter_19_1 in var_1(var_0_2) do
		if iter_19_0 <= arg_19_0.tagContainer.childCount then
			local var_19_0 = arg_19_0.tagContainer
			local var_19_1

			if not var_19_1.GetChild(var_19_0, iter_19_0 - 1) then
				cloneTplTo = var_19_1
				var_19_1 = var_19_1(arg_19_0.tagTpl, arg_19_0.tagContainer)
			end

			setActive = var_1_10007

			var_1_10007(var_19_1, true)

			setImageSprite = var_1_10007
			findTF = var_9

			local var_19_2 = var_9(var_19_1, "Image")

			GetSpriteFromAtlas = var_10

			var_1_10007(var_19_2, var_10("ui/equipmentdesignui_atlas", iter_19_1))

			onToggle = var_1_10007

			local var_19_3 = arg_19_0
			local var_19_4 = var_19_1

			local function var_19_5(arg_22_0)
				if arg_22_0 then
					var_2_10001 = arg_19_0.contextData
					var_2_10001.index = iter_19_0

					local var_22_0 = arg_19_0

					var_2_10001.filter(var_22_0)
				end

				triggerButton = var_2_10001

				var_2_10001(arg_19_0.indexPanel)

				return
			end

			SFX_PANEL = var_12

			var_1_10007(var_19_3, var_19_4, var_19_5, var_12)

			table = var_1_10007

			var_1_10007.insert(arg_19_0.tagTFs, var_19_1)
		end
	end

	triggerToggle = var_1

	var_1(arg_19_0.tagTFs[arg_19_0.contextData.index], true)

	return
end

function var_0_1.initDesigns(arg_23_0)
	local var_23_0 = arg_23_0.designScrollView

	arg_23_0.scollRect = var_1.GetComponent(var_23_0, "LScrollRect")
	arg_23_0.scollRect.decelerationRate = 0.07

	function arg_23_0.scollRect.onInitItem(arg_24_0)
		local var_24_0 = arg_23_0

		var_1.initDesign(var_24_0, arg_24_0)

		return
	end

	function arg_23_0.scollRect.onUpdateItem(arg_25_0, arg_25_1)
		local var_25_0 = arg_23_0

		var_2.updateDesign(var_25_0, arg_25_0, arg_25_1)

		return
	end

	function arg_23_0.scollRect.onReturnItem(arg_26_0, arg_26_1)
		local var_26_0 = arg_23_0

		var_2.returnDesign(var_26_0, arg_26_0, arg_26_1)

		return
	end

	arg_23_0.desgins = {}

	return
end

function var_0_1.initDesign(arg_27_0, arg_27_1)
	SpWeaponItemView = var_1_10002

	local var_27_0 = var_1_10002.New(arg_27_1)

	onButton = var_1_10003

	var_1_10003(arg_27_0, var_27_0.go, function()
		local var_28_0 = arg_27_0
		local var_28_1 = var_0.emit

		SpWeaponDesignMediator = var_2_10003

		local var_28_2 = var_2_10003.ON_COMPOSITE
		local var_28_3 = var_27_0.spWeaponVO

		var_28_1(var_28_0, var_28_2, var_4.GetConfigID(var_28_3))

		return
	end)

	arg_27_0.desgins[arg_27_1] = var_27_0

	return
end

function var_0_1.updateDesign(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if not arg_29_0.desgins[arg_29_2] then
		arg_29_0:initDesign(arg_29_2)

		var_29_0 = arg_29_0.desgins[arg_29_2]
	end

	local var_29_1 = arg_29_0.filterCraftList[arg_29_1 + 1]

	var_29_0:update(var_29_1)

	return
end

function var_0_1.returnDesign(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.exited then
		return
	end

	if arg_30_0.desgins[arg_30_2] then
		var_3:clear()
	end

	return
end

function var_0_1.getDesignVO(arg_31_0, arg_31_1)
	return arg_31_1
end

require = var_2

local var_0_3 = var_2("view.equipment.SpWeaponSortCfg")

function var_0_1.filter(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.isDefaultStatus(var_32_0) and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_1_10002

	var_1_10002("ui/share/index_atlas", var_32_1, function(arg_33_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_32_0.indexBtn, arg_33_0, true)

		return
	end)

	local var_32_2 = {}

	pairs = var_32_0

	for iter_32_0, iter_32_1 in var_32_0(arg_32_0.craftList) do
		IndexConst = var_1_10008

		if var_1_10008.filterSpWeaponByType(iter_32_1, arg_32_0.contextData.indexDatas.typeIndex) then
			IndexConst = var_1_10008

			if var_1_10008.filterSpWeaponByRarity(iter_32_1, arg_32_0.contextData.indexDatas.rarityIndex) and (arg_32_0.contextData.showOwned or not iter_32_1.owned) then
				table = var_1_10008

				var_1_10008.insert(var_32_2, iter_32_1)
			end
		end
	end

	local var_32_3 = arg_32_0.contextData.asc
	local var_32_4

	if not arg_32_0.contextData.index then
		var_32_4 = 1
	end

	table = var_5

	local var_32_5 = var_5.sort
	local var_32_6 = var_32_2

	CompareFuncs = var_1_10008

	var_32_5(var_32_6, var_1_10008(var_0_3.sortFunc(var_0_3.sort[1], var_32_3)))

	arg_32_0.filterCraftList = var_32_2

	arg_32_0:UpdateCraftList()

	GetSpriteFromAtlas = var_5

	local var_32_7 = var_5("ui/equipmentdesignui_atlas", var_0_2[var_32_4])

	setImageSprite = iter_32_0

	local var_32_8 = arg_32_0.sortBtn

	iter_32_0(var_8.Find(var_32_8, "Image"), var_32_7)

	setActive = iter_32_0

	iter_32_0(arg_32_0.sortImgAsc, arg_32_0.contextData.asc)

	setActive = iter_32_0

	iter_32_0(arg_32_0.sortImgDec, not arg_32_0.contextData.asc)

	return
end

function var_0_1.UpdateCraftList(arg_34_0)
	local var_34_0 = arg_34_0.scollRect

	var_1.SetTotalCount(var_34_0, #arg_34_0.filterCraftList)

	setActive = var_1

	var_1(arg_34_0.listEmptyTF, #arg_34_0.filterCraftList <= 0)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	return
end

function var_0_1.onBackPressed(arg_35_0)
	isActive = var_1_10001

	if var_1_10001(arg_35_0.indexPanel) then
		triggerButton = var_1

		var_1(arg_35_0.indexPanel)

		return
	end

	pg = var_1

	local var_35_0 = var_1.CriMgr.GetInstance()
	local var_35_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_35_1(var_35_0, var_1_10004)
	arg_35_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_36_0)
	arg_36_0:UnOverlayPanel(arg_36_0.indexPanel, arg_36_0._tf)

	setParent = var_1

	var_1(arg_36_0.toggleOwned, arg_36_0._tf)

	setParent = var_1

	var_1(arg_36_0.top, arg_36_0._tf)

	return
end

return var_0_1
