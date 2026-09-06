-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuswishtreetaskViewPresentor.lua

module("logic.extensions.babybus.view.BabybuswishtreetaskViewPresentor", package.seeall)

local BabybuswishtreetaskViewPresentor = class("BabybuswishtreetaskViewPresentor", ViewPresentor)

function BabybuswishtreetaskViewPresentor:ctor()
	BabybuswishtreetaskViewPresentor.super.ctor(self)
end

function BabybuswishtreetaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BabybuswishtreetaskViewPresentor:dependWhatResources()
	return {
		"ui/views/babybus/babybuswishtreetaskview.prefab"
	}
end

function BabybuswishtreetaskViewPresentor:buildViews()
	return {
		BabybuswishtreetaskView.New()
	}
end

return BabybuswishtreetaskViewPresentor
