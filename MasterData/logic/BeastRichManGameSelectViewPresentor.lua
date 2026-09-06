-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManGameSelectViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManGameSelectViewPresentor", package.seeall)

local BeastRichManGameSelectViewPresentor = class("BeastRichManGameSelectViewPresentor", ViewPresentor)

function BeastRichManGameSelectViewPresentor:ctor()
	BeastRichManGameSelectViewPresentor.super.ctor(self)
end

function BeastRichManGameSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManGameSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmangameselectview.prefab"
	}
end

function BeastRichManGameSelectViewPresentor:buildViews()
	return {
		BeastRichManGameSelectView.New()
	}
end

return BeastRichManGameSelectViewPresentor
