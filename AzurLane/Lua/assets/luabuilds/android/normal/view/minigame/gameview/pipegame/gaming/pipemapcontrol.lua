class = var_0_10000

local var_0_0 = var_0_10000("PipeMapControl")
local var_0_1
local var_0_2 = "left"
local var_0_3 = "right"
local var_0_4 = "top"
local var_0_5 = "bottom"
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 1
local var_0_11 = 2

var_0_0.CLICK_MAP_ITEM = "click map item"

local function var_0_12(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._itemTf = arg_1_0
			arg_2_0._index = arg_1_1
			GameObject = var_1

			local var_2_0 = var_1.Find("UICamera")
			local var_2_1 = var_1.GetComponent

			typeof = var_2_10003
			Camera = var_2_10004
			arg_2_0._uiCamera = var_2_1(var_2_0, var_2_10003(var_2_10004))
			GetComponent = var_1

			local var_2_2 = arg_2_0._itemTf

			typeof = var_3
			CanvasGroup = var_2_10004
			arg_2_0._canvasGroup = var_1(var_2_2, var_3(var_2_10004))
			findTF = var_1
			arg_2_0._animTf = var_1(arg_2_0._itemTf, "anim")
			findTF = var_1
			arg_2_0._imgTf = var_1(arg_2_0._animTf, "img")
			findTF = var_1
			arg_2_0._imgFullTf = var_1(arg_2_0._animTf, "imgFull")
			GetComponent = var_1
			findTF = var_2

			local var_2_3 = var_2(arg_2_0._itemTf, "anim")

			typeof = var_3
			Animator = var_4
			arg_2_0._animator = var_1(var_2_3, var_3(var_4))
			arg_2_0._eventCallback = arg_1_2
			arg_2_0._freeze = false
			GetComponent = var_1

			local var_2_4 = arg_2_0._animTf

			typeof = var_3
			DftAniEvent = var_4
			arg_2_0._dftEvent = var_1(var_2_4, var_3(var_4))
			findTF = var_1
			arg_2_0._clickTf = var_1(arg_2_0._animTf, "click")
			GetOrAddComponent = var_1

			local var_2_5 = arg_2_0._clickTf

			typeof = var_3
			EventTriggerListener = var_4
			arg_2_0._eventTriggerListener = var_1(var_2_5, var_3(var_4))

			local var_2_6 = arg_2_0._eventTriggerListener

			var_1.AddPointDownFunc(var_2_6, function()
				if not arg_2_0._data and arg_2_0._eventCallback then
					arg_2_0._eventCallback(var_0_0.CLICK_MAP_ITEM, arg_2_0)
				end

				return
			end)

			return
		end,
		setData = function(arg_4_0, arg_4_1)
			arg_4_0._data = arg_4_1

			if arg_4_0._data then
				arg_4_0._animationFlag = false

				arg_4_0:loadImg(arg_4_0._data.img, arg_4_0._data.img_full)
				arg_4_0:setItemVisible(true)
				arg_4_0:setAlpha(1)
			else
				arg_4_0:setItemVisible(false)
			end

			return
		end,
		getData = function(arg_5_0)
			return arg_5_0._data
		end,
		setTempData = function(arg_6_0, arg_6_1)
			if arg_6_0._data then
				warning = var_2

				var_2("已经存在格子数据，无需设置预览数据")

				return
			end

			arg_6_0._tempData = arg_6_1

			arg_6_0:loadImg(arg_6_0._tempData.img, arg_6_0._tempData.img_full)
			arg_6_0:setItemVisible(true)
			arg_6_0:setAlpha(0.5)

			return
		end,
		getTempData = function(arg_7_0)
			return arg_7_0._tempData
		end,
		loadImg = function(arg_8_0, arg_8_1, arg_8_2)
			setImageSprite = var_2_10003

			var_2_10003(arg_8_0._imgTf, var_0_1.GetSprite(arg_8_1))

			setImageSprite = var_2_10003

			var_2_10003(arg_8_0._imgFullTf, var_0_1.GetSprite(arg_8_2))

			return
		end,
		setItemVisible = function(arg_9_0, arg_9_1)
			setActive = var_2_10002

			var_2_10002(arg_9_0._imgTf, arg_9_1)

			setActive = var_2_10002

			var_2_10002(arg_9_0._imgFullTf, arg_9_1)

			return
		end,
		changeTempToReal = function(arg_10_0)
			if arg_10_0._tempData then
				arg_10_0:setData(arg_10_0._tempData)

				arg_10_0._tempData = nil
			end

			return
		end,
		setTriggerName = function(arg_11_0, arg_11_1)
			if arg_11_0._animationFlag then
				return
			end

			arg_11_0._animationFlag = true

			if arg_11_0.animTriggerName then
				local var_11_0 = arg_11_0._animator

				var_2.ResetTrigger(var_11_0, arg_11_0.animTriggerName)
			end

			arg_11_0.animTriggerName = arg_11_1

			return
		end,
		playAnim = function(arg_12_0, arg_12_1)
			arg_12_0._success = true

			if arg_12_0.animTriggerName then
				local var_12_0 = arg_12_0._animator

				var_2.SetTrigger(var_12_0, arg_12_0.animTriggerName)

				if arg_12_1 then
					local var_12_1 = arg_12_0._dftEvent

					var_2.SetEndEvent(var_12_1, function()
						arg_12_1()

						local var_13_0 = arg_12_0._dftEvent

						var_0.SetEndEvent(var_13_0, nil)

						return
					end)
				end
			end

			return
		end,
		getAnimationFlag = function(arg_14_0)
			return arg_14_0._animationFlag
		end,
		setVisible = function(arg_15_0, arg_15_1)
			setActive = var_2_10002

			var_2_10002(arg_15_0._itemTf, arg_15_1)

			return
		end,
		freeze = function(arg_16_0, arg_16_1)
			arg_16_0._freeze = arg_16_1

			arg_16_0:setVisible(not arg_16_0._freeze)

			return
		end,
		getFreeze = function(arg_17_0)
			return arg_17_0._freeze
		end,
		getSuccess = function(arg_18_0)
			return arg_18_0._success
		end,
		setSelect = function(arg_19_0, arg_19_1)
			arg_19_0:setTempData(arg_19_1)

			return
		end,
		setAlpha = function(arg_20_0, arg_20_1)
			arg_20_0._canvasGroup.alpha = arg_20_1

			return
		end,
		setPosition = function(arg_21_0, arg_21_1)
			arg_21_0._itemTf.anchoredPosition = arg_21_1

			return
		end,
		getIndex = function(arg_22_0)
			return arg_22_0._index
		end,
		clear = function(arg_23_0)
			arg_23_0._data = nil
			arg_23_0._tempData = nil
			arg_23_0._success = false

			arg_23_0:setItemVisible(false)
			arg_23_0:setAlpha(1)

			return
		end,
		getScreenPos = function(arg_24_0, arg_24_1)
			if not arg_24_0._screenPos then
				arg_24_0:updateScreenPos()
			end

			return arg_24_0._screenPos
		end,
		updateScreenPos = function(arg_25_0)
			local var_25_0 = arg_25_0._uiCamera

			arg_25_0._screenPos = var_1.WorldToScreenPoint(var_25_0, arg_25_0._itemTf.position)

			return
		end,
		getDirect = function(arg_26_0)
			return arg_26_0._data.direct
		end,
		dispose = function(arg_27_0)
			ClearEventTrigger = var_2_10001

			var_2_10001(arg_27_0._eventTriggerListener)

			return
		end
	}

	var_3.ctor(var_1_0)

	return var_3
