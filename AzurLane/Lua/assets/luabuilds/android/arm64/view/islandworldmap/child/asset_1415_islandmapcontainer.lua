class = var_0_10000

local var_0_0 = var_0_10000("IslandMapContainer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._parent = arg_1_1
	arg_1_0._event = arg_1_2
	GameObject = var_1_10003

	local var_1_0 = var_1_10003.Find("UICamera")
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10006
	Camera = var_1_10008
	arg_1_0._uiCamera = var_1_1(var_1_0, var_1_10006(var_1_10008))
	arg_1_0._eventTriggers = {}
	arg_1_0._scaleRate = 1

	return
end

function var_0_0.loadMap(arg_2_0, arg_2_1)
	arg_2_0._mapId = arg_2_1

	arg_2_0:clear()
	arg_2_0:updateMap()
	arg_2_0:updatePart()
	arg_2_0:updateDragBound()

	return
end

function var_0_0.updateMap(arg_3_0)
	findTF = var_1_10001
	arg_3_0._mapTf = var_1_10001(arg_3_0._parent, "island_map_1")

	arg_3_0:addTfListenerMove(arg_3_0._mapTf)

	return
end

function var_0_0.updatePart(arg_4_0)
	arg_4_0.partItems = {}
	findTF = var_1

	local var_4_0 = var_1(arg_4_0._mapTf, "part").childCount

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = var_1:GetChild(iter_4_0 - 1)

		GetComponent = var_1_10008
		findTF = var_10

		local var_4_2 = var_10(var_4_1, "click/img")

		typeof = var_1_10011
		Image = var_13
		var_1_10008 = var_1_10008(var_4_2, var_1_10011(var_13))
		var_1_10008.alphaHitTestMinimumThreshold = 0.5
		var_1_10011 = arg_4_0

		arg_4_0.addTfListenerMove(var_1_10011, var_4_1, function()
			local var_5_0 = arg_4_0._uiCamera
			local var_5_1 = var_0.WorldToScreenPoint(var_5_0, var_4_1.position)
			local var_5_2 = arg_4_0

			var_1.focusIn(var_5_2, var_5_1)

			return
		end)

		table = var_9

		var_9.insert(arg_4_0.partItems, var_4_1)
	end

	return
end

function var_0_0.updateDragBound(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance().uiCamera.gameObject.transform

	arg_6_0._screenSize = var_1.Find(var_6_0, "Canvas").sizeDelta
	math = var_2

	local var_6_1 = var_2.abs(arg_6_0._screenSize.x / 2 - arg_6_0._mapTf.sizeDelta.x * arg_6_0._scaleRate / 2)

	math = var_6_0

	local var_6_2 = var_6_0.abs(arg_6_0._screenSize.y / 2 - arg_6_0._mapTf.sizeDelta.y * arg_6_0._scaleRate / 2)

	arg_6_0._dragBounds = {
		{
			-var_6_1,
			var_6_1
		},
		{
			-var_6_2,
			var_6_2
		}
	}

	return
end

function var_0_0.addTfListenerMove(arg_7_0, arg_7_1, arg_7_2)
	GetOrAddComponent = var_1_10003

	local var_7_0 = arg_7_1

	typeof = var_1_10006
	EventTriggerListener = var_1_10008

	local var_7_1 = var_1_10003(var_7_0, var_1_10006(var_1_10008))

	arg_7_0._eventDownTime = 0
	arg_7_0._eventDownPosition = nil

	var_7_1:AddPointDownFunc(function(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_0

		Time = var_2_10003
		var_8_0._eventDownTime = var_2_10003.GetTimestamp()
		arg_7_0._eventDownPosition = arg_8_1.position

		return
	end)
	var_7_1:AddPointUpFunc(function(arg_9_0, arg_9_1)
		Time = var_2_10002

		if var_2_10002.GetTimestamp() - arg_7_0._eventDownTime < 0.25 and arg_7_0._eventDownPosition then
			math = var_4

			if var_4.abs(arg_9_1.position.x - arg_7_0._eventDownPosition.x) < 25 then
				math = var_4

				if var_4.abs(arg_9_1.position.y - arg_7_0._eventDownPosition.y) < 25 then
					if arg_7_2 then
						arg_7_2(arg_9_1)
					else
						local var_9_0 = arg_7_0

						var_4.focusIn(var_9_0, arg_9_1.position)
					end
				end
			end
		end

		return
	end)
	var_7_1:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		arg_7_0.startPosition = arg_10_1.position

		return
	end)
	var_7_1:AddDragFunc(function(arg_11_0, arg_11_1)
		if arg_7_0.startPosition then
			local var_11_0 = {
				arg_11_1.position.x - arg_7_0.startPosition.x,
				arg_11_1.position.y - arg_7_0.startPosition.y
			}
			local var_11_1 = arg_7_0

			var_3.moveMap(var_11_1, var_11_0)

			arg_7_0.startPosition = arg_11_1.position
		end

		arg_7_0._eventDownTime = 0

		return
	end)
	var_7_1:AddDragEndFunc(function(arg_12_0, arg_12_1)
		arg_7_0.startPosition = nil

		return
	end)

	table = var_4

	var_4.insert(arg_7_0._eventTriggers, var_7_1)

	return
end

function var_0_0.checkPointPart(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._uiCamera
	local var_13_1 = var_2.ScreenToWorldPoint(var_13_0, arg_13_1)

	return
end

function var_0_0.moveMap(arg_14_0, arg_14_1)
	if arg_14_0._inMovingTime then
		return
	end

	if not arg_14_1 then
		return
	end

	if not arg_14_0._mapTf then
		return
	end

	var_2.x = arg_14_0._mapTf.anchoredPosition.x + arg_14_1[1] * arg_14_0._scaleRate
	var_2.y = var_2.y + arg_14_1[2] * arg_14_0._scaleRate

	arg_14_0:fixedV2Position(var_2)

	arg_14_0._mapTf.anchoredPosition = var_2

	return
end

function var_0_0.setScale(arg_15_0, arg_15_1)
	if arg_15_0._inMovingTime then
		return
	end

	arg_15_0._inMovingTime = true
	LeanTween = var_2

	local var_15_0 = var_2.scale

	go = var_1_10004

	local var_15_1 = var_1_10004(arg_15_0._mapTf)

	Vector3 = var_1_10005

	local var_15_2 = var_15_0(var_15_1, var_1_10005(arg_15_1, arg_15_1, arg_15_1), 0.4)
	local var_15_3 = var_2.setOnUpdate

	System = var_5

	local var_15_4 = var_15_3(var_15_2, var_5.Action_float(function(arg_16_0)
		return
	end))
	local var_15_5 = var_2.setEase

	LeanTweenType = var_5

	local var_15_6 = var_15_5(var_15_4, var_5.easeInOutSine)
	local var_15_7 = var_2.setOnComplete

	System = var_5

	var_15_7(var_15_6, var_5.Action(function()
		arg_15_0._scaleRate = arg_15_1

		local var_17_0 = arg_15_0._mapTf

		Vector3 = var_1
		var_17_0.localScale = var_1(arg_15_1, arg_15_1, arg_15_1)

		local var_17_1 = arg_15_0

		var_0.updateDragBound(var_17_1)

		local var_17_2 = arg_15_0._mapTf.anchoredPosition
		local var_17_3 = arg_15_0

		var_1.fixedV2Position(var_17_3, var_17_2)

		arg_15_0._mapTf.anchoredPosition = var_17_2
		arg_15_0._inMovingTime = false

		return
	end))

	return
end

function var_0_0.scaleMap(arg_18_0)
	return
end

function var_0_0.fixedV2Position(arg_19_0, arg_19_1)
	math = var_1_10002
	arg_19_1.x = var_1_10002.max(arg_19_0._dragBounds[1][1], arg_19_1.x)
	math = var_2
	arg_19_1.x = var_2.min(arg_19_0._dragBounds[1][2], arg_19_1.x)
	math = var_2
	arg_19_1.y = var_2.max(arg_19_0._dragBounds[2][1], arg_19_1.y)
	math = var_2
	arg_19_1.y = var_2.min(arg_19_0._dragBounds[2][2], arg_19_1.y)

	return
end

function var_0_0.fixedV3Position(arg_20_0, arg_20_1)
	math = var_1_10002
	arg_20_1.x = var_1_10002.max(arg_20_0._dragBounds[1][1], arg_20_1.x)
	math = var_2
	arg_20_1.x = var_2.min(arg_20_0._dragBounds[1][2], arg_20_1.x)
	math = var_2
	arg_20_1.y = var_2.max(arg_20_0._dragBounds[2][1], arg_20_1.y)
	math = var_2
	arg_20_1.y = var_2.min(arg_20_0._dragBounds[2][2], arg_20_1.y)

	return
end

function var_0_0.focusIn(arg_21_0, arg_21_1)
	if arg_21_0._inMovingTime then
		return
	end

	arg_21_0._inMovingTime = true

	local var_21_0 = arg_21_0._mapTf.anchoredPosition
	local var_21_1 = arg_21_0:getScreenCenter()

	Vector3 = var_1_10004

	local var_21_2 = var_1_10004(var_21_0.x + (var_21_1.x - arg_21_1.x), var_21_0.y + (var_21_1.y - arg_21_1.y), 0)

	arg_21_0:setMoveTo(var_21_2)

	return
end

function var_0_0.setMoveTo(arg_22_0, arg_22_1)
	LeanTween = var_1_10002

	local var_22_0 = var_1_10002.isTweening

	go = var_1_10004

	if var_22_0(var_1_10004(arg_22_0._mapTf)) then
		return
	end

	local var_22_1 = arg_22_0

	arg_22_0.fixedV3Position(var_22_1, arg_22_1)

	LeanTween = var_2

	local var_22_2 = var_2.moveLocal

	go = var_22_1

	local var_22_3 = var_22_2(var_22_1(arg_22_0._mapTf), arg_22_1, 0.4)
	local var_22_4 = var_2.setEase

	LeanTweenType = var_5

	local var_22_5 = var_22_4(var_22_3, var_5.easeInOutSine)
	local var_22_6 = var_2.setOnComplete

	System = var_5

	var_22_6(var_22_5, var_5.Action(function()
		arg_22_0._inMovingTime = false

		return
	end))

	return
end

function var_0_0.getScreenCenter(arg_24_0)
	Vector2 = var_1_10001

	return var_1_10001(arg_24_0._screenSize.x / 2, arg_24_0._screenSize.y / 2)
end

function var_0_0.clear(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._eventTriggers do
		ClearEventTrigger = var_1_10005

		var_1_10005(arg_25_0._eventTriggers[iter_25_0])
	end

	arg_25_0._eventTriggers = {}

	return
end

function var_0_0.dispose(arg_26_0)
	local var_26_0 = arg_26_0

	arg_26_0.clear(var_26_0)

	LeanTween = var_1

	local var_26_1 = var_1.isTweening

	go = var_26_0

	if var_26_1(var_26_0(arg_26_0._mapTf)) then
		LeanTween = var_1

		local var_26_2 = var_1.cancel

		go = var_3

		var_26_2(var_3(arg_26_0._mapTf))
	end

	return
end

return var_0_0
