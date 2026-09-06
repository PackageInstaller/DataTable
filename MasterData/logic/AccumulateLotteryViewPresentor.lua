-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatelottery/view/AccumulateLotteryViewPresentor.lua

module("logic.extensions.accumulatelottery.view.AccumulateLotteryViewPresentor", package.seeall)

local AccumulateLotteryViewPresentor = class("AccumulateLotteryViewPresentor", ViewPresentor)

function AccumulateLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AccumulateLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulatelottery/accumulatelotteryview.prefab"
	}
end

function AccumulateLotteryViewPresentor:buildViews()
	return {
		AccumulateLotteryView.New()
	}
end

function AccumulateLotteryViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AccumulateLotteryViewPresentor
