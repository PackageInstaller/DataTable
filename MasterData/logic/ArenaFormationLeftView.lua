-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaFormationLeftView.lua

module("logic.extensions.arena.view.ArenaFormationLeftView", package.seeall)

local ArenaFormationLeftView = class("ArenaFormationLeftView", BuzhenLeftView)

function ArenaFormationLeftView:onEnter()
	self._oriTeamId = FormationNewModel.instance:GetCurTeamId()

	FormationNewModel.instance:SetCurTeamId(FormationNewModel.arenaTeamId)
	ArenaFormationLeftView.super.onEnter(self)
	self._Btn_Formation:SetActive(false)
	GameUtil.setAnchoredPos(self._Btn_BuffForm, 73, 192)
end

function ArenaFormationLeftView:onExit()
	self:_onExitUnbindingEvent()
	FormationNewModel.instance:SetCurTeamId(self._oriTeamId)
end

return ArenaFormationLeftView
