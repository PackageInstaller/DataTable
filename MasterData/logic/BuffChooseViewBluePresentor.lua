-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BuffChooseViewBluePresentor.lua

module("logic.extensions.common.view.BuffChooseViewBluePresentor", package.seeall)

local BuffChooseViewBluePresentor = class("BuffChooseViewBluePresentor", ViewPresentor)

function BuffChooseViewBluePresentor:ctor()
	BuffChooseViewBluePresentor.super.ctor(self)
end

function BuffChooseViewBluePresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuffChooseViewBluePresentor:dependWhatResources()
	return {
		"ui/views/common/buffchooseviewblue.prefab"
	}
end

function BuffChooseViewBluePresentor:buildViews()
	return {
		BuffChooseViewBlue.New()
	}
end

return BuffChooseViewBluePresentor
