class = var_0_10000

local var_0_0 = var_0_10000("GoldExchangeView")

var_0_0.itemid1 = 12
var_0_0.itemid2 = 24
var_0_0.const = 5
var_0_0.goldNum = {
	[1] = 3000,
	[2] = 15000
}
var_0_0.gemNum = {
	[1] = 100,
	[2] = 450
}

function var_0_0.Ctor(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)

	PoolMgr = var_1

	local var_1_0 = var_1.GetInstance()

	var_1.GetUI(var_1_0, "GoldExchangeWindow", false, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance().UIMain
		local var_2_1 = arg_2_0.transform

		var_2.SetParent(var_2_1, var_2_0.transform, false)

		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform

		local var_2_2 = arg_1_0

		var_2.init(var_2_2)

		return
	end)

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:addListener()
	arg_3_0:overLayMyself(true)
	arg_3_0:updateView()

	return
end

function var_0_0.exit(arg_4_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_4_0)
	arg_4_0:overLayMyself(false)

	PoolMgr = var_1

	local var_4_0 = var_1.GetInstance()

	var_1.ReturnUI(var_4_0, "GoldExchangeWindow", arg_4_0._go)

	pg = var_1
	var_1.goldExchangeMgr = nil

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.selectedIndex = 1
	arg_5_0.selectedNum = 1
	arg_5_0.selectedMax = 10
	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_5_0 = var_1(var_1_10003)

	arg_5_0.player = var_1.getData(var_5_0)

	return
end

function var_0_0.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.btnBack = var_1.Find(var_6_1, "Window/top/btnBack")

	local var_6_2 = arg_6_0._tf

	arg_6_0.contentTF = var_1.Find(var_6_2, "Window/Content")
	arg_6_0.goldTF = {}
	arg_6_0.goldTF[1] = {}

	local var_6_3 = arg_6_0.contentTF

	arg_6_0.goldTF_1 = var_1.Find(var_6_3, "Gold1")
	arg_6_0.goldTF[1].itemTF = arg_6_0.goldTF_1

	local var_6_4 = arg_6_0.goldTF[1]
	local var_6_5 = arg_6_0.goldTF_1

	var_6_4.countTF = var_2.Find(var_6_5, "item/icon_bg/count")

	local var_6_6 = arg_6_0.goldTF[1]
	local var_6_7 = arg_6_0.goldTF_1

	var_6_6.priceTF = var_2.Find(var_6_7, "item/consume/contain/price")

	local var_6_8 = arg_6_0.goldTF[1]
	local var_6_9 = arg_6_0.goldTF_1

	var_6_8.selectedTF = var_2.Find(var_6_9, "item/selected")

	local var_6_10 = arg_6_0.goldTF[1]
	local var_6_11 = arg_6_0.goldTF[1].selectedTF

	var_6_10.selectedNumTF = var_2.Find(var_6_11, "reduce/Text")
	setText = var_6_10

	var_6_10(arg_6_0.goldTF[1].countTF, var_0_0.goldNum[1])

	setText = var_6_10

	var_6_10(arg_6_0.goldTF[1].priceTF, var_0_0.gemNum[1])

	arg_6_0.goldTF[2] = {}

	local var_6_12 = arg_6_0.contentTF

	arg_6_0.goldTF_2 = var_1.Find(var_6_12, "Gold2")
	arg_6_0.goldTF[2].itemTF = arg_6_0.goldTF_2

	local var_6_13 = arg_6_0.goldTF[2]
	local var_6_14 = arg_6_0.goldTF_2

	var_6_13.countTF = var_2.Find(var_6_14, "item/icon_bg/count")

	local var_6_15 = arg_6_0.goldTF[2]
	local var_6_16 = arg_6_0.goldTF_2

	var_6_15.priceTF = var_2.Find(var_6_16, "item/consume/contain/price")

	local var_6_17 = arg_6_0.goldTF[2]
	local var_6_18 = arg_6_0.goldTF_2

	var_6_17.selectedTF = var_2.Find(var_6_18, "item/selected")

	local var_6_19 = arg_6_0.goldTF[2]
	local var_6_20 = arg_6_0.goldTF[2].selectedTF

	var_6_19.selectedNumTF = var_2.Find(var_6_20, "reduce/Text")
	setText = var_6_19

	var_6_19(arg_6_0.goldTF[2].countTF, var_0_0.goldNum[2])

	setText = var_6_19

	var_6_19(arg_6_0.goldTF[2].priceTF, var_0_0.gemNum[2])

	local var_6_21 = arg_6_0.contentTF

	arg_6_0.gemCountText = var_1.Find(var_6_21, "Tip/DiamondCount")

	local var_6_22 = arg_6_0.contentTF

	arg_6_0.goldCountText = var_1.Find(var_6_22, "Tip/GoldCount")

	local var_6_23 = arg_6_0._tf

	arg_6_0.shopBtn = var_1.Find(var_6_23, "Window/button_container/ShopBtn")

	local var_6_24 = arg_6_0._tf

	arg_6_0.confirmBtn = var_1.Find(var_6_24, "Window/button_container/ConfirmBtn")

	return
