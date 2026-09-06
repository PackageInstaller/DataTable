-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/video/view/AnimationPlayingViewPresentor.lua

module("logic.extensions.video.view.AnimationPlayingViewPresentor", package.seeall)

local AnimationPlayingViewPresentor = class("AnimationPlayingViewPresentor", ViewPresentor)

function AnimationPlayingViewPresentor:attachToWhichRoot()
	return
end

function AnimationPlayingViewPresentor:dependWhatResources()
	return {
		CommonResPath.UIAnimationPlaying
	}
end

function AnimationPlayingViewPresentor:buildViews()
	return {
		AnimationPlayingView.New()
	}
end

return AnimationPlayingViewPresentor
