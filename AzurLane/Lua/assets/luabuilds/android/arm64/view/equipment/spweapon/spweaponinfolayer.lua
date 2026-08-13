class = var_0_10000

local var_0_0 = "SpWeaponInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SpWeaponInfoUI"
end

var_0_1.Left = 1
var_0_1.Middle = 2
var_0_1.Right = 3
var_0_1.pos = {
	{
		-353,
		30,
		0
	},
	{
		0,
		30,
		0
	},
	{
		353,
		30,
		0
	}
}
var_0_1.TYPE_DEFAULT = 1
var_0_1.TYPE_SHIP = 2
var_0_1.TYPE_REPLACE = 3
var_0_1.TYPE_DISPLAY = 4
var_0_1.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}

function var_0_1.init(arg_2_0)
	local var_2_0 = {
		"default",
		"replace",
		"display"
	}

	arg_2_0.toggles = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		local var_2_1 = iter_2_1 .. "Panel"
		local var_2_2 = arg_2_0._tf

		arg_2_0[var_2_1] = var_8.Find(var_2_2, iter_2_1)

		local var_2_3 = arg_2_0.toggles
		local var_2_4 = iter_2_1 .. "Panel"
		local var_2_5 = arg_2_0._tf

		var_2_3[var_2_4] = var_9.Find(var_2_5, "toggle_controll/" .. iter_2_1)
	end

	Canvas = var_2

	var_2.ForceUpdateCanvases()

	local var_2_6 = arg_2_0._tf

	arg_2_0.sample = var_2.Find(var_2_6, "sample")
	setActive = var_2

	var_2(arg_2_0.sample, false)

	findTF = var_2
	arg_2_0.txtQuickEnable = var_2(arg_2_0._tf, "txtQuickEnable")
	setText = var_2

	local var_2_7 = arg_2_0.txtQuickEnable

	i18n = var_5

	var_2(var_2_7, var_5("ship_equip_check"))

	setText = var_2

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_4.Find(var_2_8, "sample/empty/Text")

	i18n = var_5

	var_2(var_2_9, var_5("spweapon_ui_empty"))

	return
end

