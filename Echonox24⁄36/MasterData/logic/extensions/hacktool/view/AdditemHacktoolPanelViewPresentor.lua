-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AdditemHacktoolPanelViewPresentor.lua

module("logic.extensions.hacktool.view.AdditemHacktoolPanelViewPresentor", package.seeall)

local M = class("AdditemHacktoolPanelViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_additem_hacktool_panel,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}
	local mainView = AdditemHacktoolPanelView.New()

	table.insert(views, mainView)

	return views
end

return M
