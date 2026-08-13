class = var_0_10000

local var_0_0 = "EquipmentDesignLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipmentDesignUI"
end

function var_0_1.setItems(arg_2_0, arg_2_1)
	arg_2_0.itemVOs = arg_2_1

	return
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1

	return
end

function var_0_1.setCapacity(arg_4_0, arg_4_1)
	arg_4_0.capacity = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.designScrollView = var_1.Find(var_5_0, "equipment_scrollview")

	local var_5_1 = arg_5_0._tf

	arg_5_0.equipmentTpl = var_1.Find(var_5_1, "equipment_tpl")

	local var_5_2 = arg_5_0.designScrollView

	arg_5_0.equipmentContainer = var_1.Find(var_5_2, "equipment_grid")

	local var_5_3 = arg_5_0._tf

	arg_5_0.msgBoxTF = var_1.Find(var_5_3, "msg_panel")
	setActive = var_1

	var_1(arg_5_0.msgBoxTF, false)

	local var_5_4 = arg_5_0._tf

	arg_5_0.top = var_1.Find(var_5_4, "top")

	local var_5_5 = arg_5_0.top

	arg_5_0.sortBtn = var_1.Find(var_5_5, "sort_button")

	local var_5_6 = arg_5_0.top

	arg_5_0.indexBtn = var_1.Find(var_5_6, "index_button")

	local var_5_7 = arg_5_0.sortBtn

	arg_5_0.decBtn = var_1.Find(var_5_7, "dec_btn")

	local var_5_8 = arg_5_0.decBtn

	arg_5_0.sortImgAsc = var_1.Find(var_5_8, "asc")

	local var_5_9 = arg_5_0.decBtn

	arg_5_0.sortImgDec = var_1.Find(var_5_9, "desc")

	local var_5_10 = arg_5_0._tf

	arg_5_0.indexPanel = var_1.Find(var_5_10, "index")

	local var_5_11 = arg_5_0.indexPanel

	arg_5_0.tagContainer = var_1.Find(var_5_11, "adapt/mask/panel")

	local var_5_12 = arg_5_0.tagContainer

	arg_5_0.tagTpl = var_1.Find(var_5_12, "tpl")

	local var_5_13 = arg_5_0._tf

	arg_5_0.listEmptyTF = var_1.Find(var_5_13, "empty")
	setActive = var_1

	var_1(arg_5_0.listEmptyTF, false)

	local var_5_14 = arg_5_0.listEmptyTF

	arg_5_0.listEmptyTxt = var_1.Find(var_5_14, "Text")
	setText = var_1

	local var_5_15 = arg_5_0.listEmptyTxt

	i18n = var_3

	var_1(var_5_15, var_3("list_empty_tip_equipmentdesignui"))
	arg_5_0:OverlayPanel(arg_5_0.indexPanel)

	EquipmentDesignObtainWayPage = var_1
	arg_5_0.obtainWayPage = var_1.New(arg_5_0._tf, arg_5_0.event)

	local var_5_16 = arg_5_0.obtainWayPage

	var_1.RegisterView(var_5_16, arg_5_0)

	return
end

function var_0_1.SetParentTF(arg_6_0, arg_6_1)
	arg_6_0.parentTF = arg_6_1

	local var_6_0 = arg_6_0.parentTF

	arg_6_0.equipmentView = var_2.Find(var_6_0, "adapt/equipment_scrollview")
	setActive = var_2

	var_2(arg_6_0.equipmentView, false)

	return
end

function var_0_1.SetTopContainer(arg_7_0, arg_7_1)
	arg_7_0.topPanel = arg_7_1

	return
end

local var_0_2 = {
	"sort_default",
	"sort_rarity",
	"sort_count"
}

