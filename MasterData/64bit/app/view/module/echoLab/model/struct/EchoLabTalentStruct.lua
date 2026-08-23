local var_0_0 = g.core.config.attribute_info
local EchoLabTreeLineConfig = require("app.view.module.echoLab.const.EchoLabTreeLineConfig")
local var_0_2 = g.core.const.ConstMgr.EchoLabConst
local EchoLabTalentStruct = class("EchoLabTalentStruct")

function EchoLabTalentStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._info = nil
	self._isActive = false
	self._preTalentList = {}
	self._nextTalentList = {}
	self._preLineType = nil
	self._preWidth = nil
	self._nextLineType = nil
	self._nextWidth = nil
end

function EchoLabTalentStruct:addInfo(arg_2_1)
	self._info = arg_2_1
end

function EchoLabTalentStruct:addNext(arg_3_1)
	table.insert(self._nextTalentList, arg_3_1)
end

function EchoLabTalentStruct:addPre(arg_4_1)
	table.insert(self._preTalentList, arg_4_1)
end

function EchoLabTalentStruct:setActive(arg_5_1)
	self._isActive = arg_5_1 == true
end

function EchoLabTalentStruct:getNextLineType()
	self._nextLineType = self._nextLineType or self:_getNextLineType()

	return self._nextLineType
end

function EchoLabTalentStruct:getNextIsUnlock()
	for iter_7_0, iter_7_1 in pairs(self._nextTalentList) do
		if not iter_7_1:isActive() then
			return false
		end
	end

	return true
end

