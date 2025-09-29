-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/component/TeamScenePickerHandler.lua

module("logic.scene.flow.component.TeamScenePickerHandler", package.seeall)

local TeamScenePickerHandler = class("TeamScenePickerHandler", ISceneFlowComp)
local kDragFactor = 40
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kQuaternion = Quaternion.AngleAxis(45, Vector3.up)
local kTempVec3 = Vector3.New()

function TeamScenePickerHandler:onInit()
	self._originalFollowPosition = Vector3.New()
	self._beginDragPosition = Vector3.New()
	self._dragUnit = false
	self._dragUnitOriginalUnionIndex = false
end

function TeamScenePickerHandler:onStart()
	self._dragUnit = false
end

function TeamScenePickerHandler:onClear()
	self:_setAsNormalEvent(false)
	self:_setAsCampAdjustmentEvent(false)

	self._dragUnit = false
	self._dragUnitOriginalUnionIndex = false
	self._unitOperator = false
	self._unitMgr = false
end

function TeamScenePickerHandler:onEnterDone()
	self:_setAsCampAdjustmentEvent(true)
end

function TeamScenePickerHandler:onExit()
	self:_setAsCampAdjustmentEvent(false)
end

function TeamScenePickerHandler:_setAsCampAdjustmentEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		TeamDispatcher:addEventListener(TeamEventType.Adjustment_OnClearOperateUnit, self._onClearOperateUnit, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		TeamDispatcher:removeEventListener(TeamEventType.Adjustment_OnClearOperateUnit, self._onClearOperateUnit, self)
	end
end

function TeamScenePickerHandler:_switchOperateUnit(unit)
	TeamDispatcher:dispatchEvent(TeamEventType.ON_HERO_HIT, unit.heroId)
end

function TeamScenePickerHandler:_clearOperateUnit()
	ViewMgr.instance:close(ViewName.RoleInfoTipsViewPresentor)
end

function TeamScenePickerHandler:_freeOperateUnit()
	if self._dragUnit then
		TeamUnitGenerator.destroyUnit(self._dragUnit)

		self._dragUnit = false
	end
end

function TeamScenePickerHandler:_onSceneHitCampAdjustment(e, isHit, hitGO, hitPoint, clickCount)
	BattleCampAdjustmentViewFacade.instance:cancelSelectedCharacter()

	local hitObjct = hitGO

	if not hitObjct then
		return
	end

	local index = TeamMainViewFacade.instance:getIndexByHitGO(hitObjct)

	if index then
		local unit = TeamMainViewFacade.instance:getUnitByIndex(index)

		if not unit then
			self:_freeOperateUnit()
			self:_clearOperateUnit()

			return
		end

		self:_switchOperateUnit(unit)
	else
		self:_freeOperateUnit()
		self:_clearOperateUnit()
	end
end

function TeamScenePickerHandler:_onClearOperateUnit()
	self:_clearOperateUnit()
end

function TeamScenePickerHandler:_onBeginDragCampAdjustment(e, position)
	local hitObjct = TeamScenePickerViewFacade.instance:checkScreenPoint(position.x, position.y)

	if not hitObjct then
		return
	end

	local isHitVaild = string.starts(hitObjct.name, "map510_sm_cube_pos")

	if not isHitVaild then
		return
	end

	local curLayer = hitObjct.layer
	local index = false

	if curLayer == SceneLayer.Default_Value then
		index = TeamMainViewFacade.instance:getIndexByCell(hitObjct)
		index = tonumber(index)
	elseif curLayer == SceneLayer.Unit_Value then
		index = TeamMainViewFacade.instance:getIndexByParent(hitObjct)
		index = tonumber(index)
	end

	self._dragUnitOriginalUnionIndex = index

	if index then
		local unit = TeamMainViewFacade.instance:getUnitByIndex(index)

		if not unit then
			self:_freeOperateUnit()
			self:_clearOperateUnit()

			return
		end

		self._dragUnit = unit
	end

	self:_clearOperateUnit()
end

function TeamScenePickerHandler:_onDragCampAdjustment(e, position)
	if not self._dragUnit then
		return
	end

	local x, y, z = TeamScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y - 80)

	if not x then
		return
	end

	Astral.TransformUtil.SetPos(self._dragUnit.go.transform, x, 0.1, z)
end

function TeamScenePickerHandler:_onEndDragCampAdjustment(e, position)
	if not self._dragUnit then
		return
	end

	local dragUnit = self._dragUnit
	local originalUnionIndex = self._dragUnitOriginalUnionIndex

	self._dragUnitOriginalUnionIndex = false

	local index = self:_getPlaceUnionIndex(position.x, position.y)

	if not index then
		self:_freeOperateUnit()
		self:_clearOperateUnit()
		TeamMainViewFacade.instance:setHighlight(originalUnionIndex, false)
		TeamMainViewFacade.instance:setCampInfo(originalUnionIndex, false)
	end

	if originalUnionIndex == index then
		EffectUtil.playEffect(BattleConst.PLACE_ENTITY2, dragUnit.go)
		TeamMainViewFacade.instance:setPosByIndex(dragUnit, originalUnionIndex)

		self._dragUnit = false

		return
	end

	local replaceUnit = TeamMainViewFacade.instance:getUnitByIndex(index)

	if dragUnit and index then
		TeamMainViewFacade.instance:updateTeamInfo(index, dragUnit.heroId, dragUnit)
		TeamMainViewFacade.instance:setPosByIndex(dragUnit, index)
		TeamMainViewFacade.instance:updateBottomInfo(index, dragUnit.heroId)
		EffectUtil.playEffect(BattleConst.PLACE_ENTITY2, dragUnit.go)
	end

	TeamMainViewFacade.instance:updateTeamInfo(originalUnionIndex, replaceUnit and replaceUnit.heroId or 0, replaceUnit)
	TeamMainViewFacade.instance:setPosByIndex(replaceUnit, originalUnionIndex)

	if replaceUnit then
		TeamMainViewFacade.instance:updateBottomInfo(originalUnionIndex, replaceUnit.heroId)
		EffectUtil.playEffect(BattleConst.PLACE_ENTITY2, replaceUnit.go)
	else
		TeamMainViewFacade.instance:updateBottomInfo(originalUnionIndex, 0)
	end

	self:_clearOperateUnit()

	self._dragUnit = false
end

function TeamScenePickerHandler:_getPlaceUnionIndex(screenX, screenY)
	local hitObjct = TeamScenePickerViewFacade.instance:checkScreenPoint(screenX, screenY)

	if not hitObjct then
		return
	end

	local index = TeamMainViewFacade.instance:getIndexByHitGO(hitObjct)

	if index then
		return index
	end

	return false
end

return TeamScenePickerHandler
