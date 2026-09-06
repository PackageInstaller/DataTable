-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorPayCardViewPresentor.lua

module("logic.extensions.angelinvestor.view.AngelInvestorPayCardViewPresentor", package.seeall)

local AngelInvestorPayCardViewPresentor = class("AngelInvestorPayCardViewPresentor", ViewPresentor)

function AngelInvestorPayCardViewPresentor:ctor()
	AngelInvestorPayCardViewPresentor.super.ctor(self)
end

function AngelInvestorPayCardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelInvestorPayCardViewPresentor:dependWhatResources()
	return {
		"ui/views/angelinvestor/angelinvestorpaycardview.prefab"
	}
end

function AngelInvestorPayCardViewPresentor:buildViews()
	return {
		AngelInvestorPayCardView.New()
	}
end

return AngelInvestorPayCardViewPresentor
