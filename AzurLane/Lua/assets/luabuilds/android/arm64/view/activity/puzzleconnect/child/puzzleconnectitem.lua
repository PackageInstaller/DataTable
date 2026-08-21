local var_0_0 = class("PuzzleConnectItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._canvasGroup = GetComponent(arg_1_0._tf, typeof(CanvasGroup))
	arg_1_0._iconContent = findTF(arg_1_0._tf, "icons")
	arg_1_0._eventTrigger = GetComponent(findTF(arg_1_0._tf, "icons"), typeof(EventTriggerListener))
	arg_1_0._iconTpl = arg_1_2
	arg_1_0._iconTfs = {}
	arg_1_0._textTf = findTF(arg_1_0._tf, "text")
	arg_1_0._bgTf = findTF(arg_1_0._tf, "bg")
	arg_1_0._boundData = Vector2(PuzzleConnectConst.item_bound[1] + PuzzleConnectConst.item_spacing, PuzzleConnectConst.item_bound[2] + PuzzleConnectConst.item_spacing)

	return
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0:clear()

	arg_2_0._itemData = arg_2_1
	arg_2_0._id = arg_2_1.id
	arg_2_0._count = arg_2_1.count
	arg_2_0._color = arg_2_1.color
	arg_2_0._itemMap = Clone(PuzzleConnectConst.item_data[arg_2_0._id])

	arg_2_0:updateIcon()
	arg_2_0:updateAlpha()
	setGray(arg_2_0._tf, false, true)

	return
end

function var_0_0.updateIcon(arg_3_0)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._itemMap) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if iter_3_3 > 0 then
				var_3_0 = var_3_0 + 1

				if var_3_0 > #arg_3_0._iconTfs then
					local var_3_1 = tf(instantiate(arg_3_0._iconTpl))

					setActive(var_3_1, true)
					setParent(var_3_1, arg_3_0._iconContent)
					setActive(findTF(var_3_1, "line"), false)
					setActive(findTF(var_3_1, "lineBound"), false)
					table.insert(arg_3_0._iconTfs, var_3_1)
				end

				setActive(arg_3_0._iconTfs[var_3_0], true)

				arg_3_0._iconTfs[var_3_0].anchoredPosition = Vector2((iter_3_2 - 1) * arg_3_0._boundData.x, -(iter_3_0 - 1) * arg_3_0._boundData.y)
			end
		end
	end

	for iter_3_4 = var_3_0, #arg_3_0._iconTfs do
		if iter_3_4 > #arg_3_0._iconTfs then
			setActive(arg_3_0.iconTfs[iter_3_4], false)
		end
	end

	for iter_3_5, iter_3_6 in ipairs(arg_3_0._iconTfs) do
		for iter_3_7 = 1, PuzzleConnectConst.color_count do
			setActive(findTF(iter_3_6, iter_3_7), iter_3_7 == arg_3_0._color)
		end
	end

	arg_3_0:updateCount()

	return
end

function var_0_0.updateCount(arg_4_0)
	setText(arg_4_0._textTf, "X" .. arg_4_0._count)

	return
end

function var_0_0.getId(arg_5_0)
	return arg_5_0._id
end

function var_0_0.getCount(arg_6_0)
	return arg_6_0._count
end

function var_0_0.getData(arg_7_0)
	return arg_7_0._itemData
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	setActive(arg_8_0._tf, arg_8_1)

	return
end

function var_0_0.setContent(arg_9_0, arg_9_1)
	setParent(arg_9_0._tf, arg_9_1)

	return
end

function var_0_0.setState(arg_10_0, arg_10_1)
	arg_10_0._state = arg_10_1

	return
end

function var_0_0.getEventTrigger(arg_11_0)
	return arg_11_0._eventTrigger
end

function var_0_0.setPosition(arg_12_0, arg_12_1)
	arg_12_0._tf.anchoredPosition = arg_12_1

	return
end

function var_0_0.getName(arg_13_0)
	arg_13_0._gridName = arg_13_0._gridName or arg_13_0._h .. "-" .. arg_13_0._v

	return arg_13_0._gridName
end

function var_0_0.setMoveItem(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0._iconContent.localScale = Vector3(1, 1, 1)

		setActive(arg_14_0._textTf, false)
		setActive(arg_14_0._bgTf, false)
	end

	return
end

function var_0_0.changeCount(arg_15_0, arg_15_1)
	arg_15_0._count = arg_15_0._count + arg_15_1

	arg_15_0:updateCount()

	return
end

function var_0_0.getPosition(arg_16_0)
	return arg_16_0._tf.anchoredPosition
end

function var_0_0.getColor(arg_17_0)
	return arg_17_0._color
end

function var_0_0.getItemIconWorld(arg_18_0, arg_18_1)
	return arg_18_0._iconTfs[arg_18_1].position
end

function var_0_0.getPuzzleWorldPos(arg_19_0)
	for iter_19_0 = 1, #arg_19_0._iconTfs do
		if isActive(arg_19_0._iconTfs[iter_19_0]) then
			table.insert({}, arg_19_0._iconTfs[iter_19_0].position)
		end
	end

	return {}
end

function var_0_0.setDraging(arg_20_0, arg_20_1)
	arg_20_0._draging = arg_20_1

	arg_20_0:updateAlpha()

	return
end

function var_0_0.updateAlpha(arg_21_0)
	arg_21_0._canvasGroup.alpha = (arg_21_0._draging or arg_21_0._count == 0) and 0.5 or 1

	if arg_21_0._count == 0 then
		setGray(arg_21_0._tf, true, true)
	else
		setGray(arg_21_0._tf, false, true)
	end

	return
end

function var_0_0.clear(arg_22_0)
	for iter_22_0 = 1, #arg_22_0._iconTfs do
		setActive(arg_22_0._iconTfs[iter_22_0], false)
	end

	return
end

function var_0_0.dispose(arg_23_0)
	if arg_23_0._eventTrigger then
		ClearEventTrigger(arg_23_0._eventTrigger)
	end

	return
end

return var_0_0
