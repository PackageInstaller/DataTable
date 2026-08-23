local PetHandbookGroupStruct = class("PetHandbookGroupStruct")
local var_0_1 = g.core.model.User.petsData
local var_0_2 = g.core.const.ConstMgr.PetHandBookConst
local var_0_3 = g.core.config.pet_compose_advanced_info

function PetHandbookGroupStruct:ctor(arg_1_1)
	self._cfg = arg_1_1.cfg
	self._startCfg = arg_1_1.cfg
	self._isActive = false
end

function PetHandbookGroupStruct:isGroupActive()
	return self._isActive
end

function PetHandbookGroupStruct:isGroupCanActivate()
	if self._isActive then
		return false
	end

	local var_3_0, var_3_1 = self:getPetAdvanceId()

	return self:_isPetSatisfy(var_3_0, 0) and self:_isPetSatisfy(var_3_1, 0)
end

function PetHandbookGroupStruct:isGroupCanUpgrade()
	if not self._isActive then
		return false
	end

	if self._cfg.next_id == 0 then
		return false
	end

	local var_4_0 = var_0_3.get(self._cfg.next_id).need

	return self:_isPetSatisfy(self._cfg.pet_1, var_4_0) and self:_isPetSatisfy(self._cfg.pet_2, var_4_0)
end

function PetHandbookGroupStruct:_isPetSatisfy(arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		return true
	end

	local var_5_0 = var_0_1:getPetByAdvanceId(arg_5_1)

	return var_5_0 and var_5_0:isOwn() and arg_5_2 <= var_5_0:getStarNum() or false
end

function PetHandbookGroupStruct:getPetNum()
	if self._cfg then
		if self._cfg.pet_2 > 0 then
			return 2
		end

		if self._cfg.pet_1 then
			return 1
		end
	end

	return 0
end

function PetHandbookGroupStruct:getQuality()
	if self._cfg then
		return self._cfg.quality
	end

	return 0
end

function PetHandbookGroupStruct:setActive()
	self._isActive = true
end

function PetHandbookGroupStruct:setNewCfg(arg_9_1)
	self._cfg = arg_9_1
end

function PetHandbookGroupStruct:getPetAdvanceId()
	return self._cfg.pet_1, self._cfg.pet_2
end

function PetHandbookGroupStruct:getBaseId()
	return (self._cfg or nil) and (self._cfg.id or 0)
end

function PetHandbookGroupStruct:getLevel()
	return (self._cfg or nil) and (self._cfg.level or 0)
end

function PetHandbookGroupStruct:getNeedStar()
	return (self._cfg.next_id > 0 or nil) and var_0_3.get(self._cfg.next_id).need
end

function PetHandbookGroupStruct:getUpgradeType()
	if not self._isActive then
		return var_0_2.GROUP_UPGRADE_TYPE.ACTIVATE
	end

	if self._cfg.next_id == 0 then
		return var_0_2.GROUP_UPGRADE_TYPE.MAX_LEVEL
	end

	return var_0_2.GROUP_UPGRADE_TYPE.UPGRADE
end

function PetHandbookGroupStruct:getGroup()
	return (self._cfg or nil) and (self._cfg.group or 0)
end

function PetHandbookGroupStruct:getName()
	return (self._cfg or nil) and (self._cfg.group_name or "")
end

function PetHandbookGroupStruct:getCurAttrList()
	return self:getAttrList((self:getBaseId()))
end

function PetHandbookGroupStruct:getAttrList(arg_18_1)
	local var_18_0 = {}

	if arg_18_1 and arg_18_1 > 0 then
		local var_18_1 = var_0_3.get(arg_18_1)

		if not var_18_1 then
			return var_18_0
		end

		local var_18_2 = 1

		while var_0_3.hasKey("attribute_type_" .. var_18_2) do
			if var_18_1["attribute_type_" .. var_18_2] > 0 then
				table.insert(var_18_0, {
					isAll = true,
					type = var_18_1["attribute_type_" .. var_18_2],
					value = var_18_1["attribute_value_" .. var_18_2]
				})
			end

			var_18_2 = var_18_2 + 1
		end
	end

	return var_18_0
end

function PetHandbookGroupStruct:getNextAttrList()
	return self:getAttrList((self._isActive and self._cfg.next_id > 0 or nil) and self._cfg.next_id)
end

function PetHandbookGroupStruct:getSumAttrMap(arg_20_1)
	local var_20_0 = {}

	while self._startCfg.level <= var_0_3.get(arg_20_1).level do
		for iter_20_0, iter_20_1 in ipairs((self:getAttrList(self._startCfg.id))) do
			var_20_0[iter_20_1.type] = var_20_0[iter_20_1.type] or 0
			var_20_0[iter_20_1.type] = var_20_0[iter_20_1.type] + iter_20_1.value
		end

		local var_20_1

		if self._startCfg.next_id > 0 then
			var_20_1 = var_0_3.get(self._startCfg.next_id)
		else
			break
		end
	end

	return var_20_0
end

function PetHandbookGroupStruct:getSumAttrList(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs((self:getSumAttrMap(arg_21_1))) do
		table.insert(var_21_0, {
			isAll = true,
			type = iter_21_0,
			value = iter_21_1
		})
	end

	return var_21_0
end

function PetHandbookGroupStruct:isPut()
	local var_22_0, var_22_1 = self:getPetAdvanceId()
	local var_22_4 = var_0_1:getPetByAdvanceId(var_22_0)
	local var_22_5 = var_22_4 and var_22_4:isPut()
	local var_22_6 = var_0_1:getPetByAdvanceId(var_22_1)
	local var_22_7 = var_22_6 and var_22_6:isPut()

	if self:getPetNum() == 1 then
		return var_22_5
	end

	return var_22_5 or var_22_7
end

return PetHandbookGroupStruct
