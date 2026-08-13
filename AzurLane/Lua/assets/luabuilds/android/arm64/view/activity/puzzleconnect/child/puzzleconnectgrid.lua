class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectGrid")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_2

	arg_1_0._v = arg_1_3
	arg_1_0._h = var_1_0
	GetComponent = var_1_0

	local var_1_1 = arg_1_0._tf

	typeof = var_1_10008
	EventTriggerListener = var_1_10010
	arg_1_0._eventTrigger = var_1_0(var_1_1, var_1_10008(var_1_10010))
	findTF = var_5
	arg_1_0._unLockTf = var_5(arg_1_0._tf, "unlock")
	findTF = var_5
	arg_1_0._iconContent = var_5(arg_1_0._tf, "iconContent")
	tf = var_5
	instantiate = var_7
	arg_1_0._iconTf = var_5(var_7(arg_1_4))
	setActive = var_5

	var_5(arg_1_0._iconTf, true)

	setParent = var_5

	var_5(arg_1_0._iconTf, arg_1_0._iconContent)

	local var_1_2 = arg_1_0._iconTf

	Vector2 = var_1_10006
	var_1_2.anchoredPosition = var_1_10006(0, 0)
	GetComponent = var_1_2

	local var_1_3 = arg_1_0._iconContent

	typeof = var_8
	CanvasGroup = var_1_10010
	arg_1_0._iconCanvasGroup = var_1_2(var_1_3, var_8(var_1_10010))

	arg_1_0:setChildVisible(arg_1_0._iconTf, false)

	setActive = var_5

	var_5(arg_1_0._unLockTf, false)

	findTF = var_5
	arg_1_0._lineTf = var_5(arg_1_0._iconTf, "line")
	setActive = var_5

	var_5(arg_1_0._lineTf, false)

	local var_1_4 = arg_1_0

	arg_1_0.setChildVisible(var_1_4, arg_1_0._lineTf, false)

	GetComponent = var_5
	findTF = var_1_4

	local var_1_5 = var_1_4(arg_1_0._iconTf, "lineBound")

	typeof = var_8
	EventTriggerListener = var_10
	arg_1_0._lineEventTrigger = var_5(var_1_5, var_8(var_10))

	return
end

function var_0_0.getLineTrigger(arg_2_0)
	return arg_2_0._lineEventTrigger
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1)

	return
end

function var_0_0.setContent(arg_4_0, arg_4_1)
	setParent = var_1_10002

	var_1_10002(arg_4_0._tf, arg_4_1)

	return
end

function var_0_0.getPosition(arg_5_0)
	return arg_5_0._tf.anchoredPosition
end

function var_0_0.setPrepare(arg_6_0, arg_6_1)
	if arg_6_0._fillItem then
		return
	end

	arg_6_0._prepareColor = arg_6_1
	arg_6_0._iconCanvasGroup.alpha = 0.5

	local var_6_0 = arg_6_0

	arg_6_0.setChildVisible(var_6_0, arg_6_0._iconTf, false)

	setActive = var_2
	findTF = var_6_0

	local var_6_1 = arg_6_0._iconTf

	tostring = var_1_10007

	var_2(var_6_0(var_6_1, var_1_10007(arg_6_1)), true)

	return
end

function var_0_0.getPrepare(arg_7_0)
	local var_7_0

	if arg_7_0._prepareColor then
		var_7_0 = arg_7_0._prepareColor > 0
	end

	return var_7_0
end

function var_0_0.clearPrepare(arg_8_0)
	if arg_8_0._prepareColor then
		local var_8_0 = arg_8_0._prepareColor

		if 0 < var_8_0 then
			GetComponent = var_8_0
			findTF = var_1_10003

			local var_8_1 = var_1_10003(arg_8_0._iconTf, arg_8_0._prepareColor)

			typeof = var_1_10004
			Image = var_6

			local var_8_2 = var_8_0(var_8_1, var_1_10004(var_6))

			Color = var_2
			var_8_2.color = var_2.New(1, 1, 1, 1)
			arg_8_0._prepareColor = nil
			arg_8_0._iconCanvasGroup.alpha = 1

			arg_8_0:setChildVisible(arg_8_0._iconTf, false)
		end
	end

	return
