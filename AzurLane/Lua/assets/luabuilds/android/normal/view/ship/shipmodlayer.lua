class = var_0_10000

local var_0_0 = "ShipModLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 12

var_0_1.IGNORE_ID = 4

function var_0_1.getUIName(arg_1_0)
	return "ShipModUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "ShipMainScene"
end

function var_0_1.setShipVOs(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.blurPanelTF = var_1.Find(var_4_0, "blur_panel")

	local var_4_1 = arg_4_0._tf

	arg_4_0.mainPanel = var_1.Find(var_4_1, "blur_panel/main")

	local var_4_2 = arg_4_0.mainPanel

	arg_4_0.shipContainer = var_1.Find(var_4_2, "bg/add_ship_panel/ships")

	local var_4_3 = arg_4_0.mainPanel

	arg_4_0.attrsPanel = var_1.Find(var_4_3, "bg/property_panel/attrs")
	setText = var_1

	local var_4_4 = arg_4_0.mainPanel
	local var_4_5 = var_2.Find(var_4_4, "bg/add_ship_panel/title/tip")

	i18n = var_4_4

	var_1(var_4_5, var_4_4("ship_mod_exp_to_attr_tip"))

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.mainPanel
	local var_5_2 = var_3.Find(var_5_1, "ok_btn")

	local function var_5_3()
		local function var_6_0()
			ShipStatus = var_3_10000

			local var_7_0, var_7_1 = var_3_10000.ShipStatusCheck("onModify", arg_5_0.shipVO)

			if not var_7_0 then
				pg = var_2

				local var_7_2 = var_2.TipsMgr.GetInstance()

				var_2.ShowTips(var_7_2, var_7_1)

				return
			end

			if not arg_5_0.contextData.materialShipIds or #arg_5_0.contextData.materialShipIds == 0 then
				pg = var_2

				local var_7_3 = var_2.TipsMgr.GetInstance()
				local var_7_4 = var_2.ShowTips

				i18n = var_3_10004

				var_7_4(var_7_3, var_3_10004("word_materal_no_enough"))

				return
			else
				local var_7_5 = arg_5_0

				var_2.startModShip(var_7_5)
			end

			return
		end

		local var_6_1 = arg_5_0.shipVO

		if var_1.isActivityNpc(var_6_1) then
			pg = var_1

			local var_6_2 = var_1.MsgboxMgr.GetInstance()
			local var_6_3 = var_1.ShowMsgBox
			local var_6_4 = {}

			i18n = var_2_10004
			var_6_4.content = var_2_10004("npc_strength_tip")
			var_6_4.onYes = var_6_0

			var_6_3(var_6_2, var_6_4)
		else
			var_6_0()
		end

		return
	end

	SFX_CONFIRM = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.mainPanel
	local var_5_6 = var_3.Find(var_5_5, "cancel_btn")

	local function var_5_7()
		if arg_5_0.contextData.materialShipIds then
			table = var_2_10001

			if var_2_10001.getCount(var_0) == 0 then
				return
			end

			local var_8_0 = arg_5_0

			var_1.clearAllShip(var_8_0)

			return
		end
	end

	SFX_CANCEL = var_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.mainPanel
	local var_5_10 = var_3.Find(var_5_9, "select_btn")

	local function var_5_11()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		ShipModMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_AUTO_SELECT_SHIP)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5)
	arg_5_0:initAttrs()

	arg_5_0.inited = true

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.emit

	ShipModMediator = var_5_10

	var_5_13(var_5_12, var_5_10.LOADEND, arg_5_0.mainPanel)
	arg_5_0:blurPanel(true)

	return
end

