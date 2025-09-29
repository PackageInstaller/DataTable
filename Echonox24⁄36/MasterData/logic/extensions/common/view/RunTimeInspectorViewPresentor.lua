-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/RunTimeInspectorViewPresentor.lua

module("logic.extensions.common.view.RunTimeInspectorViewPresentor", package.seeall)

local M = class("RunTimeInspectorViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_run_time_ins_panel
	}
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

function M:buildViews()
	local views = {}

	return views
end

return M
