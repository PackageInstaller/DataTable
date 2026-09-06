-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/CallExplainViewPresentor.lua

module("logic.extensions.lottery.view.CallExplainViewPresentor", package.seeall)

local CallExplainViewPresentor = class("CallExplainViewPresentor", ViewPresentor)

function CallExplainViewPresentor:ctor()
	CallExplainViewPresentor.super.ctor(self)
end

function CallExplainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CallExplainViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/callexplainview.prefab"
	}
end

function CallExplainViewPresentor:buildViews()
	return {
		CallExplainView.New()
	}
end

return CallExplainViewPresentor