function var_0_1.didEnter(arg_8_0)
	setParent = var_1_10001

	var_1_10001(arg_8_0._tf, arg_8_0.parentTF)

	local var_8_0 = arg_8_0.equipmentView
	local var_8_1 = var_1.GetSiblingIndex(var_8_0)
	local var_8_2 = arg_8_0._tf

	var_2.SetSiblingIndex(var_8_2, var_8_1)

	local var_8_3 = arg_8_0.contextData
	local var_8_4

	if not arg_8_0.contextData.indexDatas then
		var_8_4 = {}
	end

	var_8_3.indexDatas = var_8_4
	setParent = var_8_3

	var_8_3(arg_8_0.top, arg_8_0.topPanel)
	arg_8_0:initDesigns()

	onToggle = var_2

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.sortBtn

	local function var_8_7(arg_9_0)
		if arg_9_0 then
			setActive = var_2_10001

			var_2_10001(arg_8_0.indexPanel, true)
		else
			setActive = var_2_10001

			var_2_10001(arg_8_0.indexPanel, false)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_8_5, var_8_6, var_8_7, var_1_10006)

	onButton = var_2

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_0.indexPanel

	local function var_8_10()
		triggerToggle = var_2_10000

		var_2_10000(arg_8_0.sortBtn, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_8_8, var_8_9, var_8_10, var_1_10006)

	onButton = var_2

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0.indexBtn

	local function var_8_13()
		local var_11_0 = {}

		Clone = var_2_10001
		var_11_0.indexDatas = var_2_10001(arg_8_0.contextData.indexDatas)

		local var_11_1 = {
			minHeight = 650
		}
		local var_11_2 = {}

		CustomIndexLayer = var_2_10003
		var_11_2.mode = var_2_10003.Mode.OR
		IndexConst = var_3
		var_11_2.options = var_3.EquipmentTypeIndexs
		IndexConst = var_3
		var_11_2.names = var_3.EquipmentTypeNames
		var_11_1.typeIndex = var_11_2

		local var_11_3 = {}

		CustomIndexLayer = var_3
		var_11_3.mode = var_3.Mode.OR
		IndexConst = var_3
		var_11_3.options = var_3.EquipPropertyIndexs
		IndexConst = var_3
		var_11_3.names = var_3.EquipPropertyNames
		var_11_1.equipPropertyIndex = var_11_3

		local var_11_4 = {}

		CustomIndexLayer = var_3
		var_11_4.mode = var_3.Mode.OR
		IndexConst = var_3
		var_11_4.options = var_3.EquipPropertyIndexs
		IndexConst = var_3
		var_11_4.names = var_3.EquipPropertyNames
		var_11_1.equipPropertyIndex2 = var_11_4

		local var_11_5 = {}

		CustomIndexLayer = var_3
		var_11_5.mode = var_3.Mode.OR
		IndexConst = var_3
		var_11_5.options = var_3.EquipAmmoIndexs_1
		IndexConst = var_3
		var_11_5.names = var_3.EquipAmmoIndexs_1_Names
		var_11_1.equipAmmoIndex1 = var_11_5

		local var_11_6 = {}

		CustomIndexLayer = var_3
		var_11_6.mode = var_3.Mode.OR
		IndexConst = var_3
		var_11_6.options = var_3.EquipAmmoIndexs_2
		IndexConst = var_3
		var_11_6.names = var_3.EquipAmmoIndexs_2_Names
		var_11_1.equipAmmoIndex2 = var_11_6

		local var_11_7 = {}

		CustomIndexLayer = var_3
		var_11_7.mode = var_3.Mode.AND
		IndexConst = var_3
		var_11_7.options = var_3.EquipCampIndexs
		IndexConst = var_3
		var_11_7.names = var_3.EquipCampNames
		var_11_1.equipCampIndex = var_11_7

		local var_11_8 = {}

		CustomIndexLayer = var_3
		var_11_8.mode = var_3.Mode.AND
		IndexConst = var_3
		var_11_8.options = var_3.EquipmentRarityIndexs
		IndexConst = var_3
		var_11_8.names = var_3.RarityNames
		var_11_1.rarityIndex = var_11_8
		var_11_0.customPanels = var_11_1
		var_11_0.groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_typeeng",
				titleTxt = "indexsort_type",
				tags = {
					"typeIndex"
				}
			},
			{
				dropdown = true,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_index",
				tags = {
					"equipPropertyIndex",
					"equipPropertyIndex2",
					"equipAmmoIndex1",
					"equipAmmoIndex2"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_campeng",
				titleTxt = "indexsort_camp",
				tags = {
					"equipCampIndex"
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

		local var_11_9 = {}
		local var_11_10 = {}
		local var_11_11 = {}

		IndexConst = var_2_10004
		var_11_11.typeIndex = var_2_10004.EquipmentTypeAll
		var_11_10.include = var_11_11
		var_11_10.exclude = {}
		var_11_9.equipPropertyIndex = var_11_10

		local var_11_12 = {}
		local var_11_13 = {}

		IndexConst = var_4
		var_11_13.typeIndex = var_4.EquipmentTypeEquip
		var_11_12.include = var_11_13

		local var_11_14 = {}

		IndexConst = var_4
		var_11_14.typeIndex = var_4.EquipmentTypeAll
		var_11_12.exclude = var_11_14
		var_11_9.equipPropertyIndex2 = var_11_12

		local var_11_15 = {}
		local var_11_16 = {}

		IndexConst = var_4

		local var_11_17 = var_4.BitAll
		local var_11_18 = {}

		IndexConst = var_2_10006
		var_11_18[1] = var_2_10006.EquipmentTypeSmallCannon
		IndexConst = var_6
		var_11_18[2] = var_6.EquipmentTypeMediumCannon
		IndexConst = var_6
		var_11_18[3] = var_6.EquipmentTypeBigCannon
		var_11_16.typeIndex = var_11_17(var_11_18)
		var_11_15.include = var_11_16

		local var_11_19 = {}

		IndexConst = var_4
		var_11_19.typeIndex = var_4.EquipmentTypeAll
		var_11_15.exclude = var_11_19
		var_11_9.equipAmmoIndex1 = var_11_15

		local var_11_20 = {}
		local var_11_21 = {}

		IndexConst = var_4

		local var_11_22 = var_4.BitAll
		local var_11_23 = {}

		IndexConst = var_6
		var_11_23[1] = var_6.EquipmentTypeWarshipTorpedo
		IndexConst = var_6
		var_11_23[2] = var_6.EquipmentTypeSubmaraineTorpedo
		var_11_21.typeIndex = var_11_22(var_11_23)
		var_11_20.include = var_11_21

		local var_11_24 = {}

		IndexConst = var_4
		var_11_24.typeIndex = var_4.EquipmentTypeAll
		var_11_20.exclude = var_11_24
		var_11_9.equipAmmoIndex2 = var_11_20
		var_11_0.dropdownLimit = var_11_9

		function var_11_0.callback(arg_12_0)
			isActive = var_3_10001

			if not var_3_10001(arg_8_0._tf) then
				return
			end

			arg_8_0.contextData.indexDatas.typeIndex = arg_12_0.typeIndex
			arg_8_0.contextData.indexDatas.equipPropertyIndex = arg_12_0.equipPropertyIndex
			arg_8_0.contextData.indexDatas.equipPropertyIndex2 = arg_12_0.equipPropertyIndex2
			arg_8_0.contextData.indexDatas.equipAmmoIndex1 = arg_12_0.equipAmmoIndex1
			arg_8_0.contextData.indexDatas.equipAmmoIndex2 = arg_12_0.equipAmmoIndex2
			arg_8_0.contextData.indexDatas.equipCampIndex = arg_12_0.equipCampIndex
			arg_8_0.contextData.indexDatas.rarityIndex = arg_12_0.rarityIndex

			local var_12_0 = arg_8_0
			local var_12_1 = var_1.filter
			local var_12_2

			if not arg_8_0.contextData.index then
				var_12_2 = 1
			end

			var_12_1(var_12_0, var_12_2)

			return
		end

		local var_11_25 = arg_8_0
		local var_11_26 = var_1.emit

		EquipmentDesignMediator = var_11_24

		var_11_26(var_11_25, var_11_24.OPEN_EQUIPMENTDESIGN_INDEX, var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_8_11, var_8_12, var_8_13, var_1_10006)
	arg_8_0:initTags()

	return
end

function var_0_1.isDefaultStatus(arg_13_0)
	if arg_13_0.contextData.indexDatas.typeIndex then
		local var_13_0 = arg_13_0.contextData.indexDatas.typeIndex

		IndexConst = var_1_10002

		if var_13_0 == var_1_10002.EquipmentTypeAll then
			if arg_13_0.contextData.indexDatas.equipPropertyIndex then
				local var_13_1 = arg_13_0.contextData.indexDatas.equipPropertyIndex

				IndexConst = var_1_10002

				if var_13_1 == var_1_10002.EquipPropertyAll then
					if arg_13_0.contextData.indexDatas.equipPropertyIndex2 then
						local var_13_2 = arg_13_0.contextData.indexDatas.equipPropertyIndex2

						IndexConst = var_1_10002

						if var_13_2 == var_1_10002.EquipPropertyAll then
							if arg_13_0.contextData.indexDatas.equipAmmoIndex1 then
								local var_13_3 = arg_13_0.contextData.indexDatas.equipAmmoIndex1

								IndexConst = var_1_10002

								if var_13_3 == var_1_10002.EquipAmmoAll_1 then
									if arg_13_0.contextData.indexDatas.equipAmmoIndex2 then
										local var_13_4 = arg_13_0.contextData.indexDatas.equipAmmoIndex2

										IndexConst = var_1_10002

										if var_13_4 == var_1_10002.EquipAmmoAll_2 then
											if arg_13_0.contextData.indexDatas.equipCampIndex then
												local var_13_5 = arg_13_0.contextData.indexDatas.equipCampIndex

												IndexConst = var_1_10002

												if var_13_5 == var_1_10002.EquipCampAll then
													local var_13_7

													if arg_13_0.contextData.indexDatas.rarityIndex then
														local var_13_6 = arg_13_0.contextData.indexDatas.rarityIndex

														IndexConst = var_1_10002

														if var_13_6 ~= var_1_10002.EquipmentRarityAll then
															var_13_7 = false

															goto label_13_0
														end
													end

													var_13_7 = true

													::label_13_0::

													return var_13_7
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.initTags(arg_14_0)
	onButton = var_1_10001

	var_1_10001(arg_14_0, arg_14_0.decBtn, function()
		arg_14_0.asc = not arg_14_0.asc
		arg_14_0.contextData.asc = arg_14_0.asc

		local var_15_0 = arg_14_0
		local var_15_1 = var_0.filter
		local var_15_2

		if not arg_14_0.contextData.index then
			var_15_2 = 1
		end

		var_15_1(var_15_0, var_15_2)

		return
	end)

	arg_14_0.tagTFs = {}
	eachChild = var_1

	var_1(arg_14_0.tagContainer, function(arg_16_0)
		setActive = var_2_10001

		var_2_10001(arg_16_0, false)

		return
	end)

	ipairs = var_1

	for iter_14_0, iter_14_1 in var_1(var_0_2) do
		if iter_14_0 <= arg_14_0.tagContainer.childCount then
			var_1_10007 = arg_14_0.tagContainer

			local var_14_0

			if not var_14_0.GetChild(var_1_10007, iter_14_0 - 1) then
				cloneTplTo = var_14_0
				var_14_0 = var_14_0(arg_14_0.tagTpl, arg_14_0.tagContainer)
			end

			setActive = var_1_10007

			var_1_10007(var_14_0, true)

			setImageSprite = var_1_10007
			findTF = var_8

			local var_14_1 = var_8(var_14_0, "Image")

			GetSpriteFromAtlas = var_9

			var_1_10007(var_14_1, var_9("ui/equipmentdesignui_atlas", iter_14_1))

			onToggle = var_1_10007

			local var_14_2 = arg_14_0
			local var_14_3 = var_14_0

			local function var_14_4(arg_17_0)
				if arg_17_0 then
					local var_17_0 = arg_14_0

					var_2_10001.filter(var_17_0, iter_14_0)

					triggerButton = var_2_10001

					var_2_10001(arg_14_0.indexPanel)

					var_2_10001 = arg_14_0.contextData
					var_2_10001.index = iter_14_0
				else
					triggerButton = var_2_10001

					var_2_10001(arg_14_0.indexPanel)
				end

				return
			end

			SFX_PANEL = var_11

			var_1_10007(var_14_2, var_14_3, var_14_4, var_11)

			table = var_1_10007

			var_1_10007.insert(arg_14_0.tagTFs, var_14_0)

			if not arg_14_0.contextData.index then
				var_1_10007 = arg_14_0.contextData
				var_1_10007.index = iter_14_0
			end
		end
	end

	triggerToggle = var_1

	var_1(arg_14_0.tagTFs[arg_14_0.contextData.index], true)

	return
end

function var_0_1.initDesigns(arg_18_0)
	local var_18_0 = arg_18_0.designScrollView

	arg_18_0.scollRect = var_1.GetComponent(var_18_0, "LScrollRect")
	arg_18_0.scollRect.decelerationRate = 0.07

	function arg_18_0.scollRect.onInitItem(arg_19_0)
		local var_19_0 = arg_18_0

		var_1.initDesign(var_19_0, arg_19_0)

		return
	end

	function arg_18_0.scollRect.onUpdateItem(arg_20_0, arg_20_1)
		local var_20_0 = arg_18_0

		var_2.updateDesign(var_20_0, arg_20_0, arg_20_1)

		return
	end

	function arg_18_0.scollRect.onReturnItem(arg_21_0, arg_21_1)
		local var_21_0 = arg_18_0

		var_2.returnDesign(var_21_0, arg_21_0, arg_21_1)

		return
	end

	arg_18_0.desgins = {}

	return
end

local function var_0_3(arg_22_0, arg_22_1)
	findTF = var_1_10002

	local var_22_0 = var_1_10002(arg_22_0, "attrs")

	setImageSprite = var_3
	findTF = var_4

	local var_22_1 = var_4(arg_22_0, "name_bg/tag")

	GetSpriteFromAtlas = var_5

	local var_22_2 = "equiptype"

	EquipType = var_1_10007

	var_3(var_22_1, var_5(var_22_2, var_1_10007.type2Tag(arg_22_1:getConfig("type"))))

	eachChild = var_3

	var_3(var_22_0, function(arg_23_0)
		setActive = var_2_10001

		var_2_10001(arg_23_0, false)

		return
	end)

	local var_22_3 = arg_22_1
	local var_22_4 = arg_22_1.GetPropertiesInfo(var_22_3).attrs

	underscore = var_22_3

	local var_22_5 = var_22_3.filter(var_22_4, function(arg_24_0)
		local var_24_1

		if arg_24_0.type then
			local var_24_0 = arg_24_0.type

			AttributeType = var_2_10002

			if var_24_0 == var_2_10002.AntiSiren then
				var_24_1 = false

				goto label_24_0
			end
		end

		var_24_1 = true

		::label_24_0::

		return var_24_1
	end)
	local var_22_6

	if arg_22_1:getConfig("skill_id")[1] then
		var_22_6 = var_4[1][1]
	end

	if var_22_6 then
		local var_22_7 = arg_22_1
		local var_22_8

		if not arg_22_1.isDevice(var_22_7) or not {
			1,
			2,
			5
		} then
			var_22_8 = {
				1,
				4,
				2,
				3
			}
		end

		ipairs = var_22_7

		for iter_22_0, iter_22_1 in var_22_7(var_22_8) do
			local var_22_9 = var_22_0
			local var_22_10 = var_22_0.Find(var_22_9, "attr_" .. iter_22_1)

			setActive = var_22_9

			var_22_9(var_22_10, true)

			if iter_22_1 == 5 then
				setText = var_22_9

				local var_22_11 = var_22_10
				local var_22_12 = var_22_10.Find(var_22_11, "value")

				getSkillName = var_22_11

				var_22_9(var_22_12, var_22_11(var_22_6))
			else
				local var_22_13 = ""
				local var_22_14 = ""
				local var_22_15

				if #var_22_5 > 0 then
					table = var_22_15
					var_22_15 = var_22_15.remove(var_22_5, 1)
					Equipment = var_16
					var_22_13, var_22_14 = var_16.GetInfoTrans(var_22_15)
				end

				setText = var_22_15

				var_22_15(var_22_10:Find("tag"), var_22_13)

				setText = var_22_15

				var_22_15(var_22_10:Find("value"), var_22_14)
			end
		end

		return
	end
end

function var_0_1.createDesign(arg_25_0, arg_25_1)
	tf = var_1_10002
	arg_25_1 = var_1_10002(arg_25_1)
	findTF = var_2

	local var_25_0 = var_2(arg_25_1, "info/count")

	findTF = var_3

	local var_25_1 = var_3(arg_25_1, "mask")
	local var_25_2 = arg_25_1:Find("name_bg/mask/name")
	local var_25_3 = {
		go = arg_25_1,
		nameTxt = var_25_2
	}

	ClearTweenItemAlphaAndWhite = var_6

	var_6(var_25_3.go)

	function var_25_3.getItemById(arg_26_0, arg_26_1)
		local var_26_0

		if not arg_26_0.itemVOs[arg_26_1] then
			Item = var_26_0
			var_26_0 = var_26_0.New({
				count = 0,
				id = arg_26_1
			})
		end

		return var_26_0
	end

	function var_25_3.update(arg_27_0, arg_27_1, arg_27_2)
		arg_27_0.designId = arg_27_1
		arg_27_0.itemVOs = arg_27_2
		pg = var_2_10003

		local var_27_0 = var_2_10003.compose_data_template[arg_27_1]

		assert = var_2_10004

		var_2_10004(var_27_0, "必须存在配置" .. arg_27_1)

		local var_27_1 = var_27_0.equip_id

		TweenItemAlphaAndWhite = var_5

		var_5(arg_27_0.go)

		Equipment = var_5

		local var_27_2 = var_5.getConfigData(var_27_1)

		assert = var_6

		var_6(var_27_2, "必须存在装备" .. var_27_1)

		setText = var_6

		local var_27_3 = arg_27_0.nameTxt

		shortenString = var_8

		var_6(var_27_3, var_8(var_27_2.name, 6))

		Equipment = var_6

		local var_27_4 = var_6.New({
			id = var_27_1
		})

		findTF = var_7

		local var_27_5 = var_7(arg_25_1, "equipment/bg")

		updateEquipment = var_8

		var_8(var_27_5, var_27_4)

		local function var_27_6()
			local var_28_0

			if not arg_27_0.itemVOs[var_27_0.material_id] then
				Item = var_28_0
				var_28_0 = var_28_0.New({
					count = 0,
					id = var_27_0.material_id
				})
			end

			local var_28_1 = var_28_0.count .. "/" .. var_27_0.material_num

			if var_28_0.count >= var_27_0.material_num then
				setColorStr = var_2

				local var_28_2 = var_28_1

				COLOR_WHITE = var_3_10004

				if not var_2(var_28_2, var_3_10004) then
					::label_28_0::

					setColorStr = var_2

					local var_28_3 = var_28_1

					COLOR_RED = var_3_10004
					var_28_1 = var_2(var_28_3, var_3_10004)
				end

				setText = var_2

				var_2(var_25_0, var_28_1)

				setActive = var_2

				var_2(var_25_1, var_28_0.count < var_27_0.material_num)

				return
			end
		end

		var_0_3(arg_25_1, var_27_4)
		var_27_6()

		return
	end

	function var_25_3.clear(arg_29_0)
		ClearTweenItemAlphaAndWhite = var_2_10001

		var_2_10001(arg_29_0.go)

		return
	end

	return var_25_3
end

function var_0_1.initDesign(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.createDesign(var_30_0, arg_30_1)

	onButton = var_30_0

	local var_30_2 = arg_30_0

	tf = var_1_10005

	local var_30_3 = var_1_10005(var_30_1.go)
	local var_30_4 = var_5.Find(var_30_3, "info/make_btn")

	local function var_30_5()
		local var_31_0 = arg_30_0

		var_0.showDesignDesc(var_31_0, var_30_1.designId)

		return
	end

	SFX_PANEL = var_7

	var_30_0(var_30_2, var_30_4, var_30_5, var_7)

	onButton = var_30_0

	local var_30_6 = arg_30_0

	tf = var_30_4

	local var_30_7 = var_30_4(var_30_1.go)
	local var_30_8 = var_5.Find(var_30_7, "look")

	local function var_30_9()
		local var_32_0 = arg_30_0.obtainWayPage

		var_0.ExecuteAction(var_32_0, "Show", var_30_1.designId)

		return
	end

	SFX_PANEL = var_7

	var_30_0(var_30_6, var_30_8, var_30_9, var_7)

	arg_30_0.desgins[arg_30_1] = var_30_1

	return
end

function var_0_1.updateDesign(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0.desgins[arg_33_2] then
		arg_33_0:initDesign(arg_33_2)

		var_33_0 = arg_33_0.desgins[arg_33_2]
	end

	local var_33_1 = arg_33_0.desginIds[arg_33_1 + 1]

	var_33_0:update(var_33_1, arg_33_0.itemVOs)

	return
end

function var_0_1.returnDesign(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.exited then
		return
	end

	if arg_34_0.desgins[arg_34_2] then
		var_3:clear()
	end

	return
end

function var_0_1.getDesignVO(arg_35_0, arg_35_1)
	local var_35_0 = {}

	pg = var_1_10003

	local var_35_1 = var_1_10003.compose_data_template

	Equipment = var_1_10004
	var_35_0.equipmentCfg = var_1_10004.getConfigData(var_35_1[arg_35_1].equip_id)
	var_35_0.designCfg = var_35_1[arg_35_1]
	var_35_0.id = arg_35_1

	local var_35_2 = arg_35_0

	var_35_0.itemCount = arg_35_0.getItemById(var_35_2, var_35_1[arg_35_1].material_id).count
	math = var_35_2
	var_35_0.canMakeCount = var_35_2.floor(var_4 / var_35_1[arg_35_1].material_num)
	math = var_5
	var_35_0.canMake = var_5.min(var_35_0.canMakeCount, 1)

	local var_35_3 = var_35_1[arg_35_1].equip_id

	Equipment = var_6

	local var_35_4 = var_6.getConfigData(var_35_3)

	assert = var_7

	var_7(var_35_4, "equip config not exist: " .. var_35_3)

	var_35_0.config = var_35_4

	function var_35_0.getNation(arg_36_0)
		return var_35_4.nationality
	end

	function var_35_0.getConfig(arg_37_0, arg_37_1)
		return var_35_4[arg_37_1]
	end

	return var_35_0
end

function var_0_1.filter(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.isDefaultStatus(var_38_0) and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_38_0

	var_38_0("ui/share/index_atlas", var_38_1, function(arg_39_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_38_0.indexBtn, arg_39_0, true)

		return
	end)

	pg = var_38_0

	local var_38_2 = var_38_0.compose_data_template
	local var_38_3 = {}
	local var_38_4 = arg_38_0.asc

	getProxy = var_7
	EquipmentProxy = var_1_10008

	local var_38_5 = var_7(var_1_10008)

	ipairs = var_1_10008

	for iter_38_0, iter_38_1 in var_1_10008(var_38_2.all) do
		pg = var_1_10013
		var_1_10013 = var_1_10013.compose_data_template[iter_38_1]

		if arg_38_0:getItemById(var_1_10013.material_id).count > 0 or arg_38_0.contextData.isShowAllDesign and var_38_5:ShouldShowEquipmentDesignObtainWay(iter_38_1) then
			table = var_15

			var_15.insert(var_38_3, iter_38_1)
		end
	end

	local var_38_6 = {}

	table = var_9

	local var_38_7 = var_9.mergeArray({}, {
		arg_38_0.contextData.indexDatas.equipPropertyIndex,
		arg_38_0.contextData.indexDatas.equipPropertyIndex2
	}, true)

	pairs = var_10

	for iter_38_2, iter_38_3 in var_10(var_38_3) do
		local var_38_8 = arg_38_0
		local var_38_9 = arg_38_0.getDesignVO(var_38_8, iter_38_3)

		IndexConst = var_38_8

		if var_38_8.filterEquipByType(var_38_9, arg_38_0.contextData.indexDatas.typeIndex) then
			IndexConst = var_16

			if var_16.filterEquipByProperty(var_38_9, var_38_7) then
				IndexConst = var_16

				if var_16.filterEquipAmmo1(var_38_9, arg_38_0.contextData.indexDatas.equipAmmoIndex1) then
					IndexConst = var_16

					if var_16.filterEquipAmmo2(var_38_9, arg_38_0.contextData.indexDatas.equipAmmoIndex2) then
						IndexConst = var_16

						if var_16.filterEquipByCamp(var_38_9, arg_38_0.contextData.indexDatas.equipCampIndex) then
							IndexConst = var_16

							if var_16.filterEquipByRarity(var_38_9, arg_38_0.contextData.indexDatas.rarityIndex) then
								table = var_16

								var_16.insert(var_38_6, iter_38_3)
							end
						end
					end
				end
			end
		end
	end

	if arg_38_1 == 1 then
		if var_38_4 then
			table = var_10

			var_10.sort(var_38_6, function(arg_40_0, arg_40_1)
				local var_40_0 = arg_38_0
				local var_40_1 = var_2.getDesignVO(var_40_0, arg_40_0)
				local var_40_2 = arg_38_0
				local var_40_3 = var_3.getDesignVO(var_40_2, arg_40_1)

				if var_40_1.canMake == var_40_3.canMake then
					if var_40_1.equipmentCfg.rarity == var_40_3.equipmentCfg.rarity then
						return var_40_1.equipmentCfg.id < var_40_3.equipmentCfg.id
					else
						return var_40_1.equipmentCfg.rarity > var_40_3.equipmentCfg.rarity
					end
				else
					return var_40_1.canMake < var_40_3.canMake
				end

				return
			end)
		else
			table = var_10

			var_10.sort(var_38_6, function(arg_41_0, arg_41_1)
				local var_41_0 = arg_38_0
				local var_41_1 = var_2.getDesignVO(var_41_0, arg_41_0)
				local var_41_2 = arg_38_0
				local var_41_3 = var_3.getDesignVO(var_41_2, arg_41_1)

				if var_41_1.canMake == var_41_3.canMake then
					if var_41_1.equipmentCfg.rarity == var_41_3.equipmentCfg.rarity then
						return var_41_1.equipmentCfg.id < var_41_3.equipmentCfg.id
					else
						return var_41_1.equipmentCfg.rarity > var_41_3.equipmentCfg.rarity
					end
				else
					return var_41_1.canMake > var_41_3.canMake
				end

				return
			end)
		end
	elseif arg_38_1 == 2 then
		if arg_38_0.asc then
			table = var_10

			var_10.sort(var_38_6, function(arg_42_0, arg_42_1)
				local var_42_0 = arg_38_0
				local var_42_1 = var_2.getDesignVO(var_42_0, arg_42_0)
				local var_42_2 = arg_38_0
				local var_42_3 = var_3.getDesignVO(var_42_2, arg_42_1)

				if var_42_1.equipmentCfg.rarity == var_42_3.equipmentCfg.rarity then
					return var_42_1.equipmentCfg.id < var_42_1.equipmentCfg.id
				end

				return var_42_1.equipmentCfg.rarity < var_42_3.equipmentCfg.rarity
			end)
		else
			table = var_10

			var_10.sort(var_38_6, function(arg_43_0, arg_43_1)
				local var_43_0 = arg_38_0
				local var_43_1 = var_2.getDesignVO(var_43_0, arg_43_0)
				local var_43_2 = arg_38_0
				local var_43_3 = var_3.getDesignVO(var_43_2, arg_43_1)

				if var_43_1.equipmentCfg.rarity == var_43_3.equipmentCfg.rarity then
					return var_43_1.equipmentCfg.id < var_43_1.equipmentCfg.id
				end

				return var_43_1.equipmentCfg.rarity > var_43_3.equipmentCfg.rarity
			end)
		end
	elseif arg_38_1 == 3 then
		if arg_38_0.asc then
			table = var_10

			var_10.sort(var_38_6, function(arg_44_0, arg_44_1)
				local var_44_0 = arg_38_0
				local var_44_1 = var_2.getDesignVO(var_44_0, arg_44_0)
				local var_44_2 = arg_38_0
				local var_44_3 = var_3.getDesignVO(var_44_2, arg_44_1)

				if var_44_1.itemCount == var_44_3.itemCount then
					return var_44_1.equipmentCfg.id < var_44_3.equipmentCfg.id
				end

				return var_44_1.itemCount < var_44_3.itemCount
			end)
		else
			table = var_10

			var_10.sort(var_38_6, function(arg_45_0, arg_45_1)
				local var_45_0 = arg_38_0
				local var_45_1 = var_2.getDesignVO(var_45_0, arg_45_0)
				local var_45_2 = arg_38_0
				local var_45_3 = var_3.getDesignVO(var_45_2, arg_45_1)

				if var_45_1.itemCount == var_45_3.itemCount then
					return var_45_1.equipmentCfg.id < var_45_3.equipmentCfg.id
				end

				return var_45_1.itemCount > var_45_3.itemCount
			end)
		end
	end

	arg_38_0.desginIds = var_38_6

	local var_38_10 = arg_38_0.scollRect

	var_10.SetTotalCount(var_38_10, #var_38_6, arg_38_2 and -1 or 0)

	setActive = var_10

	var_10(arg_38_0.listEmptyTF, #var_38_6 <= 0)

	Canvas = var_10

	var_10.ForceUpdateCanvases()

	GetSpriteFromAtlas = var_10

	local var_38_11 = var_10("ui/equipmentdesignui_atlas", var_0_2[arg_38_1])

	setImageSprite = var_11

	local var_38_12 = arg_38_0.sortBtn

	var_11(var_12.Find(var_38_12, "Image"), var_38_11)

	setActive = var_11

	var_11(arg_38_0.sortImgAsc, arg_38_0.asc)

	setActive = var_11

	var_11(arg_38_0.sortImgDec, not arg_38_0.asc)

	return
end

function var_0_1.getItemById(arg_46_0, arg_46_1)
	local var_46_0

	if not arg_46_0.itemVOs[arg_46_1] then
		Item = var_46_0
		var_46_0 = var_46_0.New({
			count = 0,
			id = arg_46_1
		})
	end

	return var_46_0
end

function var_0_1.showDesignDesc(arg_47_0, arg_47_1)
	arg_47_0.isShowDesc = true
	IsNil = var_2

	if var_2(arg_47_0.msgBoxTF) then
		return
	end

	pg = var_2

	local var_47_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_47_0, arg_47_0.msgBoxTF)

	setActive = var_2

	var_2(arg_47_0.msgBoxTF, true)

	local var_47_1 = arg_47_0.msgBoxTF

	pg = var_3

	local var_47_2 = var_3.compose_data_template[arg_47_1].equip_id

	Equipment = var_1_10005

	local var_47_3 = var_1_10005.New({
		id = var_47_2
	})

	updateEquipInfo = var_6

	var_6(var_47_1:Find("bg/attrs/content"), var_47_3:GetPropertiesInfo(), var_47_3:GetSkill())

	local var_47_4 = var_47_1
	local var_47_5 = var_47_1.Find(var_47_4, "bg/frame/icon")

	GetImageSpriteFromAtlasAsync = var_47_4

	var_47_4("equips/" .. var_47_3:getConfig("icon"), "", var_47_5)

	changeToScrollText = var_47_4

	var_47_4(var_47_1:Find("bg/name"), var_47_3:getConfig("name"))

	UIItemList = var_47_4

	local var_47_6 = var_47_4.New(var_47_1:Find("bg/frame/stars"), var_47_1:Find("bg/frame/stars/sarttpl"))

	var_7.align(var_47_6, var_47_3:getConfig("rarity"))

	setImageSprite = var_8
	findTF = var_47_6

	local var_47_7 = var_47_6(var_47_1, "bg/frame/type")

	GetSpriteFromAtlas = var_10

	local var_47_8 = "equiptype"

	EquipType = var_12

	var_8(var_47_7, var_10(var_47_8, var_12.type2Tag(var_47_3:getConfig("type"))))

	setText = var_8

	local var_47_9 = var_47_1:Find("bg/frame/speciality/Text")
	local var_47_10

	if var_47_3:getConfig("speciality") == "无" or not var_47_3:getConfig("speciality") then
		i18n1 = var_47_10
		var_47_10 = var_47_10("—")
	end

	var_8(var_47_9, var_47_10)

	LoadSprite = var_8

	local var_47_11 = var_8("bg/equipment_bg_" .. var_47_3:getConfig("rarity"))
	local var_47_12 = var_47_1:Find("bg/frame")
	local var_47_13 = var_9.GetComponent

	typeof = var_11
	Image = var_12

	local var_47_14 = var_47_13(var_47_12, var_11(var_12))

	var_47_14.sprite = var_47_11
	findTF = var_47_14

	local var_47_15 = var_47_14(var_47_1, "bg/frame/numbers")
	local var_47_16

	if not var_47_3:getConfig("tech") then
		var_47_16 = 1
	end

	for iter_47_0 = 0, var_47_15.childCount - 1 do
		local var_47_17 = var_47_15
		local var_47_18 = var_47_15.GetChild(var_47_17, iter_47_0)

		setActive = var_47_17

		var_47_17(var_47_18, iter_47_0 == var_47_16)
	end

	local var_47_19 = arg_47_0
	local var_47_20 = arg_47_0.getItemById(var_47_19, var_3.material_id)

	math = var_47_19

	local var_47_21 = var_47_19.floor(var_47_20.count / var_3.material_num)
	local var_47_22 = 1
	local var_47_23 = var_47_1:Find("bg/calc/values/Text")
	local var_47_24 = var_3.gold_num
	local var_47_25 = var_47_1:Find("bg/calc/gold/Text")

	;(function(arg_48_0)
		setText = var_2_10001

		var_2_10001(var_47_23, arg_48_0)

		setText = var_2_10001

		var_2_10001(var_47_25, arg_48_0 * var_47_24)

		return
	end)(var_47_22)

	pressPersistTrigger = var_18
	findTF = var_19

	local var_47_26 = var_19(var_47_1, "bg/calc/minus")
	local var_47_27 = 0.5

	local function var_47_28(arg_49_0)
		if var_47_22 <= 1 then
			arg_49_0()

			return
		end

		var_47_22 = var_47_22 - 1

		var_0(var_47_22)

		return
	end

	local var_47_29
	local var_47_30 = true
	local var_47_31 = true
	local var_47_32 = 0.1

	SFX_PANEL = var_1_10026

	var_18(var_47_26, var_47_27, var_47_28, var_47_29, var_47_30, var_47_31, var_47_32, var_1_10026)

	pressPersistTrigger = var_18
	findTF = var_47_26

	local var_47_33 = var_47_26(var_47_1, "bg/calc/add")
	local var_47_34 = 0.5

	local function var_47_35(arg_50_0)
		if var_47_22 == var_47_21 then
			arg_50_0()

			return
		end

		var_47_22 = var_47_22 + 1

		var_0(var_47_22)

		return
	end

	local var_47_36
	local var_47_37 = true
	local var_47_38 = true
	local var_47_39 = 0.1

	SFX_PANEL = var_1_10026

	var_18(var_47_33, var_47_34, var_47_35, var_47_36, var_47_37, var_47_38, var_47_39, var_1_10026)

	onButton = var_18

	local var_47_40 = arg_47_0

	findTF = var_47_34

	local var_47_41 = var_47_34(var_47_1, "bg/calc/max")

	local function var_47_42()
		if var_47_22 == var_47_21 then
			return
		end

		local var_51_0 = arg_47_0.player
		local var_51_1 = var_0.getMaxEquipmentBag(var_51_0) - arg_47_0.capacity

		math = var_1

		local var_51_2 = var_1.max

		math = var_2_10002
		var_47_22 = var_51_2(var_2_10002.min(var_47_21, var_51_1), 1)

		var_0(var_47_22)

		return
	end

	SFX_PANEL = var_22

	var_18(var_47_40, var_47_41, var_47_42, var_22)

	onButton = var_18

	local var_47_43 = arg_47_0

	findTF = var_47_41

	local var_47_44 = var_47_41(var_47_1, "bg/cancel_btn")

	local function var_47_45()
		local var_52_0 = arg_47_0

		var_0.hideMsgBox(var_52_0)

		return
	end

	SFX_CANCEL = var_22

	var_18(var_47_43, var_47_44, var_47_45, var_22)

	onButton = var_18

	local var_47_46 = arg_47_0

	findTF = var_47_44

	local var_47_47 = var_47_44(var_47_1, "bg/confirm_btn")

	local function var_47_48()
		local var_53_0 = arg_47_0
		local var_53_1 = var_0.emit

		EquipmentDesignMediator = var_2_10002

		var_53_1(var_53_0, var_2_10002.MAKE_EQUIPMENT, arg_47_1, var_47_22)

		local var_53_2 = arg_47_0

		var_0.hideMsgBox(var_53_2)

		return
	end

	SFX_CONFIRM = var_22

	var_18(var_47_46, var_47_47, var_47_48, var_22)

	onButton = var_18

	local var_47_49 = arg_47_0
	local var_47_50 = var_47_1

	local function var_47_51()
		local var_54_0 = arg_47_0

		var_0.hideMsgBox(var_54_0)

		return
	end

	SFX_CANCEL = var_22

	var_18(var_47_49, var_47_50, var_47_51, var_22)

	return
end

function var_0_1.hideMsgBox(arg_55_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_55_0.msgBoxTF) then
		arg_55_0.isShowDesc = nil
		pg = var_1

		local var_55_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_55_0, arg_55_0.msgBoxTF, arg_55_0._tf)

		setActive = var_1

		var_1(arg_55_0.msgBoxTF, false)
	end

	return
end

function var_0_1.onBackPressed(arg_56_0)
	isActive = var_1_10001

	if var_1_10001(arg_56_0.indexPanel) then
		triggerButton = var_1

		var_1(arg_56_0.indexPanel)

		return
	end

	if arg_56_0.isShowDesc then
		arg_56_0:hideMsgBox()
	else
		pg = var_1

		local var_56_0 = var_1.CriMgr.GetInstance()
		local var_56_1 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10003

		var_56_1(var_56_0, var_1_10003)
		arg_56_0:emit(var_0_1.ON_BACK)
	end

	return
end

function var_0_1.willExit(arg_57_0)
	arg_57_0:UnOverlayPanel(arg_57_0.indexPanel, arg_57_0._tf)

	if arg_57_0.leftEventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_57_0.leftEventTrigger)
	end

	if arg_57_0.rightEventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_57_0.rightEventTrigger)
	end

	setParent = var_1

	var_1(arg_57_0.sortBtn.parent, arg_57_0._tf)

	if arg_57_0.obtainWayPage then
		local var_57_0 = arg_57_0.obtainWayPage

		var_1.Destroy(var_57_0)
	end

	arg_57_0.obtainWayPage = nil

	return
end

return var_0_1