end

function var_0_0.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bg

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.exit(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.btnBack

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.exit(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.shopBtn

	local function var_7_8()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_10_0 = var_2_10000(var_2_10002)
		local var_10_1 = var_0.getContextByMediator

		NewShopMainMediator = var_2_10004

		if var_10_1(var_10_0, var_2_10004) then
			local var_10_2 = arg_7_0

			var_2_10002.exit(var_10_2)
		else
			pg = var_2_10002

			local var_10_3 = var_2_10002.m02
			local var_10_4 = var_2.sendNotification

			GAME = var_2_10005

			local var_10_5 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			local var_10_6 = var_2_10006.CHARGE
			local var_10_7 = {}

			ChargeScene = var_2_10008
			var_10_7.wrap = var_2_10008.TYPE_ITEM

			var_10_4(var_10_3, var_10_5, var_10_6, var_10_7)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.confirmBtn

	local function var_7_11()
		local var_11_0

		if arg_7_0.selectedIndex == 1 then
			var_11_0 = var_0_0.itemid1
		elseif arg_7_0.selectedIndex == 2 then
			var_11_0 = var_0_0.itemid2
		end

		pg = var_1

		local var_11_1 = var_1.m02
		local var_11_2 = var_1.sendNotification

		GAME = var_2_10004

		var_11_2(var_11_1, var_2_10004.SHOPPING, {
			isQuickShopping = true,
			id = var_11_0,
			count = arg_7_0.selectedNum
		})

		local var_11_3 = arg_7_0

		var_1.exit(var_11_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10006)

	for iter_7_0 = 1, 2 do
		onButton = var_7_11

		local var_7_12 = arg_7_0
		local var_7_13 = arg_7_0.goldTF[iter_7_0].itemTF

		local function var_7_14()
			if arg_7_0.selectedIndex == iter_7_0 then
				local var_12_0 = arg_7_0

				math = var_1
				var_12_0.selectedNum = var_1.min(arg_7_0.selectedNum + 1, arg_7_0.selectedMax)
			else
				arg_7_0.selectedIndex = iter_7_0
				arg_7_0.selectedNum = 1
			end

			local var_12_1 = arg_7_0

			var_0.updateView(var_12_1)

			return
		end

		SFX_PANEL = var_1_10010

		var_7_11(var_7_12, var_7_13, var_7_14, var_1_10010)

		onButton = var_7_11

		local var_7_15 = arg_7_0
		local var_7_16 = arg_7_0.goldTF[iter_7_0].selectedTF

		local function var_7_17()
			if arg_7_0.selectedNum > 1 then
				arg_7_0.selectedNum = arg_7_0.selectedNum - 1

				local var_13_0 = arg_7_0

				var_0.updateView(var_13_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_7_11(var_7_15, var_7_16, var_7_17, var_1_10010)
	end

	return
end

function var_0_0.updateView(arg_14_0)
	for iter_14_0 = 1, 2 do
		setActive = var_1_10005

		var_1_10005(arg_14_0.goldTF[iter_14_0].selectedTF, iter_14_0 == arg_14_0.selectedIndex)

		setActive = var_1_10005

		var_1_10005(arg_14_0.goldTF[3 - iter_14_0].selectedTF, iter_14_0 ~= arg_14_0.selectedIndex)

		if iter_14_0 == arg_14_0.selectedIndex then
			setText = var_1_10005

			var_1_10005(arg_14_0.goldTF[iter_14_0].selectedNumTF, arg_14_0.selectedNum)
		end
	end

	local var_14_0
	local var_14_1
	local var_14_2 = var_0_0.gemNum[arg_14_0.selectedIndex] * arg_14_0.selectedNum
	local var_14_3 = var_0_0.goldNum[arg_14_0.selectedIndex] * arg_14_0.selectedNum

	setText = var_3

	var_3(arg_14_0.gemCountText, var_14_2)

	local var_14_4 = arg_14_0.player

	if var_3.getTotalGem(var_14_4) < var_14_2 then
		setTextColor = var_3

		local var_14_5 = arg_14_0.gemCountText

		Color = var_6

		var_3(var_14_5, var_6.red)
	else
		setTextColor = var_3

		local var_14_6 = arg_14_0.gemCountText

		Color = var_6

		var_3(var_14_6, var_6.yellow)
	end

	setText = var_3

	var_3(arg_14_0.goldCountText, var_14_3)

	return
end

function var_0_0.overLayMyself(arg_15_0, arg_15_1)
	if arg_15_1 == true then
		pg = var_1_10002

		local var_15_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_15_0, arg_15_0._tf)
	else
		pg = var_1_10002

		local var_15_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_15_1, arg_15_0._tf)
	end

	return
end

return var_0_0
