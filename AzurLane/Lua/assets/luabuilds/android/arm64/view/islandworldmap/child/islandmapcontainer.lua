local var_0_0 = class("IslandMapContainer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._parent = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
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
	arg_3_0._mapTf = findTF(arg_3_0._parent, "island_map_1")

	arg_3_0:addTfListenerMove(arg_3_0._mapTf)

	return
end

function var_0_0.updatePart(arg_4_0)
	arg_4_0.partItems = {}

	local var_4_0 = findTF(arg_4_0._mapTf, "part")

	for iter_4_0 = 1, var_4_0.childCount do
		local var_4_1 = var_4_0:GetChild(iter_4_0 - 1)

		GetComponent(findTF(var_4_1, "click/img"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		arg_4_0:addTfListenerMove(var_4_1, function()
			arg_4_0:focusIn((arg_4_0._uiCamera:WorldToScreenPoint(var_4_1.position)))

			return
		end)
		table.insert(arg_4_0.partItems, var_4_1)
	end

	return
end

function var_0_0.updateDragBound(arg_6_0)
	arg_6_0._screenSize = pg.UIMgr.GetInstance().uiCamera.gameObject.transform:Find("Canvas").sizeDelta

	local var_6_0 = math.abs(arg_6_0._screenSize.x / 2 - arg_6_0._mapTf.sizeDelta.x * arg_6_0._scaleRate / 2)
	local var_6_1 = math.abs(arg_6_0._screenSize.y / 2 - arg_6_0._mapTf.sizeDelta.y * arg_6_0._scaleRate / 2)

	arg_6_0._dragBounds = {
		{
			-var_6_0,
			var_6_0
		},
		{
			-var_6_1,
			var_6_1
		}
	}

	return
end

function var_0_0.addTfListenerMove(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = GetOrAddComponent(arg_7_1, typeof(EventTriggerListener))

	arg_7_0._eventDownTime = 0
	arg_7_0._eventDownPosition = nil

	var_7_0:AddPointDownFunc(function(arg_8_0, arg_8_1)
		arg_7_0._eventDownTime = Time.GetTimestamp()
		arg_7_0._eventDownPosition = arg_8_1.position

		return
	end)
	var_7_0:AddPointUpFunc(function(arg_9_0, arg_9_1)
		if Time.GetTimestamp() - arg_7_0._eventDownTime < 0.25 and arg_7_0._eventDownPosition and math.abs(arg_9_1.position.x - arg_7_0._eventDownPosition.x) < 25 and math.abs(arg_9_1.position.y - arg_7_0._eventDownPosition.y) < 25 then
			if arg_7_2 then
				arg_7_2(arg_9_1)
			else
				arg_7_0:focusIn(arg_9_1.position)
			end
		end

		return
	end)
	var_7_0:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		arg_7_0.startPosition = arg_10_1.position

		return
	end)
	var_7_0:AddDragFunc(function(arg_11_0, arg_11_1)
		if arg_7_0.startPosition then
			arg_7_0:moveMap({
				arg_11_1.position.x - arg_7_0.startPosition.x,
				arg_11_1.position.y - arg_7_0.startPosition.y
			})

			arg_7_0.startPosition = arg_11_1.position
		end

		arg_7_0._eventDownTime = 0

		return
	end)
	var_7_0:AddDragEndFunc(function(arg_12_0, arg_12_1)
		arg_7_0.startPosition = nil

		return
	end)
	table.insert(arg_7_0._eventTriggers, var_7_0)

	return
end

function var_0_0.checkPointPart(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._uiCamera:ScreenToWorldPoint(arg_13_1)

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

	local var_14_0 = arg_14_0._mapTf.anchoredPosition

	var_14_0.x = arg_14_0._mapTf.anchoredPosition.x + arg_14_1[1] * arg_14_0._scaleRate
	var_14_0.y = var_14_0.y + arg_14_1[2] * arg_14_0._scaleRate

	arg_14_0:fixedV2Position(var_14_0)

	arg_14_0._mapTf.anchoredPosition = var_14_0

	return
end

function var_0_0.setScale(arg_15_0, arg_15_1)
	if arg_15_0._inMovingTime then
		return
	end

	arg_15_0._inMovingTime = true

	LeanTween.scale(go(arg_15_0._mapTf), Vector3(arg_15_1, arg_15_1, arg_15_1), 0.4):setOnUpdate(System.Action_float(function(arg_16_0)
		return
	end)):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		arg_15_0._scaleRate = arg_15_1
		arg_15_0._mapTf.localScale = Vector3(arg_15_1, arg_15_1, arg_15_1)

		arg_15_0:updateDragBound()
		arg_15_0:fixedV2Position(arg_15_0._mapTf.anchoredPosition)

		arg_15_0._mapTf.anchoredPosition = arg_15_0._mapTf.anchoredPosition
		arg_15_0._inMovingTime = false

		return
	end))

	return
end

function var_0_0.scaleMap(arg_18_0)
	return
end

function var_0_0.fixedV2Position(arg_19_0, arg_19_1)
	arg_19_1.x = math.max(arg_19_0._dragBounds[1][1], arg_19_1.x)
	arg_19_1.x = math.min(arg_19_0._dragBounds[1][2], arg_19_1.x)
	arg_19_1.y = math.max(arg_19_0._dragBounds[2][1], arg_19_1.y)
	arg_19_1.y = math.min(arg_19_0._dragBounds[2][2], arg_19_1.y)

	return
end

function var_0_0.fixedV3Position(arg_20_0, arg_20_1)
	arg_20_1.x = math.max(arg_20_0._dragBounds[1][1], arg_20_1.x)
	arg_20_1.x = math.min(arg_20_0._dragBounds[1][2], arg_20_1.x)
	arg_20_1.y = math.max(arg_20_0._dragBounds[2][1], arg_20_1.y)
	arg_20_1.y = math.min(arg_20_0._dragBounds[2][2], arg_20_1.y)

	return
end

function var_0_0.focusIn(arg_21_0, arg_21_1)
	if arg_21_0._inMovingTime then
		return
	end

	arg_21_0._inMovingTime = true

	local var_21_0 = arg_21_0:getScreenCenter()

	arg_21_0:setMoveTo((Vector3(arg_21_0._mapTf.anchoredPosition.x + (var_21_0.x - arg_21_1.x), arg_21_0._mapTf.anchoredPosition.y + (var_21_0.y - arg_21_1.y), 0)))

	return
end

function var_0_0.setMoveTo(arg_22_0, arg_22_1)
	if LeanTween.isTweening(go(arg_22_0._mapTf)) then
		return
	end

	arg_22_0:fixedV3Position(arg_22_1)
	LeanTween.moveLocal(go(arg_22_0._mapTf), arg_22_1, 0.4):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		arg_22_0._inMovingTime = false

		return
	end))

	return
end

function var_0_0.getScreenCenter(arg_24_0)
	return Vector2(arg_24_0._screenSize.x / 2, arg_24_0._screenSize.y / 2)
end

function var_0_0.clear(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._eventTriggers do
		ClearEventTrigger(arg_25_0._eventTriggers[iter_25_0])
	end

	arg_25_0._eventTriggers = {}

	return
end

function var_0_0.dispose(arg_26_0)
	arg_26_0:clear()

	if LeanTween.isTweening(go(arg_26_0._mapTf)) then
		LeanTween.cancel(go(arg_26_0._mapTf))
	end

	return
end

return var_0_0
