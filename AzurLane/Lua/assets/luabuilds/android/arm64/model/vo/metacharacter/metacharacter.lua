class = var_0_10000

local var_0_0 = "MetaCharacter"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.ship_strengthen_meta
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003

	var_1_10003(arg_2_1.id)

	assert = var_1_10003

	var_1_10003(arg_2_2)

	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.shipVO = arg_2_2

	local var_2_0 = arg_2_0

	arg_2_0.maxRepairExp = arg_2_0.getConfig(var_2_0, "repair_total_exp")
	arg_2_0.attrs = {}
	ipairs = var_3
	MetaCharacterConst = var_2_0

	for iter_2_0, iter_2_1 in var_3(var_2_0.REPAIR_ATTRS) do
		local var_2_1 = arg_2_0.attrs

		MetaCharacterAttr = var_1_10009
		var_2_1[iter_2_1] = var_1_10009.New({
			attr = iter_2_1,
			items = arg_2_0:getConfig("repair_" .. iter_2_1)
		})
	end

	_ = var_3
	arg_2_0.effects = var_3.map(arg_2_0:getConfig("repair_effect"), function(arg_3_0)
		MetaRepairEffect = var_2_10001

		return var_2_10001.New({
			id = arg_3_0[2],
			progress = arg_3_0[1]
		})
	end)
	ipairs = var_3

	local var_2_2

	if not arg_2_1.repair_attr_info then
		var_2_2 = {}
	end

	for iter_2_2, iter_2_3 in var_3(var_2_2) do
		pairs = var_8

		for iter_2_4, iter_2_5 in var_8(arg_2_0.attrs) do
			if iter_2_5:hasItemId(iter_2_3) then
				local var_2_3 = iter_2_5:getLevelByItemId(iter_2_3)

				iter_2_5:updateCount(var_2_3)
			end
		end
	end

	return
end

function var_0_1.getBreakOutInfo(arg_4_0)
	assert = var_1_10001

	var_1_10001(arg_4_0.shipVO)

	local var_4_0 = arg_4_0.shipVO

	if not arg_4_0.beakOutInfo or var_4_0.configId ~= arg_4_0.beakOutInfo.id then
		MetaCharacterBreakout = var_2
		arg_4_0.beakOutInfo = var_2.New({
			id = var_4_0.configId
		})
	end

	return arg_4_0.beakOutInfo
end

function var_0_1.getSpecialMaterialInfoToMaxStar(arg_5_0)
	local var_5_0 = arg_5_0:getBreakOutInfo()
	local var_5_1 = {
		count = 0
	}
	local var_5_2 = arg_5_0.beakOutInfo

	var_5_1.itemID = var_3.getConfig(var_5_2, "item1")

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

function var_0_1.getCurRepairExp(arg_6_0)
	local var_6_0 = 0

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.attrs) do
		var_6_0 = var_6_0 + iter_6_1:getRepairExp()
	end

	return var_6_0
end

function var_0_1.getMaxRepairExp(arg_7_0)
	return arg_7_0.maxRepairExp
end

function var_0_1.getRepairRate(arg_8_0)
	return arg_8_0:getCurRepairExp() / arg_8_0:getMaxRepairExp()
end

function var_0_1.isMaxRepairExp(arg_9_0)
	return arg_9_0:getCurRepairExp() == arg_9_0:getMaxRepairExp()
end

function var_0_1.getAttrAddition(arg_10_0, arg_10_1)
	return arg_10_0:getRepairAddition(arg_10_1) + arg_10_0:getPercentageAddition(arg_10_1)
end

function var_0_1.getPercentageAddition(arg_11_0, arg_11_1)
	local var_11_0 = 0
	local var_11_1 = arg_11_0:getRepairRate() * 100

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_0.effects) do
		if var_11_1 >= iter_11_1.progress then
			var_11_0 = var_11_0 + iter_11_1:getAttrAddition(arg_11_1)
		end
	end

	return var_11_0
