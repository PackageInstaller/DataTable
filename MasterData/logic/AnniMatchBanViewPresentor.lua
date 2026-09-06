-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnniMatchBanViewPresentor.lua

module("logic.extensions.annimatch.view.AnniMatchBanViewPresentor", package.seeall)

local AnniMatchBanViewPresentor = class("AnniMatchBanViewPresentor", ViewPresentor)

function AnniMatchBanViewPresentor:ctor()
	AnniMatchBanViewPresentor.super.ctor(self)
end

function AnniMatchBanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnniMatchBanViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchbanview.prefab"
	}
end

function AnniMatchBanViewPresentor:buildViews()
	return {
		AnniMatchBanView.New()
	}
end

return AnniMatchBanViewPresentor
