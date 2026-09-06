-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/AnheimmMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mission.AnheimmMissionViewPresentor", package.seeall)

local AnheimmMissionViewPresentor = class("AnheimmMissionViewPresentor", MissionViewPresentor)

function AnheimmMissionViewPresentor:buildViews()
	return {
		AnheimmMissionView.New(),
		AnheimmFmtRightView.New(),
		AnheimmFmtLeftView.New(),
		AnheimmMissionFmtView.New()
	}
end

return AnheimmMissionViewPresentor
