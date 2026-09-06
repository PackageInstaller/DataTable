-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionRightView.lua

module("logic.extensions.mission.view.BFMissionRightView", package.seeall)

local BFMissionRightView = class("BFMissionRightView", FormationRightView)

function BFMissionRightView:onEnter()
	BFMissionRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self._RefreshPetList, self)
end

function BFMissionRightView:onExit()
	BFMissionRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self._RefreshPetList, self)
end

function BFMissionRightView:getAllShowPetList()
	return BreakFormationModel.instance:getAllPetList(true)
end

return BFMissionRightView
