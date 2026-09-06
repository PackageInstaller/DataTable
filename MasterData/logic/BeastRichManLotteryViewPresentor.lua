-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManLotteryViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManLotteryViewPresentor", package.seeall)

local BeastRichManLotteryViewPresentor = class("BeastRichManLotteryViewPresentor", ViewPresentor)

function BeastRichManLotteryViewPresentor:ctor()
	BeastRichManLotteryViewPresentor.super.ctor(self)
end

function BeastRichManLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanlotteryview.prefab"
	}
end

function BeastRichManLotteryViewPresentor:buildViews()
	return {
		BeastRichManLotteryView.New()
	}
end

return BeastRichManLotteryViewPresentor
