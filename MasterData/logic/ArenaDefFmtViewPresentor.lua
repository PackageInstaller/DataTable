-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaDefFmtViewPresentor.lua

module("logic.extensions.arena.view.ArenaDefFmtViewPresentor", package.seeall)

local ArenaDefFmtViewPresentor = class("ArenaDefFmtViewPresentor", MissionViewPresentor)

function ArenaDefFmtViewPresentor:ctor()
	ArenaDefFmtViewPresentor.super.ctor(self)
end

function ArenaDefFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaDefFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenafmtview.prefab",
		self:_addCommonRes()
	}
end

function ArenaDefFmtViewPresentor:buildViews()
	return {
		ArenaDefFmtView.New(),
		ArenaMissionFmtView.New()
	}
end

return ArenaDefFmtViewPresentor
