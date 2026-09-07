local BeachGuardGameUI = class("BeachGuardGameUI")

function BeachGuardGameUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_3
	self._gameData = arg_1_2
	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.asset = self._gameData.asset
	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

	onButton(self._event, findTF(self.gameUI, "ad/topRight/btnStop"), function()
		self._event:emit(BeachGuardGameView.OPEN_PAUSE_UI)
		self._event:emit(BeachGuardGameView.PAUSE_GAME, true)

		return
	end)
	onButton(self._event, findTF(self.gameUI, "ad/btnLeave"), function()
		self._event:emit(BeachGuardGameView.OPEN_LEVEL_UI)
		self._event:emit(BeachGuardGameView.PAUSE_GAME, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "ad/top/time/s")
	self.scoreTf = findTF(self.gameUI, "ad/top/score")
	self.bottom = findTF(self.gameUI, "bottom")
	self.goods = findTF(self.gameUI, "bottom/goods")
	self.goodsNum = findTF(self.gameUI, "bottom/goods/num")
	self.goodsAdd = findTF(self.gameUI, "bottom/goods/add")
	self.charContent = findTF(self.gameUI, "bottom/charContainer/content")
	self.cardTpl = findTF(self.gameUI, "bottom/cardTpl")
	self.dragChar = findTF(self.gameUI, "bottom/dragChar")

	setActive(self.dragChar, false)

	self.cards = {}
	self.cardPool = {}
	self.dragData = {}
	self.recycleFlag = false
	self.btnRecycle = findTF(self.gameUI, "bottom/recycles")

	onButton(self._event, self.btnRecycle, function()
		self.recycleFlag = true

		setActive(self.btnRecycle, false)
		setActive(self.btnMask, true)
		self._event:emit(BeachGuardGameView.RECYCLES_CHAR, true)

		return
	end)

	self.enemyComming = findTF(self.gameUI, "enemyComming")
	self.btnMask = findTF(self.gameUI, "bottom/recycleMask")

	onButton(self._event, self.btnMask, function()
		self:cancelRecycle()

		return
	end)

	self.enemyProgress = findTF(self.gameUI, "ad/enemyProgress")
	self.bossRate = findTF(self.gameUI, "ad/bossRate")

	return
end

function BeachGuardGameUI:cancelRecycle()
	self.recycleFlag = false

	setActive(self.btnRecycle, true)
	setActive(self.btnMask, false)
	self._event:emit(BeachGuardGameView.RECYCLES_CHAR, false)

	return
end

function BeachGuardGameUI:show(arg_7_1)
	self.recycleFlag = false

	setActive(self.btnRecycle, true)
	setActive(self.btnMask, false)
	setActive(self.gameUI, arg_7_1)

	return
end

function BeachGuardGameUI:firstUpdate(arg_8_1)
	local var_8_0 = BeachGuardConst.chapter_data[arg_8_1.chapter]

	self.enemyTime = BeachGuardConst.chapater_enemy[arg_8_1.chapter].time

	if not self.enemyTime or self.enemyTime == 0 then
		setActive(self.enemyProgress, false)
		setActive(self.bossRate, false)
	else
		setActive(self.enemyProgress, true)
		setActive(self.bossRate, true)
	end

	self.bossRateNum = BeachGuardConst.chapater_enemy[arg_8_1.chapter].boss_rate

	if not self.bossRateNum or self.bossRateNum == 0 then
		setActive(self.bossRate, false)
	else
		setActive(self.bossRate, true)
		setSlider(self.bossRate, 0, 1, self.bossRateNum)
	end

	setActive(self.enemyComming, false)

	self.showCards = var_8_0.show_card
	self.runningData = arg_8_1
	self.recycleFlag = false

	setActive(self.btnRecycle, true)
	setActive(self.btnMask, false)
	setActive(self.goodsAdd, false)
	self:resetChaCard()
	self:createCharCard()
	self:update()

	return
end

function BeachGuardGameUI:update()
	for iter_9_0 = 1, #self.cards do
		local var_9_0 = GetComponent(self.cards[iter_9_0].tf, typeof(CanvasGroup))

		if self.runningData.goodsNum < self.cards[iter_9_0].config.cost then
			var_9_0.blocksRaycasts = false
			var_9_0.interactable = false

			setActive(findTF(self.cards[iter_9_0].tf, "mask"), true)
		elseif self.cards[iter_9_0].config.once and table.contains(self.runningData.sceneChars, self.cards[iter_9_0].config.char_id) then
			var_9_0.blocksRaycasts = false
			var_9_0.interactable = false

			setActive(findTF(self.cards[iter_9_0].tf, "mask"), true)
		else
			var_9_0.blocksRaycasts = true
			var_9_0.interactable = true

			setActive(findTF(self.cards[iter_9_0].tf, "mask"), false)
		end
	end

	setText(self.scoreTf, self.runningData.scoreNum)
	setText(self.gameTimeS, math.ceil(self.runningData.gameTime))

	if self.enemyTime and self.enemyTime > 0 then
		setSlider(self.enemyProgress, 0, 1, (self.enemyTime - self.runningData.gameStepTime) / self.enemyTime)
	end

	setText(self.goodsNum, self.runningData.goodsNum)

	return
end

function BeachGuardGameUI:updateGoods(arg_10_1, arg_10_2)
	if arg_10_1 and arg_10_1 > 0 then
		setActive(self.goodsAdd, false)
		setText(findTF(self.goodsAdd, "text"), "+" .. tostring(arg_10_1))
		setActive(self.goodsAdd, true)
	end

	return
end

function BeachGuardGameUI:createCharCard()
	for iter_11_0 = 1, #self.showCards do
		local var_11_1 = BeachGuardConst.char_card[self.showCards[iter_11_0]]
		local var_11_2 = self:getCardFromPool(BeachGuardConst.char_card[self.showCards[iter_11_0]].id)
		local var_11_3

		if not var_11_2 then
			var_11_3 = tf(instantiate(self.cardTpl))

			SetParent(var_11_3, self.charContent)

			var_11_2 = {
				tf = var_11_3,
				config = var_11_1
			}
		else
			var_11_3 = var_11_2.tf
		end

		table.insert(self.cards, var_11_2)
		setActive(var_11_3, true)

		local var_11_4 = GetComponent(findTF(var_11_3, "icon"), typeof(Image))

		var_11_4.sprite = BeachGuardAsset.getCardQIcon(var_11_1.icon)

		var_11_4:SetNativeSize()

		local var_11_5 = GetOrAddComponent(var_11_3, typeof(EventTriggerListener))

		ClearEventTrigger(var_11_5)
		var_11_5:AddBeginDragFunc(function(arg_12_0, arg_12_1)
			if self.recycleFlag then
				return
			end

			setActive(self.dragChar, true)

			local var_12_0 = GetComponent(findTF(self.dragChar, "icon"), typeof(Image))

			var_12_0.sprite = BeachGuardAsset.getCardIcon(var_11_1.icon)

			var_12_0:SetNativeSize()

			self.dragData = {
				flag = true,
				config = var_11_1
			}

			self._event:emit(BeachGuardGameView.DRAG_CHAR, self.dragData)

			return
		end)
		var_11_5:AddDragFunc(function(arg_13_0, arg_13_1)
			if self.recycleFlag then
				return
			end

			local var_13_0 = arg_13_1.position

			var_13_0.y = arg_13_1.position.y

			local var_13_1 = self._uiCamera:ScreenToWorldPoint(var_13_0)

			self.dragChar.anchoredPosition = self.bottom:InverseTransformPoint(var_13_1)
			self.dragData.pos = self.dragData.pos or Vector3(0, 0)
			self.dragData.pos.x = var_13_1.x
			self.dragData.pos.y = var_13_1.y
			self.dragData.pos.z = var_13_1.z

			return
		end)
		var_11_5:AddDragEndFunc(function(arg_14_0, arg_14_1)
			if self.recycleFlag then
				return
			end

			setActive(self.dragChar, false)

			self.dragData.flag = false
			self.dragData.pos = nil

			self._event:emit(BeachGuardGameView.DRAG_CHAR, self.dragData)

			return
		end)
		setText(findTF(var_11_3, "cost"), tostring(var_11_1.cost))
	end

	return
end

function BeachGuardGameUI:getCardFromPool(arg_15_1)
	for iter_15_0 = #self.cardPool, 1, -1 do
		if self.cardPool[iter_15_0].config.id == arg_15_1 then
			return table.remove(self.cardPool, iter_15_0)
		end
	end

	return nil
end

function BeachGuardGameUI:resetChaCard()
	for iter_16_0 = 1, #self.cards do
		setActive(findTF(self.cards[iter_16_0].tf, "mask"), false)

		GetComponent(findTF(self.cards[iter_16_0].tf, "icon"), typeof(Image)).sprite = nil

		setText(findTF(self.cards[iter_16_0].tf, "cost"), "0")
		setActive(self.cards[iter_16_0].tf, false)
		ClearEventTrigger((GetOrAddComponent(self.cards[iter_16_0].tf, typeof(EventTriggerListener))))
	end

	for iter_16_1 = #self.cards, 1, -1 do
		table.insert(self.cardPool, (table.remove(self.cards, iter_16_1)))
	end

	return
end

function BeachGuardGameUI:setEnemyComming()
	setActive(self.enemyComming, false)
	setActive(self.enemyComming, true)

	return
end

function BeachGuardGameUI:setDragCallback(arg_18_1)
	return
end

return BeachGuardGameUI
