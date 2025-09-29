-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompShelterRoomPerform.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompShelterRoomPerform", package.seeall)

local M = class("UnitCompShelterRoomPerform", UnitComponentBase)
local AnimationState = HouseEnum.AnimationState
local kStartHeroInterval = 1
local kEndHeroInterval = 1
local kThirdStepContinueTime = 20

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._invalidDirectorSetter = nil
	self._dictDynamicPrefab = nil
	self._resLoader = nil
	self._initSucceed = false
	self._waitForInitAndShow = false
	self._urlSpineRobotArm = GameUrl.getSpineUrl("104_jixiebi")
end

function M:onInit()
	self._invalidDirectorSetter = PlayableDirectorSetter.New()
	self._dictDynamicPrefab = {}
	self._resLoader = SingleResLoader.New()
	self._initSucceed = false
	self._waitForInitAndShow = false
	self._invalidLoopTime = 0
	self._startPerformTimer = SchedulerCtrl.New(self._startHeroPerform, self)
	self._endPerformTimer = SchedulerCtrl.New(self._endHeroPerform, self)
	self._fourthStepTimer = SchedulerCtrl.New(self._fourthStep, self)
end

function M:onLateInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	self:onRoomResUnload()
end

function M:onDestroy()
	self:onReset()

	self._resLoader = nil

	self._startPerformTimer:clear()

	self._startPerformTimer = nil

	self._endPerformTimer:clear()

	self._endPerformTimer = nil

	self._fourthStepTimer:clear()

	self._fourthStepTimer = nil
end

function M:onRoomResLoaded()
	if self._unit.model:getSubRoomType() == 2 then
		self._invalidLoopTime = 0

		self:_buildView()
		self._invalidDirectorSetter:Build(self._goInvalidTimeLine, false)
		self:initView()
		self:_setPerformEvents(true)
	end
end

function M:onRoomResUnload()
	self._startPerformTimer:stop()
	self._endPerformTimer:stop()
	self._fourthStepTimer:stop()
	self:_setPerformEvents(false)
	self._invalidDirectorSetter:Clear()
	self._resLoader:clear()

	for path, goInst in pairs(self._dictDynamicPrefab) do
		goutil.destroy(goInst)
	end

	table.clear(self._dictDynamicPrefab)
	self:_unbuildView()

	self._initSucceed = false
	self._waitForInitAndShow = false
	self._invalidLoopTime = 0
end

function M:_setPerformEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.GM_SHELTER_ROOM_START_INVALID, self._onInvalidPerformStart, self)
		GlobalDispatcher:addEventListener(EventType.HOUSE_HOLDROOM_CONTAINMENT_BREACH, self._onProtomerBreach, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.GM_SHELTER_ROOM_START_INVALID, self._onInvalidPerformStart, self)
		GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLDROOM_CONTAINMENT_BREACH, self._onProtomerBreach, self)
	end
end

function M:_buildView()
	local roomGO = self._unit.resLoader:getRoomGO()

	self._goInvalidTimeLine = goutil.findChild(roomGO, "sceneResources/near/state_srs_red")
	self._goNormalMonitor = goutil.findChild(roomGO, "sceneResources/near/s206_object/s206_hud/lv")
	self._goInvalidMonitor = goutil.findChild(roomGO, "sceneResources/near/s206_object/s206_hud/hong")
end

function M:_unbuildView()
	self._goInvalidTimeLine = false
	self._goNormalMonitor = false
	self._goInvalidMonitor = false
end

function M:initView()
	self._initSucceed = false

	self:_onResLoaded()
	self:_setMonitorNormal(true)
end

function M:_loadRes(url)
	if not self._dictDynamicPrefab[url] then
		self._resLoader:load(url, self._onResLoaded, self)
	end
end

function M:_onResLoaded(resource)
	self._initSucceed = true

	if self._waitForInitAndShow then
		self:showInvalidPerform()
	end
end

