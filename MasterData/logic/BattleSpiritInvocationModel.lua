-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleSpiritInvocationModel.lua

module("logic.extensions.battle.model.BattleSpiritInvocationModel", package.seeall)

local BattleSpiritInvocationModel = class("BattleSpiritInvocationModel", BaseListModel)

function BattleSpiritInvocationModel:onReset()
	BattleSpiritInvocationModel.super.onReset(self)

	self._spiritInvocationInfo = nil
end

function BattleSpiritInvocationModel:onBattleStart(battleData)
	self._spiritInvocationInfo = nil

	local originalStates = battleData.originalStates

	for i = 1, #originalStates.teams do
		local team = originalStates.teams[i]

		if team.playerView and team.playerView:HasField("spiritInvocationSkillFightView") then
			local spiritInvocationSkill = team.playerView.spiritInvocationSkillFightView

			self:setSpiritInvocationInfo(team.teamId, spiritInvocationSkill)
		end
	end
end

function BattleSpiritInvocationModel:setSpiritInvocationInfo(teamId, info)
	self._spiritInvocationInfo = self._spiritInvocationInfo or {}

	if not self._spiritInvocationInfo[teamId] then
		local infoMO = BattleSpiritInvocationSkillMO.New()

		infoMO.spiritInvocationSkillId = info.skillId
		infoMO.minTriggerProgress = info.minTriggerProgress
		infoMO.curProgress = info.curProgress
		infoMO.spiritInvocationSummonPetId = info.spiritInvocationSummonPetId
		self._spiritInvocationInfo[teamId] = infoMO

		GlobalDispatcher:dispatch(GlobalNotify.OnSpiritInvocationSkillFight, teamId)
	end
end

function BattleSpiritInvocationModel:getSpiritInvocationInfo(teamId)
	if self._spiritInvocationInfo then
		return self._spiritInvocationInfo[teamId]
	end
end

BattleSpiritInvocationModel.instance = BattleSpiritInvocationModel.New()

return BattleSpiritInvocationModel