end

function var_0_0.setLine(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 and arg_9_0:getLineStrByGrid(arg_9_1) then
		setActive = var_1_10004
		findTF = var_6

		var_1_10004(var_6(arg_9_0._lineTf, var_3), true)
	end

	if arg_9_2 and arg_9_0:getLineStrByGrid(arg_9_2) then
		setActive = var_1_10004
		findTF = var_6

		var_1_10004(var_6(arg_9_0._lineTf, var_3), true)
	end

	return
end

function var_0_0.getLineStrByGrid(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._h - arg_10_1.h
	local var_10_1 = arg_10_0._v - arg_10_1.v
	local var_10_2

	if var_10_0 == 1 then
		if var_10_1 == 1 then
			var_10_2 = "LT"
		elseif var_10_1 == 0 then
			var_10_2 = "L"
		elseif var_10_1 == -1 then
			var_10_2 = "LB"
		end
	elseif var_10_0 == 0 then
		if var_10_1 == 1 then
			var_10_2 = "T"
		elseif var_10_1 == -1 then
			var_10_2 = "B"
		end
	elseif var_10_0 == -1 then
		if var_10_1 == 1 then
			var_10_2 = "RT"
		elseif var_10_1 == 0 then
			var_10_2 = "R"
		elseif var_10_1 == -1 then
			var_10_2 = "RB"
		end
	end

	return var_10_2
end

function var_0_0.clearLine(arg_11_0)
	arg_11_0:setChildVisible(arg_11_0._lineTf, false)

	return
end

function var_0_0.setChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		local var_12_0 = arg_12_1:GetChild(iter_12_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_12_0, arg_12_2)
	end

	return
end

function var_0_0.setIndex(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:clear()

	arg_13_0._mapIndex = arg_13_1
	arg_13_0._state = arg_13_2

	arg_13_0:updateGrid()

	return
end

function var_0_0.updateGrid(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0._unLockTf, false)

	local var_14_0 = arg_14_0._state

	PuzzleConnectPlaying = var_1_10002

	if var_14_0 == var_1_10002.game_state_puzzle then
		setActive = var_14_0

		var_14_0(arg_14_0._lineTf, false)

		local var_14_1

		if arg_14_0._mapIndex then
			var_14_1 = arg_14_0._mapIndex

			if 0 < var_14_1 then
				setActive = var_14_1

				var_14_1(arg_14_0._unLockTf, true)
			end
		end

		setActive = var_14_1
		findTF = var_3

		var_14_1(var_3(arg_14_0._iconTf, "lineBound"), false)

		setActive = var_14_1
		findTF = var_3

		var_14_1(var_3(arg_14_0._unLockTf, "whiteImg"), false)
	else
		local var_14_2 = arg_14_0._state

		PuzzleConnectPlaying = var_2

		if var_14_2 == var_2.game_state_connect then
			setActive = var_14_2

			var_14_2(arg_14_0._lineTf, true)

			if arg_14_0._mapIndex and arg_14_0._mapIndex > 0 then
				setActive = var_1
				findTF = var_3

				var_1(var_3(arg_14_0._iconTf, arg_14_0._mapIndex), true)

				setActive = var_1
				findTF = var_3

				var_1(var_3(arg_14_0._iconTf, "lineBound"), true)

				setActive = var_1

				var_1(arg_14_0._unLockTf, true)

				setActive = var_1
				findTF = var_3

				var_1(var_3(arg_14_0._unLockTf, "whiteImg"), true)
			end
		end
	end

	return
end

function var_0_0.setStart(arg_15_0, arg_15_1)
	arg_15_0._startFlag = arg_15_1

	return
end

function var_0_0.getStart(arg_16_0)
	return arg_16_0._startFlag
end

function var_0_0.setEnd(arg_17_0, arg_17_1)
	arg_17_0._endFlag = arg_17_1

	return
end

function var_0_0.getEnd(arg_18_0)
	return arg_18_0._endFlag
end

function var_0_0.getUnlock(arg_19_0)
	local var_19_0

	if arg_19_0._mapIndex then
		var_19_0 = arg_19_0._mapIndex > 0
	end

	return var_19_0
end

function var_0_0.setFillItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._fillItem = arg_20_1
	arg_20_0._fillIndex = arg_20_2
	arg_20_0._fillCount = arg_20_3

	arg_20_0:clearPrepare()

	local var_20_0 = arg_20_0._fillItem
	local var_20_1 = var_4.getColor(var_20_0)

	setActive = var_1_10005
	findTF = var_1_10007

	local var_20_2 = arg_20_0._iconTf

	tostring = var_1_10010

	var_1_10005(var_1_10007(var_20_2, var_1_10010(var_20_1)), true)

	if arg_20_0._mapIndex and arg_20_0._mapIndex > 0 then
		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_20_0._unLockTf, "whiteImg"), true)
	else
		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_20_0._unLockTf, "whiteImg"), false)
	end

	return
