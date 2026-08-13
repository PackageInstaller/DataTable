class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	GetComponent = var_1_10003

	local var_1_0 = arg_1_0._tf

	typeof = var_1_10005
	CanvasGroup = var_1_10006
	arg_1_0._canvasGroup = var_1_10003(var_1_0, var_1_10005(var_1_10006))
	findTF = var_3
	arg_1_0._iconContent = var_3(arg_1_0._tf, "icons")
	GetComponent = var_3
	findTF = var_4

	local var_1_1 = var_4(arg_1_0._tf, "icons")

	typeof = var_5
	EventTriggerListener = var_6
	arg_1_0._eventTrigger = var_3(var_1_1, var_5(var_6))
	arg_1_0._iconTpl = arg_1_2
	arg_1_0._iconTfs = {}
	findTF = var_3
	arg_1_0._textTf = var_3(arg_1_0._tf, "text")
	findTF = var_3
	arg_1_0._bgTf = var_3(arg_1_0._tf, "bg")
	Vector2 = var_3
	PuzzleConnectConst = var_4

	local var_1_2 = var_4.item_bound[1]

	PuzzleConnectConst = var_5

	local var_1_3 = var_1_2 + var_5.item_spacing

	PuzzleConnectConst = var_5

	local var_1_4 = var_5.item_bound[2]

	PuzzleConnectConst = var_6
	arg_1_0._boundData = var_3(var_1_3, var_1_4 + var_6.item_spacing)

	return
end

function var_0_0.setData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0

	arg_2_0.clear(var_2_0)

	arg_2_0._itemData = arg_2_1
	arg_2_0._id = arg_2_1.id
	arg_2_0._count = arg_2_1.count
	arg_2_0._color = arg_2_1.color
	Clone = var_2
	PuzzleConnectConst = var_2_0
	arg_2_0._itemMap = var_2(var_2_0.item_data[arg_2_0._id])

	arg_2_0:updateIcon()
	arg_2_0:updateAlpha()

	setGray = var_2

	var_2(arg_2_0._tf, false, true)

	return
end

function var_0_0.updateIcon(arg_3_0)
	local var_3_0 = 0

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0._itemMap) do
		ipairs = var_1_10007

		for iter_3_2, iter_3_3 in var_1_10007(iter_3_1) do
			if 0 < iter_3_3 then
				var_3_0 = var_3_0 + 1

				if #arg_3_0._iconTfs < var_3_0 then
					tf = var_1_10012
					instantiate = var_1_10013
					var_1_10012 = var_1_10012(var_1_10013(arg_3_0._iconTpl))
					setActive = var_1_10013

					var_1_10013(var_1_10012, true)

					setParent = var_1_10013

					var_1_10013(var_1_10012, arg_3_0._iconContent)

					setActive = var_1_10013
					findTF = var_14

					var_1_10013(var_14(var_1_10012, "line"), false)

					setActive = var_1_10013
					findTF = var_14

					var_1_10013(var_14(var_1_10012, "lineBound"), false)

					table = var_1_10013

					var_1_10013.insert(arg_3_0._iconTfs, var_1_10012)
				end

				setActive = var_1_10012

				var_1_10012(arg_3_0._iconTfs[var_3_0], true)

				var_1_10012 = arg_3_0._iconTfs[var_3_0]
				Vector2 = var_1_10013
				var_1_10012.anchoredPosition = var_1_10013((iter_3_2 - 1) * arg_3_0._boundData.x, -(iter_3_0 - 1) * arg_3_0._boundData.y)
			end
		end
	end

	for iter_3_4 = var_3_0, #arg_3_0._iconTfs do
		if #arg_3_0._iconTfs < iter_3_4 then
			setActive = var_6

			var_6(arg_3_0.iconTfs[iter_3_4], false)
		end
	end

	ipairs = var_2

	for iter_3_5, iter_3_6 in var_2(arg_3_0._iconTfs) do
		local var_3_1 = 1

		PuzzleConnectConst = var_1_10008

		for iter_3_7 = var_3_1, var_1_10008.color_count do
			setActive = iter_3_3
			findTF = var_1_10012

			iter_3_3(var_1_10012(iter_3_6, iter_3_7), iter_3_7 == arg_3_0._color)
		end
	end

	arg_3_0:updateCount()

	return
end

function var_0_0.updateCount(arg_4_0)
	setText = var_1_10001

	var_1_10001(arg_4_0._textTf, "X" .. arg_4_0._count)

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
	setActive = var_1_10002

	var_1_10002(arg_8_0._tf, arg_8_1)

	return
end

function var_0_0.setContent(arg_9_0, arg_9_1)
	setParent = var_1_10002

	var_1_10002(arg_9_0._tf, arg_9_1)

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
	if not arg_13_0._gridName then
		arg_13_0._gridName = arg_13_0._h .. "-" .. arg_13_0._v
	end

	return arg_13_0._gridName
end

function var_0_0.setMoveItem(arg_14_0, arg_14_1)
	if arg_14_1 then
		local var_14_0 = arg_14_0._iconContent

		Vector3 = var_1_10003
		var_14_0.localScale = var_1_10003(1, 1, 1)
		setActive = var_14_0

		var_14_0(arg_14_0._textTf, false)

		setActive = var_14_0

		var_14_0(arg_14_0._bgTf, false)
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
	local var_19_0 = {}

	for iter_19_0 = 1, #arg_19_0._iconTfs do
		local var_19_1 = arg_19_0._iconTfs[iter_19_0]

		isActive = var_1_10007

		if var_1_10007(var_19_1) then
			table = var_1_10007

			var_1_10007.insert(var_19_0, var_19_1.position)
		end
	end

	return var_19_0
end

function var_0_0.setDraging(arg_20_0, arg_20_1)
	arg_20_0._draging = arg_20_1

	arg_20_0:updateAlpha()

	return
end

function var_0_0.updateAlpha(arg_21_0)
	if arg_21_0._draging or arg_21_0._count == 0 then
		arg_21_0._canvasGroup.alpha = 0.5
	else
		arg_21_0._canvasGroup.alpha = 1
	end

	if arg_21_0._count == 0 then
		setGray = var_1

		var_1(arg_21_0._tf, true, true)
	else
		setGray = var_1

		var_1(arg_21_0._tf, false, true)
	end

	return
end

function var_0_0.clear(arg_22_0)
	for iter_22_0 = 1, #arg_22_0._iconTfs do
		setActive = var_1_10005

		var_1_10005(arg_22_0._iconTfs[iter_22_0], false)
	end

	return
end

function var_0_0.dispose(arg_23_0)
	if arg_23_0._eventTrigger then
		ClearEventTrigger = var_1

		var_1(arg_23_0._eventTrigger)
	end

	return
end

return var_0_0