end

function var_0_0.Ctor(arg_28_0, arg_28_1, arg_28_2)
	PipeGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_28_0._mapTf = arg_28_1
	arg_28_0._eventCallback = arg_28_2
	arg_28_0._mapItems = {}

	function arg_28_0.mapItemCallback(arg_29_0, arg_29_1)
		if var_0_0.CLICK_MAP_ITEM == arg_29_0 then
			if arg_28_0._dragTempItem then
				var_2_10003 = arg_28_0._dragTempItem

				var_2.clear(var_2_10003)

				arg_28_0._dragTempItem = nil
			end

			local var_29_0 = arg_28_0._eventCallback

			PipeGameEvent = var_2_10003

			var_29_0(var_2_10003.STOP_RECT_DRAG)

			if not arg_28_0._clickTempItem then
				arg_28_0._clickTempItem = arg_29_1

				local var_29_1 = arg_28_0._eventCallback

				PipeGameEvent = var_3

				var_29_1(var_3.SET_TOP_RECT)
			elseif arg_28_0._clickTempItem ~= arg_29_1 then
				local var_29_2 = arg_28_0._clickTempItem

				var_2.clear(var_29_2)

				arg_28_0._clickTempItem = arg_29_1

				local var_29_3 = arg_28_0._eventCallback

				PipeGameEvent = var_29_2

				var_29_3(var_29_2.SET_TOP_RECT)
			else
				local var_29_4 = arg_28_0._clickTempItem

				if var_2.getTempData(var_29_4) then
					local var_29_5 = arg_28_0._clickTempItem

					var_2.changeTempToReal(var_29_5)

					arg_28_0._clickTempItem = nil

					local var_29_6 = arg_28_0._eventCallback

					PipeGameEvent = var_3

					var_29_6(var_3.REMOVE_RECT_TOP)

					local var_29_7 = arg_28_0

					if var_2.checkFull(var_29_7) then
						local var_29_8 = arg_28_0

						var_2.startOverAniamtion(var_29_8)
					end
				end
			end
		end

		return
	end

	return
