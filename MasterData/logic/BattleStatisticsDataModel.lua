-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleStatisticsDataModel.lua

module("logic.extensions.battle.model.BattleStatisticsDataModel", package.seeall)

local BattleStatisticsDataModel = class("BattleStatisticsDataModel", BaseListModel)

function BattleStatisticsDataModel:onReset()
	BattleStatisticsDataModel.super.onReset(self)

	self._statistics = {}
	self._myTeamId = 0
	self._enemyTeamId = 1
end

function BattleStatisticsDataModel:onInit()
	BattleStatisticsDataModel.super.onInit(self)

	self._statistics = {}
	self._myTeamId = 0
	self._enemyTeamId = 1
end

function BattleStatisticsDataModel:getStatistics(teamId)
	local statisMos = self._statistics[teamId]
	local mos = {}

	if statisMos then
		for k, v in pairs(statisMos) do
			table.insert(mos, v)
		end
	end

	return mos
end

function BattleStatisticsDataModel:getTotalDamage(teamId)
	local statisMos = self._statistics[teamId]
	local damage = 0

	if statisMos then
		for k, v in pairs(statisMos) do
			damage = damage + v.damage
		end
	end

	return math.max(damage, 1)
end

function BattleStatisticsDataModel:getTotalDefDamage(teamId)
	local statisMos = self._statistics[teamId]
	local damage = 0

	if statisMos then
		for k, v in pairs(statisMos) do
			damage = damage + v.defentDamage
		end
	end

	return math.max(damage, 1)
end

function BattleStatisticsDataModel:getTotalTreatment(teamId)
	local statisMos = self._statistics[teamId]
	local treatment = 0

	if statisMos then
		for k, v in pairs(statisMos) do
			treatment = treatment + v.treatment
		end
	end

	return math.max(treatment, 1)
end

function BattleStatisticsDataModel:clearStatics()
	self._statistics = {}
end

function BattleStatisticsDataModel:onBtlEndRes(btlEndRes)
	if not btlEndRes.teamAStatistics then
		if not btlEndRes.teamBStatistics then
			local teamBStatistics = {}

			self._statistics = {}
			self._statistics[self._myTeamId] = {}
			self._statistics[self._enemyTeamId] = {}

			for i, v in ipairs(btlEndRes.teamAStatistics) do
				local mo = BattleStatisticsMo.New()

				mo.teamId = self._myTeamId
				mo.charactorId = v.petId
				mo.damage = checknumber(v.damage)
				mo.treatment = checknumber(v.heal)
				mo.defentDamage = checknumber(v.endure)
				mo.faceId = v.faceId
				mo.petLv = v.lv

				table.insert(self._statistics[self._myTeamId], mo)
			end

			for i, v in ipairs(teamBStatistics) do
				local mo = BattleStatisticsMo.New()

				mo.teamId = self._enemyTeamId
				mo.charactorId = v.petId
				mo.damage = checknumber(v.damage)
				mo.treatment = checknumber(v.heal)
				mo.defentDamage = checknumber(v.endure)
				mo.faceId = v.faceId
				mo.petLv = v.lv

				table.insert(self._statistics[self._enemyTeamId], mo)
			end
		end
	end
end

BattleStatisticsDataModel.instance = BattleStatisticsDataModel.New()

return BattleStatisticsDataModel
