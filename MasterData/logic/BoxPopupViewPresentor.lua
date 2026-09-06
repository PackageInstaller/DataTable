-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/BoxPopupViewPresentor.lua

module("logic.extensions.legend.view.treasure.BoxPopupViewPresentor", package.seeall)

local BoxPopupViewPresentor = class("BoxPopupViewPresentor", ViewPresentor)

function BoxPopupViewPresentor:ctor()
	BoxPopupViewPresentor.super.ctor(self)
end

function BoxPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BoxPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/boxpopupview.prefab"
	}
end

function BoxPopupViewPresentor:buildViews()
	return {
		BoxPopupView.New()
	}
end

return BoxPopupViewPresentor
