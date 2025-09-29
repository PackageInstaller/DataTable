-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/UnitMgr.lua

module("logic.scene.unit.UnitMgr", package.seeall)

local M = class("UnitMgr", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)

	self._dictHeroUnit = {}
	self._unitMainPlayer = nil
end

function M:onSceneLoadDone()
	self._unitMainPlayer = nil

	table.clear(self._dictHeroUnit)

	local curScene = SceneMgr.instance:getCurScene()

	if SceneMgr.instance:getCurSceneType() == SceneType.House then
		local initPos = self._flow.model:getMainPlayerInitPos()

		self._unitMainPlayer = curScene.unitFactory:createUnit(UnitTag.MainPlayer, {
			entityCode = PlayerModel.instance:getPlayerCardModelId(),
			x = initPos.x,
			y = initPos.y,
			z = initPos.z
		})

		self._unitMainPlayer.navMesh:setIsMainPlayer(true)
		goutil.setActive(self._unitMainPlayer:getGameObject(), false)
	end

	self:updatePlayerUnit()
	GlobalDispatcher:addEventListener(EventType.ON_REPLY_GET_SELF_HOUSE_INFO, self._OnReplyGetSelfHouseInfo, self)
end

function M:onEnterDone()
	M.super.onEnterDone(self)
end

function M:updatePlayerUnit()
	local curScene = SceneMgr.instance:getCurScene()
	local scheduleList = HouseWorkerModel.instance:getAllScheduleWithHero()
	local scheduleHeroId = {}

	for _, schedule in pairs(scheduleList) do
		scheduleHeroId[schedule.hero] = true
	end

	for _, schedule in pairs(scheduleList) do
		local heroId = schedule.hero
		local unit = self._dictHeroUnit[heroId]

		if not unit then
			local targetRoomId, workStatus, bornRoomId = HouseSceneUtil.getRoomIdBySchedule(schedule)
			local mo = HouseNavigationModel.instance:getMOByZoneId(bornRoomId)
			local posList = {
				mo:getLeftBorderPos(),
				mo:getRightBorderPos()
			}
			local pos = posList[math.random(1, #posList)]

			unit = curScene.unitFactory:createUnit(UnitTag.Player, {
				entityCode = heroId,
				x = pos.x,
				y = pos.y,
				z = pos.z,
				bornZoneId = bornRoomId
			})
			self._dictHeroUnit[heroId] = unit

			unit.model:setOccupyRoom(bornRoomId)
			unit.scheduleModel:setScheduleTargetRoomId(targetRoomId)
			unit.scheduleModel:setCurWorkStatus(workStatus)
		end

		unit.scheduleModel:setScheduleData(schedule)
	end

	for heroId, unit in pairs(self._dictHeroUnit) do
		if not scheduleHeroId[heroId] then
			HouseDispatcher:dispatchEvent(HouseEventType.REMOVE_HERO_UNIT, unit.id, heroId)
			curScene.unitFactory:removeUnit(UnitTag.Player, unit.id)

			self._dictHeroUnit[heroId] = nil
		end
	end

	HouseDispatcher:dispatchEvent(HouseEventType.UPDATE_ALL_HERO_UNIT)
end

function M:getAllUnit()
	local unitList = {}

	for heroId, unit in pairs(self._dictHeroUnit) do
		table.insert(unitList, unit)
	end

	return unitList
end

function M:getUnitDict()
	return self._dictHeroUnit
end

function M:getMainPlayer()
	return self._unitMainPlayer
end

function M:_OnReplyGetSelfHouseInfo()
	self:updatePlayerUnit()
	GlobalDispatcher:removeEventListener(EventType.ON_REPLY_GET_SELF_HOUSE_INFO, self._OnReplyGetSelfHouseInfo, self)
end

function M:onExit()
	if self._unitMainPlayer then
		self._unitMainPlayer.meshModel:clear()
	end

	self._unitMainPlayer = nil

	for _, unit in pairs(self._dictHeroUnit) do
		unit.meshModel:clear()
	end

	table.clear(self._dictHeroUnit)

	local curScene = SceneMgr.instance:getCurScene()

	curScene.unitFactory:removeAll()
	GlobalDispatcher:removeEventListener(EventType.ON_REPLY_GET_SELF_HOUSE_INFO, self._OnReplyGetSelfHouseInfo, self)
end

function M:onExitDone()
	return
end

return M
