class = var_0_10000

local var_0_0 = var_0_10000("ItemUsagePanel")

var_0_0.SINGLE = 1
var_0_0.BATCH = 2
var_0_0.INFO = 3
var_0_0.SEE = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	setActive = var_3

	var_3(arg_1_0._go, false)

	arg_1_0._parent = arg_1_2
	findTF = var_3
	arg_1_0.backBtn = var_3(arg_1_0._go, "window/top/btnBack")
	findTF = var_3
	arg_1_0.itemTF = var_3(arg_1_0._go, "window/item")
	findTF = var_3
	arg_1_0.itemIntro = var_3(arg_1_0.itemTF, "display_panel/desc/Text")
	findTF = var_3
	arg_1_0.itemName = var_3(arg_1_0.itemTF, "display_panel/name_container/name/Text")
	findTF = var_3
	arg_1_0.resetBtn = var_3(arg_1_0.itemTF, "reset_btn")
	findTF = var_3
	arg_1_0.useBtn = var_3(arg_1_0._go, "window/actions/use_one_button")
	setActive = var_3

	var_3(arg_1_0.useBtn, false)

	findTF = var_3
	arg_1_0.batchUseBtn = var_3(arg_1_0._go, "window/actions/batch_use_button")
	setActive = var_3

	var_3(arg_1_0.batchUseBtn, false)

	findTF = var_3
	arg_1_0.useOneBtn = var_3(arg_1_0._go, "window/actions/use_button")
	setActive = var_3

	var_3(arg_1_0.useOneBtn, false)

	findTF = var_3
	arg_1_0.confirmBtn = var_3(arg_1_0._go, "window/actions/confirm_button")
	setActive = var_3

	var_3(arg_1_0.confirmBtn, false)

	findTF = var_3
	arg_1_0.seeBtn = var_3(arg_1_0._go, "window/actions/see_button")
	setActive = var_3

	var_3(arg_1_0.seeBtn, false)

	local var_1_0 = arg_1_0.batchUseBtn

	arg_1_0.batchText = var_3.Find(var_1_0, "text")
	onButton = var_3

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.backBtn

	local function var_1_3()
		local var_2_0 = arg_1_0

		var_0.Close(var_2_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_1_1, var_1_2, var_1_3, var_1_10008)

	onButton = var_3

	local var_1_4 = arg_1_0

	findTF = var_1_2

	local var_1_5 = var_1_2(arg_1_0._go, "bg")

	local function var_1_6()
		local var_3_0 = arg_1_0

		var_0.Close(var_3_0)

		return
	end

	SFX_PANEL = var_8

	var_3(var_1_4, var_1_5, var_1_6, var_8)

	return
end

function var_0_0.Open(arg_4_0, arg_4_1)
	arg_4_0.settings = arg_4_1 or {}

	local var_4_0 = arg_4_0.settings.item

	arg_4_0:Update(var_4_0)
	arg_4_0:UpdateAction(var_4_0)

	setActive = var_3

	var_3(arg_4_0.resetBtn, true)

	setActive = var_3

	var_3(arg_4_0._go, true)

	pg = var_3

	local var_4_1 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_4_1, arg_4_0._go)

	return
end

function var_0_0.Close(arg_5_0)
	arg_5_0.settings = nil
	setActive = var_1

	var_1(arg_5_0._go, false)

	pg = var_1

	local var_5_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._go, arg_5_0._parent)

	return
end