function var_0_1.setEquipment(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.equipmentVO = arg_3_1
	arg_3_0.oldEquipmentVO = arg_3_2

	return
end

function var_0_1.setShip(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.shipVO = arg_4_1
	arg_4_0.oldShipVO = arg_4_2

	return
end

function var_0_1.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_1.checkOverGold(arg_6_0, arg_6_1)
	_ = var_1_10002

	local var_6_0

	if not var_1_10002.detect(arg_6_1, function(arg_7_0)
		local var_7_0 = arg_7_0.type

		DROP_TYPE_RESOURCE = var_2_10002

		return var_7_0 == var_2_10002 and arg_7_0.id == 1
	end).count then
		var_6_0 = 0
	end

	local var_6_1 = arg_6_0.player

	if var_3.GoldMax(var_6_1, var_6_0) then
		pg = var_3

		local var_6_2 = var_3.TipsMgr.GetInstance()
		local var_6_3 = var_3.ShowTips

		i18n = var_6

		local var_6_4 = var_6("gold_max_tip_title")

		i18n = var_1_10007

		var_6_3(var_6_2, var_6_4 .. var_1_10007("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_1.didEnter(arg_8_0)
	setActive = var_1_10001

	local var_8_0 = arg_8_0.txtQuickEnable
	local var_8_1

	if not arg_8_0.contextData.quickFlag then
		var_8_1 = false
	end

	var_1_10001(var_8_0, var_8_1)

	defaultValue = var_1_10001

	local var_8_2 = var_1_10001(arg_8_0.contextData.type, var_0_1.TYPE_DEFAULT)

	table = var_1_10002
	arg_8_0.isShowUnique = var_1_10002.contains(var_0_1.SHOW_UNIQUE, var_8_2)
	onButton = var_2

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0._tf
	local var_8_5 = var_5.Find(var_8_4, "bg")

	local function var_8_6()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SOUND_BACK = var_8_4

	var_2(var_8_3, var_8_5, var_8_6, var_8_4)
	arg_8_0:initAndSetBtn(var_8_2)

	if var_8_2 == var_0_1.TYPE_DEFAULT then
		arg_8_0:updateOperation1()
	elseif var_8_2 == var_0_1.TYPE_SHIP then
		arg_8_0:updateOperation2()
	elseif var_8_2 == var_0_1.TYPE_REPLACE then
		arg_8_0:updateOperation3()
	elseif var_8_2 == var_0_1.TYPE_DISPLAY then
		arg_8_0:updateOperation4()
	end

	pg = var_2

	local var_8_7 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_8_7, arg_8_0._tf)

	return
end

local var_0_2 = {
	{
		"Enhance",
		"msgbox_text_noPos_intensify"
	},
	{
		"Replace",
		"msgbox_text_replace"
	},
	{
		"Unload",
		"msgbox_text_unload"
	},
	{
		"Modify",
		"msgbox_text_modify"
	}
}

function var_0_1.initAndSetBtn(arg_10_0, arg_10_1)
	if arg_10_1 == var_0_1.TYPE_DEFAULT or arg_10_1 == var_0_1.TYPE_SHIP then
		local var_10_0 = arg_10_0.defaultPanel
		local var_10_1

		if not var_2.Find(var_10_0, "equipment") then
			var_10_1 = arg_10_0:cloneSampleTo(arg_10_0.defaultPanel, var_0_1.Middle, "equipment")
		end

		arg_10_0.defaultEquipTF = var_10_1
		table = var_10_1

		var_10_1.Foreach(var_0_2, function(arg_11_0, arg_11_1)
			local var_11_0 = arg_10_0.defaultPanel
			local var_11_1 = var_2.Find(var_11_0, "actions/action_button_" .. arg_11_0)
			local var_11_2 = arg_10_0

			var_11_2["default" .. arg_11_1[1] .. "Btn"] = var_11_1
			setText = var_11_2

			local var_11_3 = var_11_1:GetChild(0)

			i18n = var_6

			var_11_2(var_11_3, var_6(arg_11_1[2]))

			return
		end)

		onButton = var_2

		local var_10_2 = arg_10_0
		local var_10_3 = arg_10_0.defaultReplaceBtn

		local function var_10_4()
			local var_12_0 = arg_10_0
			local var_12_1 = var_0.emit

			SpWeaponInfoMediator = var_2_10003

			var_12_1(var_12_0, var_2_10003.ON_CHANGE)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_10_2, var_10_3, var_10_4, var_1_10007)

		onButton = var_2

		local var_10_5 = arg_10_0
		local var_10_6 = arg_10_0.defaultEnhanceBtn

		local function var_10_7()
			local var_13_0 = arg_10_0
			local var_13_1 = var_0.emit

			SpWeaponInfoMediator = var_2_10003

			var_13_1(var_13_0, var_2_10003.ON_INTENSIFY)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_10_5, var_10_6, var_10_7, var_1_10007)

		onButton = var_2

		local var_10_8 = arg_10_0
		local var_10_9 = arg_10_0.defaultUnloadBtn

		local function var_10_10()
			local var_14_0 = arg_10_0
			local var_14_1 = var_0.emit

			SpWeaponInfoMediator = var_2_10003

			var_14_1(var_14_0, var_2_10003.ON_UNEQUIP)

			return
		end

		SFX_UI_DOCKYARD_EQUIPOFF = var_1_10007

		var_2(var_10_8, var_10_9, var_10_10, var_1_10007)

		onButton = var_2

		local var_10_11 = arg_10_0
		local var_10_12 = arg_10_0.defaultModifyBtn

		local function var_10_13()
			local var_15_0 = arg_10_0
			local var_15_1 = var_0.emit

			SpWeaponInfoMediator = var_2_10003

			var_15_1(var_15_0, var_2_10003.ON_MODIFY)

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_10_11, var_10_12, var_10_13, var_1_10007)
	elseif arg_10_1 == var_0_1.TYPE_REPLACE then
		local var_10_14 = arg_10_0.replacePanel
		local var_10_15

		if not var_2.Find(var_10_14, "equipment") then
			var_10_15 = arg_10_0:cloneSampleTo(arg_10_0.replacePanel, var_0_1.Left, "equipment")
		end

		arg_10_0.replaceSrcEquipTF = var_10_15

		local var_10_16 = arg_10_0.replacePanel
		local var_10_17

		if not var_2.Find(var_10_16, "equipment_on_ship") then
			var_10_17 = arg_10_0:cloneSampleTo(arg_10_0.replacePanel, var_0_1.Right, "equipment_on_ship")
		end

		arg_10_0.replaceDstEquipTF = var_10_17

		local var_10_18 = arg_10_0.replacePanel

		arg_10_0.replaceCancelBtn = var_2.Find(var_10_18, "actions/cancel_button")

		local var_10_19 = arg_10_0.replacePanel

		arg_10_0.replaceConfirmBtn = var_2.Find(var_10_19, "actions/action_button_2")
		setText = var_2

		local var_10_20 = arg_10_0.replaceConfirmBtn
		local var_10_21 = var_4.Find(var_10_20, "label")

		i18n = var_5

		var_2(var_10_21, var_5("msgbox_text_confirm"))

		setText = var_2

		local var_10_22 = arg_10_0.replaceCancelBtn
		local var_10_23 = var_4.Find(var_10_22, "label")

		i18n = var_5

		var_2(var_10_23, var_5("msgbox_text_cancel"))

		onButton = var_2

		local var_10_24 = arg_10_0
		local var_10_25 = arg_10_0.replaceCancelBtn

		local function var_10_26()
			local var_16_0 = arg_10_0

			var_0.closeView(var_16_0)

			return
		end

		SFX_CANCEL = var_7

		var_2(var_10_24, var_10_25, var_10_26, var_7)

		onButton = var_2

		local var_10_27 = arg_10_0
		local var_10_28 = arg_10_0.replaceConfirmBtn

		local function var_10_29()
			if arg_10_0.contextData.quickCallback then
				arg_10_0.contextData.quickCallback()

				local var_17_0 = arg_10_0

				var_0.closeView(var_17_0)
			else
				local var_17_1 = arg_10_0
				local var_17_2 = var_0.emit

				SpWeaponInfoMediator = var_2_10003

				var_17_2(var_17_1, var_2_10003.ON_EQUIP)
			end

			return
		end

		SFX_UI_DOCKYARD_EQUIPADD = var_7

		var_2(var_10_27, var_10_28, var_10_29, var_7)
	elseif arg_10_1 == var_0_1.TYPE_DISPLAY then
		local var_10_30 = arg_10_0.displayPanel
		local var_10_31

		if not var_2.Find(var_10_30, "equipment") then
			var_10_31 = arg_10_0:cloneSampleTo(arg_10_0.displayPanel, var_0_1.Middle, "equipment")
		end

		arg_10_0.displayEquipTF = var_10_31

		local var_10_32 = arg_10_0.displayPanel

		arg_10_0.displayMoveBtn = var_2.Find(var_10_32, "actions/move_button")
		setText = var_2

		local var_10_33 = arg_10_0.displayMoveBtn
		local var_10_34 = var_4.Find(var_10_33, "label")

		i18n = var_5

		var_2(var_10_34, var_5("msgbox_text_equipdetail"))

		onButton = var_2

		var_2(arg_10_0, arg_10_0.displayMoveBtn, function()
			local var_18_0 = arg_10_0
			local var_18_1 = var_0.emit

			SpWeaponInfoMediator = var_2_10003

			var_18_1(var_18_0, var_2_10003.ON_MOVE, arg_10_0.shipVO.id)

			return
		end)
	end

	return
