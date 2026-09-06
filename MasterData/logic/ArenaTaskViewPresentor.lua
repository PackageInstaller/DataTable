-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaTaskViewPresentor.lua

module("logic.extensions.arena.view.ArenaTaskViewPresentor", package.seeall)

local ArenaTaskViewPresentor = class("ArenaTaskViewPresentor", ViewPresentor)

function ArenaTaskViewPresentor:ctor()
	ArenaTaskViewPresentor.super.ctor(self)
end

function ArenaTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenataskview.prefab"
	}
end

function ArenaTaskViewPresentor:buildViews()
	local views = {}
	local view = ArenaTaskView.New()

	table.insert(views, view)

	return views
end

return ArenaTaskViewPresentor
