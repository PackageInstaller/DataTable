class = var_0_10000

local var_0_0 = "FragResolvePanel"

BaseSubPanel = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "FragResolveUI"
end

local var_0_2 = {
	"control",
	"resolve"
}

function var_0_1.OnInit(arg_2_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003
	arg_2_0.bagProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	TechnologyProxy = var_1_10003
	arg_2_0.technologyProxy = var_1(var_1_10003)
	arg_2_0.toggles = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(var_0_2) do
		local var_2_0 = iter_2_1 .. "Panel"
		local var_2_1 = arg_2_0._tf

		arg_2_0[var_2_0] = var_7.Find(var_2_1, iter_2_1)

		local var_2_2 = arg_2_0._tf
		local var_2_3 = var_6.Find(var_2_2, "toggle_controll/" .. iter_2_1)
		local var_2_4 = arg_2_0.toggles

		var_2_4[iter_2_1] = var_2_3
		onToggle = var_2_4

		local var_2_5 = arg_2_0
		local var_2_6 = var_2_3

		local function var_2_7(arg_3_0)
			arg_2_0["Reset" .. iter_2_1](arg_2_0)

			return
		end

		SFX_PANEL = var_1_10012

		var_2_4(var_2_5, var_2_6, var_2_7, var_1_10012)
	end

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_4.Find(var_2_9, "bg")

	local function var_2_11()
		local var_4_0 = arg_2_0

		var_0.Back(var_4_0)

		return
	end

	SFX_PANEL = var_2_9

	var_1(var_2_8, var_2_10, var_2_11, var_2_9)

	local var_2_12 = arg_2_0.controlPanel
	local var_2_13 = var_1.Find(var_2_12, "got/empty/Text")

	setText = var_2

	local var_2_14 = arg_2_0.controlPanel
	local var_2_15 = var_4.Find(var_2_14, "allMax/txt")

	i18n = var_2_11

	var_2(var_2_15, var_2_11("onebutton_max_tip"))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "control/condition/text")
	local var_2_18 = arg_2_0.resolvePanel
	local var_2_19 = var_3.Find(var_2_18, "cancel_button/label")

	PLATFORM_CODE = var_2_16
	PLATFORM_US = var_2_18

	if var_2_16 == var_2_18 then
		setTextEN = var_2_16

		local var_2_20 = var_2_17

		i18n = var_7

		var_2_16(var_2_20, var_7("fenjie_lantu_tip"))

		setTextEN = var_2_16

		local var_2_21 = var_2_13

		i18n = var_7

		var_2_16(var_2_21, var_7("fragresolve_empty_tip"))
	else
		setText = var_2_16

		local var_2_22 = var_2_17

		i18n = var_7

		var_2_16(var_2_22, var_7("fenjie_lantu_tip"))

		setText = var_2_16

		local var_2_23 = var_2_13

		i18n = var_7

		var_2_16(var_2_23, var_7("fragresolve_empty_tip"))
	end

	setText = var_2_16

	local var_2_24 = var_2_19

	i18n = var_7

	var_2_16(var_2_24, var_7("msgbox_text_cancel"))

	getProxy = var_2_16
	PlayerProxy = var_2_24

	local var_2_25 = var_2_16(var_2_24)
	local var_2_26 = var_4.getData(var_2_25)
	local var_2_27 = var_0_1
	local var_2_28 = arg_2_0._tf

	var_2_27.keepFateTog = var_6.Find(var_2_28, "control/condition/keep_tog")
	setText = var_2_27

	local var_2_29 = arg_2_0.keepFateTog
	local var_2_30 = var_7.Find(var_2_29, "label")

	i18n = var_2_28

	var_2_27(var_2_30, var_2_28("keep_fate_tip"))

	GetComponent = var_2_27

	local var_2_31 = arg_2_0.keepFateTog

	typeof = var_8
	Toggle = var_10

	local var_2_32 = var_2_27(var_2_31, var_8(var_10))
	local var_2_33 = var_0_1
	local var_2_34 = var_2_26
	local var_2_35 = var_2_26.GetCommonFlag

	SHOW_DONT_KEEP_FATE_ITEM = var_10
	var_2_33.keepFateState = not var_2_35(var_2_34, var_10)
	var_2_32.isOn = var_0_1.keepFateState
	onToggle = var_6

	var_6(arg_2_0, arg_2_0.keepFateTog, function(arg_5_0)
		var_0_1.keepFateState = arg_5_0

		local var_5_0 = arg_2_0
		local var_5_1 = var_1.emit

		NewShopMainMediator = var_2_10004

		local var_5_2 = var_2_10004.SET_PLAYER_FLAG

		SHOW_DONT_KEEP_FATE_ITEM = var_2_10005

		var_5_1(var_5_0, var_5_2, var_2_10005, not arg_5_0)

		local var_5_3 = arg_2_0

		var_1.Trigger(var_5_3, "control")

		return
	end)
	arg_2_0:Trigger("control")

	return