end

function var_0_0.getFillItem(arg_21_0)
	return arg_21_0._fillItem, arg_21_0._fillIndex, arg_21_0._fillCount
end

function var_0_0.clearFillItem(arg_22_0)
	if arg_22_0._fillItem then
		arg_22_0._fillItem = nil
		arg_22_0._iconCanvasGroup.alpha = 1
	end

	local var_22_0 = arg_22_0

	arg_22_0.setChildVisible(var_22_0, arg_22_0._iconTf, false)

	if arg_22_0._mapIndex and arg_22_0._mapIndex > 0 then
		setActive = var_1
		findTF = var_22_0

		var_1(var_22_0(arg_22_0._unLockTf, "whiteImg"), false)
	end

	return
end

function var_0_0.getFill(arg_23_0)
	return arg_23_0._fillItem and true or false
end

function var_0_0.setPrepareAlpha(arg_24_0, arg_24_1)
	if arg_24_0._prepareColor then
		local var_24_0 = arg_24_0._prepareColor

		if 0 < var_24_0 then
			findTF = var_24_0

			local var_24_1

			var_24_1, GetComponent = var_24_0(arg_24_0._iconTf, arg_24_0._prepareColor), var_3
			typeof = var_1_10006
			Image = var_1_10008
			var_3(var_24_1, var_1_10006(var_1_10008)).color = arg_24_1
		end
	end

	return
end

function var_0_0.setState(arg_25_0, arg_25_1)
	arg_25_0._state = arg_25_1

	return
end

function var_0_0.getPoint(arg_26_0)
	return {
		h = arg_26_0._h,
		v = arg_26_0._v
	}
end

function var_0_0.getEventTrigger(arg_27_0)
	return arg_27_0._eventTrigger
end

function var_0_0.getName(arg_28_0)
	if not arg_28_0._gridName then
		arg_28_0._gridName = arg_28_0._h .. "-" .. arg_28_0._v
	end

	return arg_28_0._gridName
end

function var_0_0.getMapIndex(arg_29_0)
	return arg_29_0._mapIndex
end

function var_0_0.getComplete(arg_30_0)
	if arg_30_0._mapIndex > 0 and arg_30_0._fillItem then
		return true
	end

	return false
end

function var_0_0.clear(arg_31_0)
	arg_31_0:setStart(false)
	arg_31_0:setEnd(false)
	arg_31_0:clearPrepare()
	arg_31_0:clearFillItem()

	return
end

function var_0_0.dispose(arg_32_0)
	if arg_32_0._eventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_32_0._eventTrigger)
	end

	return
end

return var_0_0
