class = var_0_10000

local var_0_0 = "IslandShipDressUpPageNew"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

var_0_1.CHANGE_SKIN = "IslandShipDressUpPage:CHANGE_SKIN"

function var_0_1.getUIName(arg_1_0)
	return "IslandShipDressUI"
end

local var_0_2 = {}

IslandShipDressHelperNew = var_0_0
var_0_2[1] = var_0_0.DressType.Hair
IslandShipDressHelperNew = var_2
var_0_2[2] = var_2.DressType.Face
IslandShipDressHelperNew = var_2
var_0_2[3] = var_2.DressType.Body
IslandShipDressHelperNew = var_2
var_0_2[5] = var_2.DressType.BackDecorate
IslandShipDressHelperNew = var_2
var_0_2[6] = var_2.DressType.Flotage
IslandShipDressHelperNew = var_2
var_0_2[7] = var_2.DressType.Footprint
var_0_1.SORT_DEFAULT = 1
var_0_1.SORT_RARITY = 2
var_0_1.SORT_CANSEND = 3
var_0_1.SORT_LIST = {
	var_0_1.SORT_DEFAULT,
	var_0_1.SORT_RARITY,
	var_0_1.SORT_CANSEND
}

local var_0_3 = {}
local var_0_4 = var_0_1.SORT_DEFAULT

i18n = var_0_10004
var_0_3[var_0_4] = var_0_10004("word_default")

local var_0_5 = var_0_1.SORT_RARITY

i18n = var_4
var_0_3[var_0_5] = var_4("word_rarity")

local var_0_6 = var_0_1.SORT_CANSEND

i18n = var_4
var_0_3[var_0_6] = var_4("island_word_give")
var_0_1.SORTCN = var_0_3

