-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/map/HouseMapPanel.lua

module("logic.extensions.house.view.map.HouseMapPanel", package.seeall)

local M = class("HouseMapPanel")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGO = self._compContainer.gameObject
	self._presentor = false
	self._mapPointMainPlayer = false
	self._dictMapPointPlayer = {}

	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()

	self._presentor = false
	self._mapPointMainPlayer = false
	self._dictMapPointPlayer = false
end

function M:buildUI()
	self._goAllPointRoot = goutil.findChild(self._mainGO, "goPoint")
	self._goAllRoomRoot = goutil.findChild(self._mainGO, "roomClickList")
	self._goImgRoot = goutil.findChild(self._mainGO, "goImage")
	self._arrayImgGO = {}

	for i = 0, 9 do
		table.insert(self._arrayImgGO, goutil.findChild(self._goImgRoot, "Image" .. i))
	end
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvent(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.UPDATE_ALL_HERO_UNIT, self._onAllPlayerUpdate, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.UPDATE_ALL_HERO_UNIT, self._onAllPlayerUpdate, self)
	end
end

function M:onEnter()
	self:updateAllPoints()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	self:destroyAllPoints()
end

function M:setPresentor(presentor)
	self._presentor = presentor
end

function M:getMainPlayerPoint()
	return self._mapPointMainPlayer
end

function M:setRootVisible(visible)
	goutil.setActive(self._goAllPointRoot, visible)
end

function M:resetImgBg()
	local imgCanvas = self._goImgRoot:GetComponent(ComponentType.CanvasGroup)

	imgCanvas.alpha = 1

	local pointCanvas = self._goAllPointRoot:GetComponent(ComponentType.CanvasGroup)

	pointCanvas.alpha = 1

	local roomCanvas = self._goAllRoomRoot:GetComponent(ComponentType.CanvasGroup)

	roomCanvas.alpha = 1

	Astral.TransformUtil.SetLocalScale(self._goImgRoot.transform, 1, 1, 1)

	for _, imgGO in ipairs(self._arrayImgGO) do
		Astral.TransformUtil.SetLocalRotation(imgGO.transform, 0, 0, 0)
	end
end

function M:updateAllPoints()
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow and curSceneFlow.unitMgr then
		local mainPlayer = curSceneFlow.unitMgr:getMainPlayer()

		if mainPlayer then
			self:_tryCreateMainPlayerPoint()
			self._mapPointMainPlayer:setPlayerUnit(mainPlayer)
		else
			self:_destroyMapPoint(self._mapPointMainPlayer)

			self._mapPointMainPlayer = false
		end

		local dictUnit = curSceneFlow.unitMgr:getUnitDict()

		for heroId, unit in pairs(dictUnit) do
			local point = self:_tryGetPlayerPoint(heroId)

			point:setPlayerUnit(unit)
			point:setHead(heroId)
		end

		for heroId, point in pairs(self._dictMapPointPlayer) do
			if not dictUnit[heroId] then
				self:_destroyMapPoint(point)

				self._dictMapPointPlayer[heroId] = nil
			end
		end
	end
end

function M:destroyAllPoints()
	self:_destroyMapPoint(self._mapPointMainPlayer)

	self._mapPointMainPlayer = false

	for heroId, point in pairs(self._dictMapPointPlayer) do
		self:_destroyMapPoint(point)

		self._dictMapPointPlayer[heroId] = nil
	end
end

function M:setSmallMode(isSmallMap)
	if self._mapPointMainPlayer then
		self._mapPointMainPlayer:setSmallMode(isSmallMap)
	end
end

function M:showHeadIcon(show, ignoreAnim)
	for heroId, point in pairs(self._dictMapPointPlayer) do
		point:showHeadIcon(show, ignoreAnim)
	end
end

function M:_tryCreateMainPlayerPoint()
	if not self._mapPointMainPlayer then
		local pointGO = self._presentor:getResInstance(ResName.Room_room_map_point)

		goutil.addChildToParent(pointGO, self._goAllPointRoot)

		self._mapPointMainPlayer = Astral.LuaComponentContainer.Add(pointGO, HouseMapPoint)

		self._mapPointMainPlayer:setIsMainPlayer(true)
		self._mapPointMainPlayer:init()
	end
end

function M:_tryGetPlayerPoint(heroId)
	local point = self._dictMapPointPlayer[heroId]

	if not point then
		local pointGO = self._presentor:getResInstance(ResName.Room_room_map_point)

		goutil.addChildToParent(pointGO, self._goAllPointRoot)

		point = Astral.LuaComponentContainer.Add(pointGO, HouseMapPoint)

		point:init()

		self._dictMapPointPlayer[heroId] = point
	end

	return point
end

function M:_destroyMapPoint(point)
	if point then
		local go = point:getMainGO()

		goutil.destroy(go)
	end
end

function M:_onAllPlayerUpdate()
	self:updateAllPoints()
end

return M
