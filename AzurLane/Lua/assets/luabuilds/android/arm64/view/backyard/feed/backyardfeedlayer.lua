local var_0_0 = class("BackyardFeedLayer", import("...base.BaseUI"))
local var_0_1 = {
	50001,
	50002,
	50003,
	50004,
	50005,
	50006
}

function var_0_0.getUIName(arg_1_0)
	return "BackyardFeedUI"
end

function var_0_0.SetIsRemind(arg_2_0, arg_2_1)
	arg_2_0.remindEndTime = arg_2_1

	return
end

function var_0_0.OnUsageItem(arg_3_0, arg_3_1)
	local var_3_0 = table.indexof(var_0_1, arg_3_1)

	if not var_3_0 or var_3_0 <= 0 then
		return
	end

	arg_3_0.cards[var_3_0]:UpdateCnt((getProxy(BagProxy):getItemCountById(arg_3_1)))

	return
end

function var_0_0.OnDormUpdated(arg_4_0)
	arg_4_0:UpdateDorm()

	return
end

function var_0_0.OnShopDone(arg_5_0)
	arg_5_0:UpdateCards()
	arg_5_0:UpdateDorm()

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.frame = arg_6_0._tf:Find("frame")
	arg_6_0.chatTxt = arg_6_0._tf:Find("chat/Text"):GetComponent(typeof(Text))
	arg_6_0.chatTxt1 = arg_6_0._tf:Find("chat/Text1"):GetComponent(typeof(Text))
	arg_6_0.chatTime = arg_6_0._tf:Find("chat/Text/time"):GetComponent(typeof(Text))
	arg_6_0.chatTxt2 = arg_6_0._tf:Find("chat/Text2"):GetComponent(typeof(Text))
	arg_6_0.capacityBar = arg_6_0._tf:Find("frame/progress"):GetComponent(typeof(Slider))
	arg_6_0.capacityBarEffect = arg_6_0._tf:Find("frame/progress_effect"):GetComponent(typeof(Slider))
	arg_6_0.capacityTxt = arg_6_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_6_0.extendBtn = arg_6_0._tf:Find("frame/extend_btn")
	arg_6_0.additionTxt = arg_6_0._tf:Find("frame/addition"):GetComponent(typeof(Text))
	arg_6_0.paint = arg_6_0._tf:Find("lenggui")
	arg_6_0.cardTpl = arg_6_0._tf:Find("frame/foodtpl")
	arg_6_0.purchasePage = BackyardFeedPurchasePage.New(arg_6_0._tf, arg_6_0.event)
	arg_6_0.extendPage = BackyardFeedExtendPage.New(arg_6_0._tf, arg_6_0.event)
	arg_6_0.closeBtn = arg_6_0._tf:Find("close")
	Input.multiTouchEnabled = false

	setText(arg_6_0._tf:Find("frame/extend_btn/Text"), i18n("enter_extend_food_label"))

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.closeBtn, function()
		arg_7_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.extendBtn, function()
		local var_9_0 = getProxy(DormProxy):getRawData()
		local var_9_1 = ShoppingStreet.getRiseShopId(ShopArgs.BackyardFoodExtend, var_9_0.food_extend_count)

		if not var_9_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buy_max_count"))

			return
		end

		arg_7_0.extendPage:ExecuteAction("Show", var_9_1, var_9_0:GetCapcity())

		return
	end, SFX_PANEL)
	GetOrAddComponent(arg_7_0.paint, "SpineAnimUI"):SetAction("animation", 0)
	arg_7_0:UpdateDorm()
	arg_7_0:InitFoods()

	return
end

function var_0_0.UpdateDorm(arg_10_0)
	local var_10_0 = getProxy(DormProxy):getRawData()

	arg_10_0:InitCharChat(var_10_0)

	if not arg_10_0.playing then
		arg_10_0:InitCapcity(var_10_0)
	end

	return
end

function var_0_0.InitCharChat(arg_11_0, arg_11_1)
	arg_11_0:RemoveTimer()
	arg_11_0:ClearTxts()

	arg_11_0.chatTxt2.text = ""

	if arg_11_1:GetFloorShipCnt(DormShip.FLOOR_1) <= 0 then
		arg_11_0.chatTxt2.text = i18n("backyard_backyardGranaryLayer_noShip")
	elseif arg_11_1.food <= 0 then
		arg_11_0.chatTxt2.text = i18n("backyard_backyardGranaryLayer_word")
	else
		arg_11_0:AddChatTimer(arg_11_1)
	end

	return
end

function var_0_0.ClearTxts(arg_12_0)
	arg_12_0.chatTxt.text = ""
	arg_12_0.chatTxt1.text = ""
	arg_12_0.chatTime.text = ""

	return
end

