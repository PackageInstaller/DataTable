-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroReportMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroReportMo", package.seeall)

local AoQiHeroReportMo = class("AoQiHeroReportMo")

function AoQiHeroReportMo:ctor()
	self.petId = 0
	self.isCritical = false
	self.attackHps = 0
	self.afterRoundHp = 0
	self.buffIds = {}
	self.totalHpChange = 0
	self.isSkill = false
	self.effectHpBuffIds = {}
	self.isMove = false
	self.path = nil
	self.isShow = false
end

function AoQiHeroReportMo:reset()
	self.petId = 0
	self.isCritical = false
	self.totalHpChange = 0
	self.attackHps = 0
	self.afterRoundHp = 0
	self.isSkill = false
	self.isMove = false
	self.path = nil

	table.clear(self.buffIds)
	table.clear(self.effectHpBuffIds)
end

return AoQiHeroReportMo
