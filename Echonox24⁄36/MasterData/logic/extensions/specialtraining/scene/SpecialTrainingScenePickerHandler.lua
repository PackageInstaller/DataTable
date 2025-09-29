-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/scene/SpecialTrainingScenePickerHandler.lua

module("logic.extensions.specialtraining.scene.SpecialTrainingScenePickerHandler", package.seeall)

local M = class("SpecialTrainingScenePickerHandler", SceneComponentBase)

function M:onInit()
	self._lastPlanId = 0
end

function M:onEnterScene(sceneId, bornX, bornZ)
	M.super.onEnterScene(sceneId, bornX, bornZ)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onExitScene()
	self:_setEvent(false)

	self._lastPlanId = 0
end

function M:onLeaveScene()
	self:_setEvent(false)

	self._lastPlanId = 0
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
	end
end

function M:isVaildScene()
	local sceneType = SceneFace.instance:getCurSceneFlowTyp()

	return sceneType == SceneType.SpecialTraining
end

function M:_getPlanId(heroResName)
	local planList = SpecialtrainingModel.instance:getPlans()

	for i, v in ipairs(planList) do
		local characterCo = CharacterConfig.instance:getCfgInfoByID(v.heroId)
		local modelCO = ModelConfig.instance:getModelConfig(characterCo.modelId)

		printWarn("====hero resource path: ", GameUrl.getHighMeshModelUrl(modelCO.resName))

		if string.find(heroResName, modelCO.resName) then
			return i
		end
	end

	return 0
end

function M:_onSceneHit(e, isHit, hitGO, hitPoint, clickCount)
	if not self:isVaildScene(true) then
		return
	end

	if hitGO then
		printWarn("===hitGO name===", hitGO.name)

		local planId = self:_getPlanId(hitGO.name)

		if planId > 0 and planId ~= self._lastPlanId then
			self._lastPlanId = planId

			GlobalDispatcher:dispatchEvent(EventType.SPECIAL_TRAINING_PLANCLICK, planId)
		end
	end
end

function M:_onBeginDrag(e, position, pointerId)
	if not self:isVaildScene(true) then
		return
	end
end

function M:_onDrag(e, position, pointerId)
	if not self:isVaildScene(true) then
		return
	end
end

function M:_onEndDrag(e, position, pointerId)
	if not self:isVaildScene(true) then
		return
	end
end

return M
