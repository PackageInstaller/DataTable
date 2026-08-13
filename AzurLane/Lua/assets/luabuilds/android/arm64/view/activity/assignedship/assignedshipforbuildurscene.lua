class = var_0_10000

local var_0_0 = "AssignedShipForBuildURScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AssignedShipBuildURUI"
end

function var_0_1.setItemVO(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1

	return
end

function var_0_1.preload(arg_3_0, arg_3_1)
	arg_3_0.shipUsageDic = {}
	underscore = var_2

	local var_3_0 = var_2.map
	local var_3_1 = arg_3_0.contextData.itemVO

	arg_3_0.ids = var_3_0(var_4.getConfig(var_3_1, "usage_arg"), function(arg_4_0)
		pg = var_2_10001

		local var_4_0 = var_2_10001.item_usage_invitation[arg_4_0].ship_id

		arg_3_0.shipUsageDic[var_4_0] = arg_4_0

		return var_4_0
	end)
	arg_3_0.iconSprites = {}

	local var_3_2 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.ids) do
		table = var_1_10008

		var_1_10008.insert(var_3_2, function(arg_5_0)
			GetSpriteFromAtlasAsync = var_2_10001

			local var_5_0 = "RegularExchangeIcon"

			tostring = var_2_10004

			var_2_10001(var_5_0, var_2_10004(iter_3_1), function(arg_6_0)
				arg_3_0.iconSprites[iter_3_1] = arg_6_0

				arg_5_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_3_2, arg_3_1)

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.backBtn = var_1.Find(var_7_0, "top/bg/btn_back")
	onButton = var_1

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.backBtn

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_7_1, var_7_2, var_7_3, var_1_10006)

	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_1.Find(var_7_4, "select/view/container")

	UIItemList = var_1_10002

	local var_7_6 = var_1_10002.New
	local var_7_7 = var_7_5
	local var_7_8 = var_7_5

	arg_7_0.iconList = var_7_6(var_7_7, var_7_5.Find(var_7_8, "tpl"))

	local var_7_9 = arg_7_0.iconList

	var_2.make(var_7_9, function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			Ship = var_3

			local var_9_0 = var_3.New({
				configId = arg_7_0.ids[arg_9_1]
			})

			setImageSprite = var_2_10004

			var_2_10004(arg_9_2:Find("Image"), arg_7_0.iconSprites[var_9_0.configId], true)

			setActive = var_2_10004

			local var_9_1 = arg_9_2:Find("noget")

			getProxy = var_7
			CollectionProxy = var_9

			local var_9_2 = var_7(var_9)

			var_2_10004(var_9_1, not var_7.getShipGroup(var_9_2, var_9_0:getGroupId()))

			onToggle = var_2_10004

			local var_9_3 = arg_7_0
			local var_9_4 = arg_9_2

			local function var_9_5(arg_10_0)
				if arg_10_0 then
					local var_10_0 = arg_7_0

					var_1.setSelectedShip(var_10_0, var_9_0)
				end

				return
			end

			SFX_PANEL = var_9_2

			var_2_10004(var_9_3, var_9_4, var_9_5, var_9_2)

			triggerToggle = var_2_10004

			var_2_10004(arg_9_2, arg_9_1 == 1)
		end

		return
	end)

	local var_7_10 = arg_7_0._tf

	arg_7_0.btnConfirm = var_2.Find(var_7_10, "select/operation/confirm")
	onButton = var_2

	local var_7_11 = arg_7_0
	local var_7_12 = arg_7_0.btnConfirm

	local function var_7_13()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		i18n = var_2_10004

		local var_11_3 = "handbook_ur_double_check"
		local var_11_4 = arg_7_0.shipVO

		var_11_2.content = var_2_10004(var_11_3, var_7.getName(var_11_4))

		function var_11_2.onYes()
			local var_12_0 = arg_7_0
			local var_12_1 = var_0.emit

			AssignedShipMediator = var_3_10003

			local var_12_2 = var_3_10003.ON_USE_ITEM
			local var_12_3 = arg_7_0.itemVO.id
			local var_12_4 = 1
			local var_12_5 = {}
			local var_12_6 = arg_7_0.shipUsageDic
			local var_12_7 = arg_7_0.shipVO

			var_12_5[1] = var_12_6[var_8.GetConfigID(var_12_7)]

			var_12_1(var_12_0, var_12_2, var_12_3, var_12_4, var_12_5)

			return
		end

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_CONFIRM = var_7_8

	var_2(var_7_11, var_7_12, var_7_13, var_7_8)

	local var_7_14 = arg_7_0._tf

	arg_7_0.rtName = var_2.Find(var_7_14, "select/name_bg")

	local var_7_15 = arg_7_0._tf

	arg_7_0.rtPaint = var_2.Find(var_7_15, "main/paint")

	return
end

function var_0_1.setSelectedShip(arg_13_0, arg_13_1)
	if arg_13_0.shipVO then
		retPaintingPrefab = var_2

		local var_13_0 = arg_13_0.rtPaint
		local var_13_1 = arg_13_0.shipVO

		var_2(var_13_0, var_5.getPainting(var_13_1))
	end

	arg_13_0.shipVO = arg_13_1
	ShipType = var_2

	local var_13_2 = var_2.Type2BattlePrint(arg_13_1:getShipType())

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_13_3 = "shiptype"
	local var_13_4 = var_13_2
	local var_13_5 = arg_13_0.rtName

	var_1_10003(var_13_3, var_13_4, var_7.Find(var_13_5, "shiptype/Image"), true)

	setText = var_1_10003

	local var_13_6 = arg_13_0.rtName

	var_1_10003(var_5.Find(var_13_6, "name"), arg_13_1:getName())

	setText = var_1_10003

	local var_13_7 = arg_13_0.rtName
	local var_13_8 = var_5.Find(var_13_7, "english")

	string = var_6

	var_1_10003(var_13_8, var_6.upper(arg_13_1:getConfig("english_name")))

	setPaintingPrefabAsync = var_1_10003

	var_1_10003(arg_13_0.rtPaint, arg_13_1:getPainting(), "huode")

	return
end

function var_0_1.flush(arg_14_0)
	local var_14_0 = arg_14_0.iconList

	var_1.align(var_14_0, #arg_14_0.ids)

	return
end

function var_0_1.didEnter(arg_15_0)
	arg_15_0:flush()

	return
end

function var_0_1.willExit(arg_16_0)
	arg_16_0.iconSprites = nil

	if arg_16_0.shipVO then
		retPaintingPrefab = var_1

		local var_16_0 = arg_16_0.rtPaint
		local var_16_1 = arg_16_0.shipVO

		var_1(var_16_0, var_4.getPainting(var_16_1))
	end

	return
end

return var_0_1
