-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManPayMoneyViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastRichManPayMoneyViewPresentor", package.seeall)

local BeastRichManPayMoneyViewPresentor = class("BeastRichManPayMoneyViewPresentor", ViewPresentor)

function BeastRichManPayMoneyViewPresentor:ctor()
	BeastRichManPayMoneyViewPresentor.super.ctor(self)
end

function BeastRichManPayMoneyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastRichManPayMoneyViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanpaymoneyview.prefab"
	}
end

function BeastRichManPayMoneyViewPresentor:buildViews()
	return {
		BeastRichManPayMoneyView.New()
	}
end

return BeastRichManPayMoneyViewPresentor
