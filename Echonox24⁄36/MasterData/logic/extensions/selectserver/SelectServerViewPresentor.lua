-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/selectserver/SelectServerViewPresentor.lua

module("logic.extensions.selectserver.SelectServerViewPresentor", package.seeall)

local M = class("SelectServerViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Login_select_server_tips,
		ResName.Login_select_server_tab
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SelectServerView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

return M
