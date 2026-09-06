-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaSweepSelectViewPresentor.lua

module("logic.extensions.arena.view.ArenaSweepSelectViewPresentor", package.seeall)

local ArenaSweepSelectViewPresentor = class("ArenaSweepSelectViewPresentor", ViewPresentor)

function ArenaSweepSelectViewPresentor:ctor()
	ArenaSweepSelectViewPresentor.super.ctor(self)
end

function ArenaSweepSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArenaSweepSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenasweepselectview.prefab"
	}
end

function ArenaSweepSelectViewPresentor:buildViews()
	return {
		ArenaSweepSelectView.New()
	}
end

return ArenaSweepSelectViewPresentor
