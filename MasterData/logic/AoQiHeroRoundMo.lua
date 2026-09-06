-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroRoundMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroRoundMo", package.seeall)

local AoQiHeroRoundMo = class("AoQiHeroRoundMo")

function AoQiHeroRoundMo:ctor()
	self.battleId = 0
	self.teamId = 0
	self.roundIndex = 0
	self.isInit = false
	self.belongUnit = nil
	self.skillMo = nil
	self.moveInfo = nil
	self.time = nil
	self.reportMos = {}
	self.reportMosList = {}
end

function AoQiHeroRoundMo:onRoundStart()
	local reportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeRoundStart, self.belongUnit)

	self:mergeReportMos(reportMos)
end

function AoQiHeroRoundMo:onRoundEnd()
	local reportMos = AoQiHeroBuffMgr.instance:activeBuff(AoQiHeroConst.TimeRoundEnd, self.belongUnit)

	self:mergeReportMos(reportMos)
end

function AoQiHeroRoundMo:onSkillEffect()
	self.skillMo:onStart(self.reportMos)
	self.skillMo:hpChange(self.reportMos)
	self.skillMo:onEnd(self.reportMos)
end

function AoQiHeroRoundMo:onMoveEntity()
	local endPos = self.moveInfo.path[self.moveInfo.step]
	local enemyMo = AoQiHeroEntityMgr.instance:getPet(self.moveInfo.target)

	if enemyMo.teamId == AoQiHeroConst.DefenceTeam then
		AoQiHeroBattleModel.instance:chengePos(self.moveInfo.target, enemyMo.pos, endPos)

		enemyMo.pos = endPos

		local reportMo = self.reportMos[self.moveInfo.target]

		if not reportMo then
			reportMo = AoQiHeroRoundMgr.instance:getNewReportMo()
			self.reportMos[reportMo.petId] = reportMo
		end

		reportMo.petId = self.moveInfo.target
		reportMo.isMove = true
		reportMo.path = self.moveInfo.path
		reportMo.isShow = true

		return true
	end

	return false
end

function AoQiHeroRoundMo:getReportMoList()
	return table.values(self.reportMos)
end

function AoQiHeroRoundMo:startMotion()
	local haveInfo = false

	for i, v in pairs(self.reportMos) do
		haveInfo = true

		break
	end

	if haveInfo then
		table.insert(self.reportMosList, self.reportMos)
	end

	self.reportMos = {}
end

function AoQiHeroRoundMo:mergeReportMos(reportMos)
	for i, v in pairs(reportMos) do
		local reportMo = self.reportMos[v.petId]

		if not reportMo then
			self.reportMos[v.petId] = v
		else
			reportMo.attackHps = reportMo.attackHps + v.attackHps
			reportMo.afterRoundHp = v.afterRoundHp
			reportMo.totalHpChange = reportMo.totalHpChange + v.totalHpChange

			local seen = {}

			for _, value in ipairs(reportMo.buffIds) do
				seen[value] = true
			end

			for _, value in ipairs(v.buffIds) do
				if not seen[value] then
					table.insert(reportMo.buffIds, value)

					seen[value] = true
				end
			end

			for _, buffIds in ipairs(v.effectHpBuffIds) do
				table.insert(reportMo.effectHpBuffIds, buffIds)
			end
		end
	end
end

return AoQiHeroRoundMo
