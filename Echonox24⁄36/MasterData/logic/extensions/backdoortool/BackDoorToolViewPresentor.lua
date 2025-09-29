-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backdoortool/BackDoorToolViewPresentor.lua

module("logic.extensions.backdoortool.BackDoorToolViewPresentor", package.seeall)

local M = class("BackDoorToolViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Back_door_tool_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BackDoorToolView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
