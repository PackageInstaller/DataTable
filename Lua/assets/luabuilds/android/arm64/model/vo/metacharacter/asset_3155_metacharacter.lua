local MetaCharacter = class("MetaCharacter", import("..BaseVO"))

function MetaCharacter:bindConfigTable()
	return pg.ship_strengthen_meta
end

function MetaCharacter:Ctor(arg_2_1, arg_2_2)
	assert(arg_2_1.id)
	assert(arg_2_2)

	self.id = arg_2_1.id
	self.configId = self.id
	self.shipVO = arg_2_2
	self.maxRepairExp = self:getConfig("repair_total_exp")
	self.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		self.attrs[iter_2_1] = MetaCharacterAttr.New({
			attr = iter_2_1,
			items = self:getConfig("repair_" .. iter_2_1)
		})
	end

	self.effects = _.map(self:getConfig("repair_effect"), function(arg_3_0)
		return MetaRepairEffect.New({
			id = arg_3_0[2],
			progress = arg_3_0[1]
		})
	end)

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.repair_attr_info or {}) do
		for iter_2_4, iter_2_5 in pairs(self.attrs) do
			if iter_2_5:hasItemId(iter_2_3) then
				iter_2_5:updateCount((iter_2_5:getLevelByItemId(iter_2_3)))
			end
		end
	end

	return
end

function MetaCharacter:getBreakOutInfo()
	assert(self.shipVO)

	if not self.beakOutInfo or self.shipVO.configId ~= self.beakOutInfo.id then
		self.beakOutInfo = MetaCharacterBreakout.New({
			id = self.shipVO.configId
		})
	end

	return self.beakOutInfo
end

function MetaCharacter:getSpecialMaterialInfoToMaxStar()
	local var_5_0 = self:getBreakOutInfo()
	local var_5_1 = {
		count = 0,
		itemID = self.beakOutInfo:getConfig("item1")
	}

	while true do
		if not var_5_0:hasNextInfo() then
			return var_5_1
		else
			var_5_1.count = var_5_1.count + var_5_0:getConfig("item1_num")
			var_5_0 = var_5_0:getNextInfo()
		end
	end

	return
end

function MetaCharacter:getCurRepairExp()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(self.attrs) do
		var_6_0 = var_6_0 + iter_6_1:getRepairExp()
	end

	return var_6_0
end

function MetaCharacter:getMaxRepairExp()
	return self.maxRepairExp
end

function MetaCharacter:getRepairRate()
	return self:getCurRepairExp() / self:getMaxRepairExp()
end

function MetaCharacter:isMaxRepairExp()
	return self:getCurRepairExp() == self:getMaxRepairExp()
end

function MetaCharacter:getAttrAddition(arg_10_1)
	return self:getRepairAddition(arg_10_1) + self:getPercentageAddition(arg_10_1)
end

function MetaCharacter:getPercentageAddition(arg_11_1)
	local var_11_0 = 0
	local var_11_1 = self:getRepairRate() * 100

	for iter_11_0, iter_11_1 in ipairs(self.effects) do
		if var_11_1 >= iter_11_1.progress then
			var_11_0 = var_11_0 + iter_11_1:getAttrAddition(arg_11_1)
		end
	end

	return var_11_0
end

function MetaCharacter:getRepairAddition(arg_12_1)
	local var_12_0 = 0

	if self.attrs[arg_12_1] and self.attrs[arg_12_1]:isLock() then
		return 0
	end

	if self.attrs[arg_12_1] then
		var_12_0 = var_12_0 + self.attrs[arg_12_1]:getAddition()
	end

	return var_12_0
end

function MetaCharacter:getTotalMaxAddition()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.attrs) do
		local var_13_1 = iter_13_1.attr
		local var_13_2 = 0

		if iter_13_1 and iter_13_1:isLock() then
			var_13_2 = 0
		else
			local var_13_3 = Clone(iter_13_1)

			var_13_3.level = var_13_3:getItemCount() + 1
			var_13_2 = var_13_2 + var_13_3:getAddition()
		end

		var_13_0[var_13_1] = var_13_0[var_13_1] and var_13_0[var_13_1] + var_13_2 or var_13_2
	end

	for iter_13_2, iter_13_3 in ipairs(self.effects) do
		for iter_13_4, iter_13_5 in ipairs((iter_13_3:getAttrAdditionList())) do
			var_13_0[iter_13_5[1]] = var_13_0[iter_13_5[1]] and var_13_0[iter_13_5[1]] + iter_13_5[2] or iter_13_5[2]
		end
	end

	return var_13_0
end

function MetaCharacter:getFinalAddition(arg_14_1)
	assert(arg_14_1, "shipVO can not be nil")

	local var_14_0 = arg_14_1:getBaseProperties()
	local var_14_1 = self:getTotalMaxAddition()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		var_14_0[iter_14_0] = var_14_0[iter_14_0] + (var_14_1[iter_14_0] or 0)
	end

	return var_14_0
end

function MetaCharacter:getAttrVO(arg_15_1)
	return self.attrs[arg_15_1]
end

function MetaCharacter:existAttr(arg_16_1)
	return not self:getAttrVO(arg_16_1):isLock()
end

function MetaCharacter:getEffects()
	return self.effects
end

function MetaCharacter:getUnlockedVoiceList()
	local var_18_0 = self:getRepairRate() * 100
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs((self:getEffects())) do
		if var_18_0 >= iter_18_1.progress and iter_18_1.words ~= "" then
			for iter_18_2, iter_18_3 in ipairs(iter_18_1.words) do
				table.insert(var_18_1, iter_18_3)
			end
		end
	end

	return var_18_1
end

function MetaCharacter:getUnlockVoiceRepairPercent(arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs((self:getEffects())) do
		if iter_19_1.words ~= "" and table.contains(iter_19_1.words, arg_19_1) then
			var_19_0 = iter_19_1.progress
		end
	end

	return var_19_0
end

return MetaCharacter
