-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/mission/AceteamMissionViewPresentor.lua

module("logic.extensions.fbbchallenge.view.mission.AceteamMissionViewPresentor", package.seeall)

local AceteamMissionViewPresentor = class("AceteamMissionViewPresentor", MissionViewPresentor)

function AceteamMissionViewPresentor:buildViews()
	return {
		AceteamMissionView.New(),
		AceteamFormationRightView.New(),
		AceteamFmtLeftView.New(),
		AceteamMissionFmtView.New()
	}
end

return AceteamMissionViewPresentor
