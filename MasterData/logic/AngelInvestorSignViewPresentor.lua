-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorSignViewPresentor.lua

module("logic.extensions.angelinvestor.view.AngelInvestorSignViewPresentor", package.seeall)

local AngelInvestorSignViewPresentor = class("AngelInvestorSignViewPresentor", ViewPresentor)

function AngelInvestorSignViewPresentor:ctor()
	AngelInvestorSignViewPresentor.super.ctor(self)
end

function AngelInvestorSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelInvestorSignViewPresentor:dependWhatResources()
	return {
		"ui/views/angelinvestor/angelinvestorsignview.prefab"
	}
end

function AngelInvestorSignViewPresentor:buildViews()
	return {
		AngelInvestorSignView.New()
	}
end

return AngelInvestorSignViewPresentor
