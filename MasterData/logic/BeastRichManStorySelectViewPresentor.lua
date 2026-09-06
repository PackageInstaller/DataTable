-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManStorySelectViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManStorySelectViewPresentor", package.seeall)

local BeastRichManStorySelectViewPresentor = class("BeastRichManStorySelectViewPresentor", ViewPresentor)

function BeastRichManStorySelectViewPresentor:ctor()
	BeastRichManStorySelectViewPresentor.super.ctor(self)
end

function BeastRichManStorySelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BeastRichManStorySelectViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanstoryselectview.prefab"
	}
end

function BeastRichManStorySelectViewPresentor:buildViews()
	return {
		BeastRichManStorySelectView.New()
	}
end

return BeastRichManStorySelectViewPresentor
