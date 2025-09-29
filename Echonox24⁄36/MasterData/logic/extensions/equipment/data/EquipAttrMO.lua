-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/EquipAttrMO.lua

module("logic.extensions.equipment.data.EquipAttrMO", package.seeall)

local M = class("EquipAttrMO")

function M:ctor(EquipAttrNO)
	self:updateByNo(EquipAttrNO)
end

function M:updateByNo(EquipAttrNO)
	self._attrId = EquipAttrNO.attrId
	self._value = tonumber(EquipAttrNO.value) or 0
	self._baseValue = tonumber(EquipAttrNO.baseValue) or 0
	self._enhancedValue = EquipAttrNO.enhancedValue or 0
	self._co = EquipmentConfig.instance:getConfigByKey(ConfigName.AttrPartDefine, self._attrId)
end

function M:getAttrId()
	return self._attrId
end

function M:getName()
	return self._co.name
end

function M:getValue()
	return self._enhancedValue > 0 and self._enhancedValue or self._value
end

function M:getBaseValue()
	return self._baseValue
end

function M:getSourceValue()
	return self._value
end

function M:getEnhancedAddValue()
	return self._enhancedValue - self._value
end

return M
