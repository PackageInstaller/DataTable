local IslandMapContainer = class("IslandMapContainer")

function IslandMapContainer:Ctor(arg_1_1, arg_1_2)
	self._parent = arg_1_1
	self._event = arg_1_2
	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	self._eventTriggers = {}
	self._scaleRate = 1

	return
end

function IslandMapContainer:loadMap(arg_2_1)
	self._mapId = arg_2_1

	self:clear()
	self:updateMap()
	self:updatePart()
	self:updateDragBound()

	return
end

function IslandMapContainer:updateMap()
	self._mapTf = findTF(self._parent, "island_map_1")

	self:addTfListenerMove(self._mapTf)

	return
end

function IslandMapContainer:updatePart()
	self.partItems = {}

	local var_4_0 = findTF(self._mapTf, "part")

	for iter_4_0 = 1, var_4_0.childCount do
		local var_4_1 = var_4_0:GetChild(iter_4_0 - 1)

		GetComponent(findTF(var_4_1, "click/img"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		self:addTfListenerMove(var_4_1, function()
			self:focusIn((self._uiCamera:WorldToScreenPoint(var_4_1.position)))

			return
		end)
		table.insert(self.partItems, var_4_1)
	end

	return
end

function IslandMapContainer:updateDragBound()
	self._screenSize = pg.UIMgr.GetInstance().uiCamera.gameObject.transform:Find("Canvas").sizeDelta

	local var_6_0 = math.abs(self._screenSize.x / 2 - self._mapTf.sizeDelta.x * self._scaleRate / 2)
	local var_6_1 = math.abs(self._screenSize.y / 2 - self._mapTf.sizeDelta.y * self._scaleRate / 2)

	self._dragBounds = {
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

function IslandMapContainer:addTfListenerMove(arg_7_1, arg_7_2)
	local var_7_0 = GetOrAddComponent(arg_7_1, typeof(EventTriggerListener))

	self._eventDownTime = 0
	self._eventDownPosition = nil

	var_7_0:AddPointDownFunc(function(arg_8_0, arg_8_1)
		self._eventDownTime = Time.GetTimestamp()
		self._eventDownPosition = arg_8_1.position

		return
	end)
	var_7_0:AddPointUpFunc(function(arg_9_0, arg_9_1)
		if Time.GetTimestamp() - self._eventDownTime < 0.25 and self._eventDownPosition and math.abs(arg_9_1.position.x - self._eventDownPosition.x) < 25 and math.abs(arg_9_1.position.y - self._eventDownPosition.y) < 25 then
			if arg_7_2 then
				arg_7_2(arg_9_1)
			else
				self:focusIn(arg_9_1.position)
			end
		end

		return
	end)
	var_7_0:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		self.startPosition = arg_10_1.position

		return
	end)
	var_7_0:AddDragFunc(function(arg_11_0, arg_11_1)
		if self.startPosition then
			self:moveMap({
				arg_11_1.position.x - self.startPosition.x,
				arg_11_1.position.y - self.startPosition.y
			})

			self.startPosition = arg_11_1.position
		end

		self._eventDownTime = 0

		return
	end)
	var_7_0:AddDragEndFunc(function(arg_12_0, arg_12_1)
		self.startPosition = nil

		return
	end)
	table.insert(self._eventTriggers, var_7_0)

	return
end

function IslandMapContainer:checkPointPart(arg_13_1)
	local var_13_0 = self._uiCamera:ScreenToWorldPoint(arg_13_1)

	return
end

function IslandMapContainer:moveMap(arg_14_1)
	if self._inMovingTime then
		return
	end

	if not arg_14_1 then
		return
	end

	if not self._mapTf then
		return
	end

	local var_14_0 = self._mapTf.anchoredPosition

	var_14_0.x = self._mapTf.anchoredPosition.x + arg_14_1[1] * self._scaleRate
	var_14_0.y = var_14_0.y + arg_14_1[2] * self._scaleRate

	self:fixedV2Position(var_14_0)

	self._mapTf.anchoredPosition = var_14_0

	return
end

function IslandMapContainer:setScale(arg_15_1)
	if self._inMovingTime then
		return
	end

	self._inMovingTime = true

	LeanTween.scale(go(self._mapTf), Vector3(arg_15_1, arg_15_1, arg_15_1), 0.4):setOnUpdate(System.Action_float(function(arg_16_0)
		return
	end)):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		self._scaleRate = arg_15_1
		self._mapTf.localScale = Vector3(arg_15_1, arg_15_1, arg_15_1)

		self:updateDragBound()
		self:fixedV2Position(self._mapTf.anchoredPosition)

		self._mapTf.anchoredPosition = self._mapTf.anchoredPosition
		self._inMovingTime = false

		return
	end))

	return
end

function IslandMapContainer:scaleMap()
	return
end

function IslandMapContainer:fixedV2Position(arg_19_1)
	arg_19_1.x = math.max(self._dragBounds[1][1], arg_19_1.x)
	arg_19_1.x = math.min(self._dragBounds[1][2], arg_19_1.x)
	arg_19_1.y = math.max(self._dragBounds[2][1], arg_19_1.y)
	arg_19_1.y = math.min(self._dragBounds[2][2], arg_19_1.y)

	return
end

function IslandMapContainer:fixedV3Position(arg_20_1)
	arg_20_1.x = math.max(self._dragBounds[1][1], arg_20_1.x)
	arg_20_1.x = math.min(self._dragBounds[1][2], arg_20_1.x)
	arg_20_1.y = math.max(self._dragBounds[2][1], arg_20_1.y)
	arg_20_1.y = math.min(self._dragBounds[2][2], arg_20_1.y)

	return
end

function IslandMapContainer:focusIn(arg_21_1)
	if self._inMovingTime then
		return
	end

	self._inMovingTime = true

	local var_21_0 = self:getScreenCenter()

	self:setMoveTo((Vector3(self._mapTf.anchoredPosition.x + (var_21_0.x - arg_21_1.x), self._mapTf.anchoredPosition.y + (var_21_0.y - arg_21_1.y), 0)))

	return
end

function IslandMapContainer:setMoveTo(arg_22_1)
	if LeanTween.isTweening(go(self._mapTf)) then
		return
	end

	self:fixedV3Position(arg_22_1)
	LeanTween.moveLocal(go(self._mapTf), arg_22_1, 0.4):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		self._inMovingTime = false

		return
	end))

	return
end

function IslandMapContainer:getScreenCenter()
	return Vector2(self._screenSize.x / 2, self._screenSize.y / 2)
end

function IslandMapContainer:clear()
	for iter_25_0 = 1, #self._eventTriggers do
		ClearEventTrigger(self._eventTriggers[iter_25_0])
	end

	self._eventTriggers = {}

	return
end

function IslandMapContainer:dispose()
	self:clear()

	if LeanTween.isTweening(go(self._mapTf)) then
		LeanTween.cancel(go(self._mapTf))
	end

	return
end

return IslandMapContainer
