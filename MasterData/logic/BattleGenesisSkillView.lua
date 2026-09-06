-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleGenesisSkillView.lua

module("logic.extensions.battle.view.BattleGenesisSkillView", package.seeall)

local BattleGenesisSkillView = class("BattleGenesisSkillView", ViewComponent)
local UnityTime = UnityEngine.Time

function BattleGenesisSkillView:buildUI()
	BattleGenesisSkillView.super.buildUI(self)

	self._GenesisSkillNodes = {}
	self._GenesisSkillNodes[GameEnum.BattleTeam.Left] = BattleGenesisSkillComponent.New(self:getGo("top/myship/Genesisship"), self, GameEnum.BattleTeam.Left)
	self._GenesisSkillNodes[GameEnum.BattleTeam.Right] = BattleGenesisSkillComponent.New(self:getGo("top/othership/OtherGenesisship"), self, GameEnum.BattleTeam.Right)
end

function BattleGenesisSkillView:onEnter()
	BattleGenesisSkillView.super:onEnter(self)

	for k, v in pairs(self._GenesisSkillNodes) do
		v:onEnter()
		self:_updateGenesisSkillFight(k)
	end

	settimer(0, self._updateProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGenesisSkillFight, self._updateGenesisSkillFight, self)
end

function BattleGenesisSkillView:onExit()
	removetimer(self._updateProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGenesisSkillFight, self._updateGenesisSkillFight, self)
	BattleGenesisSkillView.super:onExit(self)

	for k, v in pairs(self._GenesisSkillNodes) do
		v:onExit()
	end
end

function BattleGenesisSkillView:_updateProgress()
	for k, v in pairs(self._GenesisSkillNodes) do
		v:updateProgress(UnityTime.deltaTime)
	end
end

function BattleGenesisSkillView:_updateGenesisSkillFight(teamId)
	local info = BattleGenesisModel.instance:getGenesisInfo(teamId)

	self._GenesisSkillNodes[teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()]:setInfo(info)
end

return BattleGenesisSkillView