end

function var_0_1.updateOperation1(arg_19_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_19_0.toggles.defaultPanel, true)

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.updateEquipmentPanel
	local var_19_2 = arg_19_0.defaultEquipTF
	local var_19_3 = arg_19_0.equipmentVO

	SpWeaponHelper = var_1_10006

	var_19_1(var_19_0, var_19_2, var_19_3, var_1_10006.TransformNormalInfo(arg_19_0.equipmentVO))

	setActive = var_19_1

	var_19_1(arg_19_0.defaultEnhanceBtn, true)

	setActive = var_19_1

	var_19_1(arg_19_0.defaultReplaceBtn, false)

	setActive = var_19_1

	var_19_1(arg_19_0.defaultUnloadBtn, false)

	setActive = var_19_1

	var_19_1(arg_19_0.defaultModifyBtn, true)

	return
end

function var_0_1.updateOperation2(arg_20_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_20_0.toggles.defaultPanel, true)

	local var_20_0 = arg_20_0.shipVO
	local var_20_1 = var_1.GetSpWeapon(var_20_0)
	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.updateEquipmentPanel
	local var_20_4 = arg_20_0.defaultEquipTF
	local var_20_5 = var_20_1

	SpWeaponHelper = var_1_10007

	var_20_3(var_20_2, var_20_4, var_20_5, var_1_10007.TransformNormalInfo(var_20_1))

	setActive = var_20_3

	var_20_3(arg_20_0.defaultEnhanceBtn, true)

	setActive = var_20_3

	var_20_3(arg_20_0.defaultReplaceBtn, true)

	setActive = var_20_3

	var_20_3(arg_20_0.defaultUnloadBtn, true)

	setActive = var_20_3

	var_20_3(arg_20_0.defaultModifyBtn, true)

	local var_20_6 = arg_20_0.defaultEquipTF
	local var_20_7 = var_2.Find(var_20_6, "head")

	setActive = var_20_0

	var_20_0(var_20_7, arg_20_0.shipVO)

	if arg_20_0.shipVO then
		setImageSprite = var_3
		findTF = var_5

		local var_20_8 = var_5(var_20_7, "Image")

		LoadSprite = var_6

		local var_20_9 = "qicon/"
		local var_20_10 = arg_20_0.shipVO

		var_3(var_20_8, var_6(var_20_9 .. var_9.getPainting(var_20_10)))
	end

	return