end

function var_0_1.OnShow(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.OnHide(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf)

	return
end

function var_0_1.Reset(arg_8_0)
	if arg_8_0.resolveItems then
		table = var_1

		var_1.clear(arg_8_0.resolveItems)
	end

	return
end

function var_0_1.Resetcontrol(arg_9_0)
	arg_9_0.blueprintItems = arg_9_0.GetAllBluePrintStrengthenItems()

	local var_9_0 = arg_9_0.blueprintItems
	local var_9_1 = arg_9_0.controlPanel
	local var_9_2 = var_2.Find(var_9_1, "got/empty")
	local var_9_3 = var_2:Find("got/list")

	setActive = var_9_1

	var_9_1(var_9_2, #var_9_0 <= 0)

	setActive = var_9_1

	var_9_1(var_9_3, #var_9_0 > 0)

	if #var_9_0 <= 0 then
		arg_9_0:Updatecontrol()

		return
	end

	local var_9_4 = {}

	ipairs = var_6

	local var_9_5

	if not arg_9_0.resolveItems then
		var_9_5 = {}
	end

	for iter_9_0, iter_9_1 in var_6(var_9_5) do
		var_9_4[iter_9_1.id] = iter_9_1
	end

	UIItemList = var_6

	var_6.StaticAlign(var_9_3, var_9_3:Find("item"), #var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			updateDrop = var_4

			var_4(arg_10_2:Find("icon"), var_10_0)

			math = var_4

			local var_10_1 = var_4.clamp
			local var_10_2

			if not var_9_4[var_10_0.id] or not var_9_4[var_10_0.id].curCount then
				var_10_2 = 0
			end

			var_10_0.curCount = var_10_1(var_10_2, 0, var_10_0.maxCount)
			onButton = var_4

			local var_10_3 = arg_9_0
			local var_10_4 = arg_10_2
			local var_10_5 = arg_10_2.Find(var_10_4, "icon/icon_bg")

			local function var_10_6()
				local var_11_0 = arg_9_0
				local var_11_1 = var_0.emit

				BaseUI = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_DROP, var_10_0)

				return
			end

			SFX_PANEL = var_10_4

			var_4(var_10_3, var_10_5, var_10_6, var_10_4)

			local var_10_7 = arg_10_2:Find("count")

			onButton = var_2_10005

			var_2_10005(arg_9_0, var_10_7:Find("max"), function()
				if var_10_0.curCount ~= var_10_0.maxCount then
					var_10_0.curCount = var_10_0.maxCount

					local var_12_0 = arg_9_0

					var_0.Updatecontrol(var_12_0)
				end

				return
			end)

			pressPersistTrigger = var_2_10005

			local var_10_8 = var_10_7:Find("number_panel/left")
			local var_10_9 = 0.5

			local function var_10_10(arg_13_0)
				if var_10_0.curCount <= 0 then
					arg_13_0()

					return
				end

				var_10_0.curCount = var_10_0.curCount - 1

				local var_13_0 = arg_9_0

				var_1.Updatecontrol(var_13_0)

				return
			end

			local var_10_11
			local var_10_12 = true
			local var_10_13 = true
			local var_10_14 = 0.1

			SFX_PANEL = var_2_10014

			var_2_10005(var_10_8, var_10_9, var_10_10, var_10_11, var_10_12, var_10_13, var_10_14, var_2_10014)

			pressPersistTrigger = var_2_10005

			local var_10_15 = var_10_7:Find("number_panel/right")
			local var_10_16 = 0.5

			local function var_10_17(arg_14_0)
				if var_10_0.curCount >= var_10_0.maxCount then
					arg_14_0()

					return
				end

				var_10_0.curCount = var_10_0.curCount + 1

				local var_14_0 = arg_9_0

				var_1.Updatecontrol(var_14_0)

				return
			end

			local var_10_18
			local var_10_19 = true
			local var_10_20 = true
			local var_10_21 = 0.1

			SFX_PANEL = var_2_10014

			var_2_10005(var_10_15, var_10_16, var_10_17, var_10_18, var_10_19, var_10_20, var_10_21, var_2_10014)
		end

		return
	end)

	onButton = var_6

	local var_9_6 = arg_9_0
	local var_9_7 = var_2
	local var_9_8 = var_2.Find(var_9_7, "button_1")

	local function var_9_9()
		local var_15_0 = {}

		ipairs = var_2_10001

		for iter_15_0, iter_15_1 in var_2_10001(arg_9_0.blueprintItems) do
			if iter_15_1.curCount > 0 then
				Clone = var_6

				local var_15_1 = var_6(iter_15_1)

				var_15_1.count = iter_15_1.curCount
				table = var_7

				var_7.insert(var_15_0, var_15_1)
			end
		end

		if #var_15_0 > 0 then
			local var_15_2 = arg_9_0

			var_15_2.resolveItems = var_15_0
			triggerToggle = var_15_2

			var_15_2(arg_9_0.toggles.resolve, true)
		end

		return
	end

	SFX_PANEL = var_9_7

	var_6(var_9_6, var_9_8, var_9_9, var_9_7)

	onButton = var_6

	local var_9_10 = arg_9_0
	local var_9_11 = var_2
	local var_9_12 = var_2.Find(var_9_11, "allMax")

	local function var_9_13()
		for iter_16_0 = 1, #var_9_0 do
			if var_9_0[iter_16_0].curCount ~= var_4.maxCount then
				var_4.curCount = var_4.maxCount
			end

			local var_16_0 = arg_9_0

			var_5.Updatecontrol(var_16_0)
		end

		return
	end

	SFX_PANEL = var_9_11

	var_6(var_9_10, var_9_12, var_9_13, var_9_11)
	arg_9_0:Updatecontrol()

	return
end

function var_0_1.Updatecontrol(arg_17_0)
	local var_17_0 = arg_17_0.controlPanel
	local var_17_1 = var_1.Find(var_17_0, "got/list")
	local var_17_2 = arg_17_0.blueprintItems
	local var_17_3 = 0

	UIItemList = var_5

	var_5.StaticAlign(var_17_1, var_17_1:Find("item"), #var_17_2, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = var_17_2[arg_18_1 + 1]
			local var_18_1 = arg_18_2:Find("count")

			setText = var_2_10005

			var_2_10005(var_18_1:Find("number_panel/value"), var_18_0.curCount)

			var_17_3 = var_17_3 + var_18_0.curCount
		end

		return
	end)

	local var_17_4 = var_1
	local var_17_5 = var_1.Find(var_17_4, "button_1")

	setButtonEnabled = var_1_10006

	var_1_10006(var_17_5, var_17_3 > 0)

	setGray = var_1_10006

	var_1_10006(var_17_5, var_17_3 <= 0)

	local var_17_6 = var_1:Find("allMax")

	setGray = var_17_4

	var_17_4(var_17_6, not var_17_2 or #var_17_2 == 0)

	setButtonEnabled = var_17_4

	var_17_4(var_17_6, var_17_2 and #var_17_2 > 0)

	return
end

function var_0_1.Resetresolve(arg_19_0)
	local var_19_0 = arg_19_0.resolvePanel
	local var_19_1 = var_1.Find(var_19_0, "preview/got/list")
	local var_19_2 = var_1
	local var_19_3 = var_1.Find(var_19_2, "result/got/list")
	local var_19_4 = arg_19_0.resolveItems

	UIItemList = var_19_2

	var_19_2.StaticAlign(var_19_1, var_19_1:Find("item"), #var_19_4, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = var_19_4[arg_20_1 + 1]

			updateDrop = var_4

			var_4(arg_20_2:Find("icon"), var_20_0)

			onButton = var_4

			local var_20_1 = arg_19_0
			local var_20_2 = arg_20_2
			local var_20_3 = arg_20_2.Find(var_20_2, "icon/icon_bg")

			local function var_20_4()
				local var_21_0 = arg_19_0
				local var_21_1 = var_0.emit

				BaseUI = var_3_10003

				var_21_1(var_21_0, var_3_10003.ON_DROP, var_20_0)

				return
			end

			SFX_PANEL = var_20_2

			var_4(var_20_1, var_20_3, var_20_4, var_20_2)

			setText = var_4

			var_4(arg_20_2:Find("name_panel/name"), var_20_0:getConfig("name"))

			setText = var_4

			var_4(arg_20_2:Find("name_panel/number"), "x " .. var_20_0.curCount)
		end

		return
	end)

	local var_19_5 = {}
	local var_19_6 = {}

	pairs = var_7

	for iter_19_0, iter_19_1 in var_7(var_19_4) do
		var_1_10012 = iter_19_1
		Item = var_1_10013
		var_1_10013 = var_1_10013.getConfigData(var_1_10012.id)
		assert = var_1_10014

		var_1_10014(var_1_10013, "Can't find the price " .. var_1_10012.id)

		if not var_19_5[var_1_10013.price[1]] then
			var_1_10014 = 0
		end

		var_1_10014 = var_1_10014 + var_1_10013.price[2] * var_1_10012.count
		var_19_5[var_1_10013.price[1]] = var_1_10014
	end

	pairs = var_7

	for iter_19_2, iter_19_3 in var_7(var_19_5) do
		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_19_7 = var_19_6
		local var_19_8 = {}

		DROP_TYPE_RESOURCE = var_1_10016
		var_19_8.type = var_1_10016
		var_19_8.id = iter_19_2
		var_19_8.count = iter_19_3

		var_1_10012(var_19_7, var_19_8)
	end

	UIItemList = var_7

	var_7.StaticAlign(var_19_3, var_19_3:Find("item"), #var_19_6, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_19_6[arg_22_1 + 1]

			updateDrop = var_4

			var_4(arg_22_2:Find("icon"), var_22_0)

			onButton = var_4

			local var_22_1 = arg_19_0
			local var_22_2 = arg_22_2
			local var_22_3 = arg_22_2.Find(var_22_2, "icon/icon_bg")

			local function var_22_4()
				local var_23_0 = arg_19_0
				local var_23_1 = var_0.emit

				BaseUI = var_3_10003

				var_23_1(var_23_0, var_3_10003.ON_DROP, var_22_0)

				return
			end

			SFX_PANEL = var_22_2

			var_4(var_22_1, var_22_3, var_22_4, var_22_2)

			setText = var_4

			var_4(arg_22_2:Find("name_panel/name"), var_22_0:getConfig("name"))

			setText = var_4

			var_4(arg_22_2:Find("name_panel/number"), "x " .. var_22_0.count)
		end

		return
	end)

	onButton = var_7

	var_7(arg_19_0, var_1:Find("cancel_button"), function()
		local var_24_0 = arg_19_0

		var_0.Back(var_24_0)

		return
	end)

	onButton = var_7

	var_7(arg_19_0, var_1:Find("destroy_button"), function()
		local var_25_0 = arg_19_0
		local var_25_1 = var_0.emit

		NewShopMainMediator = var_2_10003

		var_25_1(var_25_0, var_2_10003.SELL_BLUEPRINT, arg_19_0.resolveItems)

		return
	end)

	return
end

function var_0_1.GetAllBluePrintStrengthenItems()
	local var_26_0 = {}

	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_26_1 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_26_2 = var_1_10002(var_1_10004)

	pg = var_1_10003

	local var_26_3 = var_1_10003.ship_data_blueprint

	ipairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(var_26_3.all) do
		local var_26_4 = var_26_3[iter_26_1]
		local var_26_5 = var_26_1:getBluePrintById(iter_26_1)

		if var_10.isMaxLevel(var_26_5) then
			local var_26_6 = var_26_4.strengthen_item

			if var_26_2:getItemById(var_26_6) then
				local var_26_7 = var_26_1
				local var_26_8 = var_26_1.getBluePrintById
				local var_26_9 = var_26_1
				local var_26_10 = var_26_8(var_26_7, var_26_1.GetBlueprint4Item(var_26_9, var_26_6))
				local var_26_11 = var_12.count

				if var_12 and var_12.count > 0 and var_0_1.keepFateState then
					var_26_7 = var_12.count
					var_26_9 = var_26_10
					var_26_11 = var_26_7 - var_26_10.getFateMaxLeftOver(var_26_9) < 0 and 0 or var_26_11
				end

				table = var_26_7

				local var_26_12 = var_26_7.insert
				local var_26_13 = var_26_0

				Drop = var_26_9

				local var_26_14 = var_26_9.New
				local var_26_15 = {
					id = var_12.id
				}

				DROP_TYPE_ITEM = var_21
				var_26_15.type = var_21
				var_26_15.count = var_12.count
				var_26_15.maxCount = var_26_11

				var_26_12(var_26_13, var_26_14(var_26_15))
			end
		end
	end

	return var_26_0
end

function var_0_1.Trigger(arg_27_0, arg_27_1)
	if arg_27_0.toggles[arg_27_1] then
		local var_27_0 = arg_27_0.buffer

		var_3.Show(var_27_0)

		triggerToggle = var_3

		var_3(var_2, true)
	end

	return
end

function var_0_1.Back(arg_28_0)
	getToggleState = var_1_10001

	if var_1_10001(arg_28_0.toggles.resolve) then
		triggerToggle = var_1

		var_1(arg_28_0.toggles.control, true)
	else
		getToggleState = var_1

		if var_1(arg_28_0.toggles.control) then
			arg_28_0:Hide()
		end
	end

	return
end

return var_0_1
