-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaRewardViewPresentor.lua

module("logic.extensions.arena.view.ArenaRewardViewPresentor", package.seeall)

local ArenaRewardViewPresentor = class("ArenaRewardViewPresentor", ViewPresentor)

function ArenaRewardViewPresentor:ctor()
	ArenaRewardViewPresentor.super.ctor(self)
end

function ArenaRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArenaRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenarewardview.prefab"
	}
end

function ArenaRewardViewPresentor:buildViews()
	local views = {}
	local view = ArenaRewardView.New()

	table.insert(views, view)

	return views
end

return ArenaRewardViewPresentor
