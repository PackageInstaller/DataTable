-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/map/HouseMapView.lua

module("logic.extensions.house.view.map.HouseMapView", package.seeall)

local M = class("HouseMapView", ViewComponent)
local kSmallMapPosX = -27
local kMaxMoveX = 480
local kMaxMoveY = 480
local kDragSpeed = 1
local kBigMapOpenSlider = 1
local kAnimNameOpen = "open"
local kAnimNameClose = "close"
local kCloseTagName = "close_end"

M.MinMapScale = 0.71
M.MaxMapScale = 1.58
M.MiddleMapScale = 1.1

function M:buildUI()
	self._goSmallMapMask = self:getGo("room_main_view_2133202356")

	local smallMapClickGO = self:getGo("room_main_view_141298616")

	self._clickSmallMap = Astral.UIClickTrigger.Get(smallMapClickGO)
	self._txtCurArea = self:getText("room_main_view_-864816304")
	self._goRoot = self:getResInstance(ResName.Room_room_map_view)
	self._MapRegistry = ViewElementsRegistry.New(self._goRoot)

	goutil.addChildToParent(self._goRoot, self.mainGO)

	self._rectTrBlur = goutil.findChildComponent(self._goRoot, "common_blur_rt", UIComponentType.RectTransform)
	self._guiAnimation = self._goRoot:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._goBigMapToAdd = self._MapRegistry:findUIElement("room_map_view_-1467451149")
	self._goMapRoot = self._MapRegistry:findUIElement("room_map_view_1935108633")
	self._mapPanel = Astral.LuaComponentContainer.Add(self._goMapRoot, HouseMapPanel)

	self._mapPanel:setPresentor(self._viewPresentor)

	self._btnClose = UIComponentType.ButtonAdapter(self._MapRegistry:findUIElement("room_map_view_-934605567"))
	self._sliderScale = self._MapRegistry:findUIElement("room_map_view_510258795", UIComponentType.SliderAdapter)
	self._goDrag = self._MapRegistry:findUIElement("room_map_view_-1909688483")
	self._dragTrigger = Astral.UIDragTrigger.Get(self._goDrag)
	self._compositeTouch = UICompositeTouch.Get(self._goDrag)

	local multiTouch = MultiTouchChecker.New()

	multiTouch:AddMultiDragListener(self._onMultiDragListener, self)
	self._compositeTouch:AddChecker(multiTouch)

	self._goRoomsRoot = self._MapRegistry:findUIElement("room_map_view_902970274")
	self._dictMapRoom = {}

	local zoneCOs = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	for _, zoneCO in ipairs(zoneCOs) do
		local roomId = zoneCO.id
		local zoneType = NavMeshUtil.getZoneTypeByZoneId(roomId)

		if zoneType == HouseEnum.ZoneType.Room then
			local roomGO = goutil.findChild(self._goRoomsRoot, string.format("room_%s", roomId))

			if roomGO then
				local mapRoom = Astral.LuaComponentContainer.Add(roomGO, HouseMapRoom)

				mapRoom:setRoomId(roomId)
				mapRoom:setViewComponent(self)

				self._dictMapRoom[roomId] = mapRoom
			end
		end
	end

	self._rawimageBlurRT = goutil.findChildRawImageComponent(self._goRoot, "common_blur_rt")
	self._screenshotImage = CaptureScreenshotImage.Get(self._rawimageBlurRT.gameObject)

	goutil.setActive(self._rawimageBlurRT.gameObject, true)

	self._clickBottom = Astral.UIClickTrigger.Get(goutil.findChild(self._goRoot, "bg"))

	self:_buildBg()
end

function M:_buildBg()
	self._goBottomBg = self._MapRegistry:findUIElement("room_map_view_-13572425")
	self._arrayMapImg = {}

	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-2113148295", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-252862071", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1856926946", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-190188261", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1570302994", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1029212078", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1694666208", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-62013588", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1920193062", UIComponentType.Image))
	table.insert(self._arrayMapImg, self._MapRegistry:findUIElement("room_map_view_-1561589681", UIComponentType.Image))
end

