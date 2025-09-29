-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberTestViewPresentor.lua

module("logic.extensions.chamber.view.ChamberTestViewPresentor", package.seeall)

local M = class("ChamberTestViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Chamber_test_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChamberTestView.New())

	return views
end

return M
