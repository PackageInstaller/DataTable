local BackyardFeedLayer = class("BackyardFeedLayer", import("...base.BaseUI"))
local var_0_1 = {
	50001,
	50002,
	50003,
	50004,
	50005,
	50006
}

function BackyardFeedLayer:getUIName()
	return "BackyardFeedUI"
end

function BackyardFeedLayer:SetIsRemind(arg_2_1)
	self.remindEndTime = arg_2_1

	return
end

function BackyardFeedLayer:OnUsageItem(arg_3_1)
	local var_3_0 = table.indexof(var_0_1, arg_3_1)

	if not var_3_0 or var_3_0 <= 0 then
		return
	end

	self.cards[var_3_0]:UpdateCnt((getProxy(BagProxy):getItemCountById(arg_3_1)))

	return
end

function BackyardFeedLayer:OnDormUpdated()
	self:UpdateDorm()

	return
end

function BackyardFeedLayer:OnShopDone()
	self:UpdateCards()
	self:UpdateDorm()

	return
end

function BackyardFeedLayer:init()
	self.frame = self._tf:Find("frame")
	self.chatTxt = self._tf:Find("chat/Text"):GetComponent(typeof(Text))
	self.chatTxt1 = self._tf:Find("chat/Text1"):GetComponent(typeof(Text))
	self.chatTime = self._tf:Find("chat/Text/time"):GetComponent(typeof(Text))
	self.chatTxt2 = self._tf:Find("chat/Text2"):GetComponent(typeof(Text))
	self.capacityBar = self._tf:Find("frame/progress"):GetComponent(typeof(Slider))
	self.capacityBarEffect = self._tf:Find("frame/progress_effect"):GetComponent(typeof(Slider))
	self.capacityTxt = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.extendBtn = self._tf:Find("frame/extend_btn")
	self.additionTxt = self._tf:Find("frame/addition"):GetComponent(typeof(Text))
	self.paint = self._tf:Find("lenggui")
	self.cardTpl = self._tf:Find("frame/foodtpl")
	self.purchasePage = BackyardFeedPurchasePage.New(self._tf, self.event)
	self.extendPage = BackyardFeedExtendPage.New(self._tf, self.event)
	self.closeBtn = self._tf:Find("close")
	Input.multiTouchEnabled = false

	setText(self._tf:Find("frame/extend_btn/Text"), i18n("enter_extend_food_label"))

	return
end