function var_0_1.Sort2CN(arg_2_0)
	return var_0_1.SORTCN[arg_2_0]
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rightPanel = var_1.Find(var_3_0, "adapt/right_panel")

	local var_3_1 = arg_3_0.rightPanel

	arg_3_0.togglePanel = var_1.Find(var_3_1, "toggles/select_toggles")

	local var_3_2 = arg_3_0._tf

	arg_3_0.saveBtn = var_1.Find(var_3_2, "adapt/save")

	local var_3_3 = arg_3_0._tf

	arg_3_0.restBtn = var_1.Find(var_3_3, "adapt/reset")
	setText = var_1

	local var_3_4 = arg_3_0.saveBtn
	local var_3_5 = var_3.Find(var_3_4, "Text")

	i18n = var_4

	var_1(var_3_5, var_4("word_save"))

	setText = var_1

	local var_3_6 = arg_3_0.restBtn
	local var_3_7 = var_3.Find(var_3_6, "Text")

	i18n = var_4

	var_1(var_3_7, var_4("island_word_reset"))

	local var_3_8 = {}
	local var_3_9 = arg_3_0.togglePanel

	var_3_8[1] = var_2.Find(var_3_9, "hair")

	local var_3_10 = arg_3_0.togglePanel

	var_3_8[2] = var_2.Find(var_3_10, "face")

	local var_3_11 = arg_3_0.togglePanel

	var_3_8[3] = var_2.Find(var_3_11, "body")

	local var_3_12 = arg_3_0.togglePanel

	var_3_8[4] = var_2.Find(var_3_12, "skin")

	local var_3_13 = arg_3_0.togglePanel

	var_3_8[5] = var_2.Find(var_3_13, "wing")

	local var_3_14 = arg_3_0.togglePanel

	var_3_8[6] = var_2.Find(var_3_14, "trailing")

	local var_3_15 = arg_3_0.togglePanel

	var_3_8[7] = var_2.Find(var_3_15, "footprint")
	arg_3_0.toggles = var_3_8
	arg_3_0.dressCards = {}
	arg_3_0.skinCards = {}

	local var_3_16 = arg_3_0.rightPanel

	arg_3_0.dressTF = var_1.Find(var_3_16, "dress")

	local var_3_17 = arg_3_0.rightPanel

	arg_3_0.skinTF = var_1.Find(var_3_17, "skin")

	local var_3_18 = arg_3_0.dressTF

	arg_3_0.dressRectTF = var_1.Find(var_3_18, "dress_container")

	local var_3_19 = arg_3_0.dressTF
	local var_3_20 = var_1.Find(var_3_19, "dress_container/dress")

	arg_3_0.dressRect = var_1.GetComponent(var_3_20, "LScrollRect")

	local var_3_21 = arg_3_0.dressTF

	arg_3_0.dressEmpty = var_1.Find(var_3_21, "dressEmpty")

	local var_3_22 = arg_3_0.dressEmpty

	arg_3_0.dressEmptyTips = var_1.Find(var_3_22, "layout/empty_tips")
	arg_3_0.dressList = {}

	function arg_3_0.dressRect.onInitItem(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnDressInitItem(var_4_0, arg_4_0)

		return
	end

	function arg_3_0.dressRect.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.OnDressUpdateItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	local var_3_23 = arg_3_0.skinTF
	local var_3_24 = var_1.Find(var_3_23, "dress_container/dress")

	arg_3_0.skinRect = var_1.GetComponent(var_3_24, "LScrollRect")

	local var_3_25 = arg_3_0.skinTF

	arg_3_0.skinRectTF = var_1.Find(var_3_25, "dress_container")

	local var_3_26 = arg_3_0.skinTF

	arg_3_0.skinEmpty = var_1.Find(var_3_26, "skinEmpty")

	local var_3_27 = arg_3_0.skinEmpty

	arg_3_0.skinEmptyTips = var_1.Find(var_3_27, "layout/empty_tips")

	function arg_3_0.skinRect.onInitItem(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.OnSkinInitItem(var_6_0, arg_6_0)

		return
	end

	function arg_3_0.skinRect.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0

		var_2.OnSkinUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	local var_3_28 = arg_3_0.dressTF

	arg_3_0.sortBtn = var_1.Find(var_3_28, "order")

	local var_3_29 = arg_3_0.sortBtn

	arg_3_0.orderBtn = var_1.Find(var_3_29, "icon")

	local var_3_30 = arg_3_0.sortBtn
	local var_3_31 = var_1.Find(var_3_30, "Text_1")
	local var_3_32 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_3_0.orderTxt = var_3_32(var_3_31, var_4(var_6))
	IslandShipDressUpSortPage = var_1
	arg_3_0.sortPage = var_1.New(arg_3_0._tf)

	local var_3_33 = arg_3_0._tf

	arg_3_0.dressUpConfireBtn = var_1.Find(var_3_33, "adapt/confire")

	local var_3_34 = arg_3_0._tf

	arg_3_0.dressUpConfireText = var_1.Find(var_3_34, "adapt/confire/Text")
	setText = var_1

	local var_3_35 = arg_3_0.dressUpConfireText

	i18n = var_4

	var_1(var_3_35, var_4("island_dress_initial_makesure"))

	local var_3_36 = arg_3_0._tf

	arg_3_0.colorList = var_1.Find(var_3_36, "adapt/left_color_panel/colorList")

	local var_3_37 = arg_3_0._tf

	arg_3_0.colorItem = var_1.Find(var_3_37, "adapt/left_color_panel/colorList/item")

	local var_3_38 = arg_3_0._tf

	arg_3_0.color_listPanel = var_1.Find(var_3_38, "adapt/left_color_panel")

	local var_3_39 = arg_3_0._tf

	arg_3_0.color_bg_unlock = var_1.Find(var_3_39, "adapt/left_color_panel/bg1")

	local var_3_40 = arg_3_0._tf

	arg_3_0.color_bg_locked = var_1.Find(var_3_40, "adapt/left_color_panel/bglocked")

	local var_3_41 = arg_3_0.color_bg_locked

	arg_3_0.color_lockedBtn = var_1.Find(var_3_41, "unlockedBtn")

	local var_3_42 = arg_3_0.color_bg_locked

	arg_3_0.color_cost_item_icon = var_1.Find(var_3_42, "itemcost")

	local var_3_43 = arg_3_0.color_bg_locked

	arg_3_0.color_cost_item_count = var_1.Find(var_3_43, "cost_num")
	setActive = var_1

	var_1(arg_3_0.sortBtn, false)

	setText = var_1

	local var_3_44 = arg_3_0.color_bg_locked
	local var_3_45 = var_3.Find(var_3_44, "tips")

	i18n = var_4

	var_1(var_3_45, var_4("island_dresscolorunlock_tips"))

	setText = var_1

	local var_3_46 = arg_3_0.color_lockedBtn
	local var_3_47 = var_3.Find(var_3_46, "Text")

	i18n = var_4

	var_1(var_3_47, var_4("island_dresscolorunlock"))

	UIItemList = var_1
	arg_3_0.colorItemUIList = var_1.New(arg_3_0.colorList, arg_3_0.colorItem)

	local var_3_48 = arg_3_0._tf

	arg_3_0.hatTF = var_1.Find(var_3_48, "adapt/btns/hat")

	local var_3_49 = arg_3_0.hatTF

	arg_3_0.hatOn = var_1.Find(var_3_49, "hatOn")

	local var_3_50 = arg_3_0.hatTF

	arg_3_0.hatOff = var_1.Find(var_3_50, "hatOff")

	local var_3_51 = arg_3_0._tf

	arg_3_0.morphTF = var_1.Find(var_3_51, "adapt/btns/morph")

	local var_3_53

	if arg_3_0.morphTF then
		local var_3_52 = arg_3_0.morphTF

		var_3_53 = var_1.Find(var_3_52, "morphBtn")
	end

	arg_3_0.morphBtn = var_3_53

	local var_3_54 = arg_3_0._tf

	arg_3_0.morphBlocker = var_1.Find(var_3_54, "adapt/morph_blocker")
	setActive = var_1

	var_1(arg_3_0.morphBlocker, false)

	IslandShipDressDescBox = var_1
	arg_3_0.dressDetailPopup = var_1.New(arg_3_0._tf, arg_3_0.event, arg_3_0.contextData)

	return
end

function var_0_1.CheckDressIsExclusive(arg_8_0, arg_8_1)
	pg = var_1_10002

	if var_1_10002.island_dress_template[arg_8_1].exclusive_skin ~= "" then
		ipairs = var_1_10004

		for iter_8_0, iter_8_1 in var_1_10004(var_3) do
			if iter_8_1 == arg_8_0.curSkinId then
				return false, true
			end
		end
	end

	local var_8_0 = var_2.exclusive_default_skin
	local var_8_1 = arg_8_0.curSkinId == nil or arg_8_0.curSkinId == 0

	if var_8_0 ~= "" and var_8_1 then
		ipairs = var_1_10006

		for iter_8_2, iter_8_3 in var_1_10006(var_8_0) do
			if iter_8_3 == arg_8_0.shipId then
				return true, false
			end
		end
	end

	return false, false
end

function var_0_1.ClickDressCardItem(arg_9_0, arg_9_1)
	if arg_9_0.shipId ~= 0 then
		if arg_9_1.needRedDot then
			local var_9_0 = {}

			table = var_1_10003

			var_1_10003.insert(var_9_0, arg_9_1.id)

			pg = var_1_10003
			var_1_10005 = var_1_10003.m02
			var_1_10003 = var_1_10003.sendNotification
			GAME = var_6

			var_1_10003(var_1_10005, var_6.ISLAND_SEND_ROLE_DRESS_READ, {
				dress_List = var_9_0
			})
		end

		local var_9_1 = arg_9_0
		local var_9_2

		var_9_2, var_1_10003 = arg_9_0.CheckDressIsExclusive(var_9_1, arg_9_1.id)

		if var_1_10003 or var_9_2 then
			pg = var_9_1

			local var_9_3 = var_9_1.island_dress_template[arg_9_1.id]

			if var_9_2 then
				pg = var_1_10005

				local var_9_4 = var_1_10005.TipsMgr.GetInstance()

				var_1_10005 = var_1_10005.ShowTips
				i18n = var_1_10008

				var_1_10005(var_9_4, var_1_10008("island_dress_mutually_exclusive1", var_9_3.name))

				return
			else
				pg = var_1_10005

				local var_9_5 = var_1_10005.TipsMgr.GetInstance()

				var_1_10005 = var_1_10005.ShowTips
				i18n = var_1_10008

				var_1_10005(var_9_5, var_1_10008("island_dress_mutually_exclusive1", var_9_3.name))

				return
			end
		end

		local var_9_6 = arg_9_0.curShipDressTypeDataDic[arg_9_0.dressType]

		var_1_10005 = var_4.CheckIsEqualByShipIdAndDressId

		local var_9_7

		if not arg_9_1.holdedShipId then
			var_9_7 = 0
		end

		if var_1_10005(var_9_6, var_9_7, arg_9_1.id) then
			var_4:SetShipAndDressId(nil, nil)
		else
			local var_9_8 = var_4

			var_1_10005 = var_4.SetShipAndDressId

			local var_9_9

			if not arg_9_1.holdedShipId then
				var_9_9 = 0
			end

			var_1_10005(var_9_8, var_9_9, arg_9_1.id)
		end

		local var_9_10 = arg_9_0.shipDressHelper

		var_1_10005 = var_1_10005.ChangeDressByType

		local var_9_11 = arg_9_0.dressType
		local var_9_12 = {
			colorId = 0
		}
		local var_9_13

		if not var_4.dress_id then
			var_9_13 = 0
		end

		var_9_12.id = var_9_13

		var_1_10005(var_9_10, var_9_11, var_9_12)

		var_1_10005 = #arg_9_0.dressList

		local var_9_14 = arg_9_0.dressRect

		var_6.SetTotalCount(var_9_14, var_1_10005)

		return
	end

	if arg_9_1.needRedDot then
		local var_9_15 = {}

		table = var_1_10003

		var_1_10003.insert(var_9_15, arg_9_1.id)

		pg = var_1_10003
		var_1_10005 = var_1_10003.m02
		var_1_10003 = var_1_10003.sendNotification
		GAME = var_6

		var_1_10003(var_1_10005, var_6.ISLAND_SEND_COMMANDER_DRESS_READ, {
			dress_List = var_9_15
		})
	end

	local var_9_16 = arg_9_1.id

	table = var_1_10003

	local var_9_17 = var_1_10003.contains

	IslandShipDressHelperNew = var_1_10005

	local var_9_18 = var_9_17(var_1_10005.CommanderCustom, arg_9_0.dressType)

	if arg_9_0.curDressTypeDataDic[arg_9_0.dressType] == var_9_16 then
		if var_9_18 then
			return
		else
			var_9_16 = 0
		end
	end

	local var_9_19 = arg_9_0.dressType

	IslandShipDressHelperNew = var_5

	if var_9_19 == var_5.DressType.Body then
		local var_9_20 = arg_9_0.dressUpAgency

		if var_4.GetTwinCurId(var_9_20, var_9_16) and var_4 ~= 0 then
			var_9_16 = var_4
		end
	end

	arg_9_0.curDressTypeDataDic[arg_9_0.dressType] = var_9_16

	local var_9_21 = (function()
		local var_10_0 = 0

		if var_9_16 ~= 0 and arg_9_0.shipId == 0 then
			local var_10_1 = arg_9_0.dressUpAgency

			var_10_0 = var_1.GetCurrentColorByDressId(var_10_1, var_9_16)
			arg_9_0.dressColorDic[var_9_16] = var_10_0
		end

		return var_10_0
	end)()
	local var_9_22 = arg_9_0.shipDressHelper

	var_6.ChangeDressByType(var_9_22, arg_9_0.dressType, {
		id = var_9_16,
		colorId = var_9_21
	})

	local var_9_23 = #arg_9_0.dressList
	local var_9_24 = arg_9_0.dressRect

	var_7.SetTotalCount(var_9_24, var_9_23)
	arg_9_0:CheckHatAutoTakeOff(var_9_16)
	arg_9_0:UpdateHatDisplay()
	arg_9_0:UpdateMorphDisplay()
	arg_9_0:UpdateColorList(true)

	return
end

function var_0_1.CheckHatAutoTakeOff(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.dressType

	IslandShipDressHelperNew = var_1_10003

	if var_11_0 == var_1_10003.DressType.Body then
		local var_11_1 = arg_11_0.dressUpAgency

		if not var_2.GetBodyHatDressId(var_11_1, arg_11_1) or var_2 == 0 then
			local var_11_2 = arg_11_0.curDressTypeDataDic

			IslandShipDressHelperNew = var_11_1
			var_11_2[var_11_1.DressType.Hat] = 0

			local var_11_3 = arg_11_0.shipDressHelper
			local var_11_4 = var_3.ChangeDressByType

			IslandShipDressHelperNew = var_1_10006

			var_11_4(var_11_3, var_1_10006.DressType.Hat, {
				id = 0,
				colorId = 0
			})
		end
	end

	return
end

function var_0_1.UpdateHatToggleDisplay(arg_12_0, arg_12_1)
	setActive = var_1_10002

	var_1_10002(arg_12_0.hatOn, not arg_12_1)

	setActive = var_1_10002

	var_1_10002(arg_12_0.hatOff, arg_12_1)

	return
end

function var_0_1.UpdateHatDisplay(arg_13_0)
	local var_13_0 = arg_13_0.dressType

	IslandShipDressHelperNew = var_1_10002

	if var_13_0 ~= var_1_10002.DressType.Body then
		setActive = var_13_0

		var_13_0(arg_13_0.hatTF, false)

		return
	end

	if not arg_13_0.curDressTypeDataDic[arg_13_0.dressType] or var_1 == 0 then
		setActive = var_2

		var_2(arg_13_0.hatTF, false)

		return
	end

	pg = var_2

	local var_13_1

	if not var_2.island_dress_template.get_id_list_by_related_dress[var_1] then
		var_13_1 = {}
	end

	if not var_13_1[1] then
		setActive = var_1_10004

		var_1_10004(arg_13_0.hatTF, false)

		return
	end

	setActive = var_1_10004

	var_1_10004(arg_13_0.hatTF, true)

	pg = var_1_10004

	local var_13_2 = var_1_10004.island_dress_template[var_3].type
	local var_13_3 = arg_13_0.dressUpAgency
	local var_13_4 = var_5.GetBodyHatIsOn(var_13_3, var_1, var_3)
	local var_13_5 = arg_13_0.shipDressHelper

	var_6.ChangeDressByType(var_13_5, var_13_2, {
		id = var_13_4 and var_3 or 0
	})

	arg_13_0.curDressTypeDataDic[var_13_2] = var_13_4 and var_3 or 0

	arg_13_0:UpdateHatToggleDisplay(var_13_4)

	pg = var_6

	if var_6.island_dress_template[var_3].takeoff_btn_is_hide == 1 then
		setActive = var_6

		var_6(arg_13_0.hatTF, false)
	end

	onButton = var_6

	var_6(arg_13_0, arg_13_0.hatOn, function()
		if arg_13_0.curDressTypeDataDic[var_13_2] ~= var_0 then
			arg_13_0.curDressTypeDataDic[var_13_2] = var_0

			local var_14_0 = arg_13_0.shipDressHelper

			var_0.ChangeDressByType(var_14_0, var_13_2, {
				id = var_0
			})

			local var_14_1 = arg_13_0

			var_0.UpdateHatToggleDisplay(var_14_1, true)
		end

		return
	end)

	onButton = var_6

	var_6(arg_13_0, arg_13_0.hatOff, function()
		if arg_13_0.curDressTypeDataDic[var_13_2] ~= 0 then
			arg_13_0.curDressTypeDataDic[var_13_2] = 0

			local var_15_0 = arg_13_0.shipDressHelper

			var_0.ChangeDressByType(var_15_0, var_13_2, {
				id = 0
			})

			local var_15_1 = arg_13_0

			var_0.UpdateHatToggleDisplay(var_15_1, false)
		end

		return
	end)

	return
end

function var_0_1.OnDressInitItem(arg_16_0, arg_16_1)
	IslandDressCard = var_1_10002

	local var_16_0 = var_1_10002.New(arg_16_1)

	arg_16_0.dressCards[arg_16_1] = var_16_0

	return
end

function var_0_1.UpdateMorphDisplay(arg_17_0)
	local var_17_0 = arg_17_0.dressType

	IslandShipDressHelperNew = var_1_10002

	if var_17_0 ~= var_1_10002.DressType.Body then
		setActive = var_17_0

		var_17_0(arg_17_0.morphTF, false)

		return
	end

	if not arg_17_0.curDressTypeDataDic[arg_17_0.dressType] or var_1 == 0 then
		setActive = var_2

		var_2(arg_17_0.morphTF, false)

		return
	end

	local var_17_1 = 0

	pg = var_1_10003

	if var_1_10003.island_dress_template[var_1].cloth_related and var_3 ~= 0 then
		var_17_1 = var_3
	end

	if var_17_1 == 0 then
		setActive = var_1_10004

		var_1_10004(arg_17_0.morphTF, false)

		return
	end

	setActive = var_1_10004

	var_1_10004(arg_17_0.morphTF, true)

	onButton = var_1_10004

	var_1_10004(arg_17_0, arg_17_0.morphBtn, function()
		local var_18_0 = arg_17_0

		var_0.DoMorphSwitch(var_18_0, var_0, var_17_1)

		return
	end)

	return
end

function var_0_1.DoMorphSwitch(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.morphing then
		return
	end

	arg_19_0:SetMorphBlock(true)

	if not arg_19_0.shipDressHelper then
		arg_19_0:DoSwitch(arg_19_2, function()
			local var_20_0 = arg_19_0

			var_0.SetMorphBlock(var_20_0, false)

			return
		end)

		return
	end

	local var_19_0 = arg_19_0.shipDressHelper

	var_3.DoMorphSwitch(var_19_0, arg_19_1, arg_19_2, function()
		local var_21_0 = arg_19_0

		var_0.DoSwitch(var_21_0, arg_19_2, function()
			local var_22_0 = arg_19_0

			var_0.SetMorphBlock(var_22_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_1.SetMorphBlock(arg_23_0, arg_23_1)
	arg_23_0.morphing = arg_23_1
	setActive = var_1_10002

	var_1_10002(arg_23_0.morphBlocker, arg_23_1)

	return
end

function var_0_1.CanEsc(arg_24_0)
	if arg_24_0.morphing then
		return false
	end

	return true
end

function var_0_1.DoSwitch(arg_25_0, arg_25_1, arg_25_2)
	IslandShipDressHelperNew = var_1_10003

	local var_25_0 = var_1_10003.DressType.Body

	arg_25_0.curDressTypeDataDic[var_25_0] = arg_25_1

	local var_25_1 = arg_25_0.shipDressHelper

	var_4.ChangeDressByType(var_25_1, var_25_0, {
		colorId = 0,
		id = arg_25_1
	}, arg_25_2)
	arg_25_0:CheckHatAutoTakeOff(arg_25_1)
	arg_25_0:UpdateHatDisplay()
	arg_25_0:UpdateMorphDisplay()

	return
end

function var_0_1.AddLongPressListeners(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	arg_26_0.isLongPress = false

	local function var_26_0()
		if arg_26_0.isLongPress then
			local var_27_0 = arg_26_0.dressDetailPopup

			var_0.ExecuteAction(var_27_0, "Hide")

			arg_26_0.isLongPress = false
		end

		return
	end

	GetOrAddComponent = var_1_10006

	local var_26_1 = arg_26_2

	typeof = var_1_10009
	LongPressTrigger = var_1_10011

	local var_26_2 = var_1_10006(var_26_1, var_1_10009(var_1_10011)).onClick

	var_7.RemoveAllListeners(var_26_2)

	local var_26_3 = var_6.onClick

	var_7.AddListener(var_26_3, function()
		if arg_26_0.isLongPress then
			var_26_0()

			return
		end

		arg_26_4()

		return
	end)

	local var_26_4 = var_6.onLongPressed

	var_7.RemoveAllListeners(var_26_4)

	local var_26_5 = var_6.onLongPressed

	var_7.AddListener(var_26_5, function()
		arg_26_0.isLongPress = true

		local var_29_0 = arg_26_0._tf
		local var_29_1 = var_0.InverseTransformPoint

		tf = var_2_10003

		local var_29_2 = var_29_1(var_29_0, var_2_10003(arg_26_2).position)

		Vector2 = var_1

		local var_29_3 = var_29_2.x

		tf = var_2_10004

		local var_29_4 = var_29_3 - var_2_10004(arg_26_2).sizeDelta.x / 2
		local var_29_5 = var_29_2.y

		tf = var_5

		local var_29_6 = var_1(var_29_4, var_29_5 + var_5(arg_26_2).sizeDelta.y / 2)
		local var_29_7 = arg_26_0.dressDetailPopup

		var_1.ExecuteAction(var_29_7, "Show", arg_26_1, arg_26_3, var_29_6)

		return
	end)

	local var_26_6 = var_6.onReleased

	var_7.RemoveAllListeners(var_26_6)

	local var_26_7 = var_6.onReleased

	var_7.AddListener(var_26_7, var_26_0)

	return
end

function var_0_1.OnDressUpdateItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0

	if not arg_30_0.dressCards[arg_30_2] then
		var_1_10006 = arg_30_0

		arg_30_0.OnDressInitItem(var_1_10006, arg_30_2)

		var_30_0 = arg_30_0.dressCards[arg_30_2]
	end

	local var_30_1 = arg_30_0.dressList[arg_30_1 + 1]

	setActive = var_5

	var_5(var_30_0.canSendTF, false)

	local var_30_2 = var_30_1.ownCount ~= nil

	setActive = var_1_10006

	var_1_10006(var_30_0.ownNumTF, var_30_2)

	if var_30_2 then
		setText = var_1_10006

		var_1_10006(var_30_0.ownNumText, "×" .. var_30_1.ownCount)
	end

	local var_30_3 = var_30_1.holdedShipId ~= nil

	setActive = var_30_4

	var_30_4(var_30_0.shipHoldTF, var_30_3)

	local var_30_4

	if var_30_3 then
		IslandShip = var_30_4
		var_30_4 = var_30_4.StaticGetPrefab(var_30_1.holdedShipId)
		GetImageSpriteFromAtlasAsync = var_8

		var_8("island/IslandShipIcon/" .. var_30_4, "", var_30_0.shipIcon)
	end

	setActive = var_30_4

	var_30_4(var_30_0.redDot, var_30_1.needRedDot)

	local var_30_5
	local var_30_6 = var_30_1.id

	tf = var_9

	local var_30_7 = var_9(arg_30_2)
	local var_30_8 = arg_30_0
	local var_30_9 = arg_30_0.AddLongPressListeners

	IslandShipDressDescBox = var_1_10013

	var_30_9(var_30_8, var_1_10013.TYPE.DRESS, arg_30_2, var_30_6, function()
		local var_31_0 = arg_30_0

		var_0.ClickDressCardItem(var_31_0, var_30_1)

		return
	end)

	local var_30_10 = false

	if arg_30_0.shipId == 0 then
		var_30_10 = (arg_30_0.curDressTypeDataDic[arg_30_0.dressType] ~= 0 and var_11 or nil) == var_30_1.id or var_12 == var_30_1:getConfig("cloth_related")
		setActive = var_13

		var_13(var_30_0.exclusionTF, false)
	else
		local var_30_11, var_30_12 = arg_30_0:CheckDressIsExclusive(var_30_1.id)
		local var_30_13 = var_30_11 or var_30_12

		setActive = var_14

		var_14(var_30_0.exclusionTF, var_30_13)

		local var_30_14 = arg_30_0.curShipDressTypeDataDic[arg_30_0.dressType]
		local var_30_15 = var_14.CheckIsEqualByShipIdAndDressId
		local var_30_16

		if not var_30_1.holdedShipId then
			var_30_16 = 0
		end

		var_30_10 = var_30_15(var_30_14, var_30_16, var_30_1.id)
	end

	var_30_0:Update(var_30_6, var_30_10)

	return
end

function var_0_1.OnSkinInitItem(arg_32_0, arg_32_1)
	IslandSkinCard = var_1_10002

	local var_32_0 = var_1_10002.New(arg_32_1)

	arg_32_0.skinCards[arg_32_1] = var_32_0

	return
end

function var_0_1.OnSkinUpdateItem(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0.skinCards[arg_33_2] then
		var_1_10006 = arg_33_0

		arg_33_0.OnSkinInitItem(var_1_10006, arg_33_2)

		var_33_0 = arg_33_0.skinCards[arg_33_2]
	end

	local var_33_1 = arg_33_0.skinList[arg_33_1 + 1]

	tf = var_5

	local var_33_2 = var_5(arg_33_2)

	setActive = var_1_10006

	var_1_10006(var_33_2:Find("changeColor"), true)

	local var_33_3 = arg_33_0.curSkinId ~= 0 and var_6 or nil

	var_33_0:Update(var_33_1, var_33_3)

	local var_33_4 = arg_33_0
	local var_33_5 = arg_33_0.AddLongPressListeners

	IslandShipDressDescBox = var_11

	var_33_5(var_33_4, var_11.TYPE.SKIN, arg_33_2, var_33_1, function()
		local var_34_0 = arg_33_0

		var_0.ClickSkinCardItem(var_34_0, var_33_1)

		return
	end)

	return
end

function var_0_1.ChangeModelBySkinAndSkinColor(arg_35_0)
	local var_35_0 = arg_35_0.characterAgency
	local var_35_1 = var_1.GetShipById(var_35_0, arg_35_0.shipId)
	local var_35_2 = {}
	local var_35_3 = {}

	IslandShipDressHelperNew = var_4
	var_35_3[1] = var_4.DressType.BackDecorate
	IslandShipDressHelperNew = var_4
	var_35_3[2] = var_4.DressType.Flotage
	IslandShipDressHelperNew = var_4
	var_35_3[3] = var_4.DressType.Footprint
	ipairs = var_4

	for iter_35_0, iter_35_1 in var_4(var_35_3) do
		if arg_35_0.curShipDressTypeDataDic[iter_35_1] and var_9.dress_id and var_9.dress_id ~= 0 then
			if arg_35_0.curSkinId ~= 0 then
				pg = var_1_10010

				local var_35_4

				if var_1_10010.island_dress_template[var_9.dress_id].exclusive_skin ~= "" or not {} then
					var_35_4 = var_1_10010
				end

				ipairs = var_1_10012

				for iter_35_2, iter_35_3 in var_1_10012(var_35_4) do
					if iter_35_3 == arg_35_0.curSkinId then
						table = var_17

						var_17.insert(var_35_2, var_9.dress_id)
						var_9:SetShipAndDressId(nil, nil)
					end
				end
			else
				pg = var_1_10010

				local var_35_5

				if var_1_10010.island_dress_template[var_9.dress_id].exclusive_default_skin ~= "" or not {} then
					var_35_5 = var_1_10010
				end

				ipairs = var_1_10012

				for iter_35_4, iter_35_5 in var_1_10012(var_35_5) do
					if iter_35_5 == arg_35_0.shipId then
						table = var_17

						var_17.insert(var_35_2, var_9.dress_id)
						var_9:SetShipAndDressId(nil, nil)
					end
				end
			end
		end
	end

	local var_35_6 = #var_35_2

	if 0 < var_35_6 then
		local var_35_7 = ""

		ipairs = var_5

		for iter_35_6, iter_35_7 in var_5(var_35_2) do
			pg = var_1_10010
			var_1_10010 = var_1_10010.island_dress_template[iter_35_7].name

			if iter_35_6 > 1 then
				var_1_10010 = "," .. var_1_10010
			end

			var_35_7 = var_35_7 .. var_1_10010
		end

		pg = var_5
		iter_35_0 = var_5.TipsMgr.GetInstance()

		local var_35_8 = var_5.ShowTips

		i18n = iter_35_6

		var_35_8(iter_35_0, iter_35_6("island_dress_mutually_exclusive", var_35_7))
	end

	local var_35_9 = arg_35_0
	local var_35_10 = arg_35_0.emit

	IslandShipMainPage = iter_35_0

	var_35_10(var_35_9, iter_35_0.CLEAR_ITEM_ANIMATOR)

	local var_35_11 = var_35_1:GetModelBySkinAndColorId(arg_35_0.curSkinId, arg_35_0.curskinColorId)

	if #var_35_2 > 0 then
		local var_35_12 = arg_35_0.shipDressHelper

		var_5.ChangeModelTransfromByUnitIdAndChangeDress(var_35_12, var_35_11, var_35_2, nil, nil, true)
	else
		local var_35_13 = arg_35_0.shipDressHelper

		var_5.ChangeModelTransfromByUnitId(var_35_13, var_35_11, nil, true)
	end

	return
end

function var_0_1.ClickSkinCardItem(arg_36_0, arg_36_1)
	if arg_36_1 == arg_36_0.curSkinId then
		arg_36_0.curSkinId = 0
	else
		arg_36_0.curSkinId = arg_36_1
	end

	arg_36_0:UpdateSkinList()

	if arg_36_0.curSkinId ~= 0 then
		local var_36_0 = arg_36_0.characterAgency

		arg_36_0.curskinColorId = var_2.GetCurrentSkinColorByShipId(var_36_0, arg_36_0.shipId, arg_36_0.curSkinId)
	end

	arg_36_0:ChangeModelBySkinAndSkinColor()
	arg_36_0:UpdateColorList()
	arg_36_0:UpdateHatDisplay()

	return
end

function var_0_1.ClearSkinSelected(arg_37_0, arg_37_1)
	return
end

function var_0_1.AddListeners(arg_38_0)
	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.AddListener

	GAME = var_1_10004

	var_38_1(var_38_0, var_1_10004.ISLAND_CHANGE_ROLE_DRESS_DONE, arg_38_0.OnChangeRoleDressDone)

	local var_38_2 = arg_38_0
	local var_38_3 = arg_38_0.AddListener

	GAME = var_4

	var_38_3(var_38_2, var_4.ISLAND_SEND_ROLE_DRESS_READ_DONE, arg_38_0.OnSendRoleDressReadDone)

	local var_38_4 = arg_38_0
	local var_38_5 = arg_38_0.AddListener

	GAME = var_4

	var_38_5(var_38_4, var_4.ISLAND_SEND_COMMANDER_DRESS_READ_DONE, arg_38_0.OnSendRoleDressReadDone)

	local var_38_6 = arg_38_0
	local var_38_7 = arg_38_0.AddListener

	GAME = var_4

	var_38_7(var_38_6, var_4.ISLAND_BUY_ROLE_SKIN_COLOR_DONE, arg_38_0.OnBuyRoleSkinColorDone)

	local var_38_8 = arg_38_0
	local var_38_9 = arg_38_0.AddListener

	GAME = var_4

	var_38_9(var_38_8, var_4.ISLAND_BUY_ROLE_DRESS_COLOR_DONE, arg_38_0.OnBuyRoleDressColorDone)

	local var_38_10 = arg_38_0
	local var_38_11 = arg_38_0.AddListener

	GAME = var_4

	var_38_11(var_38_10, var_4.ISLAND_SHOP_OP_DONE, arg_38_0.GetBuySkindDone)

	return
end

function var_0_1.RemoveListeners(arg_39_0)
	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.RemoveListener

	GAME = var_1_10004

	var_39_1(var_39_0, var_1_10004.ISLAND_CHANGE_ROLE_DRESS_DONE, arg_39_0.OnChangeRoleDressDone)

	local var_39_2 = arg_39_0
	local var_39_3 = arg_39_0.RemoveListener

	GAME = var_4

	var_39_3(var_39_2, var_4.ISLAND_SEND_ROLE_DRESS_READ_DONE, arg_39_0.OnSendRoleDressReadDone)

	local var_39_4 = arg_39_0
	local var_39_5 = arg_39_0.RemoveListener

	GAME = var_4

	var_39_5(var_39_4, var_4.ISLAND_SEND_COMMANDER_DRESS_READ_DONE, arg_39_0.OnSendRoleDressReadDone)

	local var_39_6 = arg_39_0
	local var_39_7 = arg_39_0.RemoveListener

	GAME = var_4

	var_39_7(var_39_6, var_4.ISLAND_BUY_ROLE_SKIN_COLOR_DONE, arg_39_0.OnBuyRoleSkinColorDone)

	local var_39_8 = arg_39_0
	local var_39_9 = arg_39_0.RemoveListener

	GAME = var_4

	var_39_9(var_39_8, var_4.ISLAND_BUY_ROLE_DRESS_COLOR_DONE, arg_39_0.OnBuyRoleDressColorDone)

	local var_39_10 = arg_39_0
	local var_39_11 = arg_39_0.RemoveListener

	GAME = var_4

	var_39_11(var_39_10, var_4.ISLAND_SHOP_OP_DONE, arg_39_0.GetBuySkindDone)

	return
end

function var_0_1.OnClosePage(arg_40_0, arg_40_1)
	return
end

function var_0_1.OnInit(arg_41_0)
	onButton = var_1_10001

	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.saveBtn

	local function var_41_2()
		local var_42_0 = arg_41_0

		if not var_0.CheckDressIsDirty(var_42_0) then
			local var_42_2

			if arg_41_0.changeDressType then
				pg = var_42_2

				local var_42_1 = var_42_2.m02

				var_42_2 = var_42_2.sendNotification
				GAME = var_2_10003
				var_2_10003 = var_2_10003.ISLAND_CHEATER_CHANGE_VIEW_DRESSID

				local var_42_3 = {
					type = arg_41_0.changeDressType
				}

				PlayRoomTools = var_5
				var_42_3.game_type = var_5.GetGameTypeID()
				var_42_3.ship_id = arg_41_0.shipId

				var_42_2(var_42_1, var_2_10003, var_42_3)

				pg = var_42_2

				local var_42_4 = var_42_2.m02

				var_42_2 = var_42_2.sendNotification
				GAME = var_2_10003

				var_42_2(var_42_4, var_2_10003.PLAY_ROOM_REFRESH_ROOM_INFO)
			end

			pg = var_42_2

			local var_42_5 = var_42_2.TipsMgr.GetInstance()
			local var_42_6 = var_0.ShowTips

			i18n = var_2_10003

			var_42_6(var_42_5, var_2_10003("island_dress_save1"))

			return
		end

		local var_42_7 = arg_41_0

		var_0.SaveDressUpDataHandle(var_42_7)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_41_0, var_41_1, var_41_2, var_1_10006)

	onButton = var_1_10001

	local var_41_3 = arg_41_0
	local var_41_4 = arg_41_0.dressUpConfireBtn

	local function var_41_5()
		local var_43_0 = arg_41_0
		local var_43_1 = var_0.ShowMsgBox
		local var_43_2 = {}

		IslandMsgBox = var_2_10004
		var_43_2.type = var_2_10004.TYPE_COMMON
		i18n = var_4
		var_43_2.content = var_4("island_dressup_tip")

		function var_43_2.onYes()
			local var_44_0 = arg_41_0

			var_0.SaveDressUpDataHandle(var_44_0)

			return
		end

		function var_43_2.onNo()
			return
		end

		var_43_1(var_43_0, var_43_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_41_3, var_41_4, var_41_5, var_1_10006)

	onButton = var_1_10001

	local var_41_6 = arg_41_0
	local var_41_7 = arg_41_0.restBtn

	local function var_41_8()
		local var_46_0 = arg_41_0

		var_0.ResetDressUp(var_46_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_41_6, var_41_7, var_41_8, var_1_10006)

	ipairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0.toggles) do
		onToggle = var_1_10006

		local var_41_9 = arg_41_0
		local var_41_10 = iter_41_1

		local function var_41_11(arg_47_0)
			if arg_47_0 then
				local var_47_0 = arg_41_0

				var_1.SwitchPage(var_47_0, iter_41_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_41_9, var_41_10, var_41_11, var_1_10011)
	end

	onButton = var_1

	local var_41_12 = arg_41_0
	local var_41_13 = arg_41_0.sortBtn

	local function var_41_14()
		local var_48_0 = arg_41_0.sortPage

		var_0.ExecuteAction(var_48_0, "Show", arg_41_0.indexData, function(arg_49_0)
			local var_49_0 = arg_41_0

			var_1.OnSort(var_49_0, arg_49_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_41_12, var_41_13, var_41_14, var_1_10006)

	onButton = var_1

	local var_41_15 = arg_41_0
	local var_41_16 = arg_41_0.orderBtn

	local function var_41_17()
		local var_50_0 = 1 - arg_41_0.indexData.order
		local var_50_1 = arg_41_0

		var_1.OnOrder(var_50_1, var_50_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_41_15, var_41_16, var_41_17, var_1_10006)

	return
end

function var_0_1.OnSort(arg_51_0, arg_51_1)
	arg_51_0.indexData.sortKey = arg_51_1

	arg_51_0:UpdateOrderTxt()
	arg_51_0:UpdateDressUpList()

	return
end

function var_0_1.OnOrder(arg_52_0, arg_52_1)
	arg_52_0.indexData.order = arg_52_1

	local var_52_0 = arg_52_0.orderBtn

	Vector3 = var_1_10003
	var_52_0.localScale = var_1_10003(1, arg_52_1 == 1 and 1 or -1, 1)

	arg_52_0:UpdateDressUpList()

	return
end

function var_0_1.UpdateOrderTxt(arg_53_0)
	arg_53_0.orderTxt.text = var_0_1.SORTCN[arg_53_0.indexData.sortKey]

	return
end

function var_0_1.SwitchPage(arg_54_0, arg_54_1)
	arg_54_0.currentToggleIndex = arg_54_1

	if arg_54_0.currentToggleIndex == 4 then
		setActive = var_2

		var_2(arg_54_0.dressTF, false)

		setActive = var_2

		var_2(arg_54_0.skinTF, true)

		setActive = var_2

		var_2(arg_54_0.hatTF, false)

		var_1_10004 = arg_54_0

		arg_54_0.GetSkinList(var_1_10004)

		var_1_10004 = arg_54_0

		arg_54_0.UpdateSkinList(var_1_10004)

		var_1_10004 = arg_54_0

		arg_54_0.UpdateColorList(var_1_10004)
	else
		arg_54_0.dressType = var_0_2[arg_54_0.currentToggleIndex]

		local var_54_0

		if arg_54_0.SmoothFunc then
			var_54_0 = arg_54_0.dressType
			IslandShipDressHelperNew = var_3

			if var_54_0 == var_3.DressType.BackDecorate then
				var_54_0 = arg_54_0.SmoothFunc
				Quaternion = var_1_10004

				var_54_0(var_1_10004.Euler(0, 0, 0))
			else
				var_54_0 = arg_54_0.SmoothFunc
				Quaternion = var_1_10004

				var_54_0(var_1_10004.Euler(0, 180, 0))
			end
		end

		setActive = var_54_0

		var_54_0(arg_54_0.dressTF, true)

		setActive = var_54_0

		var_54_0(arg_54_0.skinTF, false)
		arg_54_0:GetDressUpList()
		arg_54_0:UpdateDressUpList()
		arg_54_0:UpdateHatDisplay()
		arg_54_0:UpdateMorphDisplay()
		arg_54_0:UpdateOrderTxt()
		arg_54_0:UpdateColorList(true)
	end

	return
end

function var_0_1.GetDressUpList(arg_55_0)
	arg_55_0.dressList = {}

	if arg_55_0.shipId == 0 then
		ipairs = var_1
		iter_55_5 = arg_55_0.dressUpAgency

		for iter_55_0, iter_55_5 in var_1(var_3.GetHasDressByType(iter_55_5, arg_55_0.dressType)) do
			pg = var_1_10006

			if var_1_10006.island_dress_template[iter_55_5.id].is_hide ~= 1 then
				local var_55_0 = var_1_10006.quality

				table = var_1_10008
				var_1_10008 = var_1_10008.insert
				var_1_10010 = arg_55_0.dressList
				IslandDressItem = var_1_10011

				var_1_10008(var_1_10010, var_1_10011.New({
					id = iter_55_5.id,
					quality = var_55_0,
					needRedDot = iter_55_5.state == 0
				}))
			end
		end
	else
		pairs = var_1
		iter_55_5 = arg_55_0.characterAgency

		for iter_55_2, iter_55_5 in var_1(var_3.GetAllOwnDressDic(iter_55_5)) do
			if iter_55_5:getConfigTable().type == arg_55_0.dressType and iter_55_5.num > 0 and iter_55_5:getConfigTable().is_hide ~= 1 then
				pg = var_1_10006
				var_1_10006 = var_1_10006.island_dress_template[iter_55_5.id].quality
				table = var_7

				local var_55_1 = var_7.insert
				local var_55_2 = arg_55_0.dressList

				IslandDressItem = var_1_10010

				var_55_1(var_55_2, var_1_10010.New({
					id = iter_55_5.id,
					ownCount = iter_55_5.num,
					needRedDot = iter_55_5.read == 0,
					quality = var_1_10006
				}))
			end
		end

		pairs = var_1
		iter_55_5 = arg_55_0.characterAgency

		for iter_55_4, iter_55_5 in var_1(var_3.GetShipHoldedDressDic(iter_55_5)) do
			ipairs = var_1_10006

			for iter_55_6, iter_55_7 in var_1_10006(iter_55_5) do
				if iter_55_7:getConfigTable().type == arg_55_0.dressType and iter_55_7:getConfigTable().is_hide ~= 1 then
					pg = var_11

					local var_55_3 = var_11.island_dress_template[iter_55_7.dress_id].quality

					table = var_12

					local var_55_4 = var_12.insert
					local var_55_5 = arg_55_0.dressList

					IslandDressItem = var_1_10015

					var_55_4(var_55_5, var_1_10015.New({
						id = iter_55_7.dress_id,
						holdedShipId = iter_55_7.ship_id,
						quality = var_55_3
					}))
				end
			end
		end
	end

	local var_55_6

	if arg_55_0.indexData.sortKey == var_0_1.SORT_DEFAULT then
		var_55_6 = {
			function(arg_56_0)
				return arg_56_0.holdedShipId and 0 or 1
			end,
			function(arg_57_0)
				return arg_57_0.needRedDot and 0 or 1
			end,
			function(arg_58_0)
				return -arg_58_0.quality
			end,
			function(arg_59_0)
				return -arg_59_0.id
			end
		}
	end

	table = var_2

	local var_55_7 = var_2.sort
	local var_55_8 = arg_55_0.dressList

	CompareFuncs = iter_55_5

	var_55_7(var_55_8, iter_55_5(var_55_6))

	return
end

function var_0_1.GetSkinList(arg_60_0)
	if arg_60_0.shipId ~= 0 then
		arg_60_0.skinList = {}
		ipairs = var_1
		pg = var_1_10003

		local var_60_0

		if not var_1_10003.island_skin_template.get_id_list_by_ship_group[arg_60_0.shipId] then
			var_60_0 = {}
		end

		for iter_60_0, iter_60_1 in var_1(var_60_0) do
			local var_60_1 = arg_60_0.characterAgency

			if var_6.CheckSkinIsOwned(var_60_1, iter_60_1) then
				table = var_6

				var_6.insert(arg_60_0.skinList, iter_60_1)
			end
		end
	end

	return
end

function var_0_1.UpdateSkinList(arg_61_0)
	local var_61_0 = #arg_61_0.skinList

	setActive = var_1_10002

	var_1_10002(arg_61_0.skinRectTF, var_61_0 ~= 0)

	setActive = var_1_10002

	var_1_10002(arg_61_0.skinEmpty, var_61_0 == 0)

	local var_61_1 = arg_61_0.skinRect

	var_2.SetTotalCount(var_61_1, var_61_0)

	setText = var_2

	local var_61_2 = arg_61_0.skinEmptyTips

	i18n = var_5

	var_2(var_61_2, var_5("island_dress_no_item"))

	return
end

function var_0_1.UpdateDressUpList(arg_62_0)
	if arg_62_0.currentToggleIndex == 4 then
		return
	end

	local var_62_0 = #arg_62_0.dressList

	setActive = var_1_10002

	var_1_10002(arg_62_0.dressRectTF, var_62_0 ~= 0)

	setActive = var_1_10002

	var_1_10002(arg_62_0.dressEmpty, var_62_0 == 0)

	setText = var_1_10002

	local var_62_1 = arg_62_0.dressEmptyTips

	i18n = var_5

	var_1_10002(var_62_1, var_5("island_dress_no_item"))

	setActive = var_1_10002

	var_1_10002(arg_62_0.sortBtn, false)

	if var_62_0 ~= 0 then
		local var_62_2 = arg_62_0.dressRect

		var_2.SetTotalCount(var_62_2, var_62_0)
	end

	return
end

function var_0_1.OnShow(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	arg_63_0.changeDressType = arg_63_5
	arg_63_0.SmoothFunc = arg_63_4
	arg_63_0.isFirstDressUp = arg_63_2
	setActive = var_1_10006

	var_1_10006(arg_63_0.color_listPanel, false)

	setActive = var_1_10006

	var_1_10006(arg_63_0.saveBtn, not arg_63_2)

	setActive = var_1_10006

	var_1_10006(arg_63_0.restBtn, not arg_63_2)

	arg_63_0.shipDressHelper = arg_63_3
	getProxy = var_1_10006
	IslandProxy = var_8

	local var_63_0 = var_1_10006(var_8)

	arg_63_0.island = var_6.GetIsland(var_63_0)

	local var_63_1 = arg_63_0.island

	arg_63_0.characterAgency = var_6.GetCharacterAgency(var_63_1)

	local var_63_2 = arg_63_0.island

	arg_63_0.dressUpAgency = var_6.GetDressUpAgency(var_63_2)
	arg_63_0.shipId = arg_63_1
	arg_63_0.indexData = {
		order = 1,
		sortKey = var_0_1.SORT_DEFAULT
	}
	smothObj = var_6
	arg_63_0.smothObj = var_6

	arg_63_0:InitCurDressData()

	setActive = var_6

	var_6(arg_63_0.dressUpConfireBtn, arg_63_2)

	if arg_63_1 == 0 then
		setActive = var_6

		var_6(arg_63_0.toggles[4], false)

		setActive = var_6

		var_6(arg_63_0.toggles[5], not arg_63_2)

		setActive = var_6

		var_6(arg_63_0.toggles[6], not arg_63_2)

		setActive = var_6

		var_6(arg_63_0.toggles[7], not arg_63_2)

		triggerToggle = var_6

		var_6(arg_63_0.toggles[1], true)
	else
		setActive = var_6

		var_6(arg_63_0.toggles[4], true)

		triggerToggle = var_6

		var_6(arg_63_0.toggles[4], true)
	end

	if arg_63_0.changeDressType then
		ipairs = var_6
		pg = var_8

		for iter_63_0, iter_63_1 in var_6(var_8.gameset.bar_not_display_dress_type.description) do
			pairs = var_1_10011

			for iter_63_2, iter_63_3 in var_1_10011(var_0_2) do
				if iter_63_3 == iter_63_1 then
					setActive = var_1_10016

					var_1_10016(arg_63_0.toggles[iter_63_2], false)
				end
			end
		end
	end

	setActive = var_6

	var_6(arg_63_0.toggles[1], arg_63_1 == 0)

	setActive = var_6

	var_6(arg_63_0.toggles[2], arg_63_1 == 0)

	setActive = var_6

	var_6(arg_63_0.toggles[3], arg_63_1 == 0)
	arg_63_0:UpdateRightReddot()

	return
end

function var_0_1.InitCurDressData(arg_64_0)
	arg_64_0.curDressTypeDataDic = {}
	arg_64_0.curShipDressTypeDataDic = {}
	arg_64_0.dressColorDic = {}

	if arg_64_0.shipId == 0 then
		if arg_64_0.isFirstDressUp then
			IslandShipDressHelperNew = var_64_0

			local var_64_0

			if not var_64_0.CommanderCustom then
				IslandShipDressHelperNew = var_64_0
				var_64_0 = var_64_0.DressType
			end

			pairs = var_1_10002

			for iter_64_0, iter_64_1 in var_1_10002(var_64_0) do
				if arg_64_0.isFirstDressUp then
					IslandShipDressHelperNew = var_7

					local var_64_2

					if not var_7.GetInitDressByType(iter_64_1) then
						local var_64_1 = arg_64_0.dressUpAgency

						var_64_2 = var_7.GetDressByType(var_64_1, iter_64_1)
					end

					arg_64_0.curDressTypeDataDic[iter_64_1] = var_64_2

					if var_64_2 then
						local var_64_3 = arg_64_0.dressColorDic
						local var_64_4 = arg_64_0.dressUpAgency

						var_64_3[var_64_2] = var_9.GetCurrentColorByDressId(var_64_4, var_64_2)
					end
				end
			end

			if false then
				local var_64_5 = arg_64_0.characterAgency
				local var_64_6 = var_1.GetShipById(var_64_5, arg_64_0.shipId)

				arg_64_0.curSkinId = var_1.GetCurSkinId(var_64_6)

				if arg_64_0.curSkinId == 0 then
					arg_64_0.curskinColorId = 0
				else
					var_64_6 = arg_64_0.characterAgency
					arg_64_0.curskinColorId = var_2.GetCurrentSkinColorByShipId(var_64_6, arg_64_0.shipId, arg_64_0.curSkinId)
				end

				pairs = var_2
				IslandShipDressHelperNew = var_64_6

				for iter_64_2, iter_64_3 in var_2(var_64_6.ExtraDressType) do
					local var_64_7 = arg_64_0.characterAgency
					local var_64_8

					if not var_7.GetCurDressIdByShipId(var_64_7, arg_64_0.shipId, iter_64_3) then
						var_64_8 = {}
					end

					local var_64_9 = arg_64_0.curShipDressTypeDataDic

					IslandShipDressItem = var_64_7
					var_64_9[iter_64_3] = var_64_7.New(var_64_8)
				end
			end

			return
		end
	end
end

function var_0_1.CheckDressIsDirty(arg_65_0)
	if arg_65_0.shipId == 0 then
		pairs = var_1

		for iter_65_0, iter_65_1 in var_1(arg_65_0.curDressTypeDataDic) do
			local var_65_0 = arg_65_0.dressUpAgency
			local var_65_1

			if not var_6.GetDressByType(var_65_0, iter_65_0) then
				var_65_1 = 0
			end

			if var_65_1 ~= iter_65_1 then
				return true
			end

			if iter_65_1 ~= 0 then
				local var_65_2 = arg_65_0.dressUpAgency
				local var_65_3 = var_7.GetCurrentColorByDressId(var_65_2, iter_65_1)
				local var_65_4

				if not arg_65_0.dressColorDic[iter_65_1] then
					var_65_4 = 0
				end

				if var_65_3 ~= var_65_4 then
					return true
				end
			end
		end

		return false
	else
		local var_65_5 = arg_65_0.characterAgency
		local var_65_6 = var_1.GetShipById(var_65_5, arg_65_0.shipId)
		local var_65_7 = var_1.GetCurSkinId(var_65_6)
		local var_65_8 = arg_65_0.characterAgency
		local var_65_9 = var_3.GetCurrentSkinColorByShipId(var_65_8, arg_65_0.shipId, var_65_7)

		if var_65_7 ~= arg_65_0.curSkinId or var_65_9 ~= arg_65_0.curskinColorId then
			return true
		end

		pairs = var_4

		for iter_65_2, iter_65_3 in var_4(arg_65_0.curShipDressTypeDataDic) do
			local var_65_10 = arg_65_0.characterAgency
			local var_65_11

			if not var_9.GetCurDressIdByShipId(var_65_10, arg_65_0.shipId, iter_65_2) then
				var_65_11 = {}
			end

			if not iter_65_3:CheckIsEqualByShipDressItem(var_65_11) then
				return true
			end
		end

		return false
	end

	return
end

function var_0_1.ResetDressUp(arg_66_0)
	if arg_66_0.shipId == 0 then
		pairs = var_1
		IslandShipDressHelperNew = var_1_10003

		for iter_66_0, iter_66_1 in var_1(var_1_10003.DressType) do
			local var_66_0 = arg_66_0.dressUpAgency
			local var_66_1

			if not var_6.GetDressByType(var_66_0, iter_66_1) then
				var_66_1 = 0
			end

			local var_66_2 = arg_66_0.dressUpAgency
			local var_66_3 = var_7.GetCurrentColorByDressId(var_66_2, var_66_1)
			local var_66_4 = arg_66_0.curDressTypeDataDic[iter_66_1]
			local var_66_5 = arg_66_0.dressColorDic[var_66_4]

			if var_66_1 == var_66_4 and var_66_5 ~= var_66_3 then
				local var_66_6 = arg_66_0.shipDressHelper

				var_10.ChangeCommanderPartColor(var_66_6, iter_66_1, var_66_3)

				return
			end

			local var_66_7 = arg_66_0.shipDressHelper

			var_10.ChangeDressByType(var_66_7, iter_66_1, {
				id = var_66_1,
				colorId = var_66_3
			})

			arg_66_0.curDressTypeDataDic[iter_66_1] = var_66_1
			arg_66_0.dressColorDic[var_66_1] = var_66_3
		end

		arg_66_0:UpdateDressUpList()
		arg_66_0:UpdateHatDisplay()
		arg_66_0:UpdateMorphDisplay()
	else
		local var_66_8 = arg_66_0.characterAgency
		local var_66_9 = var_1.GetShipById(var_66_8, arg_66_0.shipId)

		if (function()
			local var_67_0 = var_66_9
			local var_67_1 = var_0.GetCurSkinId(var_67_0)
			local var_67_2 = arg_66_0.characterAgency
			local var_67_3 = var_1.GetCurrentSkinColorByShipId(var_67_2, arg_66_0.shipId, var_67_1)

			if var_67_1 ~= arg_66_0.curSkinId or var_67_3 ~= arg_66_0.curskinColorId then
				arg_66_0.curSkinId = var_67_1
				arg_66_0.curskinColorId = var_67_3

				return true
			end

			return false
		end)() then
			local var_66_10 = var_66_9:GetModelBySkinAndColorId(arg_66_0.curSkinId, arg_66_0.curskinColorId)
			local var_66_11 = arg_66_0.shipDressHelper

			var_4.ChangeModelTransfromByUnitId(var_66_11, var_66_10)
			arg_66_0:UpdateSkinList()
			arg_66_0:UpdateColorList()
		end

		local var_66_12 = {}

		IslandShipDressHelperNew = var_4
		var_66_12[1] = var_4.DressType.BackDecorate
		IslandShipDressHelperNew = var_4
		var_66_12[2] = var_4.DressType.Flotage
		IslandShipDressHelperNew = var_4
		var_66_12[3] = var_4.DressType.Footprint
		ipairs = var_4

		for iter_66_2, iter_66_3 in var_4(var_66_12) do
			local var_66_13 = arg_66_0.characterAgency
			local var_66_14

			if not var_9.GetCurDressIdByShipId(var_66_13, arg_66_0.shipId, iter_66_3) then
				var_66_14 = {}
			end

			local var_66_15 = arg_66_0.shipDressHelper
			local var_66_16 = var_10.ChangeDressByType
			local var_66_17 = iter_66_3
			local var_66_18 = {
				colorId = 0
			}
			local var_66_19

			if not var_66_14.dress_id then
				var_66_19 = 0
			end

			var_66_18.id = var_66_19

			var_66_16(var_66_15, var_66_17, var_66_18)

			local var_66_20 = arg_66_0.curShipDressTypeDataDic

			IslandShipDressItem = var_66_13
			var_66_20[iter_66_3] = var_66_13.New(var_66_14)
		end

		arg_66_0:UpdateDressUpList()
	end

	return
end

function var_0_1.CheckShipCanSave(arg_68_0)
	local var_68_0 = true
	local var_68_1 = arg_68_0.characterAgency

	if not var_2.CheckSkinIsOwned(var_68_1, arg_68_0.curSkinId) then
		local var_68_2 = arg_68_0.characterAgency
		local var_68_3 = var_2.GetShipById(var_68_2, arg_68_0.shipId)

		arg_68_0.curSkinId = var_2.GetCurSkinId(var_68_3)
		var_68_0 = false
	end

	if arg_68_0.curSkinId ~= 0 then
		local var_68_4 = arg_68_0.characterAgency

		if not var_2.CheckSkinColorIsOwned(var_68_4, arg_68_0.curSkinId, arg_68_0.curskinColorId) then
			local var_68_5 = arg_68_0.characterAgency

			arg_68_0.curskinColorId = var_2.GetCurrentSkinColorByShipId(var_68_5, arg_68_0.shipId, arg_68_0.curSkinId)
			var_68_0 = false
		end
	end

	return var_68_0
end

function var_0_1.SaveDressUpDataHandle(arg_69_0, arg_69_1)
	if arg_69_0.shipId == 0 then
		arg_69_0:SaveDressUpData(arg_69_1)
	else
		if not arg_69_0:CheckShipCanSave() then
			local var_69_0 = arg_69_0.characterAgency
			local var_69_1 = var_3.GetShipById(var_69_0, arg_69_0.shipId)
			local var_69_2 = var_3.GetModelBySkinAndColorId(var_69_1, arg_69_0.curSkinId, arg_69_0.curskinColorId)
			local var_69_3 = arg_69_0.shipDressHelper

			var_5.ChangeModelTransfromByUnitId(var_69_3, var_69_2)
			arg_69_0:UpdateSkinList()
			arg_69_0:UpdateColorList()

			pg = var_5

			local var_69_4 = var_5.TipsMgr.GetInstance()
			local var_69_5 = var_5.ShowTips

			i18n = var_8

			var_69_5(var_69_4, var_8("island_dress_save2"))

			existCall = var_69_5

			var_69_5(arg_69_1)

			return
		end

		arg_69_0:SaveDressUpData(arg_69_1)
	end

	return
end

function var_0_1.SaveDressUpData(arg_70_0, arg_70_1)
	if arg_70_0.shipId == 0 then
		local var_70_0, var_70_1 = (function()
			local var_71_0 = {}
			local var_71_1 = {}

			pairs = var_2_10002

			for iter_71_0, iter_71_1 in var_2_10002(arg_70_0.curDressTypeDataDic) do
				local var_71_2 = arg_70_0.dressUpAgency
				local var_71_3 = var_7.GetDressByType(var_71_2, iter_71_0)
				local var_71_4 = false

				if iter_71_1 ~= var_71_3 then
					var_71_4 = true
				end

				IslandShipDressHelperNew = var_71_2

				if iter_71_0 == var_71_2.DressType.Hat and iter_71_1 == 0 then
					var_71_4 = true
				end

				if var_71_4 then
					table = var_9

					var_9.insert(var_71_0, {
						type = iter_71_0,
						id = iter_71_1
					})
				end

				local var_71_5

				if not arg_70_0.dressColorDic[iter_71_1] then
					var_71_5 = 0
				end

				local var_71_6 = arg_70_0.dressUpAgency

				if var_10.GetCurrentColorByDressId(var_71_6, iter_71_1) ~= var_71_5 then
					table = var_10

					var_10.insert(var_71_1, {
						id = iter_71_1,
						color = var_71_5
					})
				end
			end

			return var_71_0, var_71_1
		end)()

		pg = var_1_10005

		local var_70_2 = var_1_10005.m02
		local var_70_3 = var_5.sendNotification

		GAME = var_1_10008

		var_70_3(var_70_2, var_1_10008.ISLAND_CHANGE_COMMANDER_DRESS, {
			dress_List = var_70_0,
			color_list = var_70_1,
			island_id = arg_70_0.island.id
		})

		existCall = var_70_3

		var_70_3(arg_70_1)
	else
		local var_70_4 = {}
		local var_70_5 = {}
		local var_70_6 = {}
		local var_70_7 = {}

		pairs = var_1_10006

		for iter_70_0, iter_70_1 in var_1_10006(arg_70_0.curShipDressTypeDataDic) do
			local var_70_8 = arg_70_0.characterAgency

			if not var_1_10011.GetCurDressIdByShipId(var_70_8, arg_70_0.shipId, iter_70_0) then
				var_1_10011 = {}
			end

			if not iter_70_1:CheckIsEqualByShipDressItem(var_1_10011) then
				if not iter_70_1.dress_id then
					table = var_12

					var_12.insert(var_70_5, var_1_10011.dress_id)
				elseif iter_70_1.ship_id ~= 0 then
					if var_1_10011.dress_id then
						table = var_12

						var_12.insert(var_70_7, var_1_10011.dress_id)
					end

					table = var_12

					var_12.insert(var_70_6, {
						ship_id = iter_70_1.ship_id,
						dress_id = iter_70_1.dress_id
					})
				else
					if var_1_10011.dress_id then
						table = var_12

						var_12.insert(var_70_5, var_1_10011.dress_id)
					end

					table = var_12

					var_12.insert(var_70_4, {
						ship_id = iter_70_1.ship_id,
						dress_id = iter_70_1.dress_id
					})
				end
			end
		end

		local function var_70_9()
			pg = var_2_10000

			local var_72_0 = var_2_10000.m02
			local var_72_1 = var_0.sendNotification

			GAME = var_2_10003

			var_72_1(var_72_0, var_2_10003.ISLAND_CHANGE_DRESS, {
				dress_List = var_70_4,
				unload_dress = var_70_5,
				ship_id = arg_70_0.shipId,
				skin_id = arg_70_0.curSkinId,
				color_id = arg_70_0.curskinColorId
			})

			if arg_70_0.changeDressType then
				pg = var_0

				local var_72_2 = var_0.m02
				local var_72_3 = var_0.sendNotification

				GAME = var_3

				local var_72_4 = var_3.ISLAND_CHEATER_CHANGE_VIEW_DRESSID
				local var_72_5 = {
					type = arg_70_0.changeDressType
				}

				PlayRoomTools = var_5
				var_72_5.game_type = var_5.GetGameTypeID()
				var_72_5.ship_id = arg_70_0.shipId

				var_72_3(var_72_2, var_72_4, var_72_5)
			end

			return
		end

		if #var_70_6 == 0 then
			var_70_9()

			existCall = var_7

			var_7(arg_70_1)

			return
		end

		local var_70_10 = arg_70_0
		local var_70_11 = arg_70_0.ShowMsgBox
		local var_70_12 = {}

		IslandMsgBox = var_1_10011
		var_70_12.type = var_1_10011.TYPE_DRESS_WEAR_CONFIRE
		i18n = var_11
		var_70_12.content = var_11("island_dress_replace_tip")
		var_70_12.needconfirmDressList = var_70_6

		function var_70_12.onYes()
			ipairs = var_2_10000

			for iter_73_0, iter_73_1 in var_2_10000(var_70_6) do
				table = var_2_10005

				var_2_10005.insert(var_70_4, iter_73_1)
			end

			ipairs = var_0

			for iter_73_2, iter_73_3 in var_0(var_70_7) do
				table = var_2_10005

				var_2_10005.insert(var_70_5, iter_73_3)
			end

			var_70_9()

			existCall = var_0

			var_0(arg_70_1)

			return
		end

		function var_70_12.onNo()
			existCall = var_2_10000

			var_2_10000(arg_70_1)

			return
		end

		var_70_11(var_70_10, var_70_12)
	end

	return
end

function var_0_1.CheckInReturn(arg_75_0, arg_75_1)
	if arg_75_0.morphing then
		return
	end

	if not arg_75_0:CheckDressIsDirty() then
		existCall = var_2

		var_2(arg_75_1)

		return
	end

	if not arg_75_0:CheckShipCanSave() then
		existCall = var_1_10003

		var_1_10003(arg_75_1)

		pg = var_1_10003

		local var_75_0 = var_1_10003.TipsMgr.GetInstance()
		local var_75_1 = var_3.ShowTips

		i18n = var_1_10006

		var_75_1(var_75_0, var_1_10006("island_dress_exit2"))

		return
	end

	local var_75_2 = arg_75_0
	local var_75_3 = arg_75_0.ShowMsgBox
	local var_75_4 = {}

	IslandMsgBox = var_1_10007
	var_75_4.type = var_1_10007.TYPE_COMMON
	i18n = var_7
	var_75_4.content = var_7("island_dressup_tip_1")

	function var_75_4.onYes()
		local var_76_0 = arg_75_0

		var_0.SaveDressUpDataHandle(var_76_0, arg_75_1)

		return
	end

	function var_75_4.onNo()
		existCall = var_2_10000

		var_2_10000(arg_75_1)

		return
	end

	var_75_3(var_75_2, var_75_4)

	return
end

function var_0_1.OnChangeRoleDressDone(arg_78_0)
	pairs = var_1_10001

	for iter_78_0, iter_78_1 in var_1_10001(arg_78_0.curShipDressTypeDataDic) do
		local var_78_0 = arg_78_0.characterAgency
		local var_78_1

		if not var_6.GetCurDressIdByShipId(var_78_0, arg_78_0.shipId, iter_78_0) then
			var_78_1 = {}
		end

		local var_78_2 = arg_78_0.curShipDressTypeDataDic

		IslandShipDressItem = var_78_0
		var_78_2[iter_78_0] = var_78_0.New(var_78_1)
	end

	arg_78_0:GetDressUpList()
	arg_78_0:UpdateDressUpList()

	return
end

function var_0_1.OnSendRoleDressReadDone(arg_79_0, arg_79_1)
	ipairs = var_1_10002

	for iter_79_0, iter_79_1 in var_1_10002(arg_79_1) do
		ipairs = var_1_10007

		for iter_79_2, iter_79_3 in var_1_10007(arg_79_0.dressList) do
			if iter_79_3.id == iter_79_1 and iter_79_3.needRedDot then
				iter_79_3.needRedDot = false
			end
		end
	end

	arg_79_0:UpdateDressUpList()
	arg_79_0:UpdateRightReddot()

	return
end

function var_0_1.OnBuyRoleSkinColorDone(arg_80_0)
	arg_80_0:UpdateColorList()

	return
end

function var_0_1.OnBuyRoleDressColorDone(arg_81_0)
	arg_81_0:UpdateColorList(true)

	return
end

function var_0_1.GetBuySkindDone(arg_82_0)
	arg_82_0:UpdateSkinList()

	return
end

function var_0_1.UpdateRightReddot(arg_83_0)
	local var_83_0

	if arg_83_0.shipId ~= 0 or not {
		1,
		2,
		3,
		5,
		6,
		7
	} then
		var_83_0 = {
			5,
			6,
			7
		}
	end

	ipairs = var_1_10002

	for iter_83_0, iter_83_1 in var_1_10002(var_83_0) do
		local var_83_1 = arg_83_0.toggles[iter_83_1]
		local var_83_2 = var_7.Find(var_83_1, "red_dot")
		local var_83_3 = false
		local var_83_4 = var_0_2[iter_83_1]

		if arg_83_0.shipId == 0 then
			local var_83_5 = arg_83_0.dressUpAgency

			var_83_3 = var_11.CheckRedDotByDressType(var_83_5, var_83_4)
		else
			local var_83_6 = arg_83_0.characterAgency

			var_83_3 = var_11.CheckRedDotByDressType(var_83_6, var_83_4)
		end

		setActive = var_11

		var_11(var_83_2, var_83_3)
	end

	return
end

function var_0_1.UpdateColorPanel(arg_84_0)
	if not (function()
		if arg_84_0.isDressColor then
			if not arg_84_0.curDressTypeDataDic[arg_84_0.dressType] or var_0 == 0 then
				return false
			end

			pg = var_1

			local var_85_0

			if not var_1.island_dress_colordiff_template.get_id_list_by_belongto_dress[var_0] then
				var_85_0 = {}
			end

			return #var_85_0 > 0
		end

		local var_85_1

		if arg_84_0.curSkinId == 0 or not arg_84_0.curSkinId then
			var_85_1 = nil
		end

		if not var_85_1 then
			return false
		end

		return true
	end)() then
		setActive = var_2

		var_2(arg_84_0.color_listPanel, false)

		return
	end

	setActive = var_2

	var_2(arg_84_0.color_listPanel, true)

	return
end

function var_0_1.UpdateColorUnlockState(arg_86_0)
	local var_86_0
	local var_86_1
	local var_86_2

	if arg_86_0.isDressColor then
		if not arg_86_0.curDressTypeDataDic[arg_86_0.dressType] or var_86_2 == 0 then
			return true
		end

		var_86_1 = arg_86_0.dressColorDic[var_86_2] or 0
		pg = var_4
		var_86_0 = var_4.island_dress_colordiff_template[var_86_1]
	else
		pg = var_4
		var_86_0 = var_4.island_skin_colordiff_template[arg_86_0.curskinColorId]
	end

	local var_86_3, var_86_4 = (function()
		if arg_86_0.isDressColor then
			if arg_86_0.shipId == 0 then
				local var_87_0 = arg_86_0.dressUpAgency

				if var_0.CheckDressColorIsOwned(var_87_0, var_86_2, var_86_1) then
					return true
				end
			else
				return true
			end

			return false, true
		else
			if not arg_86_0.curskinColorId or arg_86_0.curskinColorId == 0 then
				return true
			end

			local var_87_1 = arg_86_0.characterAgency

			if var_0.CheckSkinColorIsOwned(var_87_1, arg_86_0.curSkinId, arg_86_0.curskinColorId) then
				return true
			end

			local var_87_2 = arg_86_0.characterAgency
			local var_87_3 = var_0.CheckSkinIsOwned(var_87_2, arg_86_0.curSkinId)

			return false, var_87_3
		end

		return
	end)()

	if var_86_3 then
		setActive = var_1_10007

		var_1_10007(arg_86_0.color_bg_unlock, true)

		setActive = var_1_10007

		var_1_10007(arg_86_0.color_bg_locked, false)
	else
		setActive = var_1_10007

		var_1_10007(arg_86_0.color_bg_unlock, false)

		setActive = var_1_10007

		var_1_10007(arg_86_0.color_bg_locked, true)

		pg = var_1_10007
		var_1_10007 = var_1_10007.island_item_data_template[var_86_0.cost[1][1]]
		GetImageSpriteFromAtlasAsync = var_8

		var_8("island/" .. var_1_10007.icon, "", arg_86_0.color_cost_item_icon)

		local var_86_5 = var_86_0.cost[1][2]

		setText = var_9

		var_9(arg_86_0.color_cost_item_count, "×" .. var_86_5)

		setActive = var_9

		var_9(arg_86_0.color_lockedBtn, var_86_4)
	end

	onButton = var_1_10007

	var_1_10007(arg_86_0, arg_86_0.color_lockedBtn, function()
		local function var_88_0()
			local var_89_1

			if arg_86_0.isDressColor then
				pg = var_89_1

				local var_89_0 = var_89_1.m02

				var_89_1 = var_89_1.sendNotification
				GAME = var_3_10003

				var_89_1(var_89_0, var_3_10003.ISLAND_BUY_ROLE_DRESS_COLOR, {
					id = arg_86_0.shipId,
					dress_id = var_86_2,
					color_id = var_86_1
				})
			else
				pg = var_89_1

				local var_89_2 = var_89_1.m02
				local var_89_3 = var_0.sendNotification

				GAME = var_3_10003

				var_89_3(var_89_2, var_3_10003.ISLAND_BUY_ROLE_SKIN_COLOR, {
					ship_id = arg_86_0.shipId,
					skin_id = arg_86_0.curSkinId,
					color_id = arg_86_0.curskinColorId
				})
			end

			return
		end

		pg = var_2_10001

		local var_88_1 = var_2_10001.island_item_data_template[var_86_0.cost[1][1]]

		i18n = var_2

		local var_88_2 = var_2("island_dress_color_buy", var_88_1.name .. "x" .. var_86_0.cost[1][2])
		local var_88_3 = arg_86_0
		local var_88_4 = var_3.ShowMsgBox
		local var_88_5 = {}

		IslandMsgBox = var_7
		var_88_5.type = var_7.TYPE_COMMON
		var_88_5.content = var_88_2

		function var_88_5.onYes()
			if not (function(arg_91_0)
				getProxy = var_4_10001
				IslandProxy = var_4_10003

				local var_91_0 = var_4_10001(var_4_10003)
				local var_91_1 = var_1.GetIsland(var_91_0)
				local var_91_2 = var_1.GetInventoryAgency(var_91_1)

				ipairs = var_4_10002

				for iter_91_0, iter_91_1 in var_4_10002(arg_91_0) do
					local var_91_3 = iter_91_1[1]

					if iter_91_1[2] > var_91_2:GetOwnCount(var_91_3) then
						return false
					end
				end

				return true
			end)(var_86_0.cost) then
				pg = var_1

				local var_90_0 = var_1.TipsMgr.GetInstance()
				local var_90_1 = var_1.ShowTips

				i18n = var_3_10004

				var_90_1(var_90_0, var_3_10004("common_no_resource"))

				return
			end

			var_88_0()

			return
		end

		function var_88_5.onNo()
			return
		end

		var_88_4(var_88_3, var_88_5)

		return
	end)

	return
end

function var_0_1.UpdateColorItemList(arg_93_0)
	(function()
		arg_93_0.colorItemList = {}

		local var_94_0

		if arg_93_0.isDressColor then
			var_94_0 = arg_93_0.curDressTypeDataDic[arg_93_0.dressType]

			local var_94_1 = arg_93_0.dressColorDic[var_94_0]

			pg = var_2_10002

			local var_94_2

			if not var_2_10002.island_dress_colordiff_template.get_id_list_by_belongto_dress[var_94_0] then
				var_94_2 = {}
			end

			if #var_94_2 > 0 then
				var_2_10003 = var_94_1 == 0

				local var_94_3 = true

				table = var_2_10005

				var_2_10005.insert(arg_93_0.colorItemList, {
					itemId = 0,
					selected = var_2_10003,
					owned = var_94_3
				})

				ipairs = var_5

				for iter_94_0, iter_94_1 in var_5(var_94_2) do
					var_2_10010 = var_94_1 == iter_94_1

					local var_94_4 = arg_93_0.dressUpAgency
					local var_94_5 = var_11.CheckDressColorIsOwned(var_94_4, var_94_0, iter_94_1)

					table = var_2_10012
					var_2_10012 = var_2_10012.insert
					var_2_10014 = arg_93_0.colorItemList

					local var_94_6 = {
						itemId = iter_94_1,
						selected = var_2_10010,
						owned = var_94_5
					}

					pg = var_2_10016
					var_94_6.costItemIcon = var_2_10016.island_dress_colordiff_template[iter_94_1].color_icon

					var_2_10012(var_2_10014, var_94_6)
				end
			end
		else
			pg = var_94_0

			local var_94_7

			if not var_94_0.island_skin_colordiff_template.get_id_list_by_skin_group[arg_93_0.curSkinId] then
				var_94_7 = {}
			end

			local var_94_8 = arg_93_0.curskinColorId == 0
			local var_94_9 = arg_93_0.characterAgency
			local var_94_10 = var_2.CheckSkinIsOwned(var_94_9, arg_93_0.curSkinId)

			table = var_2_10003

			var_2_10003.insert(arg_93_0.colorItemList, {
				itemId = 0,
				selected = var_94_8,
				owned = var_94_10
			})

			ipairs = var_3

			for iter_94_2, iter_94_3 in var_3(var_94_7) do
				local var_94_11 = arg_93_0.curskinColorId == iter_94_3
				local var_94_12 = arg_93_0.characterAgency
				local var_94_13 = var_9.CheckSkinColorIsOwned(var_94_12, arg_93_0.curSkinId, iter_94_3)

				table = var_2_10010
				var_2_10010 = var_2_10010.insert

				local var_94_14 = arg_93_0.colorItemList
				local var_94_15 = {
					itemId = iter_94_3,
					selected = var_94_11,
					owned = var_94_13
				}

				pg = var_2_10014
				var_94_15.costItemIcon = var_2_10014.island_skin_colordiff_template[iter_94_3].color_icon

				var_2_10010(var_94_14, var_94_15)
			end
		end

		return
	end)()

	local var_93_0 = arg_93_0.colorItemUIList

	var_2.make(var_93_0, function(arg_95_0, arg_95_1, arg_95_2)
		UIItemList = var_2_10003

		if arg_95_0 == var_2_10003.EventUpdate then
			arg_95_1 = arg_95_1 + 1

			local var_95_0 = arg_93_0.colorItemList[arg_95_1]

			setActive = var_2_10004

			var_2_10004(arg_95_2:Find("select"), var_95_0.selected)

			local var_95_1 = var_95_0.itemId

			setActive = var_2_10005

			var_2_10005(arg_95_2:Find("orginName"), var_95_1 == 0)

			setActive = var_2_10005

			var_2_10005(arg_95_2:Find("locked"), var_95_1 == 0)

			setActive = var_2_10005

			var_2_10005(arg_95_2:Find("icon"), false)

			if var_95_0.costItemIcon then
				setActive = var_5

				var_5(arg_95_2:Find("icon"), true)

				GetImageSpriteFromAtlasAsync = var_5

				var_5("island/IslandDressIcon/" .. var_95_0.costItemIcon, "", arg_95_2:Find("icon"))
			end

			setActive = var_5

			var_5(arg_95_2:Find("locked"), not var_95_0.owned)

			onButton = var_5

			var_5(arg_93_0, arg_95_2, function()
				if arg_93_0.isDressColor then
					local var_96_0 = arg_93_0.curDressTypeDataDic[arg_93_0.dressType]
					local var_96_1 = arg_93_0.dressColorDic[var_96_0]

					if var_95_1 == var_96_1 then
						return
					end

					arg_93_0.dressColorDic[var_96_0] = var_95_1

					local var_96_2 = arg_93_0.shipDressHelper

					var_2.ChangeCommanderPartColor(var_96_2, arg_93_0.dressType, var_95_1)
				else
					if var_95_1 == arg_93_0.curskinColorId then
						return
					end

					arg_93_0.curskinColorId = var_95_1

					local var_96_3 = arg_93_0

					var_0.ChangeModelBySkinAndSkinColor(var_96_3)
				end

				local var_96_4 = arg_93_0

				var_0.UpdateColorList(var_96_4, arg_93_0.isDressColor)

				return
			end)
		end

		return
	end)

	local var_93_1 = arg_93_0.colorItemUIList

	var_2.align(var_93_1, #arg_93_0.colorItemList)

	return
end

function var_0_1.UpdateColorList(arg_97_0, arg_97_1)
	arg_97_0.isDressColor = arg_97_1

	arg_97_0:UpdateColorPanel()
	arg_97_0:UpdateColorUnlockState()
	arg_97_0:UpdateColorItemList()

	return
end

function var_0_1.OnHide(arg_98_0)
	return
end

function var_0_1.OnDestroy(arg_99_0)
	if arg_99_0.shipDressHelper then
		local var_99_0 = arg_99_0.shipDressHelper

		var_1.StopMorphSwitch(var_99_0)
	end

	arg_99_0:SetMorphBlock(false)

	ClearLScrollrect = var_1

	var_1(arg_99_0.dressRect)

	ClearLScrollrect = var_1

	var_1(arg_99_0.skinRect)

	pairs = var_1

	local var_99_1

	if not arg_99_0.dressCards then
		var_99_1 = {}
	end

	for iter_99_0, iter_99_1 in var_1(var_99_1) do
		iter_99_1:Dispose()
	end

	arg_99_0.dressCards = nil
	pairs = var_1

	local var_99_2

	if not arg_99_0.skinCards then
		var_99_2 = {}
	end

	for iter_99_2, iter_99_3 in var_1(var_99_2) do
		iter_99_3:Dispose()
	end

	arg_99_0.skinCards = nil

	if arg_99_0.dressDetailPopup then
		local var_99_3 = arg_99_0.dressDetailPopup

		var_1.Destroy(var_99_3)

		arg_99_0.dressDetailPopup = nil
	end

	return
end

return var_0_1
