local ThemeThirdBossLineConfig = require("app.view.module.summerThemeThirdBoss.const.ThemeThirdBossLineConfig")
local var_0_1 = g.core.config.activity_theme_talent_info
local ThemeThirdBossTalentStruct = class("ThemeThirdBossTalentStruct")

function ThemeThirdBossTalentStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._info = var_0_1.get(arg_1_1)
	self._parentList = {}
	self._childList = {}
	self._isActive = false
end

function ThemeThirdBossTalentStruct:addParent(arg_2_1)
	table.insert(self._parentList, arg_2_1)
end

function ThemeThirdBossTalentStruct:addChild(arg_3_1)
	table.insert(self._childList, arg_3_1)
end

function ThemeThirdBossTalentStruct:getParentList()
	return self._parentList
end

function ThemeThirdBossTalentStruct:getChildList()
	return self._childList
end

function ThemeThirdBossTalentStruct:getId()
	return self._id
end

function ThemeThirdBossTalentStruct:getInfo()
	return self._info
end

function ThemeThirdBossTalentStruct:setActive(arg_8_1)
	self._isActive = arg_8_1 == true
end

function ThemeThirdBossTalentStruct:isActive()
	return self._isActive
end

function ThemeThirdBossTalentStruct:parentIsActive()
	for iter_10_0, iter_10_1 in ipairs(self._parentList) do
		if iter_10_1:isActive() then
			return true
		end
	end

	return #self._parentList == 0
end

function ThemeThirdBossTalentStruct:getName()
	return self._info.pot_name
end

function ThemeThirdBossTalentStruct:findAllChildCanReset(arg_12_1)
	arg_12_1[self:getId()] = self

	for iter_12_0, iter_12_1 in ipairs((self:getChildList())) do
		if iter_12_1:isActive() then
			local var_12_0 = true

			for iter_12_2, iter_12_3 in ipairs((iter_12_1:getParentList())) do
				local var_12_1 = iter_12_3:getId()

				if not arg_12_1[var_12_1] and var_12_1 ~= self:getId() and iter_12_3:isActive() then
					var_12_0 = false

					break
				end
			end

			if var_12_0 then
				iter_12_1:findAllChildCanReset(arg_12_1)
			end
		end
	end
end

function ThemeThirdBossTalentStruct:getPreLineType()
	self._preLineType = self._preLineType or self:_getPreLineType()

	return self._preLineType
end

function ThemeThirdBossTalentStruct:getNextLineType()
	self._nextLineType = self._nextLineType or self:_getNextLineType()

	return self._nextLineType
end

function ThemeThirdBossTalentStruct:_getNextLineType()
	if not self._childList[1] then
		return ThemeThirdBossLineConfig.lineNextType.NONE
	end

	local var_15_0 = #self._childList

	if #self._childList == 2 then
		return ThemeThirdBossLineConfig.lineNextType.HORIZONTAL
	elseif var_15_0 == 1 then
		local var_15_1 = self:getInfo().pot_location - self._childList[1]:getInfo().pot_location

		if var_15_1 == 0 then
			return ThemeThirdBossLineConfig.lineNextType.HORIZONTAL
		elseif var_15_1 == 1 then
			return ThemeThirdBossLineConfig.lineNextType.TWO_ONE_UP
		elseif var_15_1 == -1 then
			return ThemeThirdBossLineConfig.lineNextType.TWO_ONE_DOWN
		end
	end

	return ThemeThirdBossLineConfig.lineNextType.NONE
end

function ThemeThirdBossTalentStruct:_getPreLineType()
	if not self._parentList[1] then
		return ThemeThirdBossLineConfig.linePreType.NONE
	end

	if #self._parentList == 2 then
		return ThemeThirdBossLineConfig.linePreType.HORIZONTAL
	else
		local var_16_0 = self:getInfo().pot_location - self._parentList[1]:getInfo().pot_location

		if var_16_0 == 0 then
			return ThemeThirdBossLineConfig.linePreType.HORIZONTAL
		elseif var_16_0 == -1 then
			return ThemeThirdBossLineConfig.linePreType.ONE_TWO_UP
		elseif var_16_0 == 1 then
			return ThemeThirdBossLineConfig.linePreType.ONE_TWO_DOWN
		end
	end

	return ThemeThirdBossLineConfig.linePreType.NONE
end

function ThemeThirdBossTalentStruct:getPreLineWidth()
	return ThemeThirdBossLineConfig.linePreWidth[self:getPreLineType()]
end

function ThemeThirdBossTalentStruct:getNextLineWidth()
	return ThemeThirdBossLineConfig.lineNextWidth[self:getNextLineType()]
end

function ThemeThirdBossTalentStruct:getPreIsUnlock()
	for iter_19_0, iter_19_1 in pairs(self._parentList) do
		if iter_19_1:isActive() then
			return true
		end
	end

	return false
end

function ThemeThirdBossTalentStruct:getChildIsUnlock()
	for iter_20_0, iter_20_1 in pairs(self._childList) do
		if iter_20_1:isActive() then
			return true
		end
	end

	return false
end

return ThemeThirdBossTalentStruct
