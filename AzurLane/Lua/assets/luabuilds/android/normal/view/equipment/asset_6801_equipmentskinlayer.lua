class = var_0_10000

local var_0_0 = "EquipmentSkinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.DISPLAY = 1
var_0_1.REPLACE = 2

function var_0_1.getUIName(arg_1_0)
	return "EquipmentSkinInfoUI"
end

function var_0_1.setShip(arg_2_0, arg_2_1)
	arg_2_0.shipVO = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0._tf

	arg_3_0.displayPanel = var_1.Find(var_3_1, "display")
	setActive = var_1

	var_1(arg_3_0.displayPanel, false)

	local var_3_2 = arg_3_0.displayPanel

	arg_3_0.displayActions = var_1.Find(var_3_2, "actions")

	local var_3_3 = arg_3_0._tf

	arg_3_0.skinViewOnShipTF = var_1.Find(var_3_3, "replace/equipment_on_ship")

	local var_3_4 = arg_3_0._tf

	arg_3_0.skinViewTF = var_1.Find(var_3_4, "replace/equipment")

	local var_3_5 = arg_3_0._tf

	arg_3_0.replacePanel = var_1.Find(var_3_5, "replace")
	setActive = var_1

	var_1(arg_3_0.replacePanel, false)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_3.Find(var_4_4, "display/top/btnBack")

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_3, var_4_5, var_4_6, var_5)

	onButton = var_1_10001

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.replacePanel
	local var_4_9 = var_3.Find(var_4_8, "actions/cancel_button")

	local function var_4_10()
		local var_7_0 = arg_4_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_7, var_4_9, var_4_10, var_5)

	onButton = var_1_10001

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.replacePanel
	local var_4_13 = var_3.Find(var_4_12, "actions/action_button_2")

	local function var_4_14()
		if not arg_4_0.contextData.oldShipInfo then
			local var_8_0 = arg_4_0
			local var_8_1 = var_0.emit

			EquipmentSkinMediator = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_EQUIP)
		else
			local var_8_2 = arg_4_0
			local var_8_3 = var_0.emit

			EquipmentSkinMediator = var_2_10002

			var_8_3(var_8_2, var_2_10002.ON_EQUIP_FORM_SHIP)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_11, var_4_13, var_4_14, var_5)

	local var_4_15

	if not arg_4_0.contextData.mode then
		var_4_15 = var_0_1.DISPLAY
	end

	if var_4_15 == var_0_1.REPLACE and arg_4_0.shipVO then
		arg_4_0:initReplace()
	elseif var_4_15 == var_0_1.DISPLAY then
		arg_4_0:initDisplay()
	end

	return
end

function var_0_1.initDisplay(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.displayPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.replacePanel, false)

	if arg_9_0.shipVO then
		arg_9_0:initDisplay4Ship()
	else
		eachChild = var_1

		var_1(arg_9_0.displayActions, function(arg_10_0)
			local var_10_0 = arg_10_0.gameObject.name == "confirm"

			setActive = var_2_10002

			var_2_10002(arg_10_0, var_10_0)

			if var_10_0 then
				onButton = var_2_10002

				local var_10_1 = arg_9_0
				local var_10_2 = arg_10_0

				local function var_10_3()
					local var_11_0 = arg_9_0

					var_0.emit(var_11_0, var_0_1.ON_CLOSE)

					return
				end

				SFX_PANEL = var_2_10006

				var_2_10002(var_10_1, var_10_2, var_10_3, var_2_10006)
			end

			return
		end)
	end

	arg_9_0:updateSkinView(arg_9_0.displayPanel, arg_9_0.contextData.skinId)

	return
end

function var_0_1.initDisplay4Ship(arg_12_0)
	eachChild = var_1_10001

	var_1_10001(arg_12_0.displayActions, function(arg_13_0)
		local var_13_0 = arg_13_0.gameObject.name

		setActive = var_2_10002

		var_2_10002(arg_13_0, var_13_0 ~= "confirm")

		onButton = var_2_10002

		local var_13_1 = arg_12_0
		local var_13_2 = arg_13_0

		local function var_13_3()
			if var_13_0 == "unload" then
				local var_14_0 = arg_12_0
				local var_14_1 = var_0.emit

				EquipmentSkinMediator = var_3_10002

				var_14_1(var_14_0, var_3_10002.ON_UNEQUIP)
			elseif var_13_0 == "replace" then
				local var_14_2 = arg_12_0
				local var_14_3 = var_0.emit

				EquipmentSkinMediator = var_3_10002

				var_14_3(var_14_2, var_3_10002.ON_SELECT)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_13_1, var_13_2, var_13_3, var_2_10006)

		return
	end)

	return
end

