class = var_0_10000

local var_0_0 = "BuildShipRegularExchangeLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BuildShipRegularExchangeUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.ship_data_create_exchange

	REGULAR_BUILD_POOL_EXCHANGE_ID = var_1_10003
	arg_2_0.cfg = var_2_0[var_1_10003]
	arg_2_0.ids = arg_2_0.cfg.exchange_ship_id
	arg_2_0.iconSprites = {}

	local var_2_1 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.ids) do
		table = var_1_10008

		var_1_10008.insert(var_2_1, function(arg_3_0)
			GetSpriteFromAtlasAsync = var_2_10001

			local var_3_0 = "RegularExchangeIcon"

			tostring = var_2_10003

			var_2_10001(var_3_0, var_2_10003(iter_2_1), function(arg_4_0)
				arg_2_0.iconSprites[iter_2_1] = arg_4_0

				arg_3_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_2_1, arg_2_1)

	return
end

function var_0_1.setCount(arg_5_0, arg_5_1)
	arg_5_0.count = arg_5_1
	setText = var_1_10002

	var_1_10002(arg_5_0.textCount, arg_5_0.count .. "/" .. arg_5_0.cfg.exchange_request)

	setGray = var_1_10002

	var_1_10002(arg_5_0.btnConfirm, arg_5_0.count < arg_5_0.cfg.exchange_request)

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.btnBack = var_1.Find(var_6_0, "top/bg/btn_back")
	onButton = var_1

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.btnBack

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_6_1, var_6_2, var_6_3, var_1_10005)

	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_1.Find(var_6_4, "select/view/container")

	UIItemList = var_6_4
	arg_6_0.iconList = var_6_4.New(var_6_5, var_6_5:Find("tpl"))

	local var_6_6 = arg_6_0.iconList

	var_2.make(var_6_6, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			Ship = var_3

			local var_8_0 = var_3.New({
				configId = arg_6_0.ids[arg_8_1]
			})

			setImageSprite = var_4

			var_4(arg_8_2:Find("Image"), arg_6_0.iconSprites[var_8_0.configId], true)

			setActive = var_4

			local var_8_1 = arg_8_2
			local var_8_2 = arg_8_2.Find(var_8_1, "noget")

			getProxy = var_8_1
			CollectionProxy = var_7

			local var_8_3 = var_8_1(var_7)

			var_4(var_8_2, not var_6.getShipGroup(var_8_3, var_8_0:getGroupId()))

			onToggle = var_4

			local var_8_4 = arg_6_0
			local var_8_5 = arg_8_2

			local function var_8_6(arg_9_0)
				if arg_9_0 then
					local var_9_0 = arg_6_0

					var_1.setSelectedShip(var_9_0, var_8_0)
				end

				return
			end

			SFX_PANEL = var_8

			var_4(var_8_4, var_8_5, var_8_6, var_8)

			triggerToggle = var_4

			var_4(arg_8_2, arg_8_1 == 1)
		end

		return
	end)

	onButton = var_2

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0._tf
	local var_6_9 = var_4.Find(var_6_8, "select/operation/help")

	local function var_6_10()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		i18n = var_2_10003
		var_10_2.helps = var_2_10003("Normalbuild_URexchange_help")

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_6_7, var_6_9, var_6_10, var_6)

	setText = var_2

	local var_6_11 = arg_6_0._tf
	local var_6_12 = var_3.Find(var_6_11, "select/operation/count/Text")

	i18n = var_6_11

	var_2(var_6_12, var_6_11("Normalbuild_URexchange_text2") .. ":")

	local var_6_13 = arg_6_0._tf

	arg_6_0.textCount = var_2.Find(var_6_13, "select/operation/count/num")

	local var_6_14 = arg_6_0._tf

	arg_6_0.btnConfirm = var_2.Find(var_6_14, "select/operation/confirm")
	onButton = var_2

	local var_6_15 = arg_6_0
	local var_6_16 = arg_6_0.btnConfirm

	local function var_6_17()
		local var_11_1

		if arg_6_0.count < arg_6_0.cfg.exchange_request then
			pg = var_11_1

			local var_11_0 = var_11_1.TipsMgr.GetInstance()

			var_11_1 = var_11_1.ShowTips
			i18n = var_2_10002

			var_11_1(var_11_0, var_2_10002("Normalbuild_URexchange_warning1"))
		else
			pg = var_11_1

			local var_11_2 = var_11_1.MsgboxMgr.GetInstance()
			local var_11_3 = var_0.ShowMsgBox
			local var_11_4 = {}

			i18n = var_2_10003

			local var_11_5 = "Normalbuild_URexchange_confirm"
			local var_11_6 = arg_6_0.shipVO

			var_11_4.content = var_2_10003(var_11_5, var_5.getName(var_11_6))

			function var_11_4.onYes()
				local var_12_0 = arg_6_0
				local var_12_1 = var_0.emit

				BuildShipRegularExchangeMediator = var_3_10002

				var_12_1(var_12_0, var_3_10002.EXCHAGNE_SHIP, arg_6_0.shipVO.configId)

				local var_12_2 = arg_6_0

				var_0.closeView(var_12_2)

				return
			end

			var_11_3(var_11_2, var_11_4)
		end

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_6_15, var_6_16, var_6_17, var_6)

	local var_6_18 = arg_6_0._tf

	arg_6_0.rtName = var_2.Find(var_6_18, "select/name_bg")

	local var_6_19 = arg_6_0._tf

	arg_6_0.rtPaint = var_2.Find(var_6_19, "main/paint")

	arg_6_0:OverlayPanel(arg_6_0._tf)

	return
