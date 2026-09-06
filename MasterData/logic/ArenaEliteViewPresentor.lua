-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaEliteViewPresentor.lua

module("logic.extensions.arena.view.ArenaEliteViewPresentor", package.seeall)

local ArenaEliteViewPresentor = class("ArenaEliteViewPresentor", ViewWithGuidePresentor)

function ArenaEliteViewPresentor:ctor()
	ArenaEliteViewPresentor.super.ctor(self)
end

function ArenaEliteViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArenaEliteViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenaeliteview.prefab"
	}
end

function ArenaEliteViewPresentor:buildViews()
	return {
		ArenaEliteView.New()
	}
end

return ArenaEliteViewPresentor