end

function var_0_0.setClickTempItem(arg_30_0, arg_30_1)
	if arg_30_0._clickTempItem then
		local var_30_0 = arg_30_0._clickTempItem

		if not var_2.getTempData(var_30_0) then
			local var_30_1 = arg_30_0._clickTempItem

			var_2.setTempData(var_30_1, arg_30_1)
		end
	end

	return
end

function var_0_0.start(arg_31_0)
	arg_31_0._overFlag = false
	arg_31_0._clickTempItem = nil
	PipeGameVo = var_1
	arg_31_0._gameRoundData = var_1.GetRoundData()
	arg_31_0._mapBound = arg_31_0._gameRoundData.map_bound
	arg_31_0._mapSpacing = arg_31_0._gameRoundData.item_spacing
	arg_31_0._inputIndex = arg_31_0._gameRoundData.input_index
	arg_31_0._randomId = arg_31_0._gameRoundData.random_id
	PipeGameConst = var_1
	arg_31_0._randomItemData = var_1.map_random_data[arg_31_0._randomId]
	findTF = var_1

	local var_31_0 = var_1(arg_31_0._mapTf, "bg")

	Vector2 = var_2
	var_31_0.sizeDelta = var_2(arg_31_0._mapSpacing[1] * arg_31_0._mapBound[1], arg_31_0._mapSpacing[2] * arg_31_0._mapBound[2])
	arg_31_0._maxItem = arg_31_0._mapBound[1] * arg_31_0._mapBound[2]

	for iter_31_0 = 1, arg_31_0._maxItem do
		local var_31_1

		if #arg_31_0._mapItems < iter_31_0 then
			PipeGameVo = var_6

			local var_31_2 = var_6.GetTplItemFromPool

			PipeGameConst = var_1_10007

			local var_31_3 = var_31_2(var_1_10007.tpl_map_item, arg_31_0._mapTf)

			var_1_10007 = arg_31_0:getItemPosByIndex(iter_31_0, arg_31_0._mapBound[1], arg_31_0._mapSpacing)

			local var_31_4 = var_0_12(var_31_3, iter_31_0, arg_31_0.mapItemCallback)

			var_31_1.setPosition(var_31_4, var_1_10007)

			table = var_8

			var_8.insert(arg_31_0._mapItems, var_31_1)
		else
			var_31_1 = arg_31_0._mapItems[iter_31_0]
		end

		var_1_10007 = var_31_1

		var_31_1.freeze(var_1_10007, false)

		var_1_10007 = var_31_1

		var_31_1.clear(var_1_10007)

		var_1_10007 = var_31_1

		var_31_1.setData(var_1_10007, arg_31_0:getRandomItemByIndex(iter_31_0))
	end

	for iter_31_1 = arg_31_0._maxItem + 1, #arg_31_0._mapItems do
		local var_31_5 = arg_31_0._mapItems[iter_31_1]

		var_5.freeze(var_31_5, true)
	end

	return
