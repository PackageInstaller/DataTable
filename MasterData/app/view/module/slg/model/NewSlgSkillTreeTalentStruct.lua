local NewSlgLineConfig = require("app.view.module.slg.const.NewSlgLineConfig")
local var_0_1 = g.core.config.new_slg_main_technology_info
local NewSlgSkillTreeTalentStruct = class("NewSlgSkillTreeTalentStruct")

function NewSlgSkillTreeTalentStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._info = var_0_1.get(arg_1_1)
	self._parentList = {}
	self._childList = {}
	self._isActive = false
end

function NewSlgSkillTreeTalentStruct:addParent(arg_2_1)
	table.insert(self._parentList, arg_2_1)
end

function NewSlgSkillTreeTalentStruct:addChild(arg_3_1)
	table.insert(self._childList, arg_3_1)
end

function NewSlgSkillTreeTalentStruct:getParentList()
	return self._parentList
end

function NewSlgSkillTreeTalentStruct:getChildList()
	return self._childList
end

function NewSlgSkillTreeTalentStruct:getId()
	return self._id
end

function NewSlgSkillTreeTalentStruct:getInfo()
	return self._info
end

function NewSlgSkillTreeTalentStruct:setActive(arg_8_1)
	self._isActive = arg_8_1 == true
end

function NewSlgSkillTreeTalentStruct:isActive()
	return self._isActive
end

function NewSlgSkillTreeTalentStruct:parentIsActive()
	for iter_10_0, iter_10_1 in ipairs(self._parentList) do
		if iter_10_1:isActive() then
			return true
		end
	end

	return #self._parentList == 0
end

function NewSlgSkillTreeTalentStruct:getName()
	return self._info.pot_name
end

function NewSlgSkillTreeTalentStruct:findAllChildCanReset(arg_12_1)
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

function NewSlgSkillTreeTalentStruct:getPreLineType()
	self._preLineType = self._preLineType or self:_getPreLineType()

	return self._preLineType
end

function NewSlgSkillTreeTalentStruct:getNextLineType()
	self._nextLineType = self._nextLineType or self:_getNextLineType()

	return self._nextLineType
end

function NewSlgSkillTreeTalentStruct:_getNextLineType()
	if not self._childList[1] then
		return NewSlgLineConfig.lineNextType.NONE
	end

	local var_15_0 = #self._childList

	if #self._childList == 2 then
		return NewSlgLineConfig.lineNextType.HORIZONTAL
	elseif var_15_0 == 1 then
		local var_15_1 = self:getInfo().pot_location - self._childList[1]:getInfo().pot_location

		if var_15_1 == 0 then
			return NewSlgLineConfig.lineNextType.HORIZONTAL
		elseif var_15_1 == 1 then
			return NewSlgLineConfig.lineNextType.TWO_ONE_UP
		elseif var_15_1 == -1 then
			return NewSlgLineConfig.lineNextType.TWO_ONE_DOWN
		end
	end

	return NewSlgLineConfig.lineNextType.NONE
end

function NewSlgSkillTreeTalentStruct:_getPreLineType()
	if not self._parentList[1] then
		return NewSlgLineConfig.linePreType.NONE
	end

	if #self._parentList == 2 then
		return NewSlgLineConfig.linePreType.HORIZONTAL
	else
		local var_16_0 = self:getInfo().pot_location - self._parentList[1]:getInfo().pot_location

		if var_16_0 == 0 then
			return NewSlgLineConfig.linePreType.HORIZONTAL
		elseif var_16_0 == -1 then
			return NewSlgLineConfig.linePreType.ONE_TWO_UP
		elseif var_16_0 == 1 then
			return NewSlgLineConfig.linePreType.ONE_TWO_DOWN
		end
	end

	return NewSlgLineConfig.linePreType.NONE
end

function NewSlgSkillTreeTalentStruct:getPreLineWidth()
	return NewSlgLineConfig.linePreWidth[self:getPreLineType()]
end

function NewSlgSkillTreeTalentStruct:getNextLineWidth()
	return NewSlgLineConfig.lineNextWidth[self:getNextLineType()]
end

function NewSlgSkillTreeTalentStruct:getPreIsUnlock()
	for iter_19_0, iter_19_1 in pairs(self._parentList) do
		if iter_19_1:isActive() then
			return true
		end
	end

	return false
end

function NewSlgSkillTreeTalentStruct:getChildIsUnlock()
	for iter_20_0, iter_20_1 in pairs(self._childList) do
		if iter_20_1:isActive() then
			return true
		end
	end

	return false
end

function NewSlgSkillTreeTalentStruct:isUnlockWithMainWithLv(arg_21_1)
	if self._info.unlock_type == 479 then
		return arg_21_1 >= self._info.unlock_value_2
	end
end

function NewSlgSkillTreeTalentStruct:isCanActive()
	return g.core.model.User.newSlgSkillTreeData:checkPointIsUnLock(self._info.unlock_type, self._info.unlock_value_1, self._info.unlock_value_2)
end

return NewSlgSkillTreeTalentStruct
