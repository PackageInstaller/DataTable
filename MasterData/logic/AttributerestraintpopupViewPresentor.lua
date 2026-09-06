-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/AttributerestraintpopupViewPresentor.lua

module("logic.extensions.guidepopup.view.AttributerestraintpopupViewPresentor", package.seeall)

local AttributerestraintpopupViewPresentor = class("AttributerestraintpopupViewPresentor", ViewPresentor)

function AttributerestraintpopupViewPresentor:ctor()
	AttributerestraintpopupViewPresentor.super.ctor(self)
end

function AttributerestraintpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AttributerestraintpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/guidepopup/attributerestraintpopup.prefab"
	}
end

function AttributerestraintpopupViewPresentor:buildViews()
	return {
		AttributerestraintpopupView.New()
	}
end

return AttributerestraintpopupViewPresentor
