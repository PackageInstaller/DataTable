local var_0_0 = class("PuzzleConnectGrid")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1
	arg_1_0._h, arg_1_0._v = arg_1_2, arg_1_3
	arg_1_0._eventTrigger = GetComponent(arg_1_0._tf, typeof(EventTriggerListener))
	arg_1_0._unLockTf = findTF(arg_1_0._tf, "unlock")
	arg_1_0._iconContent = findTF(arg_1_0._tf, "iconContent")
	arg_1_0._iconTf = tf(instantiate(arg_1_4))

	setActive(arg_1_0._iconTf, true)
	setParent(arg_1_0._iconTf, arg_1_0._iconContent)

	arg_1_0._iconTf.anchoredPosition = Vector2(0, 0)
	arg_1_0._iconCanvasGroup = GetComponent(arg_1_0._iconContent, typeof(CanvasGroup))

	arg_1_0:setChildVisible(arg_1_0._iconTf, false)
	setActive(arg_1_0._unLockTf, false)

	arg_1_0._lineTf = findTF(arg_1_0._iconTf, "line")

	setActive(arg_1_0._lineTf, false)
	arg_1_0:setChildVisible(arg_1_0._lineTf, false)

	arg_1_0._lineEventTrigger = GetComponent(findTF(arg_1_0._iconTf, "lineBound"), typeof(EventTriggerListener))

	return
end

function var_0_0.getLineTrigger(arg_2_0)
	return arg_2_0._lineEventTrigger
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	setActive(arg_3_0._tf, arg_3_1)

	return
end

function var_0_0.setContent(arg_4_0, arg_4_1)
	setParent(arg_4_0._tf, arg_4_1)

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

	arg_6_0:setChildVisible(arg_6_0._iconTf, false)
	setActive(findTF(arg_6_0._iconTf, tostring(arg_6_1)), true)

	return
end

function var_0_0.getPrepare(arg_7_0)
	return arg_7_0._prepareColor and arg_7_0._prepareColor > 0
end

function var_0_0.clearPrepare(arg_8_0)
	if arg_8_0._prepareColor and arg_8_0._prepareColor > 0 then
		GetComponent(findTF(arg_8_0._iconTf, arg_8_0._prepareColor), typeof(Image)).color = Color.New(1, 1, 1, 1)
		arg_8_0._prepareColor = nil
		arg_8_0._iconCanvasGroup.alpha = 1

		arg_8_0:setChildVisible(arg_8_0._iconTf, false)
	end

	return
end

function var_0_0.setLine(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		local var_9_0 = arg_9_0:getLineStrByGrid(arg_9_1)

		if var_9_0 then
			setActive(findTF(arg_9_0._lineTf, var_9_0), true)
		end
	end

	if arg_9_2 then
		local var_9_1 = arg_9_0:getLineStrByGrid(arg_9_2)

		if var_9_1 then
			setActive(findTF(arg_9_0._lineTf, var_9_1), true)
		end
	end

	return
end

function var_0_0.getLineStrByGrid(arg_10_0, arg_10_1)
	local var_10_0

	if arg_10_0._h - arg_10_1.h == 1 then
		if arg_10_0._v - arg_10_1.v == 1 then
			var_10_0 = "LT"
		elseif arg_10_0._v - arg_10_1.v == 0 then
			var_10_0 = "L"
		elseif arg_10_0._v - arg_10_1.v == -1 then
			var_10_0 = "LB"
		end
	elseif arg_10_0._h - arg_10_1.h == 0 then
		if arg_10_0._v - arg_10_1.v == 1 then
			var_10_0 = "T"
		elseif arg_10_0._v - arg_10_1.v == -1 then
			var_10_0 = "B"
		end
	elseif arg_10_0._h - arg_10_1.h == -1 then
		if arg_10_0._v - arg_10_1.v == 1 then
			var_10_0 = "RT"
		elseif arg_10_0._v - arg_10_1.v == 0 then
			var_10_0 = "R"
		elseif arg_10_0._v - arg_10_1.v == -1 then
			var_10_0 = "RB"
		end
	end

	return var_10_0
end

function var_0_0.clearLine(arg_11_0)
	arg_11_0:setChildVisible(arg_11_0._lineTf, false)

	return
end

function var_0_0.setChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
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
	setActive(arg_14_0._unLockTf, false)

	if arg_14_0._state == PuzzleConnectPlaying.game_state_puzzle then
		setActive(arg_14_0._lineTf, false)

		if arg_14_0._mapIndex and arg_14_0._mapIndex > 0 then
			setActive(arg_14_0._unLockTf, true)
		end

		setActive(findTF(arg_14_0._iconTf, "lineBound"), false)
		setActive(findTF(arg_14_0._unLockTf, "whiteImg"), false)
	elseif arg_14_0._state == PuzzleConnectPlaying.game_state_connect then
		setActive(arg_14_0._lineTf, true)

		if arg_14_0._mapIndex and arg_14_0._mapIndex > 0 then
			setActive(findTF(arg_14_0._iconTf, arg_14_0._mapIndex), true)
			setActive(findTF(arg_14_0._iconTf, "lineBound"), true)
			setActive(arg_14_0._unLockTf, true)
			setActive(findTF(arg_14_0._unLockTf, "whiteImg"), true)
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
	return arg_19_0._mapIndex and arg_19_0._mapIndex > 0
end

function var_0_0.setFillItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._fillItem = arg_20_1
	arg_20_0._fillIndex = arg_20_2
	arg_20_0._fillCount = arg_20_3

	arg_20_0:clearPrepare()
	setActive(findTF(arg_20_0._iconTf, tostring((arg_20_0._fillItem:getColor()))), true)

	if arg_20_0._mapIndex and arg_20_0._mapIndex > 0 then
		setActive(findTF(arg_20_0._unLockTf, "whiteImg"), true)
	else
		setActive(findTF(arg_20_0._unLockTf, "whiteImg"), false)
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

	arg_22_0:setChildVisible(arg_22_0._iconTf, false)

	if arg_22_0._mapIndex and arg_22_0._mapIndex > 0 then
		setActive(findTF(arg_22_0._unLockTf, "whiteImg"), false)
	end

	return
end

function var_0_0.getFill(arg_23_0)
	return not not arg_23_0._fillItem
end

function var_0_0.setPrepareAlpha(arg_24_0, arg_24_1)
	if arg_24_0._prepareColor and arg_24_0._prepareColor > 0 then
		GetComponent(findTF(arg_24_0._iconTf, arg_24_0._prepareColor), typeof(Image)).color = arg_24_1
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
	arg_28_0._gridName = arg_28_0._gridName or arg_28_0._h .. "-" .. arg_28_0._v

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
		ClearEventTrigger(arg_32_0._eventTrigger)
	end

	return
end

return var_0_0
