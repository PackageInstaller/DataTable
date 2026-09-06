-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmsperuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmsperuleViewPresentor", package.seeall)

local AnheimmsperuleViewPresentor = class("AnheimmsperuleViewPresentor", ViewPresentor)

function AnheimmsperuleViewPresentor:ctor()
	AnheimmsperuleViewPresentor.super.ctor(self)
end

function AnheimmsperuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnheimmsperuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmsperuleview.prefab"
	}
end

function AnheimmsperuleViewPresentor:buildViews()
	return {
		AnheimmsperuleView.New()
	}
end

return AnheimmsperuleViewPresentor
