-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/facade/ScenePickerViewFacade.lua

module("logic.scene.facade.ScenePickerViewFacade", package.seeall)

local M = class("ScenePickerViewFacade")
local kDefaultKey = "ScenePickerViewFacade"

function M:ctor()
	self._openSignal = SignalAmount.New()
	self._scenePickerView = false
end

function M:registerView(view)
	self._scenePickerView = view
end

function M:unregisterView()
	self._scenePickerView = false
end

function M:getScenePickerView()
	return self._scenePickerView
end

function M:open(key)
	if enableLog then
		printInfo("打开ScenePick", key)
	end

	self._openSignal:addUnique(key or kDefaultKey)

	if ViewMgr.instance:isOpen(ViewName.ScenePicker) then
		self:reloadLayerMask()
	else
		ViewMgr.instance:openSpecialView(ViewName.ScenePicker)
	end
end

function M:close(key)
	if enableLog then
		printInfo("关闭ScenePick", key)
	end

	self._openSignal:remove(key or kDefaultKey)

	if self._openSignal:isActive() then
		return
	end

	ViewMgr.instance:close(ViewName.ScenePicker)
end

function M:getHitPosByScreenPointWithMask(screenX, screenY, layerMask)
	if not self:_checkPickerView() then
		return
	end

	return self._scenePickerView:getHitPosByScreenPointWithMask(screenX, screenY, layerMask)
end

function M:testHitScreenPoint(screenX, screenY)
	if not self:_checkPickerView() then
		return
	end

	return self._scenePickerView:testHitScreenPoint(screenX, screenY)
end

function M:getHitCount()
	if not self:_checkPickerView() then
		return 0
	end

	return self._scenePickerView:getHitCount()
end

function M:getHitPointXYZ(index)
	if not self:_checkPickerView() then
		return 0, 0, 0
	end

	return self._scenePickerView:getHitPointXYZ(index - 1)
end

function M:setEnable(enable)
	if not self:_checkPickerView() then
		return
	end

	return self._scenePickerView:setEnable(enable)
end

function M:reloadLayerMask()
	if not self:_checkPickerView() then
		return
	end

	self._scenePickerView:reloadLayerMask()
end

function M:_checkPickerView()
	if not self._scenePickerView then
		printWarn("no picker view has register")

		return false
	end

	return true
end

M.instance = M.New()

return M
