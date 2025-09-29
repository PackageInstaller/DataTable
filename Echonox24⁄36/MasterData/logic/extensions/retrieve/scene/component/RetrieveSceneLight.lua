-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/component/RetrieveSceneLight.lua

module("logic.extensions.retrieve.scene.component.RetrieveSceneLight", package.seeall)

local M = class("RetrieveSceneLight", SceneComponentBase)

function M:onInit()
	return
end

function M:onEnterSceneFinished()
	if SceneMgr.instance:getCurSceneType() ~= SceneType.Retrieve then
		return
	end

	local curScene = SceneMgr.instance:getCurScene()
	local mainSceneGo = curScene.stage:getGoList(RetrieveEnum.SceneNameMap.Main)[1]

	self._mainSceneCharacterLight = goutil.findChild(mainSceneGo, "SceneLighting/character_directional_light")
	self._mainSceneLight = goutil.findChild(mainSceneGo, "SceneLighting/Directional Light_RT01")

	goutil.setActive(self._mainSceneCharacterLight, true)

	local showSceneGo = curScene.stage:getGoList(RetrieveEnum.SceneNameMap.Show)[1]

	self._floorGo = goutil.findChild(showSceneGo, "sceneResources/scene_layer_0/dianhua")
end

function M:onExitScene()
	if self._mainSceneCharacterLight and not goutil.isNil(self._mainSceneCharacterLight) then
		goutil.setActive(self._mainSceneCharacterLight, false)
	end
end

function M:onLeaveScene(needUnloadRes)
	goutil.setActive(self._mainSceneCharacterLight, false)
	goutil.setActive(self._mainSceneLight, false)
end

function M:onReturnScene(needUnloadRes)
	goutil.setActive(self._mainSceneCharacterLight, true)
	goutil.setActive(self._mainSceneLight, true)
end

function M:setFloorState(active)
	if self._floorGo and not goutil.isNil(self._floorGo) then
		goutil.setActive(self._floorGo, active)
	end
end

return M
