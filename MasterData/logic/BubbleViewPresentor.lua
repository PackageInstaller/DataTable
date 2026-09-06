-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bubble/view/BubbleViewPresentor.lua

module("logic.extensions.bubble.view.BubbleViewPresentor", package.seeall)

local BubbleViewPresentor = class("BubbleViewPresentor", ViewPresentor)

function BubbleViewPresentor:ctor()
	BubbleViewPresentor.super.ctor(self)
end

function BubbleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BubbleViewPresentor:dependWhatResources()
	return {
		"ui/views/bubble/bubbleview.prefab"
	}
end

function BubbleViewPresentor:buildViews()
	return {
		BubbleView.New()
	}
end

return BubbleViewPresentor
