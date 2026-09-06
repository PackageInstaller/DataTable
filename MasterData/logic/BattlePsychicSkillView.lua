-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattlePsychicSkillView.lua

module("logic.extensions.battle.view.BattlePsychicSkillView", package.seeall)

local BattlePsychicSkillView = class("BattlePsychicSkillView", ViewComponent)
local UnityTime = UnityEngine.Time

function BattlePsychicSkillView:buildUI()
	BattlePsychicSkillView.super.buildUI(self)

	self._psychicSkillNodes = {}
	self._psychicSkillNodes[GameEnum.BattleTeam.Left] = BattlePsychicSkillComponent.New(self:getGo("top/myship/Mediumship"), self, GameEnum.BattleTeam.Left)
	self._psychicSkillNodes[GameEnum.BattleTeam.Right] = BattlePsychicSkillComponent.New(self:getGo("top/othership/OtherMediumship"), self, GameEnum.BattleTeam.Right)
end

function BattlePsychicSkillView:onEnter()
	BattlePsychicSkillView.super:onEnter(self)

	for k, v in pairs(self._psychicSkillNodes) do
		v:onEnter()
		self:_updatePsychicSkillFight(k)
	end

	settimer(0, self._updateProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.OnPsychicSkillFight, self._updatePsychicSkillFight, self)
end

function BattlePsychicSkillView:onExit()
	removetimer(self._updateProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPsychicSkillFight, self._updatePsychicSkillFight, self)
	BattlePsychicSkillView.super:onExit(self)

	for k, v in pairs(self._psychicSkillNodes) do
		v:onExit()
	end
end

function BattlePsychicSkillView:_updateProgress()
	for k, v in pairs(self._psychicSkillNodes) do
		v:updateProgress(UnityTime.deltaTime)
	end
end

function BattlePsychicSkillView:_updatePsychicSkillFight(teamId)
	local info = BattlePsychicModel.instance:getPsychicInfo(teamId)

	self._psychicSkillNodes[teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()]:setPsychicInfo(info)
end

return BattlePsychicSkillView
