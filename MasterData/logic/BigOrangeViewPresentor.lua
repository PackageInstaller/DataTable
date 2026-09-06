-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeViewPresentor.lua

module("logic.extensions.bigorange.view.BigOrangeViewPresentor", package.seeall)

local BigOrangeViewPresentor = class("BigOrangeViewPresentor", ViewPresentor)

function BigOrangeViewPresentor:ctor()
	BigOrangeViewPresentor.super.ctor(self)
end

function BigOrangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BigOrangeViewPresentor:dependWhatResources()
	return {
		"ui/views/bigorange/bigorangeview.prefab"
	}
end

function BigOrangeViewPresentor:buildViews()
	return {
		BigOrangeView.New()
	}
end

function BigOrangeViewPresentor:setGrayMaskGO(grayMaskGO)
	BigOrangeViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return BigOrangeViewPresentor