function M:_initRobotArm(spineGO)
	return
end

function M:_showSpineRobotArmInvalid()
	return
end

function M:_resetSpineRobotArm()
	return
end

function M:_setMonitorNormal(isNormal)
	goutil.setActive(self._goNormalMonitor, isNormal)
	goutil.setActive(self._goInvalidMonitor, not isNormal)
end

function M:_initInvalidData(luaTable)
	local totalDuration = checknumber(luaTable.totalDuration)
	local totalAnimTime = 14.67

	self._invalidLoopTime = totalAnimTime < totalDuration and totalDuration - totalAnimTime or kThirdStepContinueTime
end

function M:showInvalidPerform(luaTable)
	if luaTable then
		self:_initInvalidData(luaTable)
	end

	self._waitForInitAndShow = false

	if self._initSucceed then
		self:_firstStep()
	else
		self._waitForInitAndShow = true
	end
end

function M:_firstStep()
	local firstPath = "scene/common-elems/common_animation/all_timeline_start.playable"

	self:_playTimeLineAnim(firstPath, nil, self._secondStep)
	self:_showSpineRobotArmInvalid()
	self:_setMonitorNormal(false)
	self._startPerformTimer:restart(kStartHeroInterval, false)
end

function M:_startHeroPerform()
	HouseDispatcher:dispatchEvent(HouseEventType.START_HERO_SHELTER_INVALID, self._unit.model:getRoomId())
end

function M:_secondStep()
	local secondPath = "scene/common-elems/common_animation/all_timeline_closedoor.playable"

	self:_playTimeLineAnim(secondPath, nil, self._thirdStep)
end

function M:_thirdStep()
	self:_resetSpineRobotArm()

	local thirdPath = "scene/common-elems/common_animation/all_timeline_keep.playable"

	self:_playTimeLineAnim(thirdPath, UnityEngine.Playables.DirectorWrapMode.Loop)
	self._fourthStepTimer:restart(self._invalidLoopTime, false)
end

function M:_fourthStep()
	local fourthPath = "scene/common-elems/common_animation/all_timeline_reset.playable"

	self:_playTimeLineAnim(fourthPath, nil, self._fifthStep)
	self:_setMonitorNormal(true)
	self._endPerformTimer:restart(kEndHeroInterval, false)
end

function M:_endHeroPerform()
	HouseDispatcher:dispatchEvent(HouseEventType.END_HERO_SHELTER_INVALID, self._unit.model:getRoomId())
end

function M:_fifthStep()
	self._invalidDirectorSetter:RemoveListener()
	self._invalidDirectorSetter:ClearPlayableAsset()
	HouseDispatcher:dispatchEvent(HouseEventType.SHELTER_ROOM_INVALID_FINISH, self._unit.model:getRoomId())
end

function M:_playTimeLineAnim(path, playMode, callback)
	self._invalidDirectorSetter:RemoveListener()
	self._invalidDirectorSetter:ClearPlayableAsset()
	self._invalidDirectorSetter:SetWrapMode(playMode or UnityEngine.Playables.DirectorWrapMode.None)
	self._invalidDirectorSetter:PlayWithPath(path)

	if callback then
		self._invalidDirectorSetter:AddListener(callback, self)
	end
end

function M:_tryStartInvalidPerform(roomId, totalDuration)
	local roomGO = self._unit.resLoader:getRoomGO()

	if roomId == self._unit.model:getRoomId() and roomGO then
		local luaTable = {}

		luaTable.totalDuration = checknumber(totalDuration)

		self:showInvalidPerform(luaTable)
	end
end

function M:_onInvalidPerformStart(e, roomId)
	self:_tryStartInvalidPerform(self._unit.model:getRoomId(), 0)
end

function M:_onProtomerBreach(e, info)
	local roomId = info.roomId < 1100 and info.roomId + 1100 or info.roomId

	self:_tryStartInvalidPerform(roomId, info.totalDuration)
end

return M
