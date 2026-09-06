-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewSetting.lua

module("frameworkext.lmvc.view.ViewSetting", package.seeall)

local ViewSetting = class("ViewSetting")

ViewSetting.kWindow = 1
ViewSetting.kModalWindow = 2
ViewSetting.kFullScreenWindow = 3
ViewSetting.kNormalView = 11
ViewSetting.kModalView = 12
ViewSetting.kFullScreenView = 13

function ViewSetting:init(setting)
	self._setting = setting
end

function ViewSetting:isSupportBack(view)
	local co = self._setting[view]

	if co then
		return co.supportBack == true
	end

	return false
end

function ViewSetting:getSyncOpenList(view)
	local co = self._setting[view]

	if co then
		return co.syncOpenList
	end

	return nil
end

function ViewSetting:getSyncCloseList(view)
	local co = self._setting[view]

	if co then
		return co.syncCloseList
	end

	return nil
end

function ViewSetting:getAutoDestroyTime(view)
	local co = self._setting[view]

	if co then
		return co.autoDestroyTime or 0
	end

	return 0
end

function ViewSetting:isFullScreen(view)
	local co = self._setting[view]

	if co then
		return co.showMode == ViewSetting.kFullScreenWindow or co.showMode == ViewSetting.kFullScreenView
	end

	return false
end

function ViewSetting:isModal(view)
	local co = self._setting[view]

	if co then
		return co.showMode == ViewSetting.kModalWindow or co.showMode == ViewSetting.kModalView
	end

	return false
end

function ViewSetting:getPresentorName(view)
	local co = self._setting[view]

	if co then
		return co.presentor
	end

	return nil
end

function ViewSetting:getExtId(view)
	local co = self._setting[view]

	if co then
		return co.extId
	end

	return nil
end

ViewSetting.instance = ViewSetting.New()

return ViewSetting
