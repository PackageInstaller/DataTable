-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/bingqibu/BingQiBuSummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.bingqibu.BingQiBuSummaryViewPresentor", package.seeall)

local BingQiBuSummaryViewPresentor = class("BingQiBuSummaryViewPresentor", ActivitySmallSummaryOneViewPresentor)

function BingQiBuSummaryViewPresentor:buildViews()
	return {
		BingQiBuSummaryView.New()
	}
end

return BingQiBuSummaryViewPresentor
