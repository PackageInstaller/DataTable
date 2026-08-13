class = var_0_10000

local var_0_0 = var_0_10000("PipeRectControll")
local var_0_1
local var_0_2 = 140
local var_0_3 = 4

Vector2 = var_0_10004

local var_0_4 = var_0_10004(0, 90)

local function var_0_5(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._rectItem = arg_1_0
			arg_2_0._dragContent = arg_1_1
			findTF = var_1
			arg_2_0._rectImg = var_1(arg_2_0._rectItem, "img")
			findTF = var_1
			arg_2_0._rectSelect = var_1(arg_2_0._rectItem, "select")
			arg_2_0._rectParent = arg_2_0._rectItem.parent
			arg_2_0._eventCallback = arg_1_2
			GetOrAddComponent = var_1

			local var_2_0 = arg_2_0._rectItem

			typeof = var_3
			EventTriggerListener = var_2_10004
			arg_2_0._eventTrigger = var_1(var_2_0, var_3(var_2_10004))
			GameObject = var_1

			local var_2_1 = var_1.Find("UICamera")
			local var_2_2 = var_1.GetComponent

			typeof = var_3
			Camera = var_2_10004
			arg_2_0._uiCamera = var_2_2(var_2_1, var_3(var_2_10004))
			Vector2 = var_1
			arg_2_0._dragPos = var_1(0, 0)
			arg_2_0._draging = false

			local var_2_3 = arg_2_0._eventTrigger

			var_1.AddBeginDragFunc(var_2_3, function(arg_3_0, arg_3_1, arg_3_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 then
					local var_3_0 = arg_2_0

					if not var_3.isTweening(var_3_0) then
						local var_3_1 = arg_2_0
						local var_3_2 = arg_2_0

						var_3_1._screenScaleRate = var_4.getScreentScaleRate(var_3_2)
						arg_2_0._draging = true
						var_0_1.draging = true
						var_0_1.dragItem = arg_2_0._itemData
						var_0_1.dragScreenPos = arg_3_1.position
						arg_2_0._startDragPos = arg_3_1.position
						arg_2_0._startTfPos = arg_2_0._rectImg.anchoredPosition

						local var_3_3 = arg_2_0._uiCamera
						local var_3_4 = var_3.ScreenToWorldPoint(var_3_3, arg_3_1.position)
						local var_3_5 = arg_2_0._rectImg

						var_4.x = var_4.InverseTransformPoint(var_3_5, var_3_4).x - var_0_2 / 2
						var_4.y = var_4.y + var_0_4.y

						local var_3_6 = arg_2_0

						var_3_6._startOffsetPos = var_4
						setParent = var_3_6

						var_3_6(arg_2_0._rectImg, arg_2_0._dragContent, false)
					end
				end

				return
			end)

			local var_2_4 = arg_2_0._eventTrigger

			var_1.AddDragFunc(var_2_4, function(arg_4_0, arg_4_1, arg_4_2)
				if not arg_2_0._draging then
					return
				end

				if var_0_1.startSettlement then
					var_3_10004 = arg_2_0

					var_3.stopDrag(var_3_10004)

					return
				end

				local var_4_0 = var_0_1

				Vector2 = var_3_10004
				var_4_0.dragScreenPos = var_3_10004(arg_4_1.position.x, arg_4_1.position.y + var_0_4.y)
				arg_2_0._dragPos.x = arg_2_0._startOffsetPos.x + (arg_4_1.position.x - arg_2_0._startDragPos.x) * arg_2_0._screenScaleRate.x
				arg_2_0._dragPos.y = arg_2_0._startOffsetPos.y + (arg_4_1.position.y - arg_2_0._startDragPos.y) * arg_2_0._screenScaleRate.y
				arg_2_0._rectImg.anchoredPosition = arg_2_0._dragPos

				return
			end)

			local var_2_5 = arg_2_0._eventTrigger

			var_1.AddDragEndFunc(var_2_5, function(arg_5_0, arg_5_1, arg_5_2)
				if var_0_1.startSettlement then
					return
				end

				if arg_2_0._index == 1 then
					local var_5_0 = arg_2_0

					var_3.stopDrag(var_5_0)
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

				local var_6_0 = var_0_1

				var_6_0.dragScreenPos = nil
				SetParent = var_6_0

				var_6_0(arg_6_0._rectImg, arg_6_0._rectItem, false)

				if arg_6_0._startTfPos then
					local var_6_1 = arg_6_0._rectImg

					Vector2 = var_2
					var_6_1.anchoredPosition = var_2(0, 0)
				end
			end

			return
		end,
		getScreentScaleRate = function(arg_7_0)
			UnityEngine = var_2_10001

			local var_7_0 = var_2_10001.Screen.width

			UnityEngine = var_2_10002

			local var_7_1 = var_2_10002.Screen.height

			tf = var_2_10003
			GameObject = var_2_10004

			local var_7_2 = var_2_10003(var_2_10004.Find("UICamera/Canvas")).sizeDelta.x
			local var_7_3 = var_3.sizeDelta.y

			Vector2 = var_2_10006

			return var_2_10006(var_7_2 / var_7_0, var_7_3 / var_7_1)
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
			LeanTween = var_2_10001

			local var_9_0 = var_2_10001.isTweening

			go = var_2_10002

			return var_9_0(var_2_10002(arg_9_0._rectItem))
		end,
		getItem = function(arg_10_0)
			return arg_10_0._itemData
		end,
		setActive = function(arg_11_0, arg_11_1)
			setActive = var_2_10002

			var_2_10002(arg_11_0._rectItem, arg_11_1)

			return
		end,
		setIndex = function(arg_12_0, arg_12_1, arg_12_2)
			if not arg_12_2 then
				arg_12_0:setPostionByIndex(arg_12_1)
			else
				arg_12_0:fadeTo(arg_12_1)
			end

			arg_12_0._index = arg_12_1
			setActive = var_2_10003

			var_2_10003(arg_12_0._rectSelect, arg_12_1 == 1)

			return
		end,
		setImg = function(arg_13_0, arg_13_1)
			setImageSprite = var_2_10002

			var_2_10002(arg_13_0._rectImg, var_0_1.GetSprite(arg_13_1))

			return
		end,
		fadeTo = function(arg_14_0, arg_14_1)
			arg_14_0:clearTween()

			local var_14_0 = arg_14_0._rectItem.anchoredPosition.x
			local var_14_1 = arg_14_0
			local var_14_2 = arg_14_0.getIndexPosition(var_14_1, arg_14_1).x

			Vector2 = var_14_1

			local var_14_3 = var_14_1(0, arg_14_0._rectItem.anchoredPosition.y)

			LeanTween = var_5

			local var_14_4 = var_5.value

			go = var_6

			local var_14_5 = var_14_4(var_6(arg_14_0._rectItem), var_14_0, var_14_2, 0.1)
			local var_14_6 = var_5.setOnUpdate

			System = var_7

			local var_14_7 = var_14_6(var_14_5, var_7.Action_float(function(arg_15_0)
				var_14_3.x = arg_15_0
				arg_14_0._rectItem.anchoredPosition = var_14_3

				return
			end))
			local var_14_8 = var_5.setOnComplete

			System = var_7

			var_14_8(var_14_7, var_7.Action(function()
				return
			end))

			return
		end,
		getIndexPosition = function(arg_17_0, arg_17_1)
			Vector2 = var_2_10002

			return var_2_10002(-(arg_17_1 - 1) * var_0_2, 0)
		end,
		setPostionByIndex = function(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_0:getIndexPosition(arg_18_1)

			arg_18_0._rectItem.anchoredPosition = var_18_0

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
			LeanTween = var_2_10001

			local var_22_0 = var_2_10001.isTweening

			go = var_2_10002

			if var_22_0(var_2_10002(arg_22_0._rectItem)) then
				LeanTween = var_1

				local var_22_1 = var_1.cancel

				go = var_2

				var_22_1(var_2(arg_22_0._rectItem))
			end

			return
		end,
		setVisible = function(arg_23_0, arg_23_1)
			setActive = var_2_10002

			var_2_10002(arg_23_0._rectItem, arg_23_1)

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
			ClearEventTrigger = var_2_10001

			var_2_10001(arg_25_0._eventTrigger)

			return
		end
	}

	var_3.ctor(var_1_0)

	return var_3
end

function var_0_0.Ctor(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	PipeGameVo = var_1_10004
	var_0_1 = var_1_10004
	arg_26_0._rectTf = arg_26_1
	arg_26_0._dragPos = arg_26_2
	findTF = var_1_10004
	arg_26_0._content = var_1_10004(arg_26_0._rectTf, "pos")
	arg_26_0._event = arg_26_3
	arg_26_0.rectItems = {}

	local function var_26_0()
		local var_27_0 = arg_26_0

		var_0.onRectEventCall(var_27_0)

		return
	end

	for iter_26_0 = 1, var_0_3 do
		PipeGameVo = var_1_10009
		var_1_10009 = var_1_10009.GetTplItemFromPool
		PipeGameConst = var_1_10010
		var_1_10009 = var_1_10009(var_1_10010.tpl_rect_item, arg_26_0._content)
		var_1_10010 = var_0_5(var_1_10009, arg_26_0._dragPos, var_26_0)
		table = var_11

		var_11.insert(arg_26_0.rectItems, var_1_10010)
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
		local var_31_0 = arg_31_0.rectItems[iter_31_0]

		var_5.clear(var_31_0)
	end

	arg_31_0._draging = false

	return
end

function var_0_0.fillRectItem(arg_32_0)
	if #arg_32_0.rectDatas >= 0 then
		for iter_32_0 = 1, #arg_32_0.rectItems do
			local var_32_0 = arg_32_0.rectItems[iter_32_0]

			var_5.setIndex(var_32_0, iter_32_0)

			if var_5:getItem() == nil then
				table = var_6

				local var_32_1 = var_6.remove(arg_32_0.rectDatas, 1)
				local var_32_2 = var_5
				local var_32_3 = var_5.setItem

				PipeGameConst = var_1_10009

				var_32_3(var_32_2, var_1_10009.map_item_data[var_32_1])
			end
		end
	end

	return
end

function var_0_0.onRectEventCall(arg_33_0, arg_33_1, arg_33_2)
	return
end

function var_0_0.stopTopDrag(arg_34_0)
	local var_34_0 = arg_34_0.rectItems[1]

	var_1.stopDrag(var_34_0)

	return
end

function var_0_0.getTopData(arg_35_0)
	local var_35_0 = arg_35_0.rectItems[1]

	return var_1.getItem(var_35_0)
end

function var_0_0.removeTopRectData(arg_36_0)
	table = var_1_10001

	local var_36_0 = var_1_10001.remove(arg_36_0.rectItems, 1)

	table = var_2

	var_2.insert(arg_36_0.rectItems, var_36_0)
	var_36_0:setPostionByIndex(var_0_3 + 1, false)

	table = var_2

	local var_36_1 = var_2.remove(arg_36_0.rectDatas, 1)
	local var_36_2 = var_36_0
	local var_36_3 = var_36_0.setItem

	PipeGameConst = var_5

	var_36_3(var_36_2, var_5.map_item_data[var_36_1])

	for iter_36_0 = 1, #arg_36_0.rectItems do
		local var_36_4 = arg_36_0.rectItems[iter_36_0]

		var_7.setIndex(var_36_4, iter_36_0, true)
	end

	return
end

function var_0_0.getRandomRectDatas(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = var_0_1.GetRoundData().id
	local var_37_2

	PipeGameConst = var_1_10004

	local var_37_3 = var_1_10004.map_rect_data[var_37_1].list

	PipeGameConst = var_1_10005

	local var_37_4 = var_1_10005.map_rect_list

	math = var_1_10006

	local var_37_5 = var_37_4[var_37_3[var_1_10006.random(1, #var_37_3)]]

	ipairs = var_37_4

	for iter_37_0, iter_37_1 in var_37_4(var_37_5) do
		local var_37_6 = iter_37_1[1]
		local var_37_7 = iter_37_1[2]

		for iter_37_2 = 1, var_37_7 do
			table = var_1_10016

			var_1_10016.insert(var_37_0, var_37_6)
		end
	end

	return arg_37_0:shuffleArray(var_37_0)
end

function var_0_0.shuffleArray(arg_38_0, arg_38_1)
	for iter_38_0 = #arg_38_1, 2, -1 do
		math = var_1_10006
		arg_38_1[iter_38_0], arg_38_1[var_1_10006] = arg_38_1[var_1_10006.random(iter_38_0)], arg_38_1[iter_38_0]
	end

	return arg_38_1
end

function var_0_0.dispose(arg_39_0)
	for iter_39_0 = 1, #arg_39_0.rectItems do
		local var_39_0 = arg_39_0.rectItems[iter_39_0]

		var_5.dispose(var_39_0)
	end

	return
end

return var_0_0
