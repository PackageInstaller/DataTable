-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaMissionViewPresentor", package.seeall)

local AthenaMissionViewPresentor = class("AthenaMissionViewPresentor", MissionViewPresentor)

function AthenaMissionViewPresentor:buildViews()
	return {
		AthenaMissionView.New(),
		AthenaFormationRightView.New(),
		AthenaFormationLeftView.New(),
		AthenaMissionFmtView.New()
	}
end

return AthenaMissionViewPresentor
