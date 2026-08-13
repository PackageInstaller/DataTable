class = var_0_10000

local var_0_0 = "BackyardFeedLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))
local var_0_2 = {
	50001,
	50002,
	50003,
	50004,
	50005,
	50006
}

function var_0_1.getUIName(arg_1_0)
	return "BackyardFeedUI"
end

function var_0_1.SetIsRemind(arg_2_0, arg_2_1)
	arg_2_0.remindEndTime = arg_2_1

	return
end

function var_0_1.OnUsageItem(arg_3_0, arg_3_1)
	table = var_1_10002

	if not var_1_10002.indexof(var_0_2, arg_3_1) or var_2 <= 0 then
		return
	end

	local var_3_0 = arg_3_0.cards[var_2]

	getProxy = var_4
	BagProxy = var_1_10005

	local var_3_1 = var_4(var_1_10005)
	local var_3_2 = var_4.getItemCountById(var_3_1, arg_3_1)

	var_3_0:UpdateCnt(var_3_2)

	return
end

function var_0_1.OnDormUpdated(arg_4_0)
	arg_4_0:UpdateDorm()

	return
end

function var_0_1.OnShopDone(arg_5_0)
	arg_5_0:UpdateCards()
	arg_5_0:UpdateDorm()

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.frame = var_1.Find(var_6_0, "frame")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "chat/Text")
	local var_6_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.chatTxt = var_6_3(var_6_2, var_3(var_1_10004))

	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_1.Find(var_6_4, "chat/Text1")
	local var_6_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.chatTxt1 = var_6_6(var_6_5, var_3(var_1_10004))

	local var_6_7 = arg_6_0._tf
	local var_6_8 = var_1.Find(var_6_7, "chat/Text/time")
	local var_6_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.chatTime = var_6_9(var_6_8, var_3(var_1_10004))

	local var_6_10 = arg_6_0._tf
	local var_6_11 = var_1.Find(var_6_10, "chat/Text2")
	local var_6_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.chatTxt2 = var_6_12(var_6_11, var_3(var_1_10004))

	local var_6_13 = arg_6_0._tf
	local var_6_14 = var_1.Find(var_6_13, "frame/progress")
	local var_6_15 = var_1.GetComponent

	typeof = var_3
	Slider = var_1_10004
	arg_6_0.capacityBar = var_6_15(var_6_14, var_3(var_1_10004))

	local var_6_16 = arg_6_0._tf
	local var_6_17 = var_1.Find(var_6_16, "frame/progress_effect")
	local var_6_18 = var_1.GetComponent

	typeof = var_3
	Slider = var_1_10004
	arg_6_0.capacityBarEffect = var_6_18(var_6_17, var_3(var_1_10004))

	local var_6_19 = arg_6_0._tf
	local var_6_20 = var_1.Find(var_6_19, "frame/Text")
	local var_6_21 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.capacityTxt = var_6_21(var_6_20, var_3(var_1_10004))

	local var_6_22 = arg_6_0._tf

	arg_6_0.extendBtn = var_1.Find(var_6_22, "frame/extend_btn")

	local var_6_23 = arg_6_0._tf
	local var_6_24 = var_1.Find(var_6_23, "frame/addition")
	local var_6_25 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_6_0.additionTxt = var_6_25(var_6_24, var_3(var_1_10004))

	local var_6_26 = arg_6_0._tf

	arg_6_0.paint = var_1.Find(var_6_26, "lenggui")

	local var_6_27 = arg_6_0._tf

	arg_6_0.cardTpl = var_1.Find(var_6_27, "frame/foodtpl")
	BackyardFeedPurchasePage = var_1
	arg_6_0.purchasePage = var_1.New(arg_6_0._tf, arg_6_0.event)
	BackyardFeedExtendPage = var_1
	arg_6_0.extendPage = var_1.New(arg_6_0._tf, arg_6_0.event)

	local var_6_28 = arg_6_0._tf

	arg_6_0.closeBtn = var_1.Find(var_6_28, "close")
	Input = var_1
	var_1.multiTouchEnabled = false
	setText = var_1

	local var_6_29 = arg_6_0._tf
	local var_6_30 = var_2.Find(var_6_29, "frame/extend_btn/Text")

	i18n = var_6_29

	var_1(var_6_30, var_6_29("enter_extend_food_label"))

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.closeBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.extendBtn

	local function var_7_5()
		getProxy = var_2_10000
		DormProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = var_0.getRawData(var_9_0)

		ShoppingStreet = var_9_0

		local var_9_2 = var_9_0.getRiseShopId

		ShopArgs = var_2_10002

		if not var_9_2(var_2_10002.BackyardFoodExtend, var_9_1.food_extend_count) then
			pg = var_2

			local var_9_3 = var_2.TipsMgr.GetInstance()
			local var_9_4 = var_2.ShowTips

			i18n = var_2_10004

			var_9_4(var_9_3, var_2_10004("backyard_backyardGranaryLayer_buy_max_count"))

			return
		end

		local var_9_5 = arg_7_0.extendPage

		var_2.ExecuteAction(var_9_5, "Show", var_1, var_9_1:GetCapcity())

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	GetOrAddComponent = var_1_10001

	local var_7_6 = var_1_10001(arg_7_0.paint, "SpineAnimUI")

	var_1.SetAction(var_7_6, "animation", 0)
	arg_7_0:UpdateDorm()
	arg_7_0:InitFoods()

	return
