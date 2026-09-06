-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/model/AoQiAttackForceEquipmentData.lua

module("logic.extensions.aoqiattackforce.model.AoQiAttackForceEquipmentData", package.seeall)

local AoQiAttackForceEquipmentData = class("AoQiAttackForceEquipmentData")

function AoQiAttackForceEquipmentData:ctor()
	self.cfg = nil
	self.curLevel = 0
	self.curStarLv = 1
	self.id = 0
	self.defineId = 0
	self.defineIdOutGame = 0
	self.shapeType = 0
	self.oi = 0
	self.oj = 0
	self.itemRCList = {}
	self.isPack = false
	self.curExtraHPMax = 0

	self:clearLinkMap()
end

function AoQiAttackForceEquipmentData:initData(activityId, defineId, starLv, level)
	self.curLevel = level
	self.curStarLv = starLv
	self.defineId = defineId
	self.defineIdOutGame = AoQiAttackForceConfig.instance:getEquipmentIdByIdInGame(activityId, self.defineId)
	self.cfg = AoQiAttackForceConfig.instance:getEquipmentInGameCfg(self.defineId, self.curStarLv)

	if self.defineIdOutGame ~= 0 then
		self.lvCfg = AoQiAttackForceConfig.instance:getEquipmentUpgradeCfgByLv(activityId, self.defineIdOutGame, self.curLevel)
	end

	self.shapeType = self.cfg.shapeType
	self.itemRCList = AoQiAttackForceConfig.instance:getRCListByShapeTypeID(self.shapeType)

	self:_calCurHp()
end

function AoQiAttackForceEquipmentData:isStarLvMax()
	return not AoQiAttackForceConfig.instance:getEquipmentInGameCfg(self.defineId, self.curStarLv + 1)
end

function AoQiAttackForceEquipmentData:getEquipType()
	return self.cfg.equipmentType
end

function AoQiAttackForceEquipmentData:getShapeType()
	return self.shapeType
end

function AoQiAttackForceEquipmentData:_calCurHp()
	self.curExtraHPMax = 0

	if self.lvCfg and self.cfg then
		local baseHPMax = self.lvCfg.MaxHP
		local basePercentage = 100 + self.cfg.MaxHPRate

		self.curExtraHPMax = baseHPMax * basePercentage / 100
	end
end

function AoQiAttackForceEquipmentData:getCurHpMax()
	return self.curExtraHPMax
end

function AoQiAttackForceEquipmentData:updateCurStarLV(newStarLv)
	self.curStarLv = newStarLv
	self.cfg = AoQiAttackForceConfig.instance:getEquipmentInGameCfg(self.defineId, self.curStarLv)
end

function AoQiAttackForceEquipmentData:clearLinkMap()
	self.linkMap = {}
end

function AoQiAttackForceEquipmentData:AddLinkEquiptId(equiptId)
	self.linkMap[equiptId] = true
end

function AoQiAttackForceEquipmentData:getCurLinkMap()
	return self.linkMap
end

return AoQiAttackForceEquipmentData
