-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/element/UnitCompMainSceneElementAirtightClock.lua

module("logic.extensions.mainui.scene.element.UnitCompMainSceneElementAirtightClock", package.seeall)

local M = class("UnitCompMainSceneElementAirtightClock", UnitCompMainSceneElementBase)
local DEFAULT_CENTER = {
	z = 0,
	x = 0,
	y = 0.15
}
local DEFAULT_SIZE = {
	z = 0.44,
	x = 0.22,
	y = 0.44
}

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)

	self._colliderCenter = Vector3.New(DEFAULT_CENTER.x, DEFAULT_CENTER.y, DEFAULT_CENTER.z)
	self._colliderSize = Vector3.New(DEFAULT_SIZE.x, DEFAULT_SIZE.y, DEFAULT_SIZE.z)
end

function M:Awake()
	M.super.Awake(self)
	self:_initCollider()
	self:_initClock()
	self:setLowModeClock(true)
end

function M:OnEnable()
	M.super.OnEnable(self)
	self:setEvent(true)
end

function M:OnDisable()
	M.super.OnDisable(self)
	self:setEvent(false)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:setEvent(false)
end

function M:onLeaveScene(needUnloadRes)
	M.super.onLeaveScene(self, needUnloadRes)
end

function M:onReturnScene(needUnloadRes)
	M.super.onReturnScene(self, needUnloadRes)
end

function M:onReturnSceneFinished(needUnloadRes)
	M.super.onReturnSceneFinished(self, needUnloadRes)
end

function M:_initComponents()
	self:_addComponent("ui", UnityCompMainSceneClockBannerUI)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CLOCK_CHANGE_MODE, self._onClockModeChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN, self._onClockActionOpen, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_CLOSE, self._onClockActionClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CLOCK_CHANGE_MODE, self._onClockModeChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN, self._onClockActionOpen, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_CLOSE, self._onClockActionClose, self)
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_refreshClock()
	self:refreshLights()
end

function M:_onClockModeChange(e, isLow)
	self:setLowModeClock(isLow)
end

function M:_onClockActionOpen()
	local unitClock = self:_getClock()
end

function M:_onClockActionClose()
	local unitClock = self:_getClock()

	unitClock:refreshChamber(true)
end

function M:_onChamberSlotUpdate()
	local unitClock = self:_getClock()

	unitClock:refreshChamber()
	self:refreshLights()
end

function M:_onChamberAction(e, type, targetIdx, otherIdx)
	local unitClock = self:_getClock()

	unitClock:doChamberAction(type, targetIdx, otherIdx)
	self:refreshLights()
end

function M:_onChamberSelected(e, idx)
	local unitClock = self:_getClock()

	unitClock:refreshChamber()
end

function M:setElementId(elementId)
	M.super.setElementId(self, elementId)
end

function M:getCompCollider()
	local mainGO = self:getMainGO()

	if mainGO then
		return mainGO:GetComponent(ComponentType.BoxCollider)
	end
end

function M:_initCollider()
	local mainGO = self:getMainGO()
	local collider = goutil.addComponentOnce(mainGO, ComponentType.BoxCollider)

	if collider then
		collider.center = self._colliderCenter
		collider.size = self._colliderSize
	end
end

