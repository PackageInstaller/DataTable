-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaHistoryupViewPresentor.lua

module("logic.extensions.arena.view.ArenaHistoryupViewPresentor", package.seeall)

local ArenaHistoryupViewPresentor = class("ArenaHistoryupViewPresentor", ViewPresentor)

function ArenaHistoryupViewPresentor:ctor()
	ArenaHistoryupViewPresentor.super.ctor(self)
end

function ArenaHistoryupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArenaHistoryupViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenahistoryupview.prefab"
	}
end

function ArenaHistoryupViewPresentor:buildViews()
	return {
		ArenaHistoryupView.New()
	}
end

return ArenaHistoryupViewPresentor
