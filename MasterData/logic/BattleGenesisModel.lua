-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleGenesisModel.lua

module("logic.extensions.battle.model.BattleGenesisModel", package.seeall)

local BattleGenesisModel = class("BattleGenesisModel", BaseListModel)

function BattleGenesisModel:onReset()
	BattleGenesisModel.super.onReset(self)

	self._genesisInfo = nil
end

function BattleGenesisModel:onBattleStart(battleData)
	self._genesisInfo = nil

	local originalStates = battleData.originalStates

	for i = 1, #originalStates.teams do
		local team = originalStates.teams[i]

		if team.playerView and team.playerView:HasField("genesisSkillFightView") then
			local genesisSkill = team.playerView.genesisSkillFightView

			self:setGenesisInfo(team.teamId, genesisSkill)
		end
	end
end

function BattleGenesisModel:setGenesisInfo(teamId, info)
	self._genesisInfo = self._genesisInfo or {}

	if not self._genesisInfo[teamId] then
		local infoMO = BattleGenesisSkillMO.New()

		infoMO.genesisSkillId = infoMO.genesisSkillId
		infoMO.minTriggerProgress = info.minTriggerProgress
		infoMO.curProgress = info.curProgress
		infoMO.maxTriggerCount = info.maxTriggerCount
		infoMO.hasTriggerCount = info.hasTriggerCount
		self._genesisInfo[teamId] = infoMO

		GlobalDispatcher:dispatch(GlobalNotify.OnGenesisSkillFight, teamId)
	end
end

function BattleGenesisModel:getGenesisInfo(teamId)
	if self._genesisInfo then
		return self._genesisInfo[teamId]
	end
end

BattleGenesisModel.instance = BattleGenesisModel.New()

return BattleGenesisModel
