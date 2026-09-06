-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManLinkGameEndlessViewPresentor.lua

module("logic.extensions.linkgame.view.BeastRichManLinkGameEndlessViewPresentor", package.seeall)

local BeastRichManLinkGameEndlessViewPresentor = class("BeastRichManLinkGameEndlessViewPresentor", ViewPresentor)

function BeastRichManLinkGameEndlessViewPresentor:ctor()
	BeastRichManLinkGameEndlessViewPresentor.super.ctor(self)
end

function BeastRichManLinkGameEndlessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManLinkGameEndlessViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanlinkgameendlessview.prefab"
	}
end

function BeastRichManLinkGameEndlessViewPresentor:buildViews()
	return {
		BeastRichManLinkGameEndlessView.New()
	}
end

return BeastRichManLinkGameEndlessViewPresentor