end

function var_0_1.setSelectedShip(arg_13_0, arg_13_1)
	if arg_13_0.shipVO then
		retPaintingPrefab = var_2

		local var_13_0 = arg_13_0.rtPaint
		local var_13_1 = arg_13_0.shipVO

		var_2(var_13_0, var_4.getPainting(var_13_1))
	end

	arg_13_0.shipVO = arg_13_1
	ShipType = var_2

	local var_13_2 = var_2.Type2BattlePrint(arg_13_1:getShipType())

	GetImageSpriteFromAtlasAsync = var_3

	local var_13_3 = "shiptype"
	local var_13_4 = var_13_2
	local var_13_5 = arg_13_0.rtName

	var_3(var_13_3, var_13_4, var_6.Find(var_13_5, "shiptype/Image"), true)

	setText = var_3

	local var_13_6 = arg_13_0.rtName

	var_3(var_4.Find(var_13_6, "name"), arg_13_1:getName())

	setText = var_3

	local var_13_7 = arg_13_0.rtName
	local var_13_8 = var_4.Find(var_13_7, "english")

	string = var_13_7

	var_3(var_13_8, var_13_7.upper(arg_13_1:getConfig("english_name")))

	setPaintingPrefabAsync = var_3

	var_3(arg_13_0.rtPaint, arg_13_1:getPainting(), "huode")

	return
end

function var_0_1.flush(arg_14_0)
	mergeSort = var_1_10001

	local var_14_0 = arg_14_0.ids

	CompareFuncs = var_1_10003

	var_1_10001(var_14_0, var_1_10003({
		function(arg_15_0)
			Ship = var_2_10001

			local var_15_0 = var_2_10001.New({
				configId = arg_15_0
			})

			getProxy = var_2
			CollectionProxy = var_2_10003

			local var_15_1 = var_2(var_2_10003)

			return var_2.getShipGroup(var_15_1, var_15_0:getGroupId()) and 1 or 0
		end
	}, true))

	local var_14_1 = arg_14_0.iconList

	var_1.align(var_14_1, #arg_14_0.ids)

	return
end

function var_0_1.didEnter(arg_16_0)
	arg_16_0:flush()

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0.iconSprites = nil

	if arg_17_0.shipVO then
		retPaintingPrefab = var_1

		local var_17_0 = arg_17_0.rtPaint
		local var_17_1 = arg_17_0.shipVO

		var_1(var_17_0, var_3.getPainting(var_17_1))
	end

	arg_17_0:UnOverlayPanel(arg_17_0._tf)

	return
end

return var_0_1
