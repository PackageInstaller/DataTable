-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeAnswerViewPresentor.lua

module("logic.extensions.bigorange.view.BigOrangeAnswerViewPresentor", package.seeall)

local BigOrangeAnswerViewPresentor = class("BigOrangeAnswerViewPresentor", ViewPresentor)

function BigOrangeAnswerViewPresentor:ctor()
	BigOrangeAnswerViewPresentor.super.ctor(self)
end

function BigOrangeAnswerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BigOrangeAnswerViewPresentor:dependWhatResources()
	return {
		"ui/views/bigorange/bigorangeanswerview.prefab"
	}
end

function BigOrangeAnswerViewPresentor:buildViews()
	return {
		BigOrangeAnswerView.New()
	}
end

return BigOrangeAnswerViewPresentor
