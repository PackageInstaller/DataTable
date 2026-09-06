-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorHangViewPresentor.lua

module("logic.extensions.angelinvestor.view.AngelInvestorHangViewPresentor", package.seeall)

local AngelInvestorHangViewPresentor = class("AngelInvestorHangViewPresentor", ViewPresentor)

function AngelInvestorHangViewPresentor:ctor()
	AngelInvestorHangViewPresentor.super.ctor(self)
end

function AngelInvestorHangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelInvestorHangViewPresentor:dependWhatResources()
	return {
		"ui/views/angelinvestor/angelinvestorhangview.prefab"
	}
end

function AngelInvestorHangViewPresentor:buildViews()
	return {
		AngelInvestorHangView.New()
	}
end

return AngelInvestorHangViewPresentor
