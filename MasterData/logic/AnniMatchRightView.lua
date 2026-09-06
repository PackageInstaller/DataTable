-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/mission/AnniMatchRightView.lua

module("logic.extensions.annimatch.view.mission.AnniMatchRightView", package.seeall)

local AnniMatchRightView = class("AnniMatchRightView", FormationRightView)

function AnniMatchRightView:getAllShowPetList()
	local activityId = self._viewPresentor:getFirstParam()

	return AnnimatchModel.instance:getPetList(activityId)
end

function AnniMatchRightView:_getCurFormation()
	local activityId = self._viewPresentor:getFirstParam()

	return (AnnimatchModel.instance:getFormationMo(activityId))
end

return AnniMatchRightView
