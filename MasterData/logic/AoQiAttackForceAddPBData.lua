-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/model/AoQiAttackForceAddPBData.lua

module("logic.extensions.aoqiattackforce.model.AoQiAttackForceAddPBData", package.seeall)

local AoQiAttackForceAddPBData = class("AoQiAttackForceAddPBData")

function AoQiAttackForceAddPBData:ctor()
	self.id = 0
	self.shapeType = 0
	self.itemRCList = {}
	self.oi = 0
	self.oj = 0
	self.isPack = true
end

function AoQiAttackForceAddPBData:initData(shapeType)
	self.shapeType = shapeType
	self.itemRCList = AoQiAttackForceConfig.instance:getRCListByShapeTypeID(self.shapeType)
end

return AoQiAttackForceAddPBData
