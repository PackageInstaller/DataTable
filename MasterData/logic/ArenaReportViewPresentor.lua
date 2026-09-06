-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaReportViewPresentor.lua

module("logic.extensions.arena.view.ArenaReportViewPresentor", package.seeall)

local ArenaReportViewPresentor = class("ArenaReportViewPresentor", ViewPresentor)

function ArenaReportViewPresentor:ctor()
	ArenaReportViewPresentor.super.ctor(self)
end

function ArenaReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArenaReportViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenareportview.prefab"
	}
end

function ArenaReportViewPresentor:buildViews()
	local views = {}
	local view = ArenaReportView.New()

	table.insert(views, view)

	return views
end

return ArenaReportViewPresentor
