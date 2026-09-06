-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaWeekRewardTipPresentor.lua

module("logic.extensions.arena.view.ArenaWeekRewardTipPresentor", package.seeall)

local ArenaWeekRewardTipPresentor = class("ArenaWeekRewardTipPresentor", ViewPresentor)

function ArenaWeekRewardTipPresentor:ctor()
	ArenaWeekRewardTipPresentor.super.ctor(self)
end

function ArenaWeekRewardTipPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaWeekRewardTipPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenaweeklyrewardview.prefab"
	}
end

function ArenaWeekRewardTipPresentor:buildViews()
	return {
		ArenaWeekRewardTip.New()
	}
end

return ArenaWeekRewardTipPresentor