end

function var_0_1.getRepairAddition(arg_12_0, arg_12_1)
	local var_12_0 = 0

	if arg_12_0.attrs[arg_12_1] and var_3:isLock() then
		return 0
	end

	if var_3 then
		var_12_0 = var_12_0 + var_3:getAddition()
	end

	return var_12_0
end

function var_0_1.getTotalMaxAddition(arg_13_0)
	local var_13_0 = {}

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.attrs) do
		local var_13_1 = iter_13_1.attr

		var_1_10008 = 0

		if iter_13_1 and iter_13_1:isLock() then
			var_1_10008 = 0
		else
			Clone = var_1_10009

			local var_13_2 = var_1_10009(iter_13_1)

			var_1_10009.level = var_1_10009.getItemCount(var_13_2) + 1
			var_1_10008 = var_1_10008 + var_1_10009:getAddition()
		end

		if var_13_0[var_13_1] then
			var_13_0[var_13_1] = var_13_0[var_13_1] + var_1_10008
		else
			var_13_0[var_13_1] = var_1_10008
		end
	end

	ipairs = var_2

	for iter_13_2, iter_13_3 in var_2(arg_13_0.effects) do
		local var_13_3 = iter_13_3:getAttrAdditionList()

		ipairs = var_1_10008

		for iter_13_4, iter_13_5 in var_1_10008(var_13_3) do
			local var_13_4 = iter_13_5[1]
			local var_13_5 = iter_13_5[2]

			if var_13_0[var_13_4] then
				var_13_0[var_13_4] = var_13_0[var_13_4] + var_13_5
			else
				var_13_0[var_13_4] = var_13_5
			end
		end
	end

	return var_13_0
end

function var_0_1.getFinalAddition(arg_14_0, arg_14_1)
	assert = var_1_10002

	var_1_10002(arg_14_1, "shipVO can not be nil")

	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_1.getBaseProperties(var_14_0)
	local var_14_2 = arg_14_0:getTotalMaxAddition()

	pairs = var_14_0

	for iter_14_0, iter_14_1 in var_14_0(var_14_1) do
		local var_14_3 = var_14_1[iter_14_0]
		local var_14_4

		if not var_14_2[iter_14_0] then
			var_14_4 = 0
		end

		var_14_1[iter_14_0] = var_14_3 + var_14_4
	end

	return var_14_1
end

function var_0_1.getAttrVO(arg_15_0, arg_15_1)
	return arg_15_0.attrs[arg_15_1]
end

function var_0_1.existAttr(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAttrVO(arg_16_1)

	return not var_2.isLock(var_16_0)
end

function var_0_1.getEffects(arg_17_0)
	return arg_17_0.effects
end

function var_0_1.getUnlockedVoiceList(arg_18_0)
	local var_18_0 = arg_18_0:getEffects()
	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.getRepairRate(var_18_1) * 100
	local var_18_3 = {}

	ipairs = var_18_1

	for iter_18_0, iter_18_1 in var_18_1(var_18_0) do
		if var_18_2 >= iter_18_1.progress and iter_18_1.words ~= "" then
			ipairs = var_10

			for iter_18_2, iter_18_3 in var_10(iter_18_1.words) do
				table = var_1_10015

				var_1_10015.insert(var_18_3, iter_18_3)
			end
		end
	end

	return var_18_3
end

function var_0_1.getUnlockVoiceRepairPercent(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.getEffects(var_19_0)
	local var_19_2 = 0

	ipairs = var_19_0

	for iter_19_0, iter_19_1 in var_19_0(var_19_1) do
		if iter_19_1.words ~= "" then
			table = var_9

			if var_9.contains(iter_19_1.words, arg_19_1) then
				var_19_2 = iter_19_1.progress
			end
		end
	end

	return var_19_2
end

return var_0_1
