-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManIdiomChainMainViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManIdiomChainMainViewPresentor", package.seeall)

local BeastRichManIdiomChainMainViewPresentor = class("BeastRichManIdiomChainMainViewPresentor", ViewPresentor)

function BeastRichManIdiomChainMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManIdiomChainMainViewPresentor:dependWhatResources()
	return {
		"ui/views/idiomchain/idiomchainmainview.prefab"
	}
end

function BeastRichManIdiomChainMainViewPresentor:buildViews()
	return {
		BeastRichManIdiomChainMainView.New()
	}
end

return BeastRichManIdiomChainMainViewPresentor
