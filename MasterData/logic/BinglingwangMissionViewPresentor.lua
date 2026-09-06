-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/mission/BinglingwangMissionViewPresentor.lua

module("logic.extensions.mangtower.view.BinglingwangMissionViewPresentor", package.seeall)

local BinglingwangMissionViewPresentor = class("BinglingwangMissionViewPresentor", MissionViewPresentor)

function BinglingwangMissionViewPresentor:buildViews()
	return {
		BinglingwangMissionView.New(),
		BinglingwangFmtRightView.New(),
		BinglingwangFmtLeftView.New(),
		BinglingwangMissionFmtView.New()
	}
end

return BinglingwangMissionViewPresentor
