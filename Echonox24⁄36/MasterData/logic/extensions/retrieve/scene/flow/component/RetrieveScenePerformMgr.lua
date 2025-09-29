-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveScenePerformMgr.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveScenePerformMgr", package.seeall)

local M = class("RetrieveScenePerformMgr", ISceneFlowComp)
local RetrieveHeroPosMap = {
	{
		pos = Vector3.New(-0.87, -0.53, 4.33)
	},
	{
		pos = Vector3.New(0.2, -0.53, 4.15)
	},
	{
		pos = Vector3.New(1.04, -0.53, 4.33)
	},
	[999] = {
		pos = Vector3.New(0, 0, 0)
	}
}

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	M.super.onInit(self, sceneInfo)
end

function M:onEnter()
	self:_setEvent(true)
	RetrieveController.instance:sendRequest()
end

function M:onSceneLoadDone()
	return
end

function M:onEnterDone()
	return
end

function M:onExit()
	self:_setEvent(false)

	self._newRetrieveHeroPosMap = false

	table.clear(self._cacheUnits)

	self._cacheUnits = false
end

function M:onExitDone()
	return
end

function M:onLeaveScene()
	if self._cacheUnits then
		for _, retrieveUnit in pairs(self._cacheUnits) do
			retrieveUnit.meshModel:setModelActive(false, MainPerformEnum.AnimPrefix.ChouKa)
		end
	end
end

function M:onReturnScene()
	if self._cacheUnits then
		for _, retrieveUnit in pairs(self._cacheUnits) do
			retrieveUnit.meshModel:setModelActive(true, MainPerformEnum.AnimPrefix.ChouKa)
		end
	end
end

function M:onReturnSceneFinished()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CHANGE_REQ, self._handleHeroChangeReq, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CHANGE_REQ, self._handleHeroChangeReq, self)
	end
end

function M:_handleHeroChangeReq(e, info)
	local pointId = info.pointId
	local heroId = info.heroId
	local skinId = info.skinId
	local forceSet = false
	local isChange = info.isChange
	local defaultHide = info.defaultHide

	if info.forceSet ~= nil then
		forceSet = info.forceSet
	end

	local prefix = MainPerformEnum.AnimPrefix.ChouKa

	if pointId == 2 then
		prefix = MainPerformEnum.AnimPrefix.XiangQing
	end

	local tag = UnitTag.Player

	self._flow.unitFactory:removeUnitHeroByPoint(pointId)

	local checkHeroExist = not forceSet
	local checkHeroOnline = false
	local ignoreRuntimeCfgCheck = false
	local createInfo = self:getCreateUnitInfo(tag, heroId, skinId, pointId, checkHeroExist, checkHeroOnline, ignoreRuntimeCfgCheck)

	if createInfo then
		createInfo.defaultPrefix = prefix
		createInfo.isChange = isChange
		createInfo.defaultHide = defaultHide

		local transparency = isChange and 0 or 1

		self:createUnit(tag, createInfo)
	else
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, pointId, -1, nil, false)
	end
end

function M:getAdjutantSeatElement()
	return self._adjutantSeatElement
end

function M:updateHeroPosMap(leftPos, midPos, rightPos)
	if not self._newRetrieveHeroPosMap then
		self._newRetrieveHeroPosMap = {}
	end

	self._newRetrieveHeroPosMap = {
		{
			pos = leftPos
		},
		{
			pos = midPos
		},
		{
			pos = rightPos
		}
	}
end

function M:getCreateUnitInfo(tag, heroId, skinId, pointId, checkExit, checkOnline, ignoreRuntimeCfgCheck)
	if tag == nil or heroId == nil or pointId == nil then
		printWarn(string.format("模型创建失败，tag[%s] 交互点[%s] 角色[%s]", tag, pointId, heroId), debug.traceback())

		return false
	end

	if heroId <= 0 then
		return false
	end

	local canCreate = true
	local elementPosData = RetrieveHeroPosMap[pointId]

	if self._newRetrieveHeroPosMap then
		elementPosData = self._newRetrieveHeroPosMap[pointId]
	end

	if canCreate and elementPosData then
		local loadAnimList = {
			MainPerformEnum.AnimPrefix.ChouKa,
			MainPerformEnum.AnimFullName.ChangeShow,
			MainPerformEnum.AnimFullName.XiangQingIdle
		}
		local info = MainScenePerformUtil.createUnitCreateEntityInfo(heroId, skinId, pointId, loadAnimList)

		info.defaultPrefix = MainPerformEnum.AnimPrefix.ChouKa
		info.animStepStr = MainPerformEnum.AnimFullName.ChoukaIdle
		info.pos.x = elementPosData.pos.x or 0
		info.pos.y = elementPosData.pos.y or 0
		info.pos.z = elementPosData.pos.z or 0
		info.rotate.x = 0
		info.rotate.y = 180
		info.rotate.z = 0

		return info
	else
		return false
	end
end

function M:createUnit(tag, info)
	if not info then
		return
	end

	local unit = self._flow.unitFactory:createUnit(tag, info)

	if not self._cacheUnits then
		self._cacheUnits = {}
	end

	self._cacheUnits[info.entityCode] = unit
end

function M:clearCacheUnitList()
	if self._cacheUnits then
		table.clear(self._cacheUnits)
	end

	self._cacheUnits = false
end

return M
