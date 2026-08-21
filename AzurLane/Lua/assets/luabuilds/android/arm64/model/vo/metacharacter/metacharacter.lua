local var_0_0 = class("MetaCharacter", import("..BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.ship_strengthen_meta
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	assert(arg_2_1.id)
	assert(arg_2_2)

	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.shipVO = arg_2_2
	arg_2_0.maxRepairExp = arg_2_0:getConfig("repair_total_exp")
	arg_2_0.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(MetaCharacterConst.REPAIR_ATTRS) do
		arg_2_0.attrs[iter_2_1] = MetaCharacterAttr.New({
			attr = iter_2_1,
			items = arg_2_0:getConfig("repair_" .. iter_2_1)
		})
	end

	arg_2_0.effects = _.map(arg_2_0:getConfig("repair_effect"), function(arg_3_0)
		return MetaRepairEffect.New({
			id = arg_3_0[2],
			progress = arg_3_0[1]
		})
	end)

	local var_2_0 = arg_2_1.repair_attr_info or {}

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		for iter_2_4, iter_2_5 in pairs(arg_2_0.attrs) do
			if iter_2_5:hasItemId(iter_2_3) then
				iter_2_5:updateCount((iter_2_5:getLevelByItemId(iter_2_3)))
			end
		end
	end

	return
end

function var_0_0.getBreakOutInfo(arg_4_0)
	assert(arg_4_0.shipVO)

	if not arg_4_0.beakOutInfo or arg_4_0.shipVO.configId ~= arg_4_0.beakOutInfo.id then
		arg_4_0.beakOutInfo = MetaCharacterBreakout.New({
			id = arg_4_0.shipVO.configId
		})
	end

	return arg_4_0.beakOutInfo
end

function var_0_0.getSpecialMaterialInfoToMaxStar(arg_5_0)
	local var_5_0 = arg_5_0:getBreakOutInfo()
	local var_5_1 = {
		count = 0,
		itemID = arg_5_0.beakOutInfo:getConfig("item1")
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

function var_0_0.getCurRepairExp(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.attrs) do
		var_6_0 = var_6_0 + iter_6_1:getRepairExp()
	end

	return var_6_0
end

function var_0_0.getMaxRepairExp(arg_7_0)
	return arg_7_0.maxRepairExp
end

function var_0_0.getRepairRate(arg_8_0)
	return arg_8_0:getCurRepairExp() / arg_8_0:getMaxRepairExp()
end

function var_0_0.isMaxRepairExp(arg_9_0)
	return arg_9_0:getCurRepairExp() == arg_9_0:getMaxRepairExp()
end

function var_0_0.getAttrAddition(arg_10_0, arg_10_1)
	return arg_10_0:getRepairAddition(arg_10_1) + arg_10_0:getPercentageAddition(arg_10_1)
end

function var_0_0.getPercentageAddition(arg_11_0, arg_11_1)
	local var_11_0 = 0
	local var_11_1 = arg_11_0:getRepairRate() * 100

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.effects) do
		if var_11_1 >= iter_11_1.progress then
			var_11_0 = var_11_0 + iter_11_1:getAttrAddition(arg_11_1)
		end
	end

	return var_11_0
end

function var_0_0.getRepairAddition(arg_12_0, arg_12_1)
	local var_12_0 = 0

	if arg_12_0.attrs[arg_12_1] and arg_12_0.attrs[arg_12_1]:isLock() then
		return 0
	end

	if arg_12_0.attrs[arg_12_1] then
		var_12_0 = var_12_0 + arg_12_0.attrs[arg_12_1]:getAddition()
	end

	return var_12_0
end

function var_0_0.getTotalMaxAddition(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.attrs) do
		local var_13_0 = iter_13_1.attr
		local var_13_1 = 0

		if iter_13_1 and iter_13_1:isLock() then
			var_13_1 = 0
		else
			local var_13_2 = Clone(iter_13_1)

			var_13_2.level = var_13_2:getItemCount() + 1
			var_13_1 = var_13_1 + var_13_2:getAddition()
		end

		if ({})[var_13_0] then
			({})[var_13_0] = ({})[var_13_0] + var_13_1
		else
			({})[var_13_0] = var_13_1
		end
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.effects) do
		for iter_13_4, iter_13_5 in ipairs((iter_13_3:getAttrAdditionList())) do
			if ({})[iter_13_5[1]] then
				({})[iter_13_5[1]] = ({})[iter_13_5[1]] + iter_13_5[2]
			else
				({})[iter_13_5[1]] = iter_13_5[2]
			end
		end
	end

	return {}
end

function var_0_0.getFinalAddition(arg_14_0, arg_14_1)
	assert(arg_14_1, "shipVO can not be nil")

	local var_14_0 = arg_14_1:getBaseProperties()
	local var_14_1 = arg_14_0:getTotalMaxAddition()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		local var_14_2 = var_14_1[iter_14_0] or 0

		var_14_0[iter_14_0] = var_14_0[iter_14_0] + var_14_2
	end

	return var_14_0
end

function var_0_0.getAttrVO(arg_15_0, arg_15_1)
	return arg_15_0.attrs[arg_15_1]
end

function var_0_0.existAttr(arg_16_0, arg_16_1)
	return not arg_16_0:getAttrVO(arg_16_1):isLock()
end

function var_0_0.getEffects(arg_17_0)
	return arg_17_0.effects
end

function var_0_0.getUnlockedVoiceList(arg_18_0)
	local var_18_0 = arg_18_0:getRepairRate() * 100

	for iter_18_0, iter_18_1 in ipairs((arg_18_0:getEffects())) do
		if var_18_0 >= iter_18_1.progress and iter_18_1.words ~= "" then
			for iter_18_2, iter_18_3 in ipairs(iter_18_1.words) do
				table.insert({}, iter_18_3)
			end
		end
	end

	return {}
end

function var_0_0.getUnlockVoiceRepairPercent(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs((arg_19_0:getEffects())) do
		if iter_19_1.words ~= "" and table.contains(iter_19_1.words, arg_19_1) then
			var_19_0 = iter_19_1.progress
		end
	end

	return var_19_0
end

return var_0_0
