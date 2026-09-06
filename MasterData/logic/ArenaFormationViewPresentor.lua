-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaFormationViewPresentor.lua

module("logic.extensions.arena.view.ArenaFormationViewPresentor", package.seeall)

local ArenaFormationViewPresentor = class("ArenaFormationViewPresentor", ViewPresentor)

function ArenaFormationViewPresentor:ctor()
	ArenaFormationViewPresentor.super.ctor(self)
end

function ArenaFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function ArenaFormationViewPresentor:buildViews()
	return {
		ArenaFormationLeftView.New(),
		FormationRightView.New(),
		ArenaFormationView.New(true)
	}
end

return ArenaFormationViewPresentor
