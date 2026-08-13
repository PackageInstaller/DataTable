class = var_0_10000

local var_0_0 = "NewYearHotSpringShipSelectLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

import = var_0_0

local var_0_2 = var_0_0(".NewYearHotSpringFormationCard")

function var_0_1.getUIName(arg_1_0)
	return "NewYearHotSpringShipSelectUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/top/value/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.counterTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.cardContainer = var_1.Find(var_2_3, "frame/panel")

	local var_2_4 = arg_2_0._tf

	arg_2_0.mainPanel = var_1.Find(var_2_4, "frame")

	local var_2_5 = arg_2_0.cardContainer

	arg_2_0.addShipTpl = var_1.Find(var_2_5, "AddShipTpl")

	local var_2_6 = arg_2_0.cardContainer

	arg_2_0.extendShipTpl = var_1.Find(var_2_6, "ExtendShipTpl")

	local var_2_7 = arg_2_0.cardContainer

	arg_2_0.shipCardTpl = var_1.Find(var_2_7, "ShipCardTpl")
	setActive = var_1

	var_1(arg_2_0.addShipTpl, false)

	setActive = var_1

	var_1(arg_2_0.extendShipTpl, false)

	setActive = var_1

	var_1(arg_2_0.shipCardTpl, false)

	local var_2_8 = arg_2_0.cardContainer

	arg_2_0.cardContainer = var_1.Find(var_2_8, "Scroll View/Content")
	arg_2_0.shipCards = {}
	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "frame/desc")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("hotspring_tip1"))

	return
end

function var_0_1.SetActivity(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "BG")

	var_1.SetSiblingIndex(var_4_1, 0)

	onButton = var_1

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_3.Find(var_4_3, "BG")

	local function var_4_5()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_2, var_4_4, var_4_5, var_5)

	local function var_4_6(arg_6_0)
		setActive = var_2_10001

		local var_6_0 = arg_4_0._tf

		var_2_10001(var_2.Find(var_6_0, "frame/panel/ArrowRight"), arg_6_0.x < 0.01)

		setActive = var_2_10001

		local var_6_1 = arg_4_0._tf

		var_2_10001(var_2.Find(var_6_1, "frame/panel/ArrowLeft"), arg_6_0.x > 0.99)

		return
	end

	onScroll = var_4_2

	var_4_2(arg_4_0, arg_4_0.cardContainer.parent, var_4_6)
	var_4_6({
		x = 0
	})
	arg_4_0:BlurPanel(arg_4_0._tf)
	arg_4_0:UpdateSlots()

	return
end

function var_0_1.UpdateSlots(arg_7_0)
	local var_7_0 = arg_7_0.activity
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = arg_7_0

	arg_7_0.CleanCards(var_7_3)

	_ = var_4

	local var_7_4 = var_4.each

	_ = var_7_3

	var_7_4(var_7_3.range(1, var_7_0:GetTotalSlotCount()), function(arg_8_0)
		local var_8_0 = var_7_0
		local var_8_1

		if not var_1.GetShipIds(var_8_0)[arg_8_0] then
			var_8_1 = 0
		end

		math = var_8_0

		local var_8_2 = var_8_0.clamp
		local var_8_3 = var_7_0
		local var_8_4 = var_8_2(arg_8_0 - var_3.GetSlotCount(var_8_3), 0, 2)
		local var_8_6

		if 0 < var_8_1 then
			getProxy = var_3
			BayProxy = var_4

			local var_8_5 = var_3(var_4)

			var_8_6 = var_3.RawGetShipById(var_8_5, var_8_1)
		else
			var_8_6 = false
		end

		if false then
			var_8_6 = true
		end

		local var_8_7 = arg_7_0

		var_4.AddCard(var_8_7, arg_8_0, var_8_4, var_8_6)

		var_7_1 = var_7_1 + (var_8_4 == 0 and 1 or 0)
		var_7_2 = var_7_2 + (var_8_6 and 1 or 0)

		return
	end)

	arg_7_0.counterTxt.text = var_7_2 .. "/" .. var_7_1

	return
end

