-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomMapDistributionView.lua

module("logic.extensions.housemain.view.RoomMapDistributionView", package.seeall)

local M = class("RoomMapDistributionView", ViewComponent)
local kMaxMoveX = 480
local kMaxMoveY = 650
local kDragSpeed = 1
local kOrgScaleVal = 0.64

M.MinMapScale = 0.5
M.MaxMapScale = 1.67
M.MiddleMapScale = 1

function M:ctor(compContainer)
	M.super.ctor(self)

	self._go = compContainer.gameObject
end

function M:buildUI()
	self._goMapRoot = self:getGo("5&room_map_distribution_view_-1932059756")
	self._goDrag = self:getGo("5&room_map_distribution_view_1907099344")
	self._goRoomRoot = self:getRectTransform("5&room_map_distribution_view_-900576721")
	self._compositeTouch = UICompositeTouch.Get(self._goDrag)

	local DragTouchChecker = DragTouchChecker.New()

	DragTouchChecker:SetBeginDragListener(self._onBeginDrag, self)
	DragTouchChecker:SetDragListener(self._onDrag, self)
	DragTouchChecker:SetEndDragListener(self._onEndDrag, self)

	local MultiTouchChecker = MultiTouchChecker.New()

	MultiTouchChecker:AddMultiDragListener(self.onMultiDragListener, self)
	self._compositeTouch:AddChecker(MultiTouchChecker)
	self._compositeTouch:AddChecker(DragTouchChecker)
end

function M:OnDestroy()
	self._go = nil
	self._goDrag = nil
	self._goRoomRoot = nil

	for _roomTyp, typLst in pairs(self._cellItem or {}) do
		for _roomId, cell in pairs(typLst or {}) do
			cell:destroyUI()
		end
	end

	self._cellItem = nil
	self._posInfo = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = false
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for _roomTyp, typLst in pairs(self._cellItem or {}) do
		for _roomId, cell in pairs(typLst or {}) do
			cell:unbindEvents()
		end
	end
end

function M:onEnter()
	self:setEvent(true)

	self._cellItem = {}
	self._posInfo = {
		maxPosX = kMaxMoveX,
		maxPosY = kMaxMoveY,
		orgScaleVal = kOrgScaleVal
	}

	goutil.setActive(self._goDrag, true)

	self._singleDragingId = -999
	self._isMultiDraging = false
	self._beginDragPos = Vector2.New()
	self._originMapPos = Vector2.New()

	self:_updateRoomUI()
	self:showUpLastScene()

	self._inConstructMode = true
end

function M:onExit()
	self:leavePage()

	for _roomTyp, typLst in pairs(self._cellItem or {}) do
		for _roomId, cell in pairs(typLst or {}) do
			cell:onExit()
		end
	end
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:leavePage()
	self:setEvent(false)

	self._inConstructMode = false
	self._isMultiDraging = false
	self._singleDragingId = -999
end

function M:getNowScale()
	return self._nowScaleVal
end

function M:showUpLastScene()
	local posX, posY = HouseModel.instance:getLastRoomMapPos()

	Astral.TransformUtil.SetLocalPos(self._goMapRoot.transform, posX, posY, 0)

	local lastScale = HouseModel.instance:getLastRoomMapScale()
	local needTween = not lastScale or lastScale < kOrgScaleVal

	if needTween then
		self:_tweenToScale(M.MinMapScale, kOrgScaleVal, 0.3)
	else
		self._nowScaleVal = HouseModel.instance:getLastRoomMapScale() or kOrgScaleVal

		self:_updateScaleMapShow()
	end
end

function M:handleHouseHoldRoomInfoChange()
	self:_refreshRoomTypCell(HouseEnum.RoomType.Shelter)
end

function M:handleHouseHarvestReportNumChange()
	self:_refreshRoomTypCell(HouseEnum.RoomType.Supervisor)
	self:_refreshRoomTypCell(HouseEnum.RoomType.Manufacturing)
end

function M:handleHouseBackLogNumChange()
	self:_refreshRoomTypCell(HouseEnum.RoomType.Trading)
end

function M:handleLiveZoneActive(zoneId)
	local roomZoneCo = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)
	local roomTyp = roomZoneCo.roomType

	if self._cellItem and self._cellItem[roomTyp] and self._cellItem[roomTyp][zoneId] then
		self._cellItem[roomTyp][zoneId]:reflashData()
	end
end

function M:_refreshRoomTypCell(roomTyp)
	if self._cellItem then
		for _roomId, cell in pairs(self._cellItem[roomTyp] or {}) do
			cell:reflashData()
		end
	end
end

function M:_updateRoomUI()
	for i = 0, self._goRoomRoot.childCount - 1 do
		local tmpRoom = self._goRoomRoot:GetChild(i)
		local roomId = self:_splitGetRoomId(tmpRoom.gameObject.name)
		local roomZoneCo = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
		local roomTyp = roomZoneCo.roomType
		local shower = Astral.LuaComponentContainer.Get(tmpRoom.gameObject, self:_getRoomItemCellClass(roomTyp))

		if shower == nil then
			shower = Astral.LuaComponentContainer.Add(tmpRoom.gameObject, self:_getRoomItemCellClass(roomTyp))

			shower:buildUI()
			shower:bindEvents()
			shower:onEnter()
		end

		shower:setHandler(self)
		shower:setData(roomZoneCo)

		if not self._cellItem[roomTyp] then
			self._cellItem[roomTyp] = {}
		end

		self._cellItem[roomTyp][roomId] = shower
	end
