class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardGameUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_3
	arg_1_0._gameData = arg_1_2
	findTF = var_1_10004
	arg_1_0.gameUI = var_1_10004(arg_1_0._tf, "ui/gameUI")
	arg_1_0.asset = arg_1_0._gameData.asset
	GameObject = var_4

	local var_1_0 = var_4.Find("UICamera")
	local var_1_1 = var_4.GetComponent

	typeof = var_7
	Camera = var_1_10009
	arg_1_0._uiCamera = var_1_1(var_1_0, var_7(var_1_10009))
	onButton = var_4

	local var_1_2 = arg_1_0._event

	findTF = var_7

	var_4(var_1_2, var_7(arg_1_0.gameUI, "ad/topRight/btnStop"), function()
		local var_2_0 = arg_1_0._event
		local var_2_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_2_1(var_2_0, var_2_10003.OPEN_PAUSE_UI)

		local var_2_2 = arg_1_0._event
		local var_2_3 = var_0.emit

		BeachGuardGameView = var_3

		var_2_3(var_2_2, var_3.PAUSE_GAME, true)

		return
	end)

	onButton = var_4

	local var_1_3 = arg_1_0._event

	findTF = var_7

	var_4(var_1_3, var_7(arg_1_0.gameUI, "ad/btnLeave"), function()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		BeachGuardGameView = var_2_10003

		var_3_1(var_3_0, var_2_10003.OPEN_LEVEL_UI)

		local var_3_2 = arg_1_0._event
		local var_3_3 = var_0.emit

		BeachGuardGameView = var_3

		var_3_3(var_3_2, var_3.PAUSE_GAME, true)

		return
	end)

	findTF = var_4
	arg_1_0.gameTimeS = var_4(arg_1_0.gameUI, "ad/top/time/s")
	findTF = var_4
	arg_1_0.scoreTf = var_4(arg_1_0.gameUI, "ad/top/score")
	findTF = var_4
	arg_1_0.bottom = var_4(arg_1_0.gameUI, "bottom")
	findTF = var_4
	arg_1_0.goods = var_4(arg_1_0.gameUI, "bottom/goods")
	findTF = var_4
	arg_1_0.goodsNum = var_4(arg_1_0.gameUI, "bottom/goods/num")
	findTF = var_4
	arg_1_0.goodsAdd = var_4(arg_1_0.gameUI, "bottom/goods/add")
	findTF = var_4
	arg_1_0.charContent = var_4(arg_1_0.gameUI, "bottom/charContainer/content")
	findTF = var_4
	arg_1_0.cardTpl = var_4(arg_1_0.gameUI, "bottom/cardTpl")
	findTF = var_4
	arg_1_0.dragChar = var_4(arg_1_0.gameUI, "bottom/dragChar")
	setActive = var_4

	var_4(arg_1_0.dragChar, false)

	arg_1_0.cards = {}
	arg_1_0.cardPool = {}
	arg_1_0.dragData = {}
	arg_1_0.recycleFlag = false
	findTF = var_4
	arg_1_0.btnRecycle = var_4(arg_1_0.gameUI, "bottom/recycles")
	onButton = var_4

	var_4(arg_1_0._event, arg_1_0.btnRecycle, function()
		local var_4_0 = arg_1_0

		var_4_0.recycleFlag = true
		setActive = var_4_0

		var_4_0(arg_1_0.btnRecycle, false)

		setActive = var_4_0

		var_4_0(arg_1_0.btnMask, true)

		local var_4_1 = arg_1_0._event
		local var_4_2 = var_0.emit

		BeachGuardGameView = var_3

		var_4_2(var_4_1, var_3.RECYCLES_CHAR, true)

		return
	end)

	findTF = var_4
	arg_1_0.enemyComming = var_4(arg_1_0.gameUI, "enemyComming")
	findTF = var_4
	arg_1_0.btnMask = var_4(arg_1_0.gameUI, "bottom/recycleMask")
	onButton = var_4

	var_4(arg_1_0._event, arg_1_0.btnMask, function()
		local var_5_0 = arg_1_0

		var_0.cancelRecycle(var_5_0)

		return
	end)

	findTF = var_4
	arg_1_0.enemyProgress = var_4(arg_1_0.gameUI, "ad/enemyProgress")
	findTF = var_4
	arg_1_0.bossRate = var_4(arg_1_0.gameUI, "ad/bossRate")

	return