end

function var_0_0.getRandomItemByIndex(arg_32_0, arg_32_1)
	ipairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0._randomItemData.list) do
		if iter_32_1[1] == arg_32_1 then
			type = var_7

			if var_7(iter_32_1[2]) == "number" then
				PipeGameConst = var_7

				return var_7.map_item_data[iter_32_1[2]]
			else
				type = var_7

				if var_7(iter_32_1[2]) == "table" then
					math = var_7

					local var_32_0 = var_7.random(1, #iter_32_1[2])
					local var_32_1 = iter_32_1[2][var_32_0]

					PipeGameConst = var_9

					return var_9.map_item_data[var_32_1]
				end
			end
		end
	end

	return nil
end

function var_0_0.step(arg_33_0, arg_33_1)
	if var_0_1.draging then
		if arg_33_0._clickTempItem then
			local var_33_0 = arg_33_0._clickTempItem

			var_2.clear(var_33_0)

			arg_33_0._clickTempItem = nil
		end

		local var_33_1 = var_0_1.dragScreenPos

		if arg_33_0:getItemByScreenPos(var_33_1) and not var_3:getData() then
			if arg_33_0._dragTempItem ~= var_3 then
				if arg_33_0._dragTempItem then
					local var_33_2 = arg_33_0._dragTempItem

					var_4.clear(var_33_2)
				end

				arg_33_0._dragTempItem = var_3

				local var_33_3 = var_0_1.dragItem
				local var_33_4 = arg_33_0._dragTempItem

				var_5.setTempData(var_33_4, var_33_3)
			end
		else
			if arg_33_0._dragTempItem then
				local var_33_5 = arg_33_0._dragTempItem

				var_4.clear(var_33_5)
			end

			arg_33_0._dragTempItem = nil
		end

		arg_33_0._draging = var_0_1.draging
	else
		if arg_33_0._draging and arg_33_0._dragTempItem then
			local var_33_6 = arg_33_0._dragTempItem

			var_2.changeTempToReal(var_33_6)

			arg_33_0._dragTempItem = nil

			local var_33_7 = arg_33_0._eventCallback

			PipeGameEvent = var_33_6

			var_33_7(var_33_6.REMOVE_RECT_TOP)

			if arg_33_0:checkFull() then
				arg_33_0:startOverAniamtion()
			end
		end

		arg_33_0._draging = var_0_1.draging
	end

	if var_0_1.gameDragTime <= 0 then
		arg_33_0:startOverAniamtion()
	end

	return
end

function var_0_0.startOverAniamtion(arg_34_0)
	if arg_34_0._overFlag then
		return
	end

	local var_34_0 = arg_34_0._eventCallback

	PipeGameEvent = var_1_10002

	var_34_0(var_1_10002.START_SETTLEMENT)

	arg_34_0._overFlag = true
	arg_34_0._animationRound = 1

	local var_34_1 = {}
	local var_34_2 = arg_34_0:getItemByIndex(arg_34_0._inputIndex)

	if var_2.getData(var_34_2) then
		var_34_2 = var_2

		if var_2.getDirect(var_34_2)[2] ~= 0 then
			var_34_2 = var_2

			if var_2.getDirect(var_34_2)[2] == 1 then
				var_34_2 = var_2

				var_2.setTriggerName(var_34_2, var_0_4)

				table = var_3

				var_3.insert(var_34_1, var_2)

				var_34_2 = arg_34_0

				arg_34_0.playOverAniamtion(var_34_2, var_34_1, function()
					local var_35_0 = arg_34_0._eventCallback

					PipeGameEvent = var_2_10001

					var_35_0(var_2_10001.PALY_ANIMATION_COMPLETE)

					return
				end)

				goto label_34_0
			end

			do
				local var_34_3 = arg_34_0._eventCallback

				PipeGameEvent = var_34_2

				var_34_3(var_34_2.PALY_ANIMATION_COMPLETE)
			end

			::label_34_0::

			return
		end
	end
end

function var_0_0.getSuccessCount(arg_36_0)
	local var_36_0 = 0

	for iter_36_0 = 1, #arg_36_0._mapItems do
		local var_36_1 = arg_36_0._mapItems[iter_36_0]

		if var_6.getSuccess(var_36_1) and not var_6:getFreeze() then
			var_36_0 = var_36_0 + 1
		end
	end

	return var_36_0
end

function var_0_0.checkFull(arg_37_0)
	local var_37_0 = 0

	for iter_37_0 = 1, #arg_37_0._mapItems do
		local var_37_1 = arg_37_0._mapItems[iter_37_0]

		if not var_6.getFreeze(var_37_1) then
			local var_37_2 = arg_37_0._mapItems[iter_37_0]

			if not var_6.getData(var_37_2) then
				var_37_0 = var_37_0 + 1
			end
		end
	end

	return var_37_0 == 0
end

function var_0_0.playOverAniamtion(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = {}
	local var_38_1 = 0
	local var_38_2 = #arg_38_1
	local var_38_3

	if not arg_38_3 or not (arg_38_3 + 1) then
		var_38_3 = 1
	end

	local function var_38_4()
		var_38_1 = var_38_1 + 1

		if var_38_1 == var_38_2 then
			if #var_38_0 == 0 and arg_38_2 then
				arg_38_2()
			else
				local var_39_0 = arg_38_0

				var_0.playOverAniamtion(var_39_0, var_38_0, arg_38_2, var_38_3)
			end
		end

		return
	end

	ipairs = var_1_10009

	for iter_38_0, iter_38_1 in var_1_10009(arg_38_1) do
		local var_38_5 = arg_38_0:getItemsByDirect(iter_38_1, var_38_3)

		arg_38_0:setItemsTriggerName(iter_38_1, var_38_5)

		ipairs = var_15

		for iter_38_2, iter_38_3 in var_15(var_38_5) do
			table = var_1_10020

			if not var_1_10020.contains(var_38_0, iter_38_3) then
				table = var_1_10020

				var_1_10020.insert(var_38_0, iter_38_3)
			end
		end

		iter_38_1:playAnim(var_38_4)
	end

	return
end

function var_0_0.setItemsTriggerName(arg_40_0, arg_40_1, arg_40_2)
	ipairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(arg_40_2) do
		local var_40_0 = arg_40_1:getIndex()
		local var_40_1 = iter_40_1:getIndex()
		local var_40_2

		if var_40_1 < var_40_0 then
			if var_40_1 == var_40_0 - 1 then
				var_40_2 = var_0_3
			else
				var_40_2 = var_0_5
			end
		elseif var_40_0 < var_40_1 then
			if var_40_1 == var_40_0 + 1 then
				var_40_2 = var_0_2
			else
				var_40_2 = var_0_4
			end
		end

		if var_40_2 then
			iter_40_1:setTriggerName(var_40_2)
		end
	end

	return
end

function var_0_0.getItemsByDirect(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}
	local var_41_1 = arg_41_0._mapBound[1]
	local var_41_2 = arg_41_1:getDirect()
	local var_41_3 = arg_41_1:getIndex()

	if var_41_2[1] == var_0_6 or var_41_2[1] == var_0_11 then
		table = var_7

		var_7.insert(var_41_0, var_41_3 + 1)
	end

	if var_41_2[1] == var_0_6 or var_41_2[1] == var_0_10 then
		table = var_7

		var_7.insert(var_41_0, var_41_3 - 1)
	end

	if var_41_2[2] == var_0_7 or var_41_2[2] == var_0_8 then
		table = var_7

		var_7.insert(var_41_0, var_41_3 - arg_41_0._mapBound[1])
	end

	if var_41_2[2] == var_0_7 or var_41_2[2] == var_0_9 then
		table = var_7

		var_7.insert(var_41_0, var_41_3 + arg_41_0._mapBound[1])
	end

	for iter_41_0 = #var_41_0, 1, -1 do
		local var_41_4 = arg_41_0

		if arg_41_0.getItemByIndex(var_41_4, var_41_0[iter_41_0]) and var_11:getData() then
			local var_41_5 = arg_41_0

			if not arg_41_0.checkItemSuccess(var_41_5, var_41_3, var_11:getIndex(), var_41_2, var_11:getDirect()) then
				table = var_41_5

				var_41_5.remove(var_41_0, iter_41_0)
			end
		else
			table = var_41_4

			var_41_4.remove(var_41_0, iter_41_0)
		end
	end

	local var_41_6 = {}

	ipairs = var_8

	for iter_41_1, iter_41_2 in var_8(var_41_0) do
		if arg_41_0:getItemByIndex(iter_41_2) and not var_13:getAnimationFlag() then
			table = var_14

			var_14.insert(var_41_6, var_13)
		end
	end

	return var_41_6
end

function var_0_0.checkItemSuccess(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = false
	local var_42_1 = arg_42_0._mapBound[1]
	local var_42_2 = arg_42_3[1]
	local var_42_3 = arg_42_3[2]
	local var_42_4 = arg_42_4[1]
	local var_42_5 = arg_42_4[2]

	if arg_42_2 - arg_42_1 == 1 then
		if (var_42_2 == var_0_6 or var_42_2 == var_0_11) and (var_42_4 == var_0_6 or var_42_4 == var_0_10) then
			if (arg_42_1 - 1) % var_42_1 == var_42_1 - 1 then
				var_42_0 = false
			else
				var_42_0 = true
			end
		end
	elseif arg_42_1 - arg_42_2 == 1 then
		if (var_42_2 == var_0_6 or var_42_2 == var_0_10) and (var_42_4 == var_0_6 or var_42_4 == var_0_11) then
			if (arg_42_1 - 1) % var_42_1 == 0 then
				var_42_0 = false
			else
				var_42_0 = true
			end
		end
	elseif arg_42_2 - arg_42_1 == var_42_1 then
		if (var_42_3 == var_0_7 or var_42_3 == var_0_9) and (var_42_5 == var_0_7 or var_42_5 == var_0_8) then
			var_42_0 = true
		end
	elseif arg_42_1 - arg_42_2 == var_42_1 and (var_42_3 == var_0_7 or var_42_3 == var_0_8) and (var_42_5 == var_0_7 or var_42_5 == var_0_9) then
		var_42_0 = true
	end

	return var_42_0
end

function var_0_0.getItemByIndex(arg_43_0, arg_43_1)
	return arg_43_0._mapItems[arg_43_1]
end

function var_0_0.getItemByScreenPos(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:getScreentScaleRate()

	for iter_44_0 = 1, #arg_44_0._mapItems do
		local var_44_1 = arg_44_0._mapItems[iter_44_0]
		local var_44_2 = var_7.getScreenPos(var_44_1)

		if arg_44_1.x > var_44_2.x and arg_44_1.x < var_44_2.x + arg_44_0._mapSpacing[1] / var_44_0.x and arg_44_1.y < var_44_2.y and arg_44_1.y > var_44_2.y - arg_44_0._mapSpacing[2] / var_44_0.y then
			return var_7
		end
	end

	return nil
end

function var_0_0.getScreentScaleRate(arg_45_0)
	UnityEngine = var_1_10001

	local var_45_0 = var_1_10001.Screen.width

	UnityEngine = var_1_10002

	local var_45_1 = var_1_10002.Screen.height

	tf = var_1_10003
	GameObject = var_1_10004

	local var_45_2 = var_1_10003(var_1_10004.Find("UICamera/Canvas")).sizeDelta.x
	local var_45_3 = var_3.sizeDelta.y

	Vector2 = var_1_10006

	return var_1_10006(var_45_2 / var_45_0, var_45_3 / var_45_1)
end

function var_0_0.getItemPosByIndex(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = (arg_46_1 - 1) % arg_46_2

	math = var_1_10005

	local var_46_1 = var_1_10005.floor((arg_46_1 - 1) / arg_46_2)

	Vector2 = var_6

	return var_6(var_46_0 * arg_46_3[1], -var_46_1 * arg_46_3[2])
end

function var_0_0.stop(arg_47_0)
	return
end

function var_0_0.clear(arg_48_0)
	if arg_48_0._dragTempItem then
		local var_48_0 = arg_48_0._dragTempItem

		var_1.clear(var_48_0)

		arg_48_0._dragTempItem = nil
	end

	return
end

function var_0_0.dispose(arg_49_0)
	return
end

return var_0_0
