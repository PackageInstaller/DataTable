-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentMainViewPresentor.lua

module("logic.extensions.playerinfo.view.monument.MonumentMainViewPresentor", package.seeall)

local M = class("MonumentMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Symptom_syndrome_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonumentMainView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
