local var_0_0 = class("PipeRectControll")
local var_0_1
local var_0_2 = 140
local var_0_3 = 4
local var_0_4 = Vector2(0, 90)

local function var_0_5(arg_1_0, arg_1_1, arg_1_2)
	({
		ctor = function(arg_2_0)
			arg_2_0._rectItem = arg_1_0
			arg_2_0._dragContent = arg_1_1
			arg_2_0._rectImg = findTF(arg_2_0._rectItem, "img")
			arg_2_0._rectSelect = findTF(arg_2_0._rectItem, "select")
			arg_2_0._rectParent = arg_2_0._rectItem.parent
			arg_2_0._eventCallback = arg_1_2
			arg_2_0._eventTrigger = GetOrAddComponent(arg_2_0._rectItem, typeof(EventTriggerListener))
			arg_2_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
			arg_2_0._dragPos = Vector2(0, 0)
			arg_2_0._draging = false

			arg_2_0._eventTrigger:AddBeginDragFunc(function(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 and not arg_2_0:isTweening() then
					arg_2_0._screenScaleRate = arg_2_0:getScreentScaleRate()
					arg_2_0._draging = true
					var_0_1.draging = true
					var_0_1.dragItem = arg_2_0._itemData
					var_0_1.dragScreenPos = arg_3_1.position
					arg_2_0._startDragPos = arg_3_1.position
					arg_2_0._startTfPos = arg_2_0._rectImg.anchoredPosition

					local var_3_0 = arg_2_0._rectImg:InverseTransformPoint((arg_2_0._uiCamera:ScreenToWorldPoint(arg_3_1.position)))

					var_3_0.x = var_3_0.x - var_0_2 / 2
					var_3_0.y = var_3_0.y + var_0_4.y
					arg_2_0._startOffsetPos = var_3_0

					setParent(arg_2_0._rectImg, arg_2_0._dragContent, false)
				end

				return
			end)
			arg_2_0._eventTrigger:AddDragFunc(function(arg_4_0, arg_4_1, arg_4_2)
				if not arg_2_0._draging then
					return
				end

				if var_0_1.startSettlement then
					arg_2_0:stopDrag()

					return
				end

				var_0_1.dragScreenPos = Vector2(arg_4_1.position.x, arg_4_1.position.y + var_0_4.y)
				arg_2_0._dragPos.x = arg_2_0._startOffsetPos.x + (arg_4_1.position.x - arg_2_0._startDragPos.x) * arg_2_0._screenScaleRate.x
				arg_2_0._dragPos.y = arg_2_0._startOffsetPos.y + (arg_4_1.position.y - arg_2_0._startDragPos.y) * arg_2_0._screenScaleRate.y
				arg_2_0._rectImg.anchoredPosition = arg_2_0._dragPos

				return
			end)
			arg_2_0._eventTrigger:AddDragEndFunc(function(arg_5_0, arg_5_1, arg_5_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 then
					arg_2_0:stopDrag()
				end

				return
			end)
			arg_2_0:setActive(false)

			return
		end,
		stopDrag = function(arg_6_0)
			if arg_6_0._draging then
				arg_6_0._draging = false
				var_0_1.draging = false
				var_0_1.dragItem = nil
				var_0_1.dragScreenPos = nil

				SetParent(arg_6_0._rectImg, arg_6_0._rectItem, false)

				if arg_6_0._startTfPos then
					arg_6_0._rectImg.anchoredPosition = Vector2(0, 0)
				end
			end

			return
		end,
		getScreentScaleRate = function(arg_7_0)
			local var_7_0 = tf(GameObject.Find("UICamera/Canvas"))

			return Vector2(var_7_0.sizeDelta.x / UnityEngine.Screen.width, var_7_0.sizeDelta.y / UnityEngine.Screen.height)
		end,
		setItem = function(arg_8_0, arg_8_1)
			arg_8_0._itemData = arg_8_1

			if arg_8_0._itemData then
				arg_8_0:setImg(arg_8_0._itemData.img)
				arg_8_0:setActive(true)
			else
				arg_8_0:setActive(false)
			end

			return
		end,
		isTweening = function(arg_9_0)
			return LeanTween.isTweening(go(arg_9_0._rectItem))
		end,
		getItem = function(arg_10_0)
			return arg_10_0._itemData
		end,
		setActive = function(arg_11_0, arg_11_1)
			setActive(arg_11_0._rectItem, arg_11_1)

			return
		end,
		setIndex = function(arg_12_0, arg_12_1, arg_12_2)
			if not arg_12_2 then
				arg_12_0:setPostionByIndex(arg_12_1)
			else
				arg_12_0:fadeTo(arg_12_1)
			end

			arg_12_0._index = arg_12_1

			setActive(arg_12_0._rectSelect, arg_12_1 == 1)

			return
		end,
		setImg = function(arg_13_0, arg_13_1)
			setImageSprite(arg_13_0._rectImg, var_0_1.GetSprite(arg_13_1))

			return
		end,
		fadeTo = function(arg_14_0, arg_14_1)
			arg_14_0:clearTween()

			local var_14_0 = Vector2(0, arg_14_0._rectItem.anchoredPosition.y)

			LeanTween.value(go(arg_14_0._rectItem), arg_14_0._rectItem.anchoredPosition.x, arg_14_0:getIndexPosition(arg_14_1).x, 0.1):setOnUpdate(System.Action_float(function(arg_15_0)
				var_14_0.x = arg_15_0
				arg_14_0._rectItem.anchoredPosition = var_14_0

				return
			end)):setOnComplete(System.Action(function()
				return
			end))

			return
		end,
		getIndexPosition = function(arg_17_0, arg_17_1)
			return Vector2(-(arg_17_1 - 1) * var_0_2, 0)
		end,
		setPostionByIndex = function(arg_18_0, arg_18_1)
			arg_18_0._rectItem.anchoredPosition = arg_18_0:getIndexPosition(arg_18_1)

			return
		end,
		getIndex = function(arg_19_0)
			return arg_19_0._index
		end,
		isDraging = function(arg_20_0)
			return arg_20_0._draging
		end,
		getDragScreenPos = function(arg_21_0)
			return arg_21_0._dragScreenPos
		end,
		clearTween = function(arg_22_0)
			if LeanTween.isTweening(go(arg_22_0._rectItem)) then
				LeanTween.cancel(go(arg_22_0._rectItem))
			end

			return
		end,
		setVisible = function(arg_23_0, arg_23_1)
			setActive(arg_23_0._rectItem, arg_23_1)

			return
		end,
		clear = function(arg_24_0)
			arg_24_0._index = nil
			arg_24_0._itemData = nil

			arg_24_0:clearTween()
			arg_24_0:setVisible(false)

			return
		end,
		dispose = function(arg_25_0)
			ClearEventTrigger(arg_25_0._eventTrigger)

			return
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._rectItem = arg_1_0
			arg_2_0._dragContent = arg_1_1
			arg_2_0._rectImg = findTF(arg_2_0._rectItem, "img")
			arg_2_0._rectSelect = findTF(arg_2_0._rectItem, "select")
			arg_2_0._rectParent = arg_2_0._rectItem.parent
			arg_2_0._eventCallback = arg_1_2
			arg_2_0._eventTrigger = GetOrAddComponent(arg_2_0._rectItem, typeof(EventTriggerListener))
			arg_2_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
			arg_2_0._dragPos = Vector2(0, 0)
			arg_2_0._draging = false

			arg_2_0._eventTrigger:AddBeginDragFunc(function(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 and not arg_2_0:isTweening() then
					arg_2_0._screenScaleRate = arg_2_0:getScreentScaleRate()
					arg_2_0._draging = true
					var_0_1.draging = true
					var_0_1.dragItem = arg_2_0._itemData
					var_0_1.dragScreenPos = arg_3_1.position
					arg_2_0._startDragPos = arg_3_1.position
					arg_2_0._startTfPos = arg_2_0._rectImg.anchoredPosition

					local var_3_0 = arg_2_0._rectImg:InverseTransformPoint((arg_2_0._uiCamera:ScreenToWorldPoint(arg_3_1.position)))

					var_3_0.x = var_3_0.x - var_0_2 / 2
					var_3_0.y = var_3_0.y + var_0_4.y
					arg_2_0._startOffsetPos = var_3_0

					setParent(arg_2_0._rectImg, arg_2_0._dragContent, false)
				end

				return
			end)
			arg_2_0._eventTrigger:AddDragFunc(function(arg_4_0, arg_4_1, arg_4_2)
				if not arg_2_0._draging then
					return
				end

				if var_0_1.startSettlement then
					arg_2_0:stopDrag()

					return
				end

				var_0_1.dragScreenPos = Vector2(arg_4_1.position.x, arg_4_1.position.y + var_0_4.y)
				arg_2_0._dragPos.x = arg_2_0._startOffsetPos.x + (arg_4_1.position.x - arg_2_0._startDragPos.x) * arg_2_0._screenScaleRate.x
				arg_2_0._dragPos.y = arg_2_0._startOffsetPos.y + (arg_4_1.position.y - arg_2_0._startDragPos.y) * arg_2_0._screenScaleRate.y
				arg_2_0._rectImg.anchoredPosition = arg_2_0._dragPos

				return
			end)
			arg_2_0._eventTrigger:AddDragEndFunc(function(arg_5_0, arg_5_1, arg_5_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 then
					arg_2_0:stopDrag()
				end

				return
			end)
			arg_2_0:setActive(false)

			return
		end,
		stopDrag = function(arg_6_0)
			if arg_6_0._draging then
				arg_6_0._draging = false
				var_0_1.draging = false
				var_0_1.dragItem = nil
				var_0_1.dragScreenPos = nil

				SetParent(arg_6_0._rectImg, arg_6_0._rectItem, false)

				if arg_6_0._startTfPos then
					arg_6_0._rectImg.anchoredPosition = Vector2(0, 0)
				end
			end

			return
		end,
		getScreentScaleRate = function(arg_7_0)
			local var_7_0 = tf(GameObject.Find("UICamera/Canvas"))

			return Vector2(var_7_0.sizeDelta.x / UnityEngine.Screen.width, var_7_0.sizeDelta.y / UnityEngine.Screen.height)
		end,
		setItem = function(arg_8_0, arg_8_1)
			arg_8_0._itemData = arg_8_1

			if arg_8_0._itemData then
				arg_8_0:setImg(arg_8_0._itemData.img)
				arg_8_0:setActive(true)
			else
				arg_8_0:setActive(false)
			end

			return
		end,
		isTweening = function(arg_9_0)
			return LeanTween.isTweening(go(arg_9_0._rectItem))
		end,
		getItem = function(arg_10_0)
			return arg_10_0._itemData
		end,
		setActive = function(arg_11_0, arg_11_1)
			setActive(arg_11_0._rectItem, arg_11_1)

			return
		end,
		setIndex = function(arg_12_0, arg_12_1, arg_12_2)
			if not arg_12_2 then
				arg_12_0:setPostionByIndex(arg_12_1)
			else
				arg_12_0:fadeTo(arg_12_1)
			end

			arg_12_0._index = arg_12_1

			setActive(arg_12_0._rectSelect, arg_12_1 == 1)

			return
		end,
		setImg = function(arg_13_0, arg_13_1)
			setImageSprite(arg_13_0._rectImg, var_0_1.GetSprite(arg_13_1))

			return
		end,
		fadeTo = function(arg_14_0, arg_14_1)
			arg_14_0:clearTween()

			local var_14_0 = Vector2(0, arg_14_0._rectItem.anchoredPosition.y)

			LeanTween.value(go(arg_14_0._rectItem), arg_14_0._rectItem.anchoredPosition.x, arg_14_0:getIndexPosition(arg_14_1).x, 0.1):setOnUpdate(System.Action_float(function(arg_15_0)
				var_14_0.x = arg_15_0
				arg_14_0._rectItem.anchoredPosition = var_14_0

				return
			end)):setOnComplete(System.Action(function()
				return
			end))

			return
		end,
		getIndexPosition = function(arg_17_0, arg_17_1)
			return Vector2(-(arg_17_1 - 1) * var_0_2, 0)
		end,
		setPostionByIndex = function(arg_18_0, arg_18_1)
			arg_18_0._rectItem.anchoredPosition = arg_18_0:getIndexPosition(arg_18_1)

			return
		end,
		getIndex = function(arg_19_0)
			return arg_19_0._index
		end,
		isDraging = function(arg_20_0)
			return arg_20_0._draging
		end,
		getDragScreenPos = function(arg_21_0)
			return arg_21_0._dragScreenPos
		end,
		clearTween = function(arg_22_0)
			if LeanTween.isTweening(go(arg_22_0._rectItem)) then
				LeanTween.cancel(go(arg_22_0._rectItem))
			end

			return
		end,
		setVisible = function(arg_23_0, arg_23_1)
			setActive(arg_23_0._rectItem, arg_23_1)

			return
		end,
		clear = function(arg_24_0)
			arg_24_0._index = nil
			arg_24_0._itemData = nil

			arg_24_0:clearTween()
			arg_24_0:setVisible(false)

			return
		end,
		dispose = function(arg_25_0)
			ClearEventTrigger(arg_25_0._eventTrigger)

			return
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._rectItem = arg_1_0
			arg_2_0._dragContent = arg_1_1
			arg_2_0._rectImg = findTF(arg_2_0._rectItem, "img")
			arg_2_0._rectSelect = findTF(arg_2_0._rectItem, "select")
			arg_2_0._rectParent = arg_2_0._rectItem.parent
			arg_2_0._eventCallback = arg_1_2
			arg_2_0._eventTrigger = GetOrAddComponent(arg_2_0._rectItem, typeof(EventTriggerListener))
			arg_2_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
			arg_2_0._dragPos = Vector2(0, 0)
			arg_2_0._draging = false

			arg_2_0._eventTrigger:AddBeginDragFunc(function(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 and not arg_2_0:isTweening() then
					arg_2_0._screenScaleRate = arg_2_0:getScreentScaleRate()
					arg_2_0._draging = true
					var_0_1.draging = true
					var_0_1.dragItem = arg_2_0._itemData
					var_0_1.dragScreenPos = arg_3_1.position
					arg_2_0._startDragPos = arg_3_1.position
					arg_2_0._startTfPos = arg_2_0._rectImg.anchoredPosition

					local var_3_0 = arg_2_0._rectImg:InverseTransformPoint((arg_2_0._uiCamera:ScreenToWorldPoint(arg_3_1.position)))

					var_3_0.x = var_3_0.x - var_0_2 / 2
					var_3_0.y = var_3_0.y + var_0_4.y
					arg_2_0._startOffsetPos = var_3_0

					setParent(arg_2_0._rectImg, arg_2_0._dragContent, false)
				end

				return
			end)
			arg_2_0._eventTrigger:AddDragFunc(function(arg_4_0, arg_4_1, arg_4_2)
				if not arg_2_0._draging then
					return
				end

				if var_0_1.startSettlement then
					arg_2_0:stopDrag()

					return
				end

				var_0_1.dragScreenPos = Vector2(arg_4_1.position.x, arg_4_1.position.y + var_0_4.y)
				arg_2_0._dragPos.x = arg_2_0._startOffsetPos.x + (arg_4_1.position.x - arg_2_0._startDragPos.x) * arg_2_0._screenScaleRate.x
				arg_2_0._dragPos.y = arg_2_0._startOffsetPos.y + (arg_4_1.position.y - arg_2_0._startDragPos.y) * arg_2_0._screenScaleRate.y
				arg_2_0._rectImg.anchoredPosition = arg_2_0._dragPos

				return
			end)
			arg_2_0._eventTrigger:AddDragEndFunc(function(arg_5_0, arg_5_1, arg_5_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 then
					arg_2_0:stopDrag()
				end

				return
			end)
			arg_2_0:setActive(false)

			return
		end,
		stopDrag = function(arg_6_0)
			if arg_6_0._draging then
				arg_6_0._draging = false
				var_0_1.draging = false
				var_0_1.dragItem = nil
				var_0_1.dragScreenPos = nil

				SetParent(arg_6_0._rectImg, arg_6_0._rectItem, false)

				if arg_6_0._startTfPos then
					arg_6_0._rectImg.anchoredPosition = Vector2(0, 0)
				end
			end

			return
		end,
		getScreentScaleRate = function(arg_7_0)
			local var_7_0 = tf(GameObject.Find("UICamera/Canvas"))

			return Vector2(var_7_0.sizeDelta.x / UnityEngine.Screen.width, var_7_0.sizeDelta.y / UnityEngine.Screen.height)
		end,
		setItem = function(arg_8_0, arg_8_1)
			arg_8_0._itemData = arg_8_1

			if arg_8_0._itemData then
				arg_8_0:setImg(arg_8_0._itemData.img)
				arg_8_0:setActive(true)
			else
				arg_8_0:setActive(false)
			end

			return
		end,
		isTweening = function(arg_9_0)
			return LeanTween.isTweening(go(arg_9_0._rectItem))
		end,
		getItem = function(arg_10_0)
			return arg_10_0._itemData
		end,
		setActive = function(arg_11_0, arg_11_1)
			setActive(arg_11_0._rectItem, arg_11_1)

			return
		end,
		setIndex = function(arg_12_0, arg_12_1, arg_12_2)
			if not arg_12_2 then
				arg_12_0:setPostionByIndex(arg_12_1)
			else
				arg_12_0:fadeTo(arg_12_1)
			end

			arg_12_0._index = arg_12_1

			setActive(arg_12_0._rectSelect, arg_12_1 == 1)

			return
		end,
		setImg = function(arg_13_0, arg_13_1)
			setImageSprite(arg_13_0._rectImg, var_0_1.GetSprite(arg_13_1))

			return
		end,
		fadeTo = function(arg_14_0, arg_14_1)
			arg_14_0:clearTween()

			local var_14_0 = Vector2(0, arg_14_0._rectItem.anchoredPosition.y)

			LeanTween.value(go(arg_14_0._rectItem), arg_14_0._rectItem.anchoredPosition.x, arg_14_0:getIndexPosition(arg_14_1).x, 0.1):setOnUpdate(System.Action_float(function(arg_15_0)
				var_14_0.x = arg_15_0
				arg_14_0._rectItem.anchoredPosition = var_14_0

				return
			end)):setOnComplete(System.Action(function()
				return
			end))

			return
		end,
		getIndexPosition = function(arg_17_0, arg_17_1)
			return Vector2(-(arg_17_1 - 1) * var_0_2, 0)
		end,
		setPostionByIndex = function(arg_18_0, arg_18_1)
			arg_18_0._rectItem.anchoredPosition = arg_18_0:getIndexPosition(arg_18_1)

			return
		end,
		getIndex = function(arg_19_0)
			return arg_19_0._index
		end,
		isDraging = function(arg_20_0)
			return arg_20_0._draging
		end,
		getDragScreenPos = function(arg_21_0)
			return arg_21_0._dragScreenPos
		end,
		clearTween = function(arg_22_0)
			if LeanTween.isTweening(go(arg_22_0._rectItem)) then
				LeanTween.cancel(go(arg_22_0._rectItem))
			end

			return
		end,
		setVisible = function(arg_23_0, arg_23_1)
			setActive(arg_23_0._rectItem, arg_23_1)

			return
		end,
		clear = function(arg_24_0)
			arg_24_0._index = nil
			arg_24_0._itemData = nil

			arg_24_0:clearTween()
			arg_24_0:setVisible(false)

			return
		end,
		dispose = function(arg_25_0)
			ClearEventTrigger(arg_25_0._eventTrigger)

			return
		end
	}
end

function var_0_0.Ctor(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	var_0_1 = PipeGameVo
	arg_26_0._rectTf = arg_26_1
	arg_26_0._dragPos = arg_26_2
	arg_26_0._content = findTF(arg_26_0._rectTf, "pos")
	arg_26_0._event = arg_26_3
	arg_26_0.rectItems = {}

	for iter_26_0 = 1, var_0_3 do
		table.insert(arg_26_0.rectItems, (var_0_5(PipeGameVo.GetTplItemFromPool(PipeGameConst.tpl_rect_item, arg_26_0._content), arg_26_0._dragPos, function()
			arg_26_0:onRectEventCall()

			return
		end)))
	end

	return
end

function var_0_0.start(arg_28_0)
	arg_28_0.rectDatas = arg_28_0:getRandomRectDatas()

	arg_28_0:fillRectItem()

	return
end

function var_0_0.step(arg_29_0, arg_29_1)
	return
end

function var_0_0.stop(arg_30_0)
	return
end

function var_0_0.clear(arg_31_0)
	arg_31_0.rectDatas = {}

	for iter_31_0 = 1, #arg_31_0.rectItems do
		arg_31_0.rectItems[iter_31_0]:clear()
	end

	arg_31_0._draging = false

	return
end

function var_0_0.fillRectItem(arg_32_0)
	if #arg_32_0.rectDatas >= 0 then
		for iter_32_0 = 1, #arg_32_0.rectItems do
			arg_32_0.rectItems[iter_32_0]:setIndex(iter_32_0)

			if arg_32_0.rectItems[iter_32_0]:getItem() == nil then
				arg_32_0.rectItems[iter_32_0]:setItem(PipeGameConst.map_item_data[table.remove(arg_32_0.rectDatas, 1)])
			end
		end
	end

	return
end

function var_0_0.onRectEventCall(arg_33_0, arg_33_1, arg_33_2)
	return
end

function var_0_0.stopTopDrag(arg_34_0)
	arg_34_0.rectItems[1]:stopDrag()

	return
end

function var_0_0.getTopData(arg_35_0)
	return arg_35_0.rectItems[1]:getItem()
end

function var_0_0.removeTopRectData(arg_36_0)
	local var_36_0 = table.remove(arg_36_0.rectItems, 1)

	table.insert(arg_36_0.rectItems, var_36_0)
	var_36_0:setPostionByIndex(var_0_3 + 1, false)
	var_36_0:setItem(PipeGameConst.map_item_data[table.remove(arg_36_0.rectDatas, 1)])

	for iter_36_0 = 1, #arg_36_0.rectItems do
		arg_36_0.rectItems[iter_36_0]:setIndex(iter_36_0, true)
	end

	return
end

function var_0_0.getRandomRectDatas(arg_37_0)
	local var_37_1 = PipeGameConst.map_rect_data[var_0_1.GetRoundData().id].list

	for iter_37_0, iter_37_1 in ipairs(PipeGameConst.map_rect_list[var_37_1[math.random(1, #var_37_1)]]) do
		for iter_37_2 = 1, iter_37_1[2] do
			table.insert({}, iter_37_1[1])
		end
	end

	return arg_37_0:shuffleArray({})
end

function var_0_0.shuffleArray(arg_38_0, arg_38_1)
	for iter_38_0 = #arg_38_1, 2, -1 do
		local var_38_0 = math.random(iter_38_0)

		arg_38_1[iter_38_0], arg_38_1[var_38_0] = arg_38_1[var_38_0], arg_38_1[iter_38_0]
	end

	return arg_38_1
end

function var_0_0.dispose(arg_39_0)
	for iter_39_0 = 1, #arg_39_0.rectItems do
		arg_39_0.rectItems[iter_39_0]:dispose()
	end

	return
end

return var_0_0
