-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBankViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManBankViewPresentor", package.seeall)

local BeastRichManBankViewPresentor = class("BeastRichManBankViewPresentor", ViewPresentor)

function BeastRichManBankViewPresentor:ctor()
	BeastRichManBankViewPresentor.super.ctor(self)
end

function BeastRichManBankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManBankViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanbankview.prefab"
	}
end

function BeastRichManBankViewPresentor:buildViews()
	return {
		BeastRichManBankView.New()
	}
end

return BeastRichManBankViewPresentor