function M:destroyUI()
	self._clickSmallMap = false
	self._mapPanel = false
	self._screenshotImage = false

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = false
	self._guiAnimation = false

	self._MapRegistry:cleanRegistry()

	self._MapRegistry = nil
end

function M:bindEvents()
	self._clickSmallMap:AddClickListener(self._onClickSmallMap, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._sliderScale:AddOnValueChanged(self._onScaleSliderChange, self)
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddDragListener(self._onDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	self._clickBottom:AddClickListener(self._onClickBottom, self)
	self._guiAnimation:AddListener(self._dealTimelineListener, self)
end

function M:unbindEvents()
	self._clickSmallMap:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._sliderScale:RemoveOnValueChanged()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._clickBottom:RemoveClickListener()
	self._guiAnimation:RemoveListener()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.CREATE_ALL_ROOM_UNIT, self._onAllRoomCreate, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.CREATE_ALL_ROOM_UNIT, self._onAllRoomCreate, self)
	end
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	self._singleDragingId = -999
	self._isMultiDraging = false
	self._beginDragPos = Vector2.New()
	self._originMapPos = Vector2.New()

	self._mapPanel:onEnter()

	self._isSmallMode = true

	self:_realChangeMapMode()
	self:refreshMap()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
	FrameUpdate:removeListener(self)
	self._mapPanel:onExit()
	self._screenshotImage:Clear()

	self._singleDragingId = -999
	self._isMultiDraging = false
	self._beginDragPos = false
	self._originMapPos = false

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
end

function M:refreshMap()
	for _, mapRoom in pairs(self._dictMapRoom) do
		mapRoom:updateRoomStatus()
	end
end

function M:luaUpdate(dt)
	self:_updateSmallMapPos()
end

function M:changeMapMode(isSmallMode)
	self._isSmallMode = isSmallMode

	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_EXPLORE_OPEN_MAP, not self._isSmallMode)
	FrameUpdate:removeListener(self)

	if self._isSmallMode then
		self:_startChangeMapMode()
	else
		local uiRoot = ViewMgr.instance:getUIRoot()
		local rectTransform = uiRoot.transform
		local width = rectTransform.rect.width
		local height = rectTransform.rect.height

		self._screenshotImage:Build(width, height)
		self._screenshotImage:CaptureFrame(self._onCaptureFinish, self)
	end
end

