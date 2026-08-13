class = var_0_10000

local var_0_0 = "CrusingWindowLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CrusingWindowUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getAliveActivityByType

	ActivityConst = var_1_10005

	local var_2_2 = var_2_1(var_2_0, var_1_10005.ACTIVITY_TYPE_PT_CRUSING)

	GetSpriteFromAtlasAsync = var_1_10003

	local var_2_3 = "crusingwindow/map_20"

	pg = var_1_10006

	var_1_10003(var_2_3 .. var_1_10006.battlepass_event_pt[var_2_2.id].map_name, "", function(arg_3_0)
		arg_2_0.windowSprite = arg_3_0

		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	setImageSprite = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_3.Find(var_4_0, "panel"), arg_4_0.windowSprite, true)

	local var_4_1 = arg_4_0._tf

	arg_4_0.rtBg = var_1.Find(var_4_1, "bg")

	local var_4_2 = arg_4_0._tf

	arg_4_0.btnBack = var_1.Find(var_4_2, "panel/btn_back")

	local var_4_3 = arg_4_0._tf

	arg_4_0.btnGo = var_1.Find(var_4_3, "panel/btn_go")

	local var_4_4 = arg_4_0._tf

	arg_4_0.itemContent = var_1.Find(var_4_4, "panel/content")
	getProxy = var_1
	ActivityProxy = var_4_4

	local var_4_5 = var_1(var_4_4)
	local var_4_6 = var_1.getAliveActivityByType

	ActivityConst = var_4

	local var_4_7 = var_4_6(var_4_5, var_4.ACTIVITY_TYPE_PT_CRUSING)

	pg = var_1_10002

	local var_4_8

	if not var_1_10002.battlepass_event_pt[var_4_7.id].equip_skin then
		var_4_8 = {}
	end

	UIItemList = var_3

	local var_4_9 = var_3.New
	local var_4_10 = arg_4_0.itemContent
	local var_4_11 = arg_4_0.itemContent

	arg_4_0.itemList = var_4_9(var_4_10, var_6.GetChild(var_4_11, 0))

	local var_4_12 = arg_4_0.itemList

	var_3.make(var_4_12, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = {}

			unpack = var_2_10004

			local var_5_1, var_5_2, var_5_3 = var_2_10004(var_4_8[arg_5_1])

			var_5_0.count = var_5_3
			var_5_0.id = var_5_2
			var_5_0.type = var_5_1
			updateDrop = var_5_1

			var_5_1(arg_5_2, var_5_0)

			onButton = var_5_1

			local var_5_4 = arg_4_0
			local var_5_5 = arg_5_2

			local function var_5_6()
				local var_6_0 = arg_4_0

				var_0.emit(var_6_0, var_0_1.ON_DROP, var_5_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_5_1(var_5_4, var_5_5, var_5_6, var_2_10009)
		end

		return
	end)

	local var_4_13 = arg_4_0.itemList

	var_3.align(var_4_13, #var_4_8)

	return
end

function var_0_1.didEnter(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)

	onButton = var_1

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.rtBg

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_7_1, var_7_2, var_7_3, var_1_10006)

	onButton = var_1

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.btnBack

	local function var_7_6()
		local var_9_0 = arg_7_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_7_4, var_7_5, var_7_6, var_1_10006)

	onButton = var_1

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.btnGo

	local function var_7_9()
		local var_10_0 = arg_7_0
		local var_10_1 = var_0.emit

		CrusingWindowMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.GO_CRUSING)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_7_7, var_7_8, var_7_9, var_1_10006)

	return
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf)

	return
end

return var_0_1