end

function var_0_1.updateOperation3(arg_21_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_21_0.toggles.replacePanel, true)

	local var_21_1

	if arg_21_0.equipmentVO then
		SpWeaponHelper = var_1_10002

		local var_21_0

		var_21_0, var_21_1 = var_1_10002.CompareNormalInfo(var_1, arg_21_0.oldEquipmentVO)

		arg_21_0:updateEquipmentPanel(arg_21_0.replaceSrcEquipTF, var_1, var_21_0)
		arg_21_0:updateEquipmentPanel(arg_21_0.replaceDstEquipTF, arg_21_0.oldEquipmentVO, var_21_1)
	else
		arg_21_0:updateEquipmentPanel(arg_21_0.replaceSrcEquipTF, nil)

		local var_21_2 = arg_21_0
		local var_21_3 = arg_21_0.updateEquipmentPanel
		local var_21_4 = arg_21_0.replaceDstEquipTF
		local var_21_5 = arg_21_0.oldEquipmentVO

		SpWeaponHelper = var_1_10007

		var_21_3(var_21_2, var_21_4, var_21_5, var_1_10007.TransformNormalInfo(arg_21_0.oldEquipmentVO))
	end

	local var_21_6 = arg_21_0.replaceDstEquipTF
	local var_21_7 = var_2.Find(var_21_6, "head")

	setActive = var_21_1

	var_21_1(var_21_7, arg_21_0.oldShipVO)

	if arg_21_0.oldShipVO then
		setImageSprite = var_3
		findTF = var_5

		local var_21_8 = var_5(var_21_7, "Image")

		LoadSprite = var_6

		local var_21_9 = "qicon/"
		local var_21_10 = arg_21_0.oldShipVO

		var_3(var_21_8, var_6(var_21_9 .. var_9.getPainting(var_21_10)))
	end

	return
end

function var_0_1.updateOperation4(arg_22_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_22_0.toggles.displayPanel, true)

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.updateEquipmentPanel
	local var_22_2 = arg_22_0.displayEquipTF
	local var_22_3 = arg_22_0.equipmentVO

	SpWeaponHelper = var_1_10006

	var_22_1(var_22_0, var_22_2, var_22_3, var_1_10006.TransformNormalInfo(arg_22_0.equipmentVO))

	setActive = var_22_1

	var_22_1(arg_22_0.displayMoveBtn, arg_22_0.shipVO)

	local var_22_4 = arg_22_0.displayEquipTF
	local var_22_5 = var_1.Find(var_22_4, "head")

	setActive = var_1_10002

	var_1_10002(var_22_5, arg_22_0.shipVO)

	if arg_22_0.shipVO then
		setImageSprite = var_2
		findTF = var_4

		local var_22_6 = var_4(var_22_5, "Image")

		LoadSprite = var_5

		local var_22_7 = "qicon/"
		local var_22_8 = arg_22_0.shipVO

		var_2(var_22_6, var_5(var_22_7 .. var_8.getPainting(var_22_8)))
	end

	return
end

