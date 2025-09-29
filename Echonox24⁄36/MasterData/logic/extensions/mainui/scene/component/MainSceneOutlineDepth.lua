-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneOutlineDepth.lua

module("logic.extensions.mainui.scene.component.MainSceneOutlineDepth", package.seeall)

local M = class("MainSceneOutlineDepth", SceneComponentBase)

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:_setEvent(true)
	self:_resetOutlineDepth()
end

function M:onExitScene()
	self:_setEvent(false)
	self:_setOutlineDepth(false)

	self._globalVolumeDepth = nil
end

function M:onLeaveScene(needUnloadRes)
	self:_setOutlineDepth(false)

	self._globalVolumeDepth = nil
end

function M:onReturnScene(needUnloadRes)
	return
end

function M:onReturnSceneFinished(needUnloadRes)
	self:onEnterScene(self._scene:getSceneId(), self._scene:getBornX(), self._scene:getBornZ())
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_IN_CHARACTER_VIEW_CHANGE, self._handleOnInCharacterViewChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_IN_CHARACTER_VIEW_CHANGE, self._handleOnInCharacterViewChange, self)
	end
end

function M:_handleOnInCharacterViewChange(e, inView)
	self._outlineDepthActive = inView

	self:_setOutlineDepth(inView)
end

function M:_resetOutlineDepth()
	self:_setOutlineDepth(self._outlineDepthActive)
end

function M:_setOutlineDepth(active)
	SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(active)

	local globalVolumeDepth = self:getGlobalVolumeDepth()

	if not globalVolumeDepth or goutil.isNil(globalVolumeDepth) then
		return
	end

	goutil.setActive(globalVolumeDepth, active)
end

function M:_initGlobalVolume()
	if not self._globalVolumeDepth or goutil.isNil(self._globalVolumeDepth) then
		local scene = SceneMgr.instance:getScene(SceneType.Room)
		local root = scene.stage:getHouseRootGo()

		self._globalVolumeDepth = goutil.findChild(root, "otherResources/globalvolume_depth@h")

		if self._globalVolumeDepth then
			self._globalVolumeDepth = self._globalVolumeDepth.gameObject
		end
	end
end

function M:getGlobalVolumeDepth()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return nil
	end

	self:_initGlobalVolume()

	return self._globalVolumeDepth
end

return M
