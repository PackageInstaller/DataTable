-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattlePsychicModel.lua

module("logic.extensions.battle.model.BattlePsychicModel", package.seeall)

local BattlePsychicModel = class("BattlePsychicModel", BaseListModel)

function BattlePsychicModel:onReset()
	BattlePsychicModel.super.onReset(self)

	self._psychicInfo = nil
end

function BattlePsychicModel:onBattleStart(battleData)
	self._psychicInfo = nil

	local originalStates = battleData.originalStates

	for i = 1, #originalStates.teams do
		local team = originalStates.teams[i]

		if team.playerView and team.playerView:HasField("psychicSkillFightView") then
			local psychicSkill = team.playerView.psychicSkillFightView

			self:setPsychicInfo(team.teamId, psychicSkill)
		end
	end
end

function BattlePsychicModel:setPsychicInfo(teamId, info)
	self._psychicInfo = self._psychicInfo or {}

	if not self._psychicInfo[teamId] then
		local infoMO = BattlePsychicSkillMO.New()

		infoMO.psychicSkillId = infoMO.psychicSkillId
		infoMO.minTriggerProgress = info.minTriggerProgress
		infoMO.curProgress = info.curProgress
		infoMO.maxTriggerCount = info.maxTriggerCount
		infoMO.hasTriggerCount = info.hasTriggerCount
		self._psychicInfo[teamId] = infoMO

		GlobalDispatcher:dispatch(GlobalNotify.OnPsychicSkillFight, teamId)
	end
end

function BattlePsychicModel:getPsychicInfo(teamId)
	if self._psychicInfo then
		return self._psychicInfo[teamId]
	end
end

BattlePsychicModel.instance = BattlePsychicModel.New()

return BattlePsychicModel
