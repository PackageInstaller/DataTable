class = var_0_10000

local var_0_0 = "SupportShipPoolPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SupportShipPoolPageUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.medalCount = var_1.Find(var_2_0, "gallery/res_items/medal")

	local var_2_1 = arg_2_0._tf

	arg_2_0.patingTF = var_1.Find(var_2_1, "painting")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_2, "gallery/bg")

	local var_2_3 = arg_2_0.bg
	local var_2_4 = var_1.Find(var_2_3, "type_intro/mask/title")

	arg_2_0.tipSTxt = var_1.GetComponent(var_2_4, "ScrollText")

	local var_2_5 = arg_2_0._tf

	arg_2_0.shopBtn = var_1.Find(var_2_5, "gallery/shop_btn")

	local var_2_6 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_6, "gallery/help_btn")

	local var_2_7 = arg_2_0._tf

	arg_2_0.startBtn = var_1.Find(var_2_7, "gallery/start_btn")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.shopBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BuildShipMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_SUPPORT_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Flush(arg_5_0)
	local var_5_0 = arg_5_0

	arg_5_0.UpdateMedal(var_5_0)

	getProxy = var_1
	BuildShipProxy = var_5_0

	local var_5_1 = var_1(var_5_0)
	local var_5_2 = var_1.getSupportShipCost(var_5_1)

	pg = var_1_10002

	local var_5_3 = var_1_10002.gametip.honor_medal_support_tips_display.tip

	setText = var_5_1

	local var_5_4 = arg_5_0._tf

	var_5_1(var_5.Find(var_5_4, "gallery/prints/intro/text"), var_5_3.support_tip_consume)

	setImageSprite = var_5_1

	local var_5_5 = arg_5_0.bg

	GetSpriteFromAtlas = var_6

	var_5_1(var_5_5, var_6(var_5_3.bg, ""))

	local var_5_6 = var_5_3.support_tip_ship
	local var_5_7 = arg_5_0.tipSTxt

	var_4.SetText(var_5_7, var_5_6)

	local var_5_8 = arg_5_0._tf
	local var_5_9 = var_4.Find(var_5_8, "gallery/item_bg/medal")

	setText = var_5_5

	local var_5_10 = var_5_9:Find("name")

	Drop = var_8

	local var_5_11 = var_8.New
	local var_5_12 = {}

	DROP_TYPE_ITEM = var_1_10011
	var_5_12.type = var_1_10011
	ITEM_ID_SILVER_HOOK = var_1_10011
	var_5_12.id = var_1_10011

	local var_5_13 = var_5_11(var_5_12)

	var_5_5(var_5_10, var_8.getName(var_5_13))

	setText = var_5_5

	var_5_5(var_5_9:Find("count/Text"), var_5_2)
	arg_5_0:UpdateBuildPoolPaiting()

	onButton = var_5

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.helpBtn

	local function var_5_16()
		local var_6_0 = arg_5_0.contextData.helpWindow

		var_0.ExecuteAction(var_6_0, "Show", var_5_3, "support")

		return
	end

	SFX_CANCEL = var_10

	var_5(var_5_14, var_5_15, var_5_16, var_10)

	getProxy = var_5
	BagProxy = var_5_14

	local var_5_17 = var_5(var_5_14)

	onButton = var_5_8

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.startBtn

	local function var_5_20()
		local var_7_0 = {
			buildType = "medal"
		}

		Item = var_2_10001

		local var_7_1 = var_2_10001.New
		local var_7_2 = {}

		ITEM_ID_SILVER_HOOK = var_2_10004
		var_7_2.id = var_2_10004

		local var_7_3 = var_5_17
		local var_7_4 = var_4.getItemCountById

		ITEM_ID_SILVER_HOOK = var_2_10007
		var_7_2.count = var_7_4(var_7_3, var_2_10007)
		var_7_0.itemVO = var_7_1(var_7_2)
		var_7_0.cost = var_5_2
		MAX_BUILD_WORK_COUNT = var_1
		var_7_0.max = var_1

		function var_7_0.onConfirm(arg_8_0)
			local var_8_0 = arg_5_0
			local var_8_1 = var_1.emit

			BuildShipMediator = var_3_10004

			var_8_1(var_8_0, var_3_10004.ON_SUPPORT_EXCHANGE, arg_8_0)

			return
		end

		local var_7_5 = arg_5_0.contextData.msgbox

		var_1.ExecuteAction(var_7_5, "Show", var_7_0)

		return
	end

	SFX_UI_BUILDING_STARTBUILDING = var_1_10011

	var_5_8(var_5_18, var_5_19, var_5_20, var_1_10011)

	return
end

function var_0_1.UpdateMedal(arg_9_0)
	setText = var_1_10001

	local var_9_0 = arg_9_0.medalCount
	local var_9_1 = var_3.Find(var_9_0, "Text")

	getProxy = var_1_10004
	BagProxy = var_6

	local var_9_2 = var_1_10004(var_6)
	local var_9_3 = var_4.getItemCountById

	ITEM_ID_SILVER_HOOK = var_1_10007

	var_1_10001(var_9_1, var_9_3(var_9_2, var_1_10007))

	return
end

function var_0_1.UpdateBuildPoolPaiting(arg_10_0)
	local var_10_0 = arg_10_0.contextData.falgShip
	local var_10_1 = var_1.getPainting(var_10_0)

	if arg_10_0.painting ~= var_10_1 then
		pg = var_2

		local var_10_2 = var_2.UIMgr.GetInstance()

		var_2.LoadingOn(var_10_2)

		setPaintingPrefabAsync = var_2

		var_2(arg_10_0.patingTF, var_10_1, "build", function()
			local var_11_0 = arg_10_0

			var_11_0.painting = var_10_1
			pg = var_11_0

			local var_11_1 = var_11_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_11_1)

			return
		end)
	end

	return
end

function var_0_1.ShowOrHide(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0:Show()
	else
		arg_12_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