end

function var_0_0.cancelRecycle(arg_6_0)
	arg_6_0.recycleFlag = false
	setActive = var_1

	var_1(arg_6_0.btnRecycle, true)

	setActive = var_1

	var_1(arg_6_0.btnMask, false)

	local var_6_0 = arg_6_0._event
	local var_6_1 = var_1.emit

	BeachGuardGameView = var_4

	var_6_1(var_6_0, var_4.RECYCLES_CHAR, false)

	return
end

function var_0_0.show(arg_7_0, arg_7_1)
	arg_7_0.recycleFlag = false
	setActive = var_2

	var_2(arg_7_0.btnRecycle, true)

	setActive = var_2

	var_2(arg_7_0.btnMask, false)

	setActive = var_2

	var_2(arg_7_0.gameUI, arg_7_1)

	return
end

function var_0_0.firstUpdate(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.chapter

	BeachGuardConst = var_1_10003

	local var_8_1 = var_1_10003.chapter_data[var_8_0]

	BeachGuardConst = var_1_10004
	arg_8_0.enemyTime = var_1_10004.chapater_enemy[var_8_0].time

	if not arg_8_0.enemyTime or arg_8_0.enemyTime == 0 then
		setActive = var_4

		var_4(arg_8_0.enemyProgress, false)

		setActive = var_4

		var_4(arg_8_0.bossRate, false)
	else
		setActive = var_4

		var_4(arg_8_0.enemyProgress, true)

		setActive = var_4

		var_4(arg_8_0.bossRate, true)
	end

	BeachGuardConst = var_4
	arg_8_0.bossRateNum = var_4.chapater_enemy[var_8_0].boss_rate

	if not arg_8_0.bossRateNum or arg_8_0.bossRateNum == 0 then
		setActive = var_4

		var_4(arg_8_0.bossRate, false)
	else
		setActive = var_4

		var_4(arg_8_0.bossRate, true)

		setSlider = var_4

		var_4(arg_8_0.bossRate, 0, 1, arg_8_0.bossRateNum)
	end

	setActive = var_4

	var_4(arg_8_0.enemyComming, false)

	arg_8_0.showCards = var_8_1.show_card
	arg_8_0.runningData = arg_8_1
	arg_8_0.recycleFlag = false
	setActive = var_4

	var_4(arg_8_0.btnRecycle, true)

	setActive = var_4

	var_4(arg_8_0.btnMask, false)

	setActive = var_4

	var_4(arg_8_0.goodsAdd, false)
	arg_8_0:resetChaCard()
	arg_8_0:createCharCard()
	arg_8_0:update()

	return
end

function var_0_0.update(arg_9_0)
	local var_9_0 = arg_9_0.runningData.goodsNum
	local var_9_1 = arg_9_0.runningData.sceneChars

	for iter_9_0 = 1, #arg_9_0.cards do
		local var_9_2 = arg_9_0.cards[iter_9_0].config
		local var_9_3 = arg_9_0.cards[iter_9_0].tf
		local var_9_4 = var_9_2.cost
		local var_9_5 = var_9_2.once
		local var_9_6 = var_9_2.char_id

		GetComponent = var_1_10012

		local var_9_7 = var_9_3

		typeof = var_1_10015
		CanvasGroup = var_1_10017
		var_1_10012 = var_1_10012(var_9_7, var_1_10015(var_1_10017))

		if var_9_0 < var_9_4 then
			var_1_10012.blocksRaycasts = false
			var_1_10012.interactable = false
			setActive = var_1_10013
			findTF = var_1_10015

			var_1_10013(var_1_10015(var_9_3, "mask"), true)
		else
			if var_9_5 then
				table = var_1_10013

				if var_1_10013.contains(var_9_1, var_9_6) then
					var_1_10012.blocksRaycasts = false
					var_1_10012.interactable = false
					setActive = var_1_10013
					findTF = var_1_10015

					var_1_10013(var_1_10015(var_9_3, "mask"), true)

					goto label_9_0
				end
			end

			var_1_10012.blocksRaycasts = true
			var_1_10012.interactable = true
			setActive = var_1_10013
			findTF = var_1_10015

			var_1_10013(var_1_10015(var_9_3, "mask"), false)
		end

		::label_9_0::
	end

	setText = var_3

	var_3(arg_9_0.scoreTf, arg_9_0.runningData.scoreNum)

	setText = var_3

	local var_9_8 = arg_9_0.gameTimeS

	math = var_6

	var_3(var_9_8, var_6.ceil(arg_9_0.runningData.gameTime))

	local var_9_9

	if arg_9_0.enemyTime and arg_9_0.enemyTime > 0 then
		var_9_9 = (arg_9_0.enemyTime - arg_9_0.runningData.gameStepTime) / arg_9_0.enemyTime
		setSlider = var_4

		var_4(arg_9_0.enemyProgress, 0, 1, var_9_9)
	end

	setText = var_9_9

	var_9_9(arg_9_0.goodsNum, var_9_0)

	return
end

function var_0_0.updateGoods(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 and 0 < arg_10_1 then
		setActive = var_3

		var_3(arg_10_0.goodsAdd, false)

		setText = var_3
		findTF = var_5

		local var_10_0 = var_5(arg_10_0.goodsAdd, "text")
		local var_10_1 = "+"

		tostring = var_7

		var_3(var_10_0, var_10_1 .. var_7(arg_10_1))

		setActive = var_3

		var_3(arg_10_0.goodsAdd, true)
	end

	return
end

function var_0_0.createCharCard(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.showCards do
		local var_11_0 = iter_11_0

		BeachGuardConst = var_1_10006
		var_1_10006 = var_1_10006.char_card[arg_11_0.showCards[iter_11_0]]

		local var_11_1 = arg_11_0
		local var_11_2 = arg_11_0.getCardFromPool(var_11_1, var_1_10006.id)
		local var_11_3

		if not var_11_2 then
			tf = var_11_1
			instantiate = var_1_10011
			var_11_3 = var_11_1(var_1_10011(arg_11_0.cardTpl))
			SetParent = var_11_1

			var_11_1(var_11_3, arg_11_0.charContent)

			var_11_2 = {
				tf = var_11_3,
				config = var_1_10006
			}
		else
			var_11_3 = var_11_2.tf
		end

		table = var_11_1

		var_11_1.insert(arg_11_0.cards, var_11_2)

		setActive = var_9

		var_9(var_11_3, true)

		GetComponent = var_9
		findTF = var_1_10011
		var_1_10011 = var_1_10011(var_11_3, "icon")
		typeof = var_12
		Image = var_14

		local var_11_4 = var_9(var_1_10011, var_12(var_14))

		BeachGuardAsset = var_10
		var_11_4.sprite = var_10.getCardQIcon(var_1_10006.icon)

		var_11_4:SetNativeSize()

		GetOrAddComponent = var_10

		local var_11_5 = var_11_3

		typeof = var_13
		EventTriggerListener = var_1_10015

		local var_11_6 = var_10(var_11_5, var_13(var_1_10015))

		ClearEventTrigger = var_1_10011

		var_1_10011(var_11_6)
		var_11_6:AddBeginDragFunc(function(arg_12_0, arg_12_1)
			if arg_11_0.recycleFlag then
				return
			end

			setActive = var_2

			var_2(arg_11_0.dragChar, true)

			GetComponent = var_2
			findTF = var_4

			local var_12_0 = var_4(arg_11_0.dragChar, "icon")

			typeof = var_5
			Image = var_7

			local var_12_1 = var_2(var_12_0, var_5(var_7))

			BeachGuardAsset = var_2_10003
			var_12_1.sprite = var_2_10003.getCardIcon(var_1_10006.icon)

			var_12_1:SetNativeSize()

			arg_11_0.dragData = {
				flag = true,
				config = var_1_10006
			}

			local var_12_2 = arg_11_0._event
			local var_12_3 = var_3.emit

			BeachGuardGameView = var_6

			var_12_3(var_12_2, var_6.DRAG_CHAR, arg_11_0.dragData)

			return
		end)
		var_11_6:AddDragFunc(function(arg_13_0, arg_13_1)
			if arg_11_0.recycleFlag then
				return
			end

			var_2.y = arg_13_1.position.y

			local var_13_0 = arg_11_0._uiCamera
			local var_13_1 = var_3.ScreenToWorldPoint(var_13_0, var_2)
			local var_13_2 = arg_11_0.dragChar
			local var_13_3 = arg_11_0.bottom

			var_13_2.anchoredPosition = var_5.InverseTransformPoint(var_13_3, var_13_1)

			if not arg_11_0.dragData.pos then
				local var_13_4 = arg_11_0.dragData

				Vector3 = var_5
				var_13_4.pos = var_5(0, 0)
			end

			arg_11_0.dragData.pos.x = var_13_1.x
			arg_11_0.dragData.pos.y = var_13_1.y
			arg_11_0.dragData.pos.z = var_13_1.z

			return
		end)

		local var_11_7 = var_11_6

		var_11_6.AddDragEndFunc(var_11_7, function(arg_14_0, arg_14_1)
			if arg_11_0.recycleFlag then
				return
			end

			setActive = var_2

			var_2(arg_11_0.dragChar, false)

			arg_11_0.dragData.flag = false
			arg_11_0.dragData.pos = nil

			local var_14_0 = arg_11_0._event
			local var_14_1 = var_2.emit

			BeachGuardGameView = var_5

			var_14_1(var_14_0, var_5.DRAG_CHAR, arg_11_0.dragData)

			return
		end)

		setText = var_1_10011
		findTF = var_11_7

		local var_11_8 = var_11_7(var_11_3, "cost")

		tostring = var_14

		var_1_10011(var_11_8, var_14(var_1_10006.cost))
	end

	return
end

function var_0_0.getCardFromPool(arg_15_0, arg_15_1)
	for iter_15_0 = #arg_15_0.cardPool, 1, -1 do
		if arg_15_0.cardPool[iter_15_0].config.id == arg_15_1 then
			table = var_6

			return var_6.remove(arg_15_0.cardPool, iter_15_0)
		end
	end

	return nil
end

function var_0_0.resetChaCard(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.cards do
		var_1_10005 = arg_16_0.cards[iter_16_0].tf
		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(var_1_10005, "mask"), false)

		GetComponent = var_1_10006
		findTF = var_1_10008
		var_1_10008 = var_1_10008(var_1_10005, "icon")
		typeof = var_9
		Image = var_11
		var_1_10006 = var_1_10006(var_1_10008, var_9(var_11))
		var_1_10006.sprite = nil
		setText = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(var_1_10005, "cost"), "0")

		setActive = var_1_10006

		var_1_10006(var_1_10005, false)

		GetOrAddComponent = var_1_10006
		var_1_10008 = var_1_10005
		typeof = var_9
		EventTriggerListener = var_11
		var_1_10006 = var_1_10006(var_1_10008, var_9(var_11))
		ClearEventTrigger = var_7

		var_7(var_1_10006)
	end

	for iter_16_1 = #arg_16_0.cards, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_16_0.cards, iter_16_1)
		table = var_1_10006

		var_1_10006.insert(arg_16_0.cardPool, var_1_10005)
	end

	return
end

function var_0_0.setEnemyComming(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.enemyComming, false)

	setActive = var_1_10001

	var_1_10001(arg_17_0.enemyComming, true)

	return
end

function var_0_0.setDragCallback(arg_18_0, arg_18_1)
	return
end

return var_0_0
