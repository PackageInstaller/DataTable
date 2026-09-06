-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManIdiomChainResultViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManIdiomChainResultViewPresentor", package.seeall)

local BeastRichManIdiomChainResultViewPresentor = class("BeastRichManIdiomChainResultViewPresentor", ViewPresentor)

function BeastRichManIdiomChainResultViewPresentor:ctor()
	BeastRichManIdiomChainResultViewPresentor.super.ctor(self)
end

function BeastRichManIdiomChainResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BeastRichManIdiomChainResultViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanidiomchainresultview.prefab"
	}
end

function BeastRichManIdiomChainResultViewPresentor:buildViews()
	return {
		BeastRichManIdiomChainResultView.New()
	}
end

return BeastRichManIdiomChainResultViewPresentor
