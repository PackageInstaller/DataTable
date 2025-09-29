-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/facade/TeamScenePickerViewFacade.lua

module("logic.extensions.team.facade.TeamScenePickerViewFacade", package.seeall)

local TeamScenePickerViewFacade = class("TeamScenePickerViewFacade", BaseFacade)

function TeamScenePickerViewFacade:ctor()
	self._scenePickerView = false
end

function TeamScenePickerViewFacade:registerView(view)
	self._scenePickerView = view
end

function TeamScenePickerViewFacade:unregisterView()
	self._scenePickerView = false
end

function TeamScenePickerViewFacade:setEnable(enable)
	if not self:checkView() then
		return
	end

	return self._scenePickerView:setEnable(enable)
end

function TeamScenePickerViewFacade:testHitScreenPoint(screenX, screenY)
	if not self:checkView() then
		return
	end

	return self._scenePickerView:testHitScreenPoint(screenX, screenY)
end

function TeamScenePickerViewFacade:checkScreenPoint(screenX, screenY)
	if not self:checkView() then
		return
	end

	return self._scenePickerView:checkScreenPoint(screenX, screenY)
end

function TeamScenePickerViewFacade:checkView()
	if not self._scenePickerView then
		if enableErrorLog then
			printError("TeamScenePickerViewFacade::need to register view first!")
		end

		return false
	end

	return true
end

TeamScenePickerViewFacade.instance = TeamScenePickerViewFacade.New()

return TeamScenePickerViewFacade