function var_0_0.Update(arg_6_0, arg_6_1)
	Drop = var_1_10002

	local var_6_0 = var_1_10002.New
	local var_6_1 = {}

	DROP_TYPE_WORLD_ITEM = var_1_10005
	var_6_1.type = var_1_10005
	var_6_1.id = arg_6_1.id
	var_6_1.count = arg_6_1.count

	local var_6_2 = var_6_0(var_6_1)

	updateDrop = var_1_10003

	local var_6_3 = arg_6_0.itemTF

	var_1_10003(var_5.Find(var_6_3, "left/IconTpl"), var_6_2)

	UpdateOwnDisplay = var_1_10003

	local var_6_4 = arg_6_0.itemTF

	var_1_10003(var_5.Find(var_6_4, "left/own"), var_6_2)

	RegisterDetailButton = var_1_10003

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.itemTF

	var_1_10003(var_6_5, var_6.Find(var_6_6, "left/detail"), var_6_2)

	setText = var_1_10003

	var_1_10003(arg_6_0.itemIntro, arg_6_1:getConfig("display"))

	setText = var_1_10003

	local var_6_7 = arg_6_0.itemName
	local var_6_8 = arg_6_1

	var_1_10003(var_6_7, arg_6_1.getConfig(var_6_8, "name"))

	onButton = var_1_10003

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.resetBtn

	local function var_6_11()
		assert = var_2_10000

		var_2_10000(arg_6_0.settings.onResetInfo, "without reset info callback")

		local var_7_0 = arg_6_0.settings.onResetInfo

		Drop = var_2

		local var_7_1 = var_2.New
		local var_7_2 = {
			count = 1
		}

		DROP_TYPE_WORLD_ITEM = var_2_10005
		var_7_2.type = var_2_10005
		var_7_2.id = arg_6_1.id

		var_7_0(var_7_1(var_7_2))

		return
	end

	SFX_PANEL = var_6_8

	var_1_10003(var_6_9, var_6_10, var_6_11, var_6_8)

	return
end

function var_0_0.UpdateAction(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.settings
	local var_8_1

	if not arg_8_0.settings.mode then
		var_8_1 = var_0_0.SINGLE
	end

	setActive = var_1_10004

	var_1_10004(arg_8_0.useBtn, var_8_1 == var_0_0.SINGLE)

	setActive = var_1_10004

	var_1_10004(arg_8_0.batchUseBtn, var_8_1 == var_0_0.BATCH)

	setActive = var_1_10004

	var_1_10004(arg_8_0.useOneBtn, var_8_1 == var_0_0.BATCH)

	setActive = var_1_10004

	var_1_10004(arg_8_0.confirmBtn, var_8_1 == var_0_0.INFO)

	setActive = var_1_10004

	var_1_10004(arg_8_0.seeBtn, var_8_1 == var_0_0.SEE)

	if var_8_1 == var_0_0.SINGLE then
		onButton = var_4

		local var_8_2 = arg_8_0
		local var_8_3 = arg_8_0.useBtn

		local function var_8_4()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUse then
				var_8_0.onUse()
			end

			local var_9_0 = arg_8_0

			var_0.Close(var_9_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_8_2, var_8_3, var_8_4, var_1_10009)
	elseif var_8_1 == var_0_0.BATCH then
		math = var_4

		local var_8_5 = var_4.min(arg_8_1.count, 10)

		setText = var_1_10005

		var_1_10005(arg_8_0.batchText, var_8_5)

		onButton = var_1_10005

		local var_8_6 = arg_8_0
		local var_8_7 = arg_8_0.batchUseBtn

		function var_1_10009()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUseBatch then
				var_8_0.onUseBatch(var_8_5)
			end

			local var_10_0 = arg_8_0

			var_0.Close(var_10_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10005(var_8_6, var_8_7, var_1_10009, var_1_10010)

		onButton = var_1_10005

		local var_8_8 = arg_8_0
		local var_8_9 = arg_8_0.useOneBtn

		function var_1_10009()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUseOne then
				var_8_0.onUseOne()
			end

			local var_11_0 = arg_8_0

			var_0.Close(var_11_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10005(var_8_8, var_8_9, var_1_10009, var_1_10010)

		setActive = var_1_10005

		var_1_10005(arg_8_0.batchUseBtn, var_8_5 > 1)
	elseif var_8_1 == var_0_0.INFO then
		onButton = var_4

		local var_8_10 = arg_8_0
		local var_8_11 = arg_8_0.confirmBtn

		local function var_8_12()
			local var_12_0 = arg_8_0

			var_0.Close(var_12_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_8_10, var_8_11, var_8_12, var_1_10009)
	elseif var_8_1 == var_0_0.SEE then
		onButton = var_4

		local var_8_13 = arg_8_0
		local var_8_14 = arg_8_0.seeBtn

		local function var_8_15()
			if arg_8_1.count == 0 then
				return
			end

			if var_8_0.onUse then
				var_8_0.onUse()
			end

			local var_13_0 = arg_8_0

			var_0.Close(var_13_0)

			return
		end

		SFX_PANEL = var_1_10009

		var_4(var_8_13, var_8_14, var_8_15, var_1_10009)
	end

	return
end

function var_0_0.Dispose(arg_14_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_14_0)
	arg_14_0:Close()

	return
end

return var_0_0
