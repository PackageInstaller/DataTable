-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManCollectViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManCollectViewPresentor", package.seeall)

local BeastRichManCollectViewPresentor = class("BeastRichManCollectViewPresentor", ViewPresentor)

function BeastRichManCollectViewPresentor:ctor()
	BeastRichManCollectViewPresentor.super.ctor(self)
end

function BeastRichManCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmancollectview.prefab"
	}
end

function BeastRichManCollectViewPresentor:buildViews()
	return {
		BeastRichManCollectView.New()
	}
end

return BeastRichManCollectViewPresentor