end

function M:_getRoomItemCellClass(roomTyp)
	local _roomTypDefine = HouseEnum.RoomType

	if roomTyp == _roomTypDefine.Supervisor then
		return RoomDistributionItemSupervisor
	elseif roomTyp == _roomTypDefine.Trading then
		return RoomDistributionItemTrading
	elseif roomTyp == _roomTypDefine.Manufacturing then
		return RoomDistributionItemManufacturing
	elseif roomTyp == _roomTypDefine.Shelter then
		return RoomDistributionItemShelter
	elseif roomTyp == _roomTypDefine.Living then
		return RoomDistributionItemLiving
	else
		return RoomDistributionItemLiving
	end
end

function M:_splitGetRoomId(objName)
	local t = {}

	for item in string.gmatch(objName, "%d+") do
		table.insert(t, item)
	end

	return tonumber(t[1])
end

function M:_setBigMapPos(posX, posY)
	local scale = self._nowScaleVal
	local absPosX = kMaxMoveX * scale
	local absPosY = kMaxMoveY * scale

	posX = math.min(absPosX, math.max(absPosX * -1, posX))
	posY = math.min(absPosY, math.max(absPosY * -1, posY))

	Astral.TransformUtil.SetLocalPos(self._goMapRoot.transform, posX, posY, 0)
	HouseModel.instance:setLastRoomMapPos(posX, posY)

	local rectScale = Astral.TransformUtil.GetLocalScale(self._goMapRoot.transform, 0, 0, 0)

	self._posInfo.scale = (rectScale - self.MinMapScale) / (self.MaxMapScale - self.MinMapScale)
	self._posInfo.posX = posX
	self._posInfo.posY = posY

	HouseDispatcher:dispatchEvent(HouseEventType.ON_MAIN_ROOM_MAP_POS_CHANGE, self._posInfo)
end

function M:_onBeginDrag2(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if self._singleDragingId > 0 or self._isMultiDraging then
		return
	end

	self._singleDragingId = pointerId

	self._beginDragPos:Set(position.x, position.y)

	local mapPosX, mapPosY = Astral.TransformUtil.GetLocalPos(self._goMapRoot.transform, 0, 0, 0)

	self._originMapPos:Set(mapPosX, mapPosY)
end

function M:_onBeginDrag(x, y)
	if self._isMultiDraging then
		return
	end

	self._beginDragPos:Set(x, y)

	local mapPosX, mapPosY = Astral.TransformUtil.GetLocalPos(self._goMapRoot.transform, 0, 0, 0)

	self._originMapPos:Set(mapPosX, mapPosY)
end

function M:_onDrag2(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if pointerId == self._singleDragingId and not self._isMultiDraging then
		local deltaX = position.x - self._beginDragPos.x
		local deltaY = position.y - self._beginDragPos.y
		local offsetX = deltaX * kDragSpeed
		local offsetY = deltaY * kDragSpeed
		local posX = self._originMapPos.x + offsetX
		local posY = self._originMapPos.y + offsetY

		self:_setBigMapPos(posX, posY)
	end
end

function M:_onDrag(x, y)
	if not self._isMultiDraging then
		local deltaX = x - self._beginDragPos.x
		local deltaY = y - self._beginDragPos.y
		local offsetX = deltaX * kDragSpeed
		local offsetY = deltaY * kDragSpeed
		local posX = self._originMapPos.x + offsetX
		local posY = self._originMapPos.y + offsetY

		self:_setBigMapPos(posX, posY)
	end
end

function M:_onEndDrag2(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if pointerId == self._singleDragingId then
		self._singleDragingId = -999
	end

	self._isMultiDraging = false
end

function M:_onEndDrag(x, y)
	self._isMultiDraging = false
end

function M:onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	if self._inConstructMode then
		self._isMultiDraging = true
		self._singleDragingId = -999

		local deltaDis = math.abs(distance * (scale - 1))
		local originMapScale = self._nowScaleVal
		local mapScale = originMapScale
		local scaleSpeed = 0.002

		if scale > 1 then
			mapScale = originMapScale + deltaDis * scaleSpeed
		elseif scale < 1 then
			mapScale = originMapScale - deltaDis * scaleSpeed
		end

		mapScale = math.min(1, math.max(0, mapScale))
		self._nowScaleVal = mapScale

		HouseModel.instance:setLastRoomMapScale(self._nowScaleVal)
		self:_updateScaleMapShow()
	end
end

function M:_updateScaleMapShow()
	local scale = (self.MaxMapScale - self.MinMapScale) * self._nowScaleVal + self.MinMapScale

	Astral.TransformUtil.SetLocalScale(self._goMapRoot.transform, scale, scale, 1)

	local mapPosX, mapPosY = Astral.TransformUtil.GetLocalPos(self._goMapRoot.transform, 0, 0, 0)

	self:_setBigMapPos(mapPosX, mapPosY)
end

function M:_tweenToScale(beginScale, endScale, duration)
	self._nowScaleVal = beginScale

	self:_updateScaleMapShow()
	TweenNumberUtils.FloatToWithGetter(endScale, duration, self.getNowScale, function(handler, val)
		self._nowScaleVal = val

		HouseModel.instance:setLastRoomMapScale(val)
		self:_updateScaleMapShow()
	end, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
end

return M