function var_0_1.initReplace(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.displayPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_15_0.replacePanel, true)

	local var_15_0 = arg_15_0.contextData.pos
	local var_15_1 = arg_15_0.shipVO
	local var_15_2

	if not var_2.getEquipSkin(var_15_1, var_15_0) then
		var_15_2 = 0
	end

	local var_15_3 = arg_15_0.contextData.skinId

	arg_15_0:updateSkinView(arg_15_0.skinViewOnShipTF, var_15_2)

	if arg_15_0.contextData.oldShipInfo then
		local var_15_4 = arg_15_0.contextData.oldShipInfo

		arg_15_0:updateSkinView(arg_15_0.skinViewTF, var_15_3, var_15_4)
	else
		arg_15_0:updateSkinView(arg_15_0.skinViewTF, var_15_3)
	end

	return
end

function var_0_1.updateSkinView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2 ~= 0
	local var_16_1 = arg_16_1:Find("empty")
	local var_16_2 = arg_16_1
	local var_16_3 = arg_16_1.Find(var_16_2, "info")

	if var_16_1 then
		setActive = var_16_2

		var_16_2(var_16_1, not var_16_0)
	end

	setActive = var_16_2

	var_16_2(var_16_3, var_16_0)

	local var_16_4 = arg_16_1
	local var_16_5 = arg_16_1.GetComponent

	typeof = var_9
	Image = var_1_10010

	local var_16_6 = var_16_5(var_16_4, var_9(var_1_10010))

	var_16_6.enabled = var_16_0

	if var_16_0 then
		pg = var_16_6

		local var_16_7 = var_16_6.equip_skin_template[arg_16_2]

		assert = var_16_4

		var_16_4(var_16_7, "miss config equip_skin_template >> " .. arg_16_2)

		local var_16_8 = arg_16_1:Find("info/display_panel/name_container/name")
		local var_16_9 = var_8.GetComponent

		typeof = var_10
		Text = var_11

		local var_16_10 = var_16_9(var_16_8, var_10(var_11))
		local var_16_11 = arg_16_1:Find("info/display_panel/desc")
		local var_16_12 = var_9.GetComponent

		typeof = var_11
		Text = var_1_10012

		local var_16_13 = var_16_12(var_16_11, var_11(var_1_10012))

		var_16_10.text = var_16_7.name
		var_16_13.text = var_16_7.desc
		_ = var_10

		local var_16_14 = var_10.map(var_16_7.equip_type, function(arg_17_0)
			EquipType = var_2_10001

			return var_2_10001.Type2Name2(arg_17_0)
		end)

		setScrollText = var_11

		local var_16_15 = arg_16_1
		local var_16_16 = arg_16_1.Find(var_16_15, "info/display_panel/equip_type/mask/Text")

		table = var_16_15

		var_11(var_16_16, var_16_15.concat(var_16_14, ","))

		local var_16_17 = arg_16_1
		local var_16_18 = arg_16_1.Find(var_16_17, "info/play_btn")

		setActive = var_16_17

		var_16_17(var_16_18, true)

		onButton = var_16_17

		local var_16_19 = arg_16_0
		local var_16_20 = var_16_18

		local function var_16_21()
			local var_18_0 = arg_16_0
			local var_18_1 = var_0.emit

			EquipmentSkinMediator = var_2_10002

			var_18_1(var_18_0, var_2_10002.ON_PREVIEW, arg_16_2)

			return
		end

		SFX_PANEL = var_1_10016

		var_16_17(var_16_19, var_16_20, var_16_21, var_1_10016)

		updateDrop = var_16_17

		local var_16_22 = arg_16_1
		local var_16_23 = arg_16_1.Find(var_16_22, "info/equip")

		Drop = var_16_22

		local var_16_24 = var_16_22.New
		local var_16_25 = {}

		DROP_TYPE_EQUIPMENT_SKIN = var_1_10016
		var_16_25.type = var_1_10016
		var_16_25.id = arg_16_2

		var_16_17(var_16_23, var_16_24(var_16_25))

		local var_16_26 = arg_16_1

		if arg_16_1.Find(var_16_26, "info/head") then
			setActive = var_16_26

			var_16_26(var_12, arg_16_3)

			if arg_16_3 then
				assert = var_16_26

				var_16_26(arg_16_3.id, "old ship id is nil")

				assert = var_16_26

				var_16_26(arg_16_3.pos, "old ship pos is nil")

				getProxy = var_16_26
				BayProxy = var_14

				local var_16_27 = var_16_26(var_14)

				if var_13.getShipById(var_16_27, arg_16_3.id) then
					setImageSprite = var_16_27

					local var_16_28 = var_12
					local var_16_29 = var_12.Find(var_16_28, "Image")

					LoadSprite = var_16_28

					var_16_27(var_16_29, var_16_28("qicon/" .. var_13:getPainting()))
				end
			end
		end
	end

	return
end

function var_0_1.willExit(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_0, arg_19_0._tf, arg_19_0.UIMain)

	return
end

return var_0_1