function var_0_1.blurPanel(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.OverlayPanel
		local var_10_2 = arg_10_0.blurPanelTF
		local var_10_3 = {}
		local var_10_4 = {}
		local var_10_5 = arg_10_0.mainPanel

		var_10_4[1] = var_7.Find(var_10_5, "bg")
		var_10_3.pbList = var_10_4
		LayerWeightConst = var_10_4
		var_10_3.overlayType = var_10_4.OVERLAY_UI_ADAPT

		var_10_1(var_10_0, var_10_2, var_10_3)
	else
		arg_10_0:UnOverlayPanel(arg_10_0.blurPanelTF, arg_10_0._tf)
	end

	return
end

function var_0_1.startModShip(arg_11_0)
	if not arg_11_0.hasAddition then
		pg = var_1

		local var_11_0 = var_1.MsgboxMgr.GetInstance()
		local var_11_1 = var_1.ShowMsgBox

		var_1_10003 = {}
		i18n = var_1_10004
		var_1_10003.content = var_1_10004("ship_mod_no_addition_tip")

		function var_1_10003.onYes()
			local var_12_0 = arg_11_0
			local var_12_1 = var_0.emit

			ShipModMediator = var_2_10002

			var_12_1(var_12_0, var_2_10002.MOD_SHIP, arg_11_0.shipVO.id)

			return
		end

		var_11_1(var_11_0, var_1_10003)
	else
		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.emit

		ShipModMediator = var_1_10003

		var_11_3(var_11_2, var_1_10003.MOD_SHIP, arg_11_0.shipVO.id)
	end

	return
end

function var_0_1.setShip(arg_13_0, arg_13_1)
	arg_13_0.shipVO = arg_13_1

	arg_13_0:initSelectedShips()

	if arg_13_0.inited then
		arg_13_0:initAttrs()
	end

	return
end

function var_0_1.clearAllShip(arg_14_0)
	for iter_14_0 = 1, var_0_2 do
		local var_14_0 = arg_14_0.shipContainer
		local var_14_1 = var_5.GetChild(var_14_0, iter_14_0 - 1)

		setActive = var_14_0

		var_14_0(var_14_1:Find("IconTpl"), false)

		onButton = var_14_0

		local var_14_2 = arg_14_0
		local var_14_3 = var_14_1:Find("add")

		local function var_14_4()
			local var_15_0 = arg_14_0
			local var_15_1 = var_0.emit

			ShipModMediator = var_2_10002

			var_15_1(var_15_0, var_2_10002.ON_SELECT_MATERIAL_SHIPS)

			return
		end

		SFX_PANEL = var_10

		var_14_0(var_14_2, var_14_3, var_14_4, var_10)
	end

	arg_14_0.contextData.materialShipIds = nil

	arg_14_0:updateAttrs()

	return
end

function var_0_1.initSelectedShips(arg_16_0)
	local var_16_0

	if not arg_16_0.contextData.materialShipIds then
		var_16_0 = {}
	end

	table = var_1_10002

	local var_16_1 = var_1_10002.getCount(var_16_0)

	for iter_16_0 = 1, var_0_2 do
		local var_16_2 = arg_16_0.shipContainer
		local var_16_3 = var_7.GetChild(var_16_2, iter_16_0 - 1)

		if iter_16_0 <= var_16_1 then
			arg_16_0:updateShip(var_16_3, var_16_0[iter_16_0])
		else
			onButton = var_16_2

			local var_16_4 = arg_16_0
			local var_16_5 = var_16_3:Find("add")

			local function var_16_6()
				local var_17_0 = arg_16_0
				local var_17_1 = var_0.emit

				ShipModMediator = var_2_10002

				var_17_1(var_17_0, var_2_10002.ON_SELECT_MATERIAL_SHIPS)

				return
			end

			SFX_PANEL = var_12

			var_16_2(var_16_4, var_16_5, var_16_6, var_12)
		end

		setActive = var_16_2

		var_16_2(var_16_3:Find("IconTpl"), iter_16_0 <= var_16_1)
	end

	return
end

function var_0_1.updateShip(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.shipVOs[arg_18_2]

	onButton = var_1_10004

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_1

	local function var_18_3()
		ipairs = var_2_10000

		for iter_19_0, iter_19_1 in var_2_10000(arg_18_0.contextData.materialShipIds) do
			if arg_18_2 == iter_19_1 then
				local var_19_0 = arg_18_1
				local var_19_1 = var_5.Find(var_19_0, "add")

				setActive = var_19_0

				local var_19_2 = arg_18_1

				var_19_0(var_7.Find(var_19_2, "IconTpl"), false)

				onButton = var_19_0

				local var_19_3 = arg_18_0
				local var_19_4 = var_19_1

				local function var_19_5()
					local var_20_0 = arg_18_0
					local var_20_1 = var_0.emit

					ShipModMediator = var_3_10002

					var_20_1(var_20_0, var_3_10002.ON_SELECT_MATERIAL_SHIPS)

					return
				end

				SFX_PANEL = var_2_10010

				var_19_0(var_19_3, var_19_4, var_19_5, var_2_10010)

				table = var_19_0

				var_19_0.remove(arg_18_0.contextData.materialShipIds, iter_19_0)

				local var_19_6 = arg_18_0

				var_6.updateAttrs(var_19_6)

				break
			end
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10004(var_18_1, var_18_2, var_18_3, var_1_10008)

	updateShip = var_1_10004

	var_1_10004(arg_18_1:Find("IconTpl"), var_18_0, {
		initStar = true
	})

	setText = var_1_10004

	var_1_10004(arg_18_1:Find("IconTpl/icon_bg/lv/Text"), var_18_0.level)

	return
end

function var_0_1.initAttrs(arg_21_0)
	arg_21_0.attrTFs = {}
	pairs = var_1
	ShipModAttr = var_1_10002

	for iter_21_0, iter_21_1 in var_1(var_1_10002.ID_TO_ATTR) do
		if arg_21_0.IGNORE_ID ~= iter_21_0 then
			local var_21_0 = arg_21_0.attrsPanel
			local var_21_1 = var_6.Find(var_21_0, "attr_" .. iter_21_0)

			arg_21_0.attrTFs[iter_21_0] = var_21_1
		end
	end

	arg_21_0:updateAttrs()

	return
end

function var_0_1.updateAttrs(arg_22_0)
	arg_22_0.hasAddition = nil
	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.attrTFs) do
		arg_22_0:updateAttr(iter_22_0)
	end

	return
end

function var_0_1.updateAttr(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.attrTFs[arg_23_1]
	local var_23_1 = var_2.Find(var_23_0, "info")
	local var_23_2 = var_2
	local var_23_3 = var_2.GetComponent

	typeof = var_1_10006
	CanvasGroup = var_1_10007

	local var_23_4 = var_23_3(var_23_2, var_1_10006(var_1_10007))

	ShipModAttr = var_23_2

	local var_23_5 = var_23_2.ID_TO_ATTR[arg_23_1]
	local var_23_6 = arg_23_0.shipVO
	local var_23_7 = var_6.getModAttrTopLimit(var_23_6, var_23_5)

	intProperties = var_23_6

	local var_23_8 = arg_23_0.shipVO
	local var_23_9 = var_23_6(var_8.getShipProperties(var_23_8))
	local var_23_10 = arg_23_0:getMaterialShips(arg_23_0.contextData.materialShipIds)
	local var_23_11 = var_0_1.getExpAddition(arg_23_0.shipVO, var_23_10, var_23_5)
	local var_23_12 = arg_23_0.shipVO
	local var_23_13 = var_10.getModExpRatio(var_23_12, var_23_5)

	math = var_23_12

	local var_23_14 = var_23_12.max
	local var_23_15 = arg_23_0.shipVO
	local var_23_16 = var_23_14(var_12.getModExpRatio(var_23_15, var_23_5), 1)

	if var_23_11 ~= 0 then
		arg_23_0.hasAddition = true
	end

	local var_23_17 = arg_23_0.shipVO
	local var_23_18 = var_12.getModAttrBaseMax(var_23_17, var_23_5)
	local var_23_19 = arg_23_0.getRemainExp(arg_23_0.shipVO, var_23_5)

	math = var_14

	local var_23_20 = var_14.max

	math = var_15

	local var_23_21 = var_15.min

	math = var_1_10016

	local var_23_22 = var_23_20(var_23_21(var_1_10016.floor((var_23_19 + var_23_11) / var_23_16), var_23_18 - var_23_9[var_23_5]), 0)

	setText = var_15

	var_15(var_23_1:Find("info_container/addition"), "+" .. var_23_22)

	setText = var_15

	local var_23_23 = var_23_1
	local var_23_24 = var_23_1.Find(var_23_23, "info_container/name")

	AttributeType = var_23_23

	var_15(var_23_24, var_23_23.Type2Name(var_23_5))

	setText = var_15

	var_15(var_23_1:Find("max_container/Text"), var_23_18)

	setText = var_15

	var_15(var_23_1:Find("info_container/value"), var_23_9[var_23_5])

	var_23_4.alpha = var_23_9[var_23_5] == 0 and 0.3 or 1

	local var_23_25 = var_23_1:Find("prev_slider")
	local var_23_26 = var_15.GetComponent

	typeof = var_17
	Slider = var_18

	local var_23_27 = var_23_26(var_23_25, var_17(var_18))

	arg_23_0:setSliderValue(var_23_27, (var_23_11 + var_23_19) / var_23_16)

	local var_23_28 = var_23_19 / var_23_16
	local var_23_29 = var_23_19 + var_23_11 .. "/" .. var_23_13

	if var_23_18 == var_23_9[var_23_5] and var_23_9[var_23_5] ~= 0 then
		var_23_28 = 1
		var_23_29 = "MAX"
	end

	local var_23_30 = var_23_1:Find("cur_slider")
	local var_23_31 = var_18.GetComponent

	typeof = var_20
	Slider = var_1_10021

	local var_23_32 = var_23_31(var_23_30, var_20(var_1_10021))

	arg_23_0:setSliderValue(var_23_32, var_23_28)

	setText = var_19

	var_19(var_2:Find("exp_container/Text"), var_23_29)

	return
end

function var_0_1.modAttrAnim(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_3 or 0.3

	intProperties = var_1_10005

	local var_24_1 = var_1_10005(arg_24_1:getShipProperties())

	intProperties = var_6

	local var_24_2 = var_6(arg_24_2:getShipProperties())

	arg_24_0.tweens = {}
	pairs = var_7

	for iter_24_0, iter_24_1 in var_7(arg_24_0.attrTFs) do
		ShipModAttr = var_1_10012
		var_1_10012 = var_1_10012.ID_TO_ATTR[iter_24_0]

		local var_24_3 = arg_24_1:getModAttrTopLimit(var_1_10012)
		local var_24_4 = arg_24_0.shipVO
		local var_24_5 = var_14.getModAttrBaseMax(var_24_4, var_1_10012)

		if var_24_3 == 0 then
			arg_24_0:updateAttr(iter_24_0)
		else
			local var_24_6 = arg_24_0.attrTFs[iter_24_0]
			local var_24_7 = var_15.Find(var_24_6, "info")
			local var_24_8 = var_16.Find(var_24_7, "info_container/value")
			local var_24_9 = var_24_1[var_1_10012] - var_24_2[var_1_10012]

			math = var_19

			local var_24_10 = var_19.max(arg_24_1:getModExpRatio(var_1_10012), 1)
			local var_24_11 = var_16:Find("cur_slider")
			local var_24_12 = var_16:Find("prev_slider")
			local var_24_13 = var_24_11
			local var_24_14 = var_24_11.GetComponent

			typeof = var_1_10024
			Slider = var_1_10025

			local var_24_15 = var_24_14(var_24_13, var_1_10024(var_1_10025))

			var_1_10024 = var_24_12

			local var_24_16 = var_24_12.GetComponent

			typeof = var_1_10025
			Slider = var_1_10026

			local var_24_17 = var_24_16(var_1_10024, var_1_10025(var_1_10026))

			var_1_10024 = arg_24_0.getRemainExp(arg_24_1, var_1_10012)
			var_1_10026 = var_16
			var_1_10025 = var_16.Find(var_1_10026, "info_container/addition")
			var_1_10026 = var_15:Find("exp_container/Text")

			arg_24_0:setSliderValue(var_24_17, 0)

			setText = var_27

			var_27(var_15:Find("exp_container/Text"), var_1_10024 .. "/" .. var_24_10)

			local function var_24_18(arg_25_0, arg_25_1)
				setText = var_2_10002

				var_2_10002(var_24_8, arg_25_0)

				setText = var_2_10002

				var_2_10002(var_1_10025, "+" .. arg_25_1)

				return
			end

			if var_24_9 >= 1 then
				local var_24_19 = var_24_2[var_1_10012]

				arg_24_0:tweenValue(var_24_15, var_24_15.value, 1, var_24_0, nil, function(arg_26_0)
					local var_26_0 = arg_24_0

					var_1.setSliderValue(var_26_0, var_24_15, arg_26_0)

					return
				end, function()
					pg = var_2_10000

					local var_27_0 = var_2_10000.CriMgr.GetInstance()
					local var_27_1 = var_0.PlaySoundEffect_V3

					SFX_BREAK_OUT_FULL = var_2_10002

					var_27_1(var_27_0, var_2_10002)

					var_24_19 = var_24_19 + 1

					var_24_18(var_24_19, var_24_1[var_1_10012] - var_24_19)

					if var_24_1[var_1_10012] - var_24_19 > 0 then
						local var_27_2 = arg_24_0

						var_1.tweenValue(var_27_2, var_24_15, 0, 1, var_24_0, nil, function(arg_28_0)
							local var_28_0 = arg_24_0

							var_1.setSliderValue(var_28_0, var_24_15, arg_28_0)

							return
						end, function()
							pg = var_3_10000

							local var_29_0 = var_3_10000.CriMgr.GetInstance()
							local var_29_1 = var_0.PlaySoundEffect_V3

							SFX_BREAK_OUT_FULL = var_3_10002

							var_29_1(var_29_0, var_3_10002)

							var_24_19 = var_24_19 + 1

							var_24_18(var_24_19, var_24_1[var_1_10012] - var_24_19)

							if var_24_19 == var_24_1[var_1_10012] then
								local var_29_2 = arg_24_0

								var_0.tweenValue(var_29_2, var_24_15, 0, var_1_10024 / var_24_10, var_24_0, nil, function(arg_30_0)
									local var_30_0 = arg_24_0

									var_1.setSliderValue(var_30_0, var_24_15, arg_30_0)

									return
								end, function()
									if var_24_5 == var_24_1[var_1_10012] then
										local var_31_0 = arg_24_0

										var_0.setSliderValue(var_31_0, var_24_15, 1)

										setText = var_0

										var_0(var_1_10026, "MAX")
									end

									return
								end)
							end

							return
						end, var_0)
					else
						local var_27_3 = arg_24_0

						var_1.tweenValue(var_27_3, var_24_15, 0, var_1_10024 / var_24_10, var_24_0, nil, function(arg_32_0)
							local var_32_0 = arg_24_0

							var_1.setSliderValue(var_32_0, var_24_15, arg_32_0)

							return
						end, function()
							if var_24_5 == var_24_1[var_1_10012] then
								local var_33_0 = arg_24_0

								var_0.setSliderValue(var_33_0, var_24_15, 1)

								setText = var_0

								var_0(var_1_10026, "MAX")
							end

							return
						end)
					end

					return
				end)
			else
				arg_24_0:tweenValue(var_24_15, var_24_15.value, var_1_10024 / var_24_10, var_24_0, nil, function(arg_34_0)
					local var_34_0 = arg_24_0

					var_1.setSliderValue(var_34_0, var_24_15, arg_34_0)

					return
				end, function()
					if var_24_5 == var_24_1[var_1_10012] then
						local var_35_0 = arg_24_0

						var_0.setSliderValue(var_35_0, var_24_15, 1)

						setText = var_0

						var_0(var_1_10026, "MAX")
					end

					return
				end)
			end
		end
	end

	return
end

function var_0_1.tweenValue(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5, arg_36_6, arg_36_7, arg_36_8)
	assert = var_1_10009

	var_1_10009(not arg_36_0.exited, "tween after ui exited")

	if not arg_36_0.tweens then
		return
	end

	local var_36_0 = arg_36_0.tweens

	var_36_0[arg_36_1] = arg_36_1
	LeanTween = var_36_0

	local var_36_1 = var_36_0.cancel

	go = var_10

	var_36_1(var_10(arg_36_1))

	LeanTween = var_36_1

	local var_36_2 = var_36_1.value

	go = var_10

	local var_36_3 = var_36_2(var_10(arg_36_1), arg_36_2, arg_36_3, arg_36_4)
	local var_36_4 = var_9.setOnUpdate

	System = var_11

	local var_36_5 = var_36_4(var_36_3, var_11.Action_float(function(arg_37_0)
		if arg_36_6 then
			arg_36_6(arg_37_0)
		end

		return
	end))
	local var_36_6 = var_9.setDelay(var_36_5, arg_36_5 or 0)
	local var_36_7 = var_9.setOnComplete

	System = var_11

	local var_36_8 = var_36_7(var_36_6, var_11.Action(function()
		if arg_36_7 then
			arg_36_7()
		end

		return
	end))

	if arg_36_8 and arg_36_8 > 0 then
		var_36_8:setRepeat(arg_36_8)
	end

	return
end

function var_0_1.getBuffExp()
	BuffHelper = var_1_10000

	local var_39_0 = var_1_10000.GetShipModExpBuff()
	local var_39_1 = 0

	ipairs = var_1_10002

	for iter_39_0, iter_39_1 in var_1_10002(var_39_0) do
		math = var_1_10007
		var_1_10007 = var_1_10007.max

		local var_39_2

		if not iter_39_1 or not (iter_39_1:getConfig("benefit_effect") / 100) then
			var_39_2 = 0
		end

		var_39_1 = var_1_10007(var_39_2, var_39_1)
	end

	return var_39_1
end

function var_0_1.getModExpAdditions(arg_40_0, arg_40_1)
	pg = var_1_10002

	local var_40_0 = var_1_10002.ship_data_template[arg_40_0.configId].group_type

	pg = var_1_10004

	local var_40_1 = var_1_10004.ship_data_strengthen
	local var_40_2 = {}
	local var_40_3 = var_0_1.getBuffExp()

	pairs = var_1_10007
	ShipModAttr = var_1_10008

	for iter_40_0, iter_40_1 in var_1_10007(var_1_10008.ID_TO_ATTR) do
		local var_40_4 = 0

		ShipModLayer = var_1_10013

		if iter_40_0 ~= var_1_10013.IGNORE_ID then
			pairs = var_1_10013

			for iter_40_2, iter_40_3 in var_1_10013(arg_40_1) do
				local var_40_5 = var_2[iter_40_3.configId].strengthen_id

				assert = var_1_10020

				var_1_10020(var_40_1[var_40_5], "ship_data_strengthen>>" .. var_40_5)

				var_1_10020 = var_40_1[var_40_5].attr_exp[iter_40_0 - 1]

				if var_18.group_type == var_40_0 then
					var_1_10020 = var_1_10020 * 2
				end

				var_40_4 = var_40_4 + var_1_10020
			end
		end

		math = var_1_10013
		var_40_2[iter_40_1] = var_1_10013.floor(var_40_4 * (1 + var_40_3))
	end

	return var_40_2
end

function var_0_1.getMaterialShips(arg_41_0, arg_41_1)
	local var_41_0 = {}

	ipairs = var_1_10003

	for iter_41_0, iter_41_1 in var_1_10003(arg_41_1 or {}) do
		table = var_1_10008

		var_1_10008.insert(var_41_0, arg_41_0.shipVOs[iter_41_1])
	end

	return var_41_0
end

function var_0_1.getExpAddition(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = var_0_1.getModExpAdditions(arg_42_0, arg_42_1)

	if arg_42_0:getModAttrTopLimit(arg_42_2) == 0 then
		return 0, 0
	else
		Clone = var_4

		local var_42_1 = var_4(arg_42_0)

		var_4.addModAttrExp(var_42_1, arg_42_2, var_42_0[arg_42_2])

		return var_4:getModProperties(arg_42_2) - arg_42_0:getModProperties(arg_42_2)
	end

	return
end

function var_0_1.getRemainExp(arg_43_0, arg_43_1)
	math = var_1_10002

	local var_43_0 = var_1_10002.max(arg_43_0:getModExpRatio(arg_43_1), 1)

	return arg_43_0:getModProperties(arg_43_1) % var_43_0
end

function var_0_1.setSliderValue(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_2 ~= 0 or not arg_44_2 then
		::label_44_0::

		math = var_1_10003
		var_1_10003 = var_1_10003.max(arg_44_2, 0.08)
	end

	arg_44_1.value = var_1_10003

	return
end

function var_0_1.willExit(arg_45_0)
	arg_45_0:blurPanel(false)

	pairs = var_1

	local var_45_0

	if not arg_45_0.tweens then
		var_45_0 = {}
	end

	for iter_45_0, iter_45_1 in var_1(var_45_0) do
		LeanTween = var_1_10006
		var_1_10006 = var_1_10006.cancel
		go = var_1_10007

		var_1_10006(var_1_10007(iter_45_1))
	end

	arg_45_0.tweens = nil

	return
end

function var_0_1.onBackPressed(arg_46_0)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.emit

	BaseUI = var_1_10003

	var_46_1(var_46_0, var_1_10003.ON_BACK_PRESSED, true)

	return
end

return var_0_1
