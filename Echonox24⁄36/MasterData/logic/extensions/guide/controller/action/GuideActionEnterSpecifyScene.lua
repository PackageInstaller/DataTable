-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionEnterSpecifyScene.lua

module("logic.extensions.guide.controller.action.GuideActionEnterSpecifyScene", package.seeall)

local GuideActionEnterSpecifyScene = class("GuideActionEnterSpecifyScene", BaseGuideAction)

function GuideActionEnterSpecifyScene:ctor(guideId, stepId, guideStepCO)
	GuideActionEnterSpecifyScene.super.ctor(self, guideId, stepId, guideStepCO)

	self._sceneId = tonumber(guideStepCO.guideControlParam)
end

function GuideActionEnterSpecifyScene:onEnter(context)
	GuideActionEnterSpecifyScene.super.onEnter(self, context)
	self:_doEnterSceneById(self._sceneId)
	self:onDone(WorkResult.Succeed)
end

function GuideActionEnterSpecifyScene:onExit()
	GuideActionEnterSpecifyScene.super.onExit(self)
end

function GuideActionEnterSpecifyScene:_doEnterSceneById(sceneId)
	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	if not sceneCO then
		return
	end

	local sceneType = sceneCO.sceneType
	local curSceneType = SceneMgr.instance:getCurSceneType()
	local curSceneId = SceneMgr.instance:getCurSceneId()

	if curSceneType == sceneType and curSceneId == sceneId then
		return
	end

	SceneFace.instance:enterScene({
		sceneType = sceneType,
		sceneId = sceneId
	}, false)
end

return GuideActionEnterSpecifyScene
