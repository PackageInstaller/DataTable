-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaChooseViewPresentor.lua

module("logic.extensions.arena.view.ArenaChooseViewPresentor", package.seeall)

local ArenaChooseViewPresentor = class("ArenaChooseViewPresentor", ViewPresentor)

function ArenaChooseViewPresentor:ctor()
	ArenaChooseViewPresentor.super.ctor(self)
end

function ArenaChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenachooseview.prefab"
	}
end

function ArenaChooseViewPresentor:buildViews()
	local views = {}
	local view = ArenaChooseView.New()

	table.insert(views, view)

	return views
end

return ArenaChooseViewPresentor
