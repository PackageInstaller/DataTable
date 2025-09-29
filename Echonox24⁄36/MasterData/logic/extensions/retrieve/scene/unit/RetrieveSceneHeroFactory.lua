-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/unit/RetrieveSceneHeroFactory.lua

module("logic.extensions.retrieve.scene.unit.RetrieveSceneHeroFactory", package.seeall)

local M = class("RetrieveSceneHeroFactory", MainSceneHeroFactory)

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	M.super.onInit(self, sceneInfo)
end

function M:onLeaveScene()
	return
end

function M:onReturnScene()
	return
end

function M:onReturnSceneFinished()
	return
end

function M:initCreateDefine()
	self._unitDefine = {
		[UnitTag.Player] = {
			class = UnitRetrieveSceneAdjutant,
			creator = M._createUnitAdjutant
		}
	}
end

function M:_createUnitAdjutant(unitTag, entityInfo, defineInfo)
	local unit, resPaths = self:_createBaseUnit(unitTag, entityInfo, defineInfo)

	if unit then
		table.insert(resPaths, {
			typ = MainPerformEnum.ResTyp.ChangeTimeline,
			path = MainScenePerformUtil.getHeroChangeShowTimelinePath(unit:getModelId())
		})
		unit.meshModel:setBody(resPaths, entityInfo)
		unit.meshModel:originRotation(entityInfo.rotate)
		unit.changeEff:setOffSetPos(0, 0.5, 0)
		unit.collider:setColliderCenter(-0.1, 0.8, 0)
		unit.collider:setColliderSize(0.7, 1.7, 0.24)
	end

	return unit
end

function M:removeAll()
	M.super.removeAll(self)
	self:removeAllPointUi()
end

function M:removeAllPointUi()
	for point, unit in pairs(self._interactPointUnit or {}) do
		unit.ui:unbindUI()
		unit:returnSelf()

		self._interactPointUnit[point] = nil
	end
end

function M:getContainer()
	local scene = SceneMgr.instance:getScene(SceneType.Retrieve)
	local container = scene:getContainer()

	return container
end

function M:getUnitHeroByPoint(pointId)
	if not pointId then
		printWarn("请传入pointId")

		return nil
	end

	local tag = pointId == MainPerformEnum.ElementPointAdjutant and UnitTag.Player or UnitTag.Npc
	local tagUnits = self:getUnits(tag)
	local theUnit

	for _heroId, _unit in pairs(tagUnits) do
		if pointId == _unit:getPointId() then
			theUnit = _unit
		end
	end

	return theUnit
end

function M:removeUnitHero(unitTag, heroId, includeElement, fallbackDefaultElement)
	if not heroId then
		printWarn("请传入heroId")

		return nil
	end

	if not self._units[unitTag] then
		return
	end

	heroId = tonumber(heroId)

	local _unit = self:getUnitHero(unitTag, heroId)

	if _unit and includeElement then
		if fallbackDefaultElement then
			self._flow.elementMgr:showDefaultElement(_unit:getPointId())
		else
			self._flow.elementMgr:setElementShow(_unit:getElementId(), false)
		end
	end

	M.super.removeUnitHero(self, unitTag, heroId)
end

function M:removeUnitHeroByPoint(pointId)
	local unitTag = UnitTag.Player

	self:removeUnitHeroCustom(unitTag, function(_unit)
		return _unit:getPointId() == pointId
	end)
end

function M:removeUnitAdjutant(includeElement)
	self:removeUnitHeroByPoint(0)

	if includeElement then
		self._flow.elementMgr:hideAllElementInPoint(MainPerformEnum.ElementPointAdjutant)
	end
end

function M:createInteractPoint(entityInfo)
	local interactPointId = entityInfo.point
	local parentGo = ViewMgr.instance:getRoot(ViewRootType.Hud)
	local goName = string.format("point_%s", interactPointId)
	local unit = UnitMainSceneInteractPoint:createInstance(goName, 0, 0, 0)

	goutil.addChildToParent(unit:getTransform(), parentGo)
	unit:setPointId(interactPointId)
	unit.ui:setEntityInfo(entityInfo)
	unit.ui:setVisible(MainUIModel.instance:getPerformEditorVisible())

	if not self._interactPointUnit then
		self._interactPointUnit = {}
	end

	self._interactPointUnit[interactPointId] = unit

	return unit
end

return M