function M:_initClock()
	self._isLow = true

	local mainGO = self:getMainGO()

	self._goClockLow = goutil.findChild(mainGO, "go_clock_low")
	self._goChair = goutil.findChild(mainGO, "go_chair")

	local clockHeightGO = goutil.findChild(mainGO, "s001_obj_biao")

	self._unitClock = Astral.SimpleLuaComponentContainer.Add(clockHeightGO, UnitMainSceneClock)

	local clockHeightRedGO = goutil.findChild(mainGO, "s001_obj_biao_red")

	self._unitClockRed = Astral.SimpleLuaComponentContainer.Add(clockHeightRedGO, UnitMainSceneClock)

	local timeGO = goutil.findChild(mainGO, "go_time")

	self._unitTime = Astral.SimpleLuaComponentContainer.Add(timeGO, UnitMainSceneClockTime)

	self._unitTime:refreshTime()

	self._arrayLightPos = {}
	self._arrayLight = {}

	local chamberGO = goutil.findChild(mainGO, "go_chamber")

	goutil.setActive(chamberGO, false)

	self._arrayChamber = {
		chamberGO
	}

	local edgeGO = goutil.findChild(mainGO, "go_chamber_edge")

	self:_initEdge(edgeGO)

	self._arrayChamberEdge = {
		edgeGO
	}

	for i = 1, ChamberModel.MAX_SLOT_NUM do
		local posGO = goutil.findChild(mainGO, "go_light/light_" .. i)
		local lightGO = goutil.findChild(posGO, "light")
		local light = Astral.SimpleLuaComponentContainer.Add(lightGO, UnitMainSceneClockLight)

		light:setIndex(i)
		table.insert(self._arrayLightPos, posGO)
		table.insert(self._arrayLight, light)

		if i > 1 then
			local newChamber = goutil.cloneAndSetParent(chamberGO, mainGO.transform)

			goutil.setActive(newChamber, false)
			table.insert(self._arrayChamber, newChamber)

			local newEdge = goutil.cloneAndSetParent(edgeGO, mainGO.transform)

			self:_initEdge(newEdge)
			table.insert(self._arrayChamberEdge, newEdge)
		end
	end

	self:refreshLights()
end

function M:_initEdge(edge)
	local setter = MaterialSetter.Get(edge)

	setter:SetGameObject(goutil.findChild(edge, "mesh"))
	setter:SetColor(UnityEngine.Shader.PropertyToID("_BaseColor"), "#FFFFFF00")
	setter:SetFloat(UnityEngine.Shader.PropertyToID("_SelectOutline"), 0.001)
	goutil.setActive(edge, false)
end

function M:refreshLights()
	for i, light in ipairs(self._arrayLight) do
		light:refresh()
	end
end

function M:setLowModeClock(isLow)
	self._isLow = isLow

	if isLow then
		goutil.addChildToParent(self._unitTime:getMainGO(), self:getMainGO())
		self._unitTime:resetPos()
		goutil.setActive(self._goClockLow, true)
		self._unitClock:setVisible(false)
		self._unitClockRed:setVisible(false)

		for i, light in ipairs(self._arrayLight) do
			local posGO = self._arrayLightPos[i]

			goutil.addChildToParent(light:getMainGO(), posGO)
			light:resetTrs()
		end
	else
		goutil.setActive(self._goClockLow, false)
		self:_refreshClock()
	end
end

function M:_refreshClock()
	if self._isLow then
		self._unitClock:setVisible(false)
		self._unitClockRed:setVisible(false)
	else
		self._unitClock:setVisible(true)
		self._unitClockRed:setVisible(true)

		local unitClock = self:_getClock(true)

		unitClock:playIdle()
		unitClock:addToTimePos(self._unitTime:getMainGO())
		unitClock:addLights(self._arrayLight)
		unitClock:refreshChamber(true)
	end
end

function M:_getClock(initChamber)
	local inAirtightTime = AirtightRoomController.instance:getAirtightTimeInfo()

	if inAirtightTime then
		if initChamber then
			self._unitClock:setChamberList()
			self._unitClockRed:setChamberList(self._arrayChamber, self._arrayChamberEdge)
		end

		return self._unitClockRed
	end

	if initChamber then
		self._unitClockRed:setChamberList()
		self._unitClock:setChamberList(self._arrayChamber, self._arrayChamberEdge)
	end

	return self._unitClock
end

function M:onClickElement()
	CriwareAudioFacade.instance.playSESimpleByName("ui_main_2436")

	if SystemOpenFacade.instance:isOpen(AirtightRoomUtil.getSystemKey(), true) then
		ViewMgr.instance:open(ViewName.AirtightRoomTimeView)
	end

	if not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.CLICK_SCENE_OBJECT, self:getMainGO().name)
end

return M
