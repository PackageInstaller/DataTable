-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleSpiritInvocationSkillView.lua

module("logic.extensions.battle.view.BattleSpiritInvocationSkillView", package.seeall)

local BattleSpiritInvocationSkillView = class("BattleSpiritInvocationSkillView", ViewComponent)
local UnityTime = UnityEngine.Time

function BattleSpiritInvocationSkillView:buildUI()
	BattleSpiritInvocationSkillView.super.buildUI(self)

	self._spiritInvocationSkillNodes = {}
	self._spiritInvocationSkillNodes[GameEnum.BattleTeam.Left] = BattleSpiritInvocationSkillComponent.New(self:getGo("spiritInvocationPet/left/ship/SpiritInvocationship"), self, GameEnum.BattleTeam.Left)
	self._spiritInvocationSkillNodes[GameEnum.BattleTeam.Right] = BattleSpiritInvocationSkillComponent.New(self:getGo("spiritInvocationPet/right/ship/OtherSpiritInvocationship"), self, GameEnum.BattleTeam.Right)
end

function BattleSpiritInvocationSkillView:onEnter()
	BattleSpiritInvocationSkillView.super.onEnter(self)

	for k, v in pairs(self._spiritInvocationSkillNodes) do
		v:onEnter()
		self:_updateSpiritInvocationSkillFight(k)
	end

	settimer(0, self._updateProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSpiritInvocationSkillFight, self._updateSpiritInvocationSkillFight, self)
end

function BattleSpiritInvocationSkillView:onExit()
	removetimer(self._updateProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSpiritInvocationSkillFight, self._updateSpiritInvocationSkillFight, self)
	BattleSpiritInvocationSkillView.super.onExit(self)

	for k, v in pairs(self._spiritInvocationSkillNodes) do
		v:onExit()
	end
end

function BattleSpiritInvocationSkillView:_updateProgress()
	for k, v in pairs(self._spiritInvocationSkillNodes) do
		v:updateProgress(UnityTime.deltaTime)
	end
end

function BattleSpiritInvocationSkillView:_updateSpiritInvocationSkillFight(teamId)
	local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(teamId)

	self._spiritInvocationSkillNodes[teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()]:setInfo(info)
end

return BattleSpiritInvocationSkillView
