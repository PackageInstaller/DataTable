-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/mission/AceteamFmtRightView.lua

module("logic.extensions.aceteam.view.mission.mission.AceteamFmtRightView", package.seeall)

local AceteamFmtRightView = class("AceteamFmtRightView", FormationRightView)

function AceteamFmtRightView:_getCurFormation()
	return AceTeamModel.instance:GetCurFormation()
end

return AceteamFmtRightView