function var_0_1.updateOperationAward(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.awards = arg_23_3

	if arg_23_1.childCount == 0 then
		for iter_23_0 = 1, #arg_23_3 do
			cloneTplTo = var_1_10008

			var_1_10008(arg_23_2, arg_23_1)
		end
	end

	for iter_23_1 = 1, #arg_23_3 do
		local var_23_0 = arg_23_1
		local var_23_1 = arg_23_1.GetChild(var_23_0, iter_23_1 - 1)
		local var_23_2 = arg_23_3[iter_23_1]

		updateDrop = var_23_0

		var_23_0(var_23_1, var_23_2)

		onButton = var_23_0

		local var_23_3 = arg_23_0
		local var_23_4 = var_23_1

		local function var_23_5()
			local var_24_0 = arg_23_0

			var_0.emit(var_24_0, var_0_1.ON_DROP, var_23_2)

			return
		end

		SFX_PANEL = var_1_10015

		var_23_0(var_23_3, var_23_4, var_23_5, var_1_10015)

		setText = var_23_0
		findTF = var_23_3

		local var_23_6 = var_23_3(var_23_1, "name_panel/name")

		getText = var_23_4
		findTF = var_1_10015

		var_23_0(var_23_6, var_23_4(var_1_10015(var_23_1, "name")))

		setText = var_23_0
		findTF = var_23_6

		local var_23_7 = var_23_6(var_23_1, "name_panel/number")
		local var_23_8 = " x "

		getText = var_14
		findTF = var_1_10016

		var_23_0(var_23_7, var_23_8 .. var_14(var_1_10016(var_23_1, "icon_bg/count")))

		setActive = var_23_0
		findTF = var_23_7

		var_23_0(var_23_7(var_23_1, "icon_bg/count"), false)
	end

	return
end

function var_0_1.updateEquipmentPanel(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1
	local var_25_1 = arg_25_1.Find(var_25_0, "info")
	local var_25_2 = arg_25_1
	local var_25_3 = arg_25_1.Find(var_25_2, "empty")

	setActive = var_25_0

	var_25_0(var_25_1, arg_25_2)

	setActive = var_25_0

	var_25_0(var_25_3, not arg_25_2)

	if not arg_25_2 then
		return
	end

	findTF = var_25_0

	local var_25_4 = var_25_0(var_25_1, "name")

	setScrollText = var_25_2
	findTF = var_9

	var_25_2(var_9(var_25_4, "mask/Text"), arg_25_2:GetName())

	findTF = var_25_2

	local var_25_5 = var_25_2(var_25_1, "equip")

	setImageSprite = var_8
	findTF = var_10

	local var_25_6 = var_10(var_25_5, "bg")

	GetSpriteFromAtlas = var_11

	local var_25_7 = "ui/equipmentinfoui_atlas"
	local var_25_8 = "equip_bg_"

	ItemRarity = var_1_10015

	var_8(var_25_6, var_11(var_25_7, var_25_8 .. var_1_10015.Rarity2Print(arg_25_2:GetRarity())))

	updateSpWeapon = var_8

	var_8(var_25_5, arg_25_2, {
		noIconColorful = true
	})

	setActive = var_8
	findTF = var_10

	var_8(var_10(var_25_5, "slv"), arg_25_2:GetLevel() > 1)

	setText = var_8
	findTF = var_10

	var_8(var_10(var_25_5, "slv/Text"), arg_25_2:GetLevel() - 1)

	setActive = var_8
	findTF = var_10

	var_8(var_10(var_25_5, "slv/next"), false)

	setText = var_8
	findTF = var_10

	var_8(var_10(var_25_5, "slv/next/Text"), arg_25_2:GetLevel() - 1)

	local var_25_9 = var_25_5
	local var_25_10 = var_25_5.Find(var_25_9, "tier")

	setActive = var_9

	var_9(var_25_10, arg_25_2)

	local var_25_11 = arg_25_2:GetTechTier()

	eachChild = var_25_9

	var_25_9(var_25_10, function(arg_26_0)
		setActive = var_2_10001

		local var_26_0 = arg_26_0

		tostring = var_2_10004

		var_2_10001(var_26_0, var_2_10004(var_25_11) == arg_26_0.gameObject.name)

		return
	end)

	updateSpWeaponInfo = var_25_9

	var_25_9(var_25_1:Find("attributes/view/content"), arg_25_3, arg_25_2:GetSkillGroup())

	return
end

function var_0_1.cloneSampleTo(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	cloneTplTo = var_1_10005

	local var_27_0 = var_1_10005(arg_27_0.sample, arg_27_1, arg_27_3)

	Vector3 = var_1_10006
	var_27_0.localPosition = var_1_10006.New(var_0_1.pos[arg_27_2][1], var_0_1.pos[arg_27_2][2], var_0_1.pos[arg_27_2][3])

	if arg_27_4 then
		var_27_0:SetSiblingIndex(arg_27_4)
	end

	return var_27_0
end

function var_0_1.willExit(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_0, arg_28_0._tf)

	return
end

function var_0_1.onBackPressed(arg_29_0)
	arg_29_0:closeView()

	return
end

return var_0_1
