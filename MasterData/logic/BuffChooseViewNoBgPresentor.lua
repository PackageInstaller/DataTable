-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BuffChooseViewNoBgPresentor.lua

module("logic.extensions.common.view.BuffChooseViewNoBgPresentor", package.seeall)

local BuffChooseViewNoBgPresentor = class("BuffChooseViewNoBgPresentor", ViewPresentor)

function BuffChooseViewNoBgPresentor:ctor()
	BuffChooseViewNoBgPresentor.super.ctor(self)
end

function BuffChooseViewNoBgPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BuffChooseViewNoBgPresentor:dependWhatResources()
	return {
		"ui/views/common/buffchooseviewnobg.prefab"
	}
end

function BuffChooseViewNoBgPresentor:buildViews()
	return {
		BuffChooseViewNoBg.New()
	}
end

return BuffChooseViewNoBgPresentor
