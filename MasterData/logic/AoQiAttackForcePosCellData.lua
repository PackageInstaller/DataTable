-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/model/AoQiAttackForcePosCellData.lua

module("logic.extensions.aoqiattackforce.model.AoQiAttackForcePosCellData", package.seeall)

local AoQiAttackForcePosCellData = class("AoQiAttackForcePosCellData")

function AoQiAttackForcePosCellData:ctor(x, y)
	self.posX = checknumber(x)
	self.posY = checknumber(y)
	self.isExist = false
	self.coverBlock = nil
end

function AoQiAttackForcePosCellData:setXAndY(x, y)
	self.posX = checknumber(x)
	self.posY = checknumber(y)
end

return AoQiAttackForcePosCellData
