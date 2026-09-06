-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmMainViewPresentor", package.seeall)

local AnheimmMainViewPresentor = class("AnheimmMainViewPresentor", ViewPresentor)

function AnheimmMainViewPresentor:ctor()
	AnheimmMainViewPresentor.super.ctor(self)
end

function AnheimmMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnheimmMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmmainview.prefab"
	}
end

function AnheimmMainViewPresentor:buildViews()
	return {
		AnheimmMainView.New()
	}
end

return AnheimmMainViewPresentor