function var_0_1.AddCard(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0

	if arg_9_2 == 0 and arg_9_3 then
		cloneTplTo = var_1_10005

		local var_9_1 = var_1_10005(arg_9_0.shipCardTpl, arg_9_0.cardContainer)

		var_1_10005 = var_9_0.Find(var_9_1, "content")

		local var_9_2 = var_0_2.New

		go = var_7

		local var_9_3 = var_9_2(var_7(var_9_0))

		onButton = var_7

		local var_9_4 = arg_9_0
		local var_9_5 = var_1_10005

		function var_1_10010()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			NewYearHotSpringShipSelectMediator = var_2_10002

			var_10_1(var_10_0, var_2_10002.OPEN_CHUANWU, arg_9_1, arg_9_3)

			return
		end

		SFX_PANEL = var_1_10011

		var_7(var_9_4, var_9_5, var_1_10010, var_1_10011)

		GetOrAddComponent = var_7

		local var_9_6 = var_1_10005

		typeof = var_9_5
		UILongPressTrigger = var_1_10010

		local var_9_7 = var_7(var_9_6, var_9_5(var_1_10010)).onLongPressed

		var_8.RemoveAllListeners(var_9_7)

		local var_9_8 = var_7.onLongPressed

		var_8.AddListener(var_9_8, function()
			if not arg_9_3 then
				return
			end

			local var_11_0 = arg_9_0
			local var_11_1 = var_0.emit

			NewYearHotSpringShipSelectMediator = var_2_10002

			var_11_1(var_11_0, var_2_10002.LOOG_PRESS_SHIP, arg_9_1, arg_9_3)

			return
		end)
		var_9_3:update(arg_9_3)

		local var_9_9 = arg_9_3:getRecoverEnergyPoint()

		var_1_10010 = arg_9_0.activity

		local var_9_10 = var_9_9 + var_9.GetEnergyRecoverAddition(var_1_10010)
		local var_9_11 = 0

		getProxy = var_1_10010
		DormProxy = var_1_10011

		local var_9_12 = var_1_10010(var_1_10011)
		local var_9_13 = var_1_10010.getRawData(var_9_12)
		local var_9_14, var_9_15 = var_1_10010.InBackYard(var_9_13, arg_9_3.id)

		if var_9_14 then
			DormShip = var_13

			if var_9_15 == var_13.FLOOR_1 then
				Ship = var_13
				var_9_10 = var_9_10 + var_13.BACKYARD_1F_ENERGY_ADDITION
			else
				DormShip = var_13

				if var_9_15 == var_13.FLOOR_2 then
					Ship = var_13
					var_9_10 = var_9_10 + var_13.BACKYARD_2F_ENERGY_ADDITION
				end
			end

			ipairs = var_13
			BuffHelper = var_1_10014

			for iter_9_0, iter_9_1 in var_13(var_1_10014.GetBackYardEnergyBuffs()) do
				tonumber = var_1_10018
				var_9_11 = var_9_11 + var_1_10018(iter_9_1:getConfig("benefit_effect"))
			end
		end

		local var_9_16 = var_9_3
		local var_9_17 = var_9_3.updateProps1
		local var_9_18 = {}
		local var_9_19 = {}

		i18n = iter_9_1
		var_9_19[1] = iter_9_1("word_lv")
		var_9_19[2] = arg_9_3.level
		var_9_18[1] = var_9_19

		local var_9_20 = {}

		i18n = var_17
		var_9_20[1] = var_17("word_nowenergy")
		var_9_20[2] = arg_9_3.energy
		var_9_18[2] = var_9_20

		local var_9_21 = {}

		i18n = var_17
		var_9_21[1] = var_17("word_energy_recov_speed")
		setColorStr = var_17

		local var_9_22 = 10 * var_9_10

		COLOR_GREEN = var_1_10019

		local var_9_23 = var_17(var_9_22, var_1_10019)

		if 0 < var_9_11 then
			setColorStr = var_18

			local var_9_24 = "+" .. 10 * var_9_11

			COLOR_GREEN = var_20

			local var_9_25

			if not var_18(var_9_24, var_20) then
				var_9_25 = ""
			end

			var_9_21[2] = var_9_23 .. var_9_25 .. "/h"
			var_9_18[3] = var_9_21

			var_9_17(var_9_16, var_9_18)

			setActive = var_9_17

			var_9_17(var_9_3.propsTr, false)

			setActive = var_9_17

			var_9_17(var_9_3.propsTr1, true)

			table = var_9_17

			var_9_17.insert(arg_9_0.shipCards, {
				info = var_9_3,
				longpressedTigger = var_7
			})

			if false then
				cloneTplTo = var_1_10005

				local var_9_26 = var_1_10005(arg_9_0.extendShipTpl, arg_9_0.cardContainer)

				var_1_10005 = var_9_0.Find(var_9_26, "content")
				setActive = var_9_26

				var_9_26(var_1_10005:Find("label/add"), arg_9_2 == 0)

				setActive = var_9_26

				var_9_26(var_1_10005:Find("label/unlock"), arg_9_2 == 1)

				setActive = var_9_26

				var_9_26(var_1_10005:Find("label/lock"), arg_9_2 == 2)

				setActive = var_9_26

				var_9_26(var_1_10005:Find("mask"), arg_9_2 == 2)

				if arg_9_2 == 0 then
					onButton = var_9_26

					local var_9_27 = arg_9_0
					local var_9_28 = var_1_10005

					local function var_9_29()
						local var_12_0 = arg_9_0
						local var_12_1 = var_0.emit

						NewYearHotSpringShipSelectMediator = var_2_10002

						var_12_1(var_12_0, var_2_10002.OPEN_CHUANWU, arg_9_1)

						return
					end

					SFX_PANEL = var_1_10010

					var_9_26(var_9_27, var_9_28, var_9_29, var_1_10010)
				elseif arg_9_2 == 1 then
					onButton = var_9_26

					local var_9_30 = arg_9_0
					local var_9_31 = var_1_10005

					local function var_9_32()
						local var_13_0 = arg_9_0
						local var_13_1 = var_0.emit

						NewYearHotSpringShipSelectMediator = var_2_10002

						var_13_1(var_13_0, var_2_10002.EXTEND, arg_9_1)

						return
					end

					SFX_PANEL = var_1_10010

					var_9_26(var_9_30, var_9_31, var_9_32, var_1_10010)
				elseif arg_9_2 == 2 then
					-- block empty
				end
			end

			setActive = var_1_10005

			var_1_10005(var_9_0, true)

			return
		end
	end
end

function var_0_1.CleanCards(arg_14_0)
	_ = var_1_10001

	var_1_10001.each(arg_14_0.shipCards, function(arg_15_0)
		local var_15_0 = arg_15_0.longpressedTigger.onLongPressed

		var_1.RemoveAllListeners(var_15_0)

		local var_15_1 = arg_15_0.info

		var_1.clear(var_15_1)

		return
	end)

	arg_14_0.shipCards = {}
	removeAllChildren = var_1

	var_1(arg_14_0.cardContainer)

	return
end

function var_0_1.willExit(arg_16_0)
	arg_16_0:UnOverlayPanel(arg_16_0._tf)
	arg_16_0:CleanCards()

	return
end

return var_0_1
