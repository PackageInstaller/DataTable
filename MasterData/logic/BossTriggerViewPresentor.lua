-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/BossTriggerViewPresentor.lua

module("logic.extensions.sharetask.view.BossTriggerViewPresentor", package.seeall)

local BossTriggerViewPresentor = class("BossTriggerViewPresentor", ViewPresentor)

function BossTriggerViewPresentor:ctor()
	BossTriggerViewPresentor.super.ctor(self)
end

function BossTriggerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BossTriggerViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/bosstriggerview.prefab"
	}
end

function BossTriggerViewPresentor:buildViews()
	return {
		BossTriggerView.New()
	}
end

return BossTriggerViewPresentor