function BackyardFeedLayer:didEnter()
	onButton(self, self.closeBtn, function()
		self:emit(BackyardFeedLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(self, self.extendBtn, function()
		local var_9_0 = getProxy(DormProxy):getRawData()
		local var_9_1 = ShoppingStreet.getRiseShopId(ShopArgs.BackyardFoodExtend, var_9_0.food_extend_count)

		if not var_9_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buy_max_count"))

			return
		end

		self.extendPage:ExecuteAction("Show", var_9_1, var_9_0:GetCapcity())

		return
	end, SFX_PANEL)
	GetOrAddComponent(self.paint, "SpineAnimUI"):SetAction("animation", 0)
	self:UpdateDorm()
	self:InitFoods()

	return
end

function BackyardFeedLayer:UpdateDorm()
	local var_10_0 = getProxy(DormProxy):getRawData()

	self:InitCharChat(var_10_0)

	if not self.playing then
		self:InitCapcity(var_10_0)
	end

	return
end

function BackyardFeedLayer:InitCharChat(arg_11_1)
	self:RemoveTimer()
	self:ClearTxts()

	self.chatTxt2.text = ""

	if arg_11_1:GetFloorShipCnt(DormShip.FLOOR_1) <= 0 then
		self.chatTxt2.text = i18n("backyard_backyardGranaryLayer_noShip")
	elseif arg_11_1.food <= 0 then
		self.chatTxt2.text = i18n("backyard_backyardGranaryLayer_word")
	else
		self:AddChatTimer(arg_11_1)
	end

	return
end

function BackyardFeedLayer:ClearTxts()
	self.chatTxt.text = ""
	self.chatTxt1.text = ""
	self.chatTime.text = ""

	return
end

function BackyardFeedLayer:AddChatTimer(arg_13_1)
	local var_13_0 = arg_13_1:getFoodLeftTime()

	self.chatTxt.text = i18n("backyard_backyardGranaryLayer_foodTimeNotice_top")
	self.chatTxt1.text = i18n("backyard_backyardGranaryLayer_foodTimeNotice_bottom")

	self:RemoveTimer()

	self.timer = Timer.New(function()
		local var_14_0 = var_13_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_14_0 <= 0 then
			self:RemoveTimer()

			self.chatTxt2.text = i18n("backyard_backyardGranaryLayer_word")

			self:ClearTxts()
		else
			self.chatTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_0)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function BackyardFeedLayer:InitCapcity(arg_15_1)
	self:UpdateCapacity(arg_15_1.food, (arg_15_1:GetCapcity()))

	return
end

function BackyardFeedLayer:UpdateCapacity(arg_16_1, arg_16_2)
	self.capacityBar.value = arg_16_1 / arg_16_2
	self.capacityBarEffect.value = arg_16_1 / arg_16_2

	self:UpdateCapacityTxt(arg_16_1, arg_16_2)

	return
end

function BackyardFeedLayer:UpdateCapacityTxt(arg_17_1, arg_17_2)
	self.capacityTxt.text = "<color=#eb9e30>" .. arg_17_1 .. "</color><color=#606064>/" .. arg_17_2 .. "</color>"

	return
end

function BackyardFeedLayer:UpdateCapacityWithAnim(arg_18_1, arg_18_2)
	if LeanTween.isTweening(self.capacityBarEffect.gameObject) then
		LeanTween.cancel(self.capacityBarEffect.gameObject)
	end

	if LeanTween.isTweening(self.capacityBar.gameObject) then
		LeanTween.cancel(self.capacityBar.gameObject)
	end

	self.playing = true

	self:UpdateCapacityTxt(arg_18_1, arg_18_2)
	LeanTween.value(self.capacityBarEffect.gameObject, self.capacityBarEffect.value, arg_18_1 / arg_18_2, 0.396):setOnUpdate(System.Action_float(function(arg_19_0)
		self.capacityBarEffect.value = arg_19_0

		return
	end)):setEase(LeanTweenType.easeOutQuint)
	LeanTween.value(self.capacityBar.gameObject, self.capacityBarEffect.value, arg_18_1 / arg_18_2, 0.396):setEase(LeanTweenType.easeInOutQuart):setOnUpdate(System.Action_float(function(arg_20_0)
		self.capacityBar.value = arg_20_0

		return
	end)):setOnComplete(System.Action(function()
		self:UpdateDorm()

		self.playing = false

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

function BackyardFeedLayer:InitFoods()
	self.cards = {}

	local var_27_0 = FoodCard.New(self.cardTpl)

	table.insert(self.cards, var_27_0)
	var_0_2(self, var_27_0)

	local var_27_1 = {}

	for iter_27_0 = 1, #var_0_1 - 1 do
		table.insert(var_27_1, function(arg_28_0)
			if self.exited then
				return
			end

			local var_28_0 = FoodCard.New(cloneTplTo(self.cardTpl, self.cardTpl.parent))

			var_28_0:UpdatePositin(iter_27_0)
			var_0_2(self, var_28_0)
			table.insert(self.cards, var_28_0)
			onNextTick(arg_28_0)

			return
		end)
	end

	seriesAsync(var_27_1, function()
		if self.exited then
			return
		end

		self:UpdateCards()

		return
	end)

	return
end

function BackyardFeedLayer:UpdateCards()
	for iter_30_0 = 1, #var_0_1 do
		self.cards[iter_30_0]:Update(var_0_1[iter_30_0], (getProxy(BagProxy):getItemCountById(var_0_1[iter_30_0])))
	end

	return
end

function BackyardFeedLayer:SimulateAddFood(arg_31_1, arg_31_2)
	if not self.isSimulation then
		local var_31_0 = getProxy(DormProxy):getRawData()

		self.simulateFood = var_31_0.food
		self.simulateCapacity = var_31_0:GetCapcity()
		self.simulateAddition = Item.getConfigData(arg_31_1).usage_arg[1]
		self.simulateItemCnt = getProxy(BagProxy):getItemCountById(arg_31_1)
		self.simulateUsageCnt = 0
		self.isSimulation = true
	end

	if self.simulateFood >= self.simulateCapacity then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_full"))
		arg_31_2()

		return
	elseif self.simulateItemCnt == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_foodCountLimit"))
		arg_31_2()

		return
	elseif self.simulateFood + self.simulateAddition > self.simulateCapacity then
		if pg.TimeMgr.GetInstance():GetServerTime() > self.remindEndTime then
			self:ShowCapcityTip(arg_31_1, self.simulateFood, self.simulateCapacity, self.simulateAddition)
			arg_31_2()

			return
		end
	end

	self.simulateItemCnt = self.simulateItemCnt - 1
	self.simulateUsageCnt = self.simulateUsageCnt + 1
	self.simulateFood = self.simulateFood + self.simulateAddition

	self:UpdateCapacityWithAnim(self.simulateFood, self.simulateCapacity)
	self.cards[table.indexof(var_0_1, arg_31_1)]:UpdateCnt(self.simulateItemCnt)
	self:DoAddFoodAnimation(self.simulateAddition)

	return
end

function BackyardFeedLayer:DoAddFoodAnimation(arg_32_1)
	self.additionTxt.text = "+" .. arg_32_1

	if LeanTween.isTweening(go(self.additionTxt)) then
		LeanTween.cancel(go(self.additionTxt))
	end

	LeanTween.moveLocalY(go(self.additionTxt), 220, 0.5):setFrom(160):setOnComplete(System.Action(function()
		self.additionTxt.text = ""

		return
	end))

	return
end

function BackyardFeedLayer:ShowCapcityTip(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = pg.MsgboxMgr.GetInstance()

	var_34_0:ShowMsgBox({
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
			self:emit(BackyardFeedMediator.USE_FOOD, arg_34_1, 1, var_34_0.stopRemindToggle.isOn)

			return
		end
	})

	return
end

function BackyardFeedLayer:TriggerAddFood(arg_36_1, arg_36_2)
	if not arg_36_2 or arg_36_2 <= 0 then
		return
	end

	self:emit(BackyardFeedMediator.USE_FOOD, arg_36_1, arg_36_2)

	return
end

function BackyardFeedLayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function BackyardFeedLayer:willExit()
	if LeanTween.isTweening(self.capacityBarEffect.gameObject) then
		LeanTween.cancel(self.capacityBarEffect.gameObject)
	end

	if LeanTween.isTweening(self.capacityBar.gameObject) then
		LeanTween.cancel(self.capacityBar.gameObject)
	end

	self:RemoveTimer()

	for iter_38_0, iter_38_1 in pairs(self.cards) do
		iter_38_1:Dispose()
	end

	self.cards = nil

	if LeanTween.isTweening(go(self.additionTxt)) then
		LeanTween.cancel(go(self.additionTxt))
	end

	if self.purchasePage then
		self.purchasePage:Destroy()

		self.purchasePage = nil
	end

	if self.extendPage then
		self.extendPage:Destroy()

		self.extendPage = nil
	end

	Input.multiTouchEnabled = true

	return
end

return BackyardFeedLayer