end

function var_0_1.UpdateDorm(arg_10_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getRawData(var_10_0)

	arg_10_0:InitCharChat(var_10_1)

	if not arg_10_0.playing then
		arg_10_0:InitCapcity(var_10_1)
	end

	return
end

function var_0_1.InitCharChat(arg_11_0, arg_11_1)
	arg_11_0:RemoveTimer()
	arg_11_0:ClearTxts()

	arg_11_0.chatTxt2.text = ""

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.GetFloorShipCnt

	DormShip = var_1_10004

	if var_11_1(var_11_0, var_1_10004.FLOOR_1) <= 0 then
		local var_11_2 = arg_11_0.chatTxt2

		i18n = var_4
		var_11_2.text = var_4("backyard_backyardGranaryLayer_noShip")
	elseif arg_11_1.food <= 0 then
		local var_11_3 = arg_11_0.chatTxt2

		i18n = var_4
		var_11_3.text = var_4("backyard_backyardGranaryLayer_word")
	else
		arg_11_0:AddChatTimer(arg_11_1)
	end

	return
end

function var_0_1.ClearTxts(arg_12_0)
	arg_12_0.chatTxt.text = ""
	arg_12_0.chatTxt1.text = ""
	arg_12_0.chatTime.text = ""

	return
end

function var_0_1.AddChatTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getFoodLeftTime()
	local var_13_1 = arg_13_0.chatTxt

	i18n = var_1_10004
	var_13_1.text = var_1_10004("backyard_backyardGranaryLayer_foodTimeNotice_top")

	local var_13_2 = arg_13_0.chatTxt1

	i18n = var_4
	var_13_2.text = var_4("backyard_backyardGranaryLayer_foodTimeNotice_bottom")

	arg_13_0:RemoveTimer()

	Timer = var_3
	arg_13_0.timer = var_3.New(function()
		local var_14_0 = var_13_0

		pg = var_2_10001

		local var_14_1 = var_2_10001.TimeMgr.GetInstance()

		if var_14_0 - var_1.GetServerTime(var_14_1) <= 0 then
			var_14_1 = arg_13_0

			var_1.RemoveTimer(var_14_1)

			local var_14_2 = arg_13_0.chatTxt2

			i18n = var_14_1
			var_14_2.text = var_14_1("backyard_backyardGranaryLayer_word")
			var_14_1 = arg_13_0

			var_1.ClearTxts(var_14_1)
		else
			local var_14_3 = arg_13_0.chatTime

			pg = var_14_1

			local var_14_4 = var_14_1.TimeMgr.GetInstance()

			var_14_3.text = var_2.DescCDTime(var_14_4, var_0)
		end

		return
	end, 1, -1)

	local var_13_3 = arg_13_0.timer

	var_3.Start(var_13_3)
	arg_13_0.timer.func()

	return
end

function var_0_1.InitCapcity(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetCapcity()

	arg_15_0:UpdateCapacity(arg_15_1.food, var_15_0)

	return
end

function var_0_1.UpdateCapacity(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1 / arg_16_2

	arg_16_0.capacityBar.value = var_16_0
	arg_16_0.capacityBarEffect.value = var_16_0

	arg_16_0:UpdateCapacityTxt(arg_16_1, arg_16_2)

	return
end

function var_0_1.UpdateCapacityTxt(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.capacityTxt.text = "<color=#eb9e30>" .. arg_17_1 .. "</color><color=#606064>/" .. arg_17_2 .. "</color>"

	return
end

function var_0_1.UpdateCapacityWithAnim(arg_18_0, arg_18_1, arg_18_2)
	LeanTween = var_1_10003

	if var_1_10003.isTweening(arg_18_0.capacityBarEffect.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_18_0.capacityBarEffect.gameObject)
	end

	LeanTween = var_3

	if var_3.isTweening(arg_18_0.capacityBar.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_18_0.capacityBar.gameObject)
	end

	arg_18_0.playing = true

	local var_18_0 = arg_18_0.capacityBarEffect.value
	local var_18_1 = arg_18_1 / arg_18_2

	arg_18_0:UpdateCapacityTxt(arg_18_1, arg_18_2)

	LeanTween = var_5

	local var_18_2 = var_5.value(arg_18_0.capacityBarEffect.gameObject, var_18_0, var_18_1, 0.396)
	local var_18_3 = var_5.setOnUpdate

	System = var_7

	local var_18_4 = var_18_3(var_18_2, var_7.Action_float(function(arg_19_0)
		arg_18_0.capacityBarEffect.value = arg_19_0

		return
	end))
	local var_18_5 = var_5.setEase

	LeanTweenType = var_7

	var_18_5(var_18_4, var_7.easeOutQuint)

	LeanTween = var_18_5

	local var_18_6 = var_18_5.value(arg_18_0.capacityBar.gameObject, var_18_0, var_18_1, 0.396)
	local var_18_7 = var_5.setEase

	LeanTweenType = var_7

	local var_18_8 = var_18_7(var_18_6, var_7.easeInOutQuart)
	local var_18_9 = var_5.setOnUpdate

	System = var_7

	local var_18_10 = var_18_9(var_18_8, var_7.Action_float(function(arg_20_0)
		arg_18_0.capacityBar.value = arg_20_0

		return
	end))
	local var_18_11 = var_5.setOnComplete

	System = var_7

	local var_18_12 = var_18_11(var_18_10, var_7.Action(function()
		local var_21_0 = arg_18_0

		var_0.UpdateDorm(var_21_0)

		arg_18_0.playing = false

		return
	end))

	var_5.setDelay(var_18_12, 0.069)

	return
end

local function var_0_3(arg_22_0, arg_22_1)
	onButton = var_1_10002

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_1.mask

	local function var_22_2()
		local var_23_0 = arg_22_0.purchasePage

		var_0.ExecuteAction(var_23_0, "Show", arg_22_1.foodId)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_22_0, var_22_1, var_22_2, var_1_10006)

	onButton = var_1_10002

	local var_22_3 = arg_22_0
	local var_22_4 = arg_22_1.addTF

	local function var_22_5()
		local var_24_0 = arg_22_0.purchasePage

		var_0.ExecuteAction(var_24_0, "Show", arg_22_1.foodId)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_22_3, var_22_4, var_22_5, var_1_10006)

	pressPersistTrigger = var_1_10002

	local var_22_6 = arg_22_1.icon
	local var_22_7 = 0.5

	local function var_22_8(arg_25_0)
		local var_25_0 = arg_22_0

		var_1.SimulateAddFood(var_25_0, arg_22_1.foodId, arg_25_0)

		return
	end

	local function var_22_9()
		local var_26_0 = arg_22_0

		var_0.TriggerAddFood(var_26_0, arg_22_1.foodId, arg_22_0.simulateUsageCnt)

		arg_22_0.simulateFood = nil
		arg_22_0.simulateCapacity = nil
		arg_22_0.simulateAddition = nil
		arg_22_0.simulateItemCnt = nil
		arg_22_0.simulateUsageCnt = nil
		arg_22_0.isSimulation = nil

		return
	end

	local var_22_10 = true
	local var_22_11 = true
	local var_22_12 = 0.15

	SFX_PANEL = var_1_10010

	var_1_10002(var_22_6, var_22_7, var_22_8, var_22_9, var_22_10, var_22_11, var_22_12, var_1_10010)

	return
end

function var_0_1.InitFoods(arg_27_0)
	arg_27_0.cards = {}
	FoodCard = var_1

	local var_27_0 = var_1.New(arg_27_0.cardTpl)

	table = var_2

	var_2.insert(arg_27_0.cards, var_27_0)
	var_0_3(arg_27_0, var_27_0)

	local var_27_1 = {}

	for iter_27_0 = 1, #var_0_2 - 1 do
		table = var_1_10007

		var_1_10007.insert(var_27_1, function(arg_28_0)
			if arg_27_0.exited then
				return
			end

			FoodCard = var_1

			local var_28_0 = var_1.New

			cloneTplTo = var_2_10002

			local var_28_1 = var_28_0(var_2_10002(arg_27_0.cardTpl, arg_27_0.cardTpl.parent))

			var_1.UpdatePositin(var_28_1, iter_27_0)
			var_0_3(arg_27_0, var_1)

			table = var_2

			var_2.insert(arg_27_0.cards, var_1)

			onNextTick = var_2

			var_2(arg_28_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_27_1, function()
		if arg_27_0.exited then
			return
		end

		local var_29_0 = arg_27_0

		var_0.UpdateCards(var_29_0)

		return
	end)

	return
end

function var_0_1.UpdateCards(arg_30_0)
	for iter_30_0 = 1, #var_0_2 do
		local var_30_0 = var_0_2[iter_30_0]
		local var_30_1 = arg_30_0.cards[iter_30_0]

		getProxy = var_1_10007
		BagProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)
		var_1_10007 = var_1_10007.getItemCountById(var_1_10008, var_30_0)

		var_30_1:Update(var_30_0, var_1_10007)
	end

	return
end

function var_0_1.SimulateAddFood(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0.isSimulation then
		getProxy = var_3
		DormProxy = var_1_10004

		local var_31_0 = var_3(var_1_10004)

		arg_31_0.simulateFood = var_3.getRawData(var_31_0).food
		var_1_10005 = var_3
		arg_31_0.simulateCapacity = var_3.GetCapcity(var_1_10005)
		Item = var_4
		arg_31_0.simulateAddition = var_4.getConfigData(arg_31_1).usage_arg[1]
		getProxy = var_4
		BagProxy = var_1_10005
		var_1_10005 = var_4(var_1_10005)
		arg_31_0.simulateItemCnt = var_4.getItemCountById(var_1_10005, arg_31_1)
		arg_31_0.simulateUsageCnt = 0
		arg_31_0.isSimulation = true
	end

	if arg_31_0.simulateFood >= arg_31_0.simulateCapacity then
		pg = var_3

		local var_31_1 = var_3.TipsMgr.GetInstance()
		local var_31_2 = var_3.ShowTips

		i18n = var_1_10005

		var_31_2(var_31_1, var_1_10005("backyard_backyardGranaryLayer_full"))
		arg_31_2()

		return
	elseif arg_31_0.simulateItemCnt == 0 then
		pg = var_3

		local var_31_3 = var_3.TipsMgr.GetInstance()
		local var_31_4 = var_3.ShowTips

		i18n = var_1_10005

		var_31_4(var_31_3, var_1_10005("backyard_backyardGranaryLayer_foodCountLimit"))
		arg_31_2()

		return
	elseif arg_31_0.simulateFood + arg_31_0.simulateAddition > arg_31_0.simulateCapacity then
		pg = var_3

		local var_31_5 = var_3.TimeMgr.GetInstance()

		if var_3.GetServerTime(var_31_5) > arg_31_0.remindEndTime then
			arg_31_0:ShowCapcityTip(arg_31_1, arg_31_0.simulateFood, arg_31_0.simulateCapacity, arg_31_0.simulateAddition)
			arg_31_2()

			return
		end
	end

	arg_31_0.simulateItemCnt = arg_31_0.simulateItemCnt - 1
	arg_31_0.simulateUsageCnt = arg_31_0.simulateUsageCnt + 1
	arg_31_0.simulateFood = arg_31_0.simulateFood + arg_31_0.simulateAddition

	arg_31_0:UpdateCapacityWithAnim(arg_31_0.simulateFood, arg_31_0.simulateCapacity)

	table = var_3

	local var_31_6 = var_3.indexof(var_0_2, arg_31_1)
	local var_31_7 = arg_31_0.cards[var_31_6]

	var_4.UpdateCnt(var_31_7, arg_31_0.simulateItemCnt)
	arg_31_0:DoAddFoodAnimation(arg_31_0.simulateAddition)

	return
end

function var_0_1.DoAddFoodAnimation(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.additionTxt

	var_32_0.text = "+" .. arg_32_1
	LeanTween = var_32_0

	local var_32_1 = var_32_0.isTweening

	go = var_3

	local var_32_2

	if var_32_1(var_3(arg_32_0.additionTxt)) then
		LeanTween = var_32_2
		var_32_2 = var_32_2.cancel
		go = var_3

		var_32_2(var_3(arg_32_0.additionTxt))
	end

	LeanTween = var_32_2

	local var_32_3 = var_32_2.moveLocalY

	go = var_3

	local var_32_4 = var_32_3(var_3(arg_32_0.additionTxt), 220, 0.5)
	local var_32_5 = var_2.setFrom(var_32_4, 160)
	local var_32_6 = var_2.setOnComplete

	System = var_4

	var_32_6(var_32_5, var_4.Action(function()
		arg_32_0.additionTxt.text = ""

		return
	end))

	return
end

function var_0_1.ShowCapcityTip(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	pg = var_1_10005

	local var_34_0 = var_1_10005.MsgboxMgr.GetInstance()

	Item = var_1_10006

	local var_34_1 = var_1_10006.getConfigData(arg_34_1).name
	local var_34_2 = var_34_0
	local var_34_3 = var_34_0.ShowMsgBox
	local var_34_4 = {
		showStopRemind = true
	}

	MSGBOX_TYPE_SINGLE_ITEM = var_1_10010
	var_34_4.type = var_1_10010
	i18n = var_1_10010
	var_34_4.content = var_1_10010("backyard_food_remind", var_34_1)
	i18n = var_10
	var_34_4.name = var_10("backyard_food_count", arg_34_2 .. "/" .. arg_34_3)

	local var_34_5 = {}

	DROP_TYPE_ITEM = var_11
	var_34_5.type = var_11
	var_34_5.id = arg_34_1
	i18n = var_11
	var_34_5.count = var_11("common_food") .. ":" .. arg_34_4
	var_34_4.drop = var_34_5

	function var_34_4.onYes()
		local var_35_0 = arg_34_0
		local var_35_1 = var_0.emit

		BackyardFeedMediator = var_2_10002

		var_35_1(var_35_0, var_2_10002.USE_FOOD, arg_34_1, 1, var_34_0.stopRemindToggle.isOn)

		return
	end

	var_34_3(var_34_2, var_34_4)

	return
end

function var_0_1.TriggerAddFood(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_2 or arg_36_2 <= 0 then
		return
	end

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.emit

	BackyardFeedMediator = var_1_10005

	var_36_1(var_36_0, var_1_10005.USE_FOOD, arg_36_1, arg_36_2)

	return
end

function var_0_1.RemoveTimer(arg_37_0)
	if arg_37_0.timer then
		local var_37_0 = arg_37_0.timer

		var_1.Stop(var_37_0)

		arg_37_0.timer = nil
	end

	return
end

function var_0_1.willExit(arg_38_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_38_0.capacityBarEffect.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_38_0.capacityBarEffect.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_38_0.capacityBar.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_38_0.capacityBar.gameObject)
	end

	arg_38_0:RemoveTimer()

	pairs = var_1

	for iter_38_0, iter_38_1 in var_1(arg_38_0.cards) do
		iter_38_1:Dispose()
	end

	arg_38_0.cards = nil
	LeanTween = var_1

	local var_38_0 = var_1.isTweening

	go = var_2

	if var_38_0(var_2(arg_38_0.additionTxt)) then
		LeanTween = var_1

		local var_38_1 = var_1.cancel

		go = var_2

		var_38_1(var_2(arg_38_0.additionTxt))
	end

	if arg_38_0.purchasePage then
		local var_38_2 = arg_38_0.purchasePage

		var_1.Destroy(var_38_2)

		arg_38_0.purchasePage = nil
	end

	if arg_38_0.extendPage then
		local var_38_3 = arg_38_0.extendPage

		var_1.Destroy(var_38_3)

		arg_38_0.extendPage = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

return var_0_1