function M:_onCaptureFinish()
	local downSample = 1
	local iteration = 4
	local rendertTexture = SpaceX.CommandBufferEffectUtils.Blur(self._rawimageBlurRT.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	TransformUtils.SetLocalEulerAngles(self._rectTrBlur, 0, 0, 0)
	self._screenshotImage:SetRenderTexture(rendertTexture)
	self:_startChangeMapMode()
end

function M:_startChangeMapMode()
	goutil.setActive(self._goRoot, true)

	if not self._isSmallMode then
		goutil.addChildToParent(self._goMapRoot, self._goBigMapToAdd)
		Astral.TransformUtil.SetLocalRotation(self._goMapRoot.transform, 0, 0, 0)

		local mainPoint = self._mapPanel:getMainPlayerPoint()

		if mainPoint then
			local posX, posY = mainPoint:getPointPos()
			local scale = (self.MaxMapScale - self.MinMapScale) * kBigMapOpenSlider + self.MinMapScale

			posX = posX * -1 * scale
			posY = posY * -1 * scale

			Astral.TransformUtil.SetLocalPos(self._goMapRoot.transform, posX, posY, 0)
			self._mapPanel:showHeadIcon(true, true)
		end

		self._sliderScale:SetValue(kBigMapOpenSlider)
		self:_refreshMapBg()
	end

	self:_setPointAndSignVisible(false)

	if not self._isSmallMode then
		self:_realChangeMapMode()
	end

	local name = self._isSmallMode and kAnimNameClose or kAnimNameOpen

	self:_playAnima(name)
end

function M:_realChangeMapMode()
	self:_setPointAndSignVisible(true)
	self._mapPanel:setSmallMode(self._isSmallMode)

	for _, mapRoom in pairs(self._dictMapRoom) do
		mapRoom:setSmallMode(self._isSmallMode)
	end

	goutil.setActive(self._goRoot, not self._isSmallMode)

	if self._isSmallMode then
		goutil.addChildToParent(self._goMapRoot, self._goSmallMapMask)
		self._screenshotImage:Clear()
		self._mapPanel:showHeadIcon(false, true)
		self._mapPanel:resetImgBg()
		self._sliderScale:SetValue(0)
		self:_updateSmallMapPos()
		FrameUpdate:addListener(self)
		self:_refreshMapBg()
	end
end

function M:_refreshMapBg()
	goutil.setActive(self._goBottomBg, not self._isSmallMode)

	local colorStr = self._isSmallMode and "#2B2B2BF5" or "#141414F5"

	for _, img in ipairs(self._arrayMapImg) do
		img.color = parsecolor(colorStr)
	end
end

function M:_playAnima(name)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(name)
	self._guiAnimation:ResumeAni()
end

function M:_dealTimelineListener(tagName)
	if tagName == kCloseTagName then
		self._guiAnimation:StopTimelineAni()
		self:_realChangeMapMode()
	end
end

function M:_setPointAndSignVisible(visible)
	self._mapPanel:setRootVisible(visible)

	for _, mapRoom in pairs(self._dictMapRoom) do
		mapRoom:setVisible(visible)
	end
end

function M:_setBigMapPos(posX, posY)
	local scale = self._sliderScale:GetValue()
	local absPosX = kMaxMoveX * scale
	local absPosY = kMaxMoveY * scale

	posX = math.min(absPosX, math.max(absPosX * -1, posX))
	posY = math.min(absPosY, math.max(absPosY * -1, posY))

	Astral.TransformUtil.SetLocalPos(self._goMapRoot.transform, posX, posY, 0)
end

function M:_updateSmallMapPos()
	local mainPoint = self._mapPanel:getMainPlayerPoint()

	if mainPoint then
		local posX, posY = mainPoint:getPointPos()
		local mapPosY = math.sqrt(posX * posX + posY * posY) * self.MinMapScale

		Astral.TransformUtil.SetLocalPos(self._goMapRoot.transform, kSmallMapPosX, mapPosY, 0)

		local angle = mainPoint:getPointAngle()

		Astral.TransformUtil.SetLocalRotation(self._goMapRoot.transform, 0, 0, angle * -1)

		local mainUnit = mainPoint:getPlayerUnit()

		self._txtCurArea.text = string.format("当前：%s", HouseSceneUtil.getZoneName(mainUnit))
	end
end

function M:_onClickSmallMap()
	self:changeMapMode(false)
end

function M:_onClickBtnClose()
	self:changeMapMode(true)
end

function M:_onScaleSliderChange(sliderValue)
	local scale = (self.MaxMapScale - self.MinMapScale) * sliderValue + self.MinMapScale

	Astral.TransformUtil.SetLocalScale(self._goMapRoot.transform, scale, scale, 1)
	self._mapPanel:showHeadIcon(scale >= self.MiddleMapScale)

	local mapPosX, mapPosY = Astral.TransformUtil.GetLocalPos(self._goMapRoot.transform, 0, 0, 0)

	self:_setBigMapPos(mapPosX, mapPosY)
end

function M:_onBeginDrag(eventData)
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

function M:_onDrag(eventData)
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

function M:_onEndDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if pointerId == self._singleDragingId then
		self._singleDragingId = -999
	end

	self._isMultiDraging = false
end

function M:_onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	self._isMultiDraging = true
	self._singleDragingId = -999

	local deltaDis = math.abs(distance * (scale - 1))
	local originMapScale = self._sliderScale:GetValue()
	local mapScale = originMapScale
	local scaleSpeed = 0.002

	if scale > 1 then
		mapScale = originMapScale + deltaDis * scaleSpeed
	elseif scale < 1 then
		mapScale = originMapScale - deltaDis * scaleSpeed
	end

	mapScale = math.min(1, math.max(0, mapScale))

	self._sliderScale:SetValue(mapScale)
end

function M:_onClickBottom()
	return
end

function M:_onAllRoomCreate()
	self:refreshMap()
end

return M