function EchoLabTalentStruct:_getNextLineType()
	if not self._nextTalentList[1] then
		return EchoLabTreeLineConfig.lineNextType.NONE
	end

	local var_8_0 = self:isBig()

	if #self._nextTalentList == 2 then
		local var_8_1 = math.abs(self:getGridX() - self._nextTalentList[1]:getGridX())

		if var_8_1 == 2 then
			return (var_8_0 or nil) and (EchoLabTreeLineConfig.lineNextType.HORIZONTAL_BIG or EchoLabTreeLineConfig.lineNextType.HORIZONTAL_SMALL)
		elseif var_8_1 == 1 then
			if var_8_0 then
				return EchoLabTreeLineConfig.lineNextType.ONE_TWO_BIG
			else
				return EchoLabTreeLineConfig.lineNextType.ONE_TWO_SMALL
			end
		end
	elseif #self._nextTalentList == 1 then
		local var_8_2 = self:getGridY() - self._nextTalentList[1]:getGridY()

		if var_8_2 == 0 then
			return (var_8_0 or nil) and (EchoLabTreeLineConfig.lineNextType.HORIZONTAL_BIG or EchoLabTreeLineConfig.lineNextType.HORIZONTAL_SMALL)
		elseif var_8_2 == 1 then
			return EchoLabTreeLineConfig.lineNextType.TWO_ONE_DOWN_SMALL
		elseif var_8_2 == -1 then
			return EchoLabTreeLineConfig.lineNextType.TWO_ONE_UP_SMALL
		elseif var_8_2 == 2 then
			return EchoLabTreeLineConfig.lineNextType.TWO_ONE_DOWN_BIG
		elseif var_8_2 == -2 then
			return EchoLabTreeLineConfig.lineNextType.TWO_ONE_UP_BIG
		else
			assert(false, string.format("talent %s and n_preTalent %s Y length is %s", self:getId(), self._nextTalentList[1]:getId(), var_8_2))
		end
	else
		assert(false, string.format("talent &s has %s count n_preTalent", self:getId(), #self._nextTalentList))
	end

	return EchoLabTreeLineConfig.lineNextType.NONE
end

function EchoLabTalentStruct:getPreTalentList()
	return self._preTalentList
end

function EchoLabTalentStruct:getNextTalentList()
	return self._nextTalentList
end

function EchoLabTalentStruct:getPreLineType()
	self._preLineType = self._preLineType or self:_getPreLineType()

	return self._preLineType
end

function EchoLabTalentStruct:getPreIsUnlock()
	for iter_12_0, iter_12_1 in pairs(self._preTalentList) do
		if not iter_12_1:isActive() then
			return false
		end
	end

	return true
end

function EchoLabTalentStruct:_getPreLineType()
	if not self._preTalentList[1] then
		return EchoLabTreeLineConfig.linePreType.NONE
	end

	local var_13_0 = self:isBig()
	local var_13_1 = math.abs(self:getGridX() - self._preTalentList[1]:getGridX())

	if var_13_1 == 1 then
		return EchoLabTreeLineConfig.linePreType.NONE
	elseif var_13_1 == 2 then
		if #self._preTalentList == 2 then
			return (var_13_0 or nil) and (EchoLabTreeLineConfig.linePreType.HORIZONTAL_BIG or EchoLabTreeLineConfig.linePreType.HORIZONTAL_SMALL)
		else
			local var_13_2 = self:getGridY() - self._preTalentList[1]:getGridY()

			if var_13_2 == 0 then
				return (var_13_0 or nil) and (EchoLabTreeLineConfig.linePreType.HORIZONTAL_BIG or EchoLabTreeLineConfig.linePreType.HORIZONTAL_SMALL)
			elseif var_13_2 == -1 then
				return EchoLabTreeLineConfig.linePreType.ONE_TWO_DOWN_SMALL
			elseif var_13_2 == 1 then
				return EchoLabTreeLineConfig.linePreType.ONE_TWO_UP_SMALL
			elseif var_13_2 == -2 then
				return EchoLabTreeLineConfig.linePreType.ONE_TWO_DOWN_BIG
			elseif var_13_2 == 2 then
				return EchoLabTreeLineConfig.linePreType.ONE_TWO_UP_BIG
			else
				assert(false, string.format("talent %s and _preTalent %s Y length is %s", self:getId(), self._preTalentList[1]:getId(), var_13_2))
			end
		end
	end

	return EchoLabTreeLineConfig.linePreType.NONE
end

function EchoLabTalentStruct:getXYKey(arg_14_1, arg_14_2)
	return self:getGridX() .. "_" .. self:getGridY()
end

function EchoLabTalentStruct:getId()
	return self._id
end

function EchoLabTalentStruct:getIcon()
	local var_16_0 = ""

	if self:isBig() then
		var_16_0 = "huixiangzhongduan"
	else
		local var_16_1 = var_0_0.get(self:getInfo().affect_type_1)

		if self:getNodeType() == var_0_2.NODE_TYPE1.VALUE1 then
			var_16_0 = var_16_1.icon
		elseif self:getNodeType() == var_0_2.NODE_TYPE1.VALUE3 then
			var_16_0 = var_16_1.icon_big
		end
	end

	return var_16_0
end

function EchoLabTalentStruct:getGridX()
	return self._info.x_seat
end

function EchoLabTalentStruct:getGridY()
	return self._info.y_seat
end

function EchoLabTalentStruct:getPreLineWidth()
	return EchoLabTreeLineConfig.linePreWidth[self:getPreLineType()]
end

function EchoLabTalentStruct:getNextLineWidth()
	return EchoLabTreeLineConfig.lineNextWidth[self:getNextLineType()]
end

function EchoLabTalentStruct:getName()
	return g.core.lang:get(408900, {
		name = self._info.name,
		level = self._info.grade
	})
end

function EchoLabTalentStruct:getNodeType()
	return self._info.node_type
end

function EchoLabTalentStruct:isBig()
	return self:getNodeType() == var_0_2.NODE_TYPE1.VALUE2
end

function EchoLabTalentStruct:getInfo()
	return self._info
end

function EchoLabTalentStruct:getAttrList()
	local var_25_0 = {}

	for iter_25_0, iter_25_1, iter_25_2 in self._info.gmatch({
		"affect_type_%d+",
		"affect_value_%d+"
	}, true) do
		if iter_25_2[1] > 0 then
			table.insert(var_25_0, {
				type = iter_25_2[1],
				value = iter_25_2[2]
			})
		end
	end

	return var_25_0
end

function EchoLabTalentStruct:isActive()
	return self._isActive
end

function EchoLabTalentStruct:preIsActive()
	for iter_27_0, iter_27_1 in ipairs(self._preTalentList) do
		if not iter_27_1:isActive() then
			return false
		end
	end

	return true
end

return EchoLabTalentStruct