function var_0_0.AddChatTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getFoodLeftTime()

	arg_13_0.chatTxt.text = i18n("backyard_backyardGranaryLayer_foodTimeNotice_top")
	arg_13_0.chatTxt1.text = i18n("backyard_backyardGranaryLayer_foodTimeNotice_bottom")

	arg_13_0:RemoveTimer()

	arg_13_0.timer = Timer.New(function()
		local var_14_0 = var_13_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_14_0 <= 0 then
			arg_13_0:RemoveTimer()

			arg_13_0.chatTxt2.text = i18n("backyard_backyardGranaryLayer_word")

			arg_13_0:ClearTxts()
		else
			local var_14_1 = arg_13_0.chatTime

			var_14_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_0)
		end

		return
	end, 1, -1)

	arg_13_0.timer:Start()
	arg_13_0.timer.func()

	return
end

function var_0_0.InitCapcity(arg_15_0, arg_15_1)
	arg_15_0:UpdateCapacity(arg_15_1.food, (arg_15_1:GetCapcity()))

	return
end

function var_0_0.UpdateCapacity(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.capacityBar.value = arg_16_1 / arg_16_2
	arg_16_0.capacityBarEffect.value = arg_16_1 / arg_16_2

	arg_16_0:UpdateCapacityTxt(arg_16_1, arg_16_2)

	return
end

function var_0_0.UpdateCapacityTxt(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.capacityTxt.text = "<color=#eb9e30>" .. arg_17_1 .. "</color><color=#606064>/" .. arg_17_2 .. "</color>"

	return
end

function var_0_0.UpdateCapacityWithAnim(arg_18_0, arg_18_1, arg_18_2)
	if LeanTween.isTweening(arg_18_0.capacityBarEffect.gameObject) then
		LeanTween.cancel(arg_18_0.capacityBarEffect.gameObject)
	end

	if LeanTween.isTweening(arg_18_0.capacityBar.gameObject) then
		LeanTween.cancel(arg_18_0.capacityBar.gameObject)
	end

	arg_18_0.playing = true

	arg_18_0:UpdateCapacityTxt(arg_18_1, arg_18_2)
	LeanTween.value(arg_18_0.capacityBarEffect.gameObject, arg_18_0.capacityBarEffect.value, arg_18_1 / arg_18_2, 0.396):setOnUpdate(System.Action_float(function(arg_19_0)
		arg_18_0.capacityBarEffect.value = arg_19_0

		return
	end)):setEase(LeanTweenType.easeOutQuint)
	LeanTween.value(arg_18_0.capacityBar.gameObject, arg_18_0.capacityBarEffect.value, arg_18_1 / arg_18_2, 0.396):setEase(LeanTweenType.easeInOutQuart):setOnUpdate(System.Action_float(function(arg_20_0)
		arg_18_0.capacityBar.value = arg_20_0

		return
	end)):setOnComplete(System.Action(function()
		arg_18_0:UpdateDorm()

		arg_18_0.playing = false

		return
	end)):setDelay(0.069)

	return
end

local function var_0_2(arg_22_0, arg_22_1)
	onButton(arg_22_0, arg_22_1.mask, function()
		arg_22_0.purchasePage:ExecuteAction("Show", arg_22_1.foodId)

		return
	end, SFX_PANEL)
	onButton(arg_22_0, arg_22_1.addTF, function()
		arg_22_0.purchasePage:ExecuteAction("Show", arg_22_1.foodId)

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_22_1.icon, 0.5, function(arg_25_0)
		arg_22_0:SimulateAddFood(arg_22_1.foodId, arg_25_0)

		return
	end, function()
		arg_22_0:TriggerAddFood(arg_22_1.foodId, arg_22_0.simulateUsageCnt)

		arg_22_0.simulateFood = nil
		arg_22_0.simulateCapacity = nil
		arg_22_0.simulateAddition = nil
		arg_22_0.simulateItemCnt = nil
		arg_22_0.simulateUsageCnt = nil
		arg_22_0.isSimulation = nil

		return
	end, true, true, 0.15, SFX_PANEL)

	return
end

function var_0_0.InitFoods(arg_27_0)
	arg_27_0.cards = {}

	local var_27_0 = FoodCard.New(arg_27_0.cardTpl)

	table.insert(arg_27_0.cards, var_27_0)
	var_0_2(arg_27_0, var_27_0)

	for iter_27_0 = 1, #var_0_1 - 1 do
		table.insert({}, function(arg_28_0)
			if arg_27_0.exited then
				return
			end

			local var_28_0 = FoodCard.New(cloneTplTo(arg_27_0.cardTpl, arg_27_0.cardTpl.parent))

			var_28_0:UpdatePositin(iter_27_0)
			var_0_2(arg_27_0, var_28_0)
			table.insert(arg_27_0.cards, var_28_0)
			onNextTick(arg_28_0)

			return
		end)
	end

	seriesAsync({}, function()
		if arg_27_0.exited then
			return
		end

		arg_27_0:UpdateCards()

		return
	end)

	return
end

function var_0_0.UpdateCards(arg_30_0)
	for iter_30_0 = 1, #var_0_1 do
		local var_30_0 = getProxy(BagProxy)

		arg_30_0.cards[iter_30_0]:Update(var_0_1[iter_30_0], (var_30_0:getItemCountById(var_0_1[iter_30_0])))
	end

	return
end

function var_0_0.SimulateAddFood(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0.isSimulation then
		local var_31_0 = getProxy(DormProxy):getRawData()

		arg_31_0.simulateFood = var_31_0.food
		arg_31_0.simulateCapacity = var_31_0:GetCapcity()
		arg_31_0.simulateAddition = Item.getConfigData(arg_31_1).usage_arg[1]
		arg_31_0.simulateItemCnt = getProxy(BagProxy):getItemCountById(arg_31_1)
		arg_31_0.simulateUsageCnt = 0
		arg_31_0.isSimulation = true
	end

	if arg_31_0.simulateFood >= arg_31_0.simulateCapacity then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_full"))
		arg_31_2()

		return
	elseif arg_31_0.simulateItemCnt == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_foodCountLimit"))
		arg_31_2()

		return
	elseif arg_31_0.simulateFood + arg_31_0.simulateAddition > arg_31_0.simulateCapacity then
		if pg.TimeMgr.GetInstance():GetServerTime() > arg_31_0.remindEndTime then
			arg_31_0:ShowCapcityTip(arg_31_1, arg_31_0.simulateFood, arg_31_0.simulateCapacity, arg_31_0.simulateAddition)
			arg_31_2()

			return
		end
	end

	arg_31_0.simulateItemCnt = arg_31_0.simulateItemCnt - 1
	arg_31_0.simulateUsageCnt = arg_31_0.simulateUsageCnt + 1
	arg_31_0.simulateFood = arg_31_0.simulateFood + arg_31_0.simulateAddition

	arg_31_0:UpdateCapacityWithAnim(arg_31_0.simulateFood, arg_31_0.simulateCapacity)
	arg_31_0.cards[table.indexof(var_0_1, arg_31_1)]:UpdateCnt(arg_31_0.simulateItemCnt)
	arg_31_0:DoAddFoodAnimation(arg_31_0.simulateAddition)

	return
end

function var_0_0.DoAddFoodAnimation(arg_32_0, arg_32_1)
	arg_32_0.additionTxt.text = "+" .. arg_32_1

	if LeanTween.isTweening(go(arg_32_0.additionTxt)) then
		LeanTween.cancel(go(arg_32_0.additionTxt))
	end

	LeanTween.moveLocalY(go(arg_32_0.additionTxt), 220, 0.5):setFrom(160):setOnComplete(System.Action(function()
		arg_32_0.additionTxt.text = ""

		return
	end))

	return
end

function var_0_0.ShowCapcityTip(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = pg.MsgboxMgr.GetInstance()

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		showStopRemind = true,
		type = MSGBOX_TYPE_SINGLE_ITEM,
		content = i18n("backyard_food_remind", Item.getConfigData(arg_34_1).name),
		name = i18n("backyard_food_count", arg_34_2 .. "/" .. arg_34_3),
		drop = {
			type = DROP_TYPE_ITEM,
			id = arg_34_1,
			count = i18n("common_food") .. ":" .. arg_34_4
		},
		onYes = function()
			arg_34_0:emit(BackyardFeedMediator.USE_FOOD, arg_34_1, 1, var_34_0.stopRemindToggle.isOn)

			return
		end
	})

	return
end

function var_0_0.TriggerAddFood(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_2 or arg_36_2 <= 0 then
		return
	end

	arg_36_0:emit(BackyardFeedMediator.USE_FOOD, arg_36_1, arg_36_2)

	return
end

function var_0_0.RemoveTimer(arg_37_0)
	if arg_37_0.timer then
		arg_37_0.timer:Stop()

		arg_37_0.timer = nil
	end

	return
end

function var_0_0.willExit(arg_38_0)
	if LeanTween.isTweening(arg_38_0.capacityBarEffect.gameObject) then
		LeanTween.cancel(arg_38_0.capacityBarEffect.gameObject)
	end

	if LeanTween.isTweening(arg_38_0.capacityBar.gameObject) then
		LeanTween.cancel(arg_38_0.capacityBar.gameObject)
	end

	arg_38_0:RemoveTimer()

	for iter_38_0, iter_38_1 in pairs(arg_38_0.cards) do
		iter_38_1:Dispose()
	end

	arg_38_0.cards = nil

	if LeanTween.isTweening(go(arg_38_0.additionTxt)) then
		LeanTween.cancel(go(arg_38_0.additionTxt))
	end

	if arg_38_0.purchasePage then
		arg_38_0.purchasePage:Destroy()

		arg_38_0.purchasePage = nil
	end

	if arg_38_0.extendPage then
		arg_38_0.extendPage:Destroy()

		arg_38_0.extendPage = nil
	end

	Input.multiTouchEnabled = true

	return
end

return var_0_0
