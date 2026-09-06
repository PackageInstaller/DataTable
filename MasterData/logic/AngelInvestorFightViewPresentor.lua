-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/view/AngelInvestorFightViewPresentor.lua

module("logic.extensions.angelinvestor.view.AngelInvestorFightViewPresentor", package.seeall)

local AngelInvestorFightViewPresentor = class("AngelInvestorFightViewPresentor", ViewPresentor)

function AngelInvestorFightViewPresentor:ctor()
	AngelInvestorFightViewPresentor.super.ctor(self)
end

function AngelInvestorFightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AngelInvestorFightViewPresentor:dependWhatResources()
	return {
		"ui/views/angelinvestor/angelinvestorfightview.prefab"
	}
end

function AngelInvestorFightViewPresentor:buildViews()
	return {
		AngelInvestorFightView.New()
	}
end

return AngelInvestorFightViewPresentor
