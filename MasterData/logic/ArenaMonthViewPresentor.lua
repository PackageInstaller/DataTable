-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arenamonth/view/ArenaMonthViewPresentor.lua

module("logic.extensions.arenamonth.view.ArenaMonthViewPresentor", package.seeall)

local ArenaMonthViewPresentor = class("ArenaMonthViewPresentor", ViewPresentor)

function ArenaMonthViewPresentor:ctor()
	ArenaMonthViewPresentor.super.ctor(self)
end

function ArenaMonthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaMonthViewPresentor:dependWhatResources()
	return {
		"ui/views/arenamonth/arenamonthview.prefab"
	}
end

function ArenaMonthViewPresentor:buildViews()
	return {
		ArenaMonthView.New()
	}
end

return ArenaMonthViewPresentor
