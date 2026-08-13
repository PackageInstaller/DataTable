class = var_0_10000

local var_0_0 = "NewBackYardShipInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewBackYardShipInfoUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/desc")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/top/value/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.counterTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.cardContainer = var_1.Find(var_2_6, "frame/panel")

	local var_2_7 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_7, "frame/top/close")

	local var_2_8 = arg_2_0._tf

	arg_2_0.mainPanel = var_1.Find(var_2_8, "frame")

	local var_2_9 = {}

	DormShip = var_2_8

	local var_2_10 = var_2_8.FLOOR_2
	local var_2_11 = arg_2_0._tf

	var_2_9[var_2_10] = var_3.Find(var_2_11, "frame/top/rest")
	DormShip = var_2_10

	local var_2_12 = var_2_10.FLOOR_1
	local var_2_13 = arg_2_0._tf

	var_2_9[var_2_12] = var_3.Find(var_2_13, "frame/top/train")
	arg_2_0.toggles = var_2_9

	local var_2_14 = {}

	DormShip = var_2_12

	local var_2_15 = var_2_12.FLOOR_2
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "frame/top/rest")
	local var_2_18 = var_3.GetComponent

	typeof = var_5
	Animation = var_1_10006
	var_2_14[var_2_15] = var_2_18(var_2_17, var_5(var_1_10006))
	DormShip = var_2_15

	local var_2_19 = var_2_15.FLOOR_1
	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "frame/top/train")
	local var_2_22 = var_3.GetComponent

	typeof = var_5
	Animation = var_1_10006
	var_2_14[var_2_19] = var_2_22(var_2_21, var_5(var_1_10006))
	arg_2_0.animations = var_2_14

	local var_2_23 = {}

	DormShip = var_2_19
	var_2_23[var_2_19.FLOOR_2] = {
		"anim_backyard_shipinfo_rest_Select",
		"anim_backyard_shipinfo_rest_unSelect"
	}
	DormShip = var_2
	var_2_23[var_2.FLOOR_1] = {
		"anim_backyard_shipinfo_train_Select",
		"anim_backyard_shipinfo_train_unSelect"
	}
	arg_2_0.animationName = var_2_23

	local var_2_24 = arg_2_0.cardContainer

	arg_2_0.addShipTpl = var_1.Find(var_2_24, "AddShipTpl")

	local var_2_25 = arg_2_0.cardContainer

	arg_2_0.extendShipTpl = var_1.Find(var_2_25, "ExtendShipTpl")

	local var_2_26 = arg_2_0.cardContainer

	arg_2_0.shipCardTpl = var_1.Find(var_2_26, "ShipCardTpl")
	arg_2_0.cards = {
		{},
		{},
		{}
	}
	table = var_1

	local var_2_27 = var_1.insert
	local var_2_28 = arg_2_0.cards[1]

	BackYardShipCard = var_3

	var_2_27(var_2_28, var_3.New(arg_2_0.shipCardTpl, arg_2_0.event))

	table = var_2_27

	local var_2_29 = var_2_27.insert
	local var_2_30 = arg_2_0.cards[2]

	BackYardEmptyCard = var_3

	var_2_29(var_2_30, var_3.New(arg_2_0.addShipTpl, arg_2_0.event))

	table = var_2_29

	local var_2_31 = var_2_29.insert
	local var_2_32 = arg_2_0.cards[3]

	BackYardExtendCard = var_3

	var_2_31(var_2_32, var_3.New(arg_2_0.extendShipTpl, arg_2_0.event))

	setText = var_2_31

	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_2.Find(var_2_33, "frame/desc1")

	i18n = var_2_33

	var_2_31(var_2_34, var_2_33("backyard_longpress_ship_tip"))

	setText = var_2_31

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_2.Find(var_2_35, "frame/top/rest/Text")

	i18n = var_2_35

	var_2_31(var_2_36, var_2_35("courtyard_label_rest"))

	setText = var_2_31

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_2.Find(var_2_37, "frame/top/train/Text")

	i18n = var_2_37

	var_2_31(var_2_38, var_2_37("courtyard_label_train"))

	setText = var_2_31

	local var_2_39 = arg_2_0._tf
	local var_2_40 = var_2.Find(var_2_39, "frame/top/rest/Text_un")

	i18n = var_2_39

	var_2_31(var_2_40, var_2_39("courtyard_label_rest"))

	setText = var_2_31

	local var_2_41 = arg_2_0._tf
	local var_2_42 = var_2.Find(var_2_41, "frame/top/train/Text_un")

	i18n = var_2_41

	var_2_31(var_2_42, var_2_41("courtyard_label_train"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	Color = var_1_10001

	local var_3_6 = var_1_10001.New(0.2235294, 0.227451, 0.2352941, 1)

	Color = var_2

	local var_3_7 = var_2.New(0.5137255, 0.5137255, 0.5137255, 1)

	pairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_0.toggles) do
		onToggle = var_1_10008

		local var_3_8 = arg_3_0
		local var_3_9 = iter_3_1

		local function var_3_10(arg_6_0)
			if arg_6_0 then
				local var_6_0 = arg_3_0

				var_1.SwitchToPage(var_6_0, iter_3_0)
			end

			local var_6_1 = iter_3_1
			local var_6_2 = var_1.Find(var_6_1, "icon")
			local var_6_3 = var_1.GetComponent

			typeof = var_3
			Image = var_2_10004

			local var_6_4 = var_6_3(var_6_2, var_3(var_2_10004))
			local var_6_5

			if not arg_6_0 or not var_3_6 then
				var_6_5 = var_3_7
			end

			var_6_4.color = var_6_5

			local var_6_6 = arg_3_0.animations[iter_3_0]
			local var_6_7 = arg_3_0.animationName[iter_3_0]
			local var_6_8 = arg_6_0 and 1 or 2

			var_6_6:Play(var_6_7[var_6_8])

			print = var_4

			var_4(var_6_7[var_6_8])

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10008(var_3_8, var_3_9, var_3_10, var_1_10012)
	end

	getProxy = var_3
	DormProxy = var_4

	local var_3_11 = var_3(var_4)
	local var_3_12 = var_3.getRawData(var_3_11)

	setActive = var_3_11

	var_3_11(arg_3_0.toggles[2], var_3_12:isUnlockFloor(2))

	onNextTick = var_3_11

	var_3_11(function()
		if arg_3_0.exited then
			return
		end

		local var_7_0

		if not arg_3_0.contextData.type then
			DormShip = var_7_0
			var_7_0 = var_7_0.FLOOR_1
		end

		local var_7_1 = {}

		DormShip = var_2_10002
		var_7_1[1] = var_2_10002.FLOOR_1
		DormShip = var_2
		var_7_1[2] = var_2.FLOOR_2
		ipairs = var_2

		for iter_7_0, iter_7_1 in var_2(var_7_1) do
			triggerToggle = var_2_10007

			var_2_10007(arg_3_0.toggles[iter_7_1], iter_7_1 == var_7_0)
		end

		return
	end)

	return
end

function var_0_1.GetCardTypeCnt(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	DormProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)
	local var_8_1 = var_2.getRawData(var_8_0)
	local var_8_2 = 0
	local var_8_3 = 0
	local var_8_4 = 0

	DormShip = var_1_10006

	if arg_8_1 == var_1_10006.FLOOR_1 then
		var_8_2 = var_8_1.exp_pos
		var_8_3 = var_8_1:getConfig("training_ship_number")
	else
		DormShip = var_6

		if arg_8_1 == var_6.FLOOR_2 then
			var_8_2 = var_8_1.rest_pos
			var_8_3 = var_8_1:getConfig("fix_ship_number")
		end
	end

	local var_8_5 = var_8_2 - var_8_1:GetFloorShipCnt(arg_8_1)
	local var_8_6 = var_8_3 - var_8_2

	return {
		var_6,
		var_8_5,
		var_8_6
	}
end

function var_0_1.SwitchToPage(arg_9_0, arg_9_1)
	if arg_9_0.type == arg_9_1 then
		return
	end

	arg_9_0.type = arg_9_1

	local var_9_0 = arg_9_0

	arg_9_0.UpdateSlots(var_9_0)

	DormShip = var_2

	local var_9_1

	if arg_9_1 == var_2.FLOOR_1 then
		var_9_1 = arg_9_0.descTxt
		i18n = var_9_0
		var_9_1.text = var_9_0("backyard_traning_tip")
	else
		DormShip = var_9_1

		if arg_9_1 == var_9_1.FLOOR_2 then
			local var_9_2 = arg_9_0.descTxt

			i18n = var_9_0
			var_9_2.text = var_9_0("backyard_rest_tip")
		end
	end

	return
end

function var_0_1.UpdateSlots(arg_10_0)
	local var_10_0 = arg_10_0.type
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.GetCardTypeCnt(var_10_1, var_10_0)

	getProxy = var_10_1
	DormProxy = var_4

	local var_10_3 = var_10_1(var_4)
	local var_10_4 = var_3.getRawData(var_10_3)
	local var_10_5 = var_3.GetBayShipOnFloor(var_10_4, var_10_0)
	local var_10_6 = 0
	local var_10_7 = {}

	ipairs = var_1_10007

	for iter_10_0, iter_10_1 in var_1_10007(var_10_2) do
		local var_10_8 = arg_10_0
		local var_10_9 = arg_10_0.GetTypeCards(var_10_8, iter_10_0, iter_10_1)

		ipairs = var_10_8

		for iter_10_2, iter_10_3 in var_10_8(var_10_9) do
			var_10_6 = var_10_6 + 1

			iter_10_3:Flush(var_10_0, var_10_5[iter_10_2])
			iter_10_3:SetSiblingIndex(var_10_6)
		end
	end

	arg_10_0.counterTxt.text = var_10_2[1] .. "/" .. var_10_2[2] + var_10_2[1]

	return
end

function var_0_1.GetTypeCards(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = #arg_11_0.cards[arg_11_1], arg_11_2 - 1 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_11_0 = var_3
		local var_11_1 = var_3[1]

		var_1_10008(var_11_0, var_10.Clone(var_11_1))
	end

	for iter_11_1 = #var_3, arg_11_2 + 1, -1 do
		local var_11_2 = var_3[iter_11_1]

		var_8.Disable(var_11_2)
	end

	local var_11_3 = {}

	for iter_11_2 = 1, arg_11_2 do
		local var_11_4 = var_3[iter_11_2]

		var_9.Enable(var_11_4)

		var_11_3[iter_11_2] = var_9
	end

	return var_11_3
end

function var_0_1.willExit(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.cards) do
		ipairs = var_1_10006

		for iter_12_2, iter_12_3 in var_1_10006(iter_12_1) do
			iter_12_3:Dispose()
		end
	end

	return
end

return var_0_1
