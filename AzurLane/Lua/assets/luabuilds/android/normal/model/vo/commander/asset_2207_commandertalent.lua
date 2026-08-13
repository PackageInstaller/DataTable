class = var_0_10000

local var_0_0 = "CommanderTalent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

pg = var_0_0

local var_0_2 = var_0_0.commander_ability_group

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.groupId = arg_1_0:getConfig("group_id")
	assert = var_2

	var_2(var_0_2[arg_1_0.groupId])

	arg_1_0.list = var_0_2[arg_1_0.groupId].ability_list

	return
end

function var_0_1.reset(arg_2_0)
	arg_2_0.id = arg_2_0.list[1]
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_1.setOrigin(arg_3_0, arg_3_1)
	arg_3_0.origin = arg_3_1

	return
end

function var_0_1.isOrigin(arg_4_0)
	return arg_4_0.origin
end

function var_0_1.getTalentList(arg_5_0)
	return arg_5_0.list
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.commander_ability_template
end

function var_0_1.getConsume(arg_7_0)
	local var_7_0 = 0

	table = var_1_10002

	local var_7_1 = var_1_10002.indexof(arg_7_0.list, arg_7_0.id)

	if arg_7_0.origin then
		table = var_3
		var_7_0 = var_7_1 - var_3.indexof(arg_7_0.list, arg_7_0.origin.id)
	else
		var_7_0 = var_7_1
	end

	return var_7_0
end

function var_0_1.getAttrsAddition(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	ipairs = var_1_10003
	CommanderConst = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10003(var_1_10004.PROPERTIES) do
		ipairs = var_1_10008

		for iter_8_2, iter_8_3 in var_1_10008(arg_8_0:getConfig("add")) do
			CommanderConst = var_1_10013

			if var_1_10013.TALENT_ADDITION_NUMBER == iter_8_3[1] then
				if iter_8_3[4] == iter_8_0 then
					var_8_0[iter_8_1] = {
						value = iter_8_3[5],
						nation = iter_8_3[2],
						shiptype = iter_8_3[3]
					}
				end
			else
				CommanderConst = var_1_10013

				if var_1_10013.TALENT_ADDITION_RATIO == iter_8_3[1] and iter_8_3[4] == iter_8_0 then
					var_8_1[iter_8_1] = {
						value = iter_8_3[5],
						nation = iter_8_3[2],
						shiptype = iter_8_3[3]
					}
				end
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_1.getBuffsAddition(arg_9_0)
	local var_9_0 = {}

	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0:getConfig("add")) do
		CommanderConst = var_1_10007

		if var_1_10007.TALENT_ADDITION_BUFF == iter_9_1[1] then
			table = var_1_10007

			var_1_10007.insert(var_9_0, iter_9_1[4])
		end
	end

	return var_9_0
end

function var_0_1.getDestoryExpValue(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.getConfig(var_10_1, "add")

	ipairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(var_10_2) do
		local var_10_3 = iter_10_1[1]

		CommanderConst = var_1_10009

		if var_10_3 == var_1_10009.TALENT_ADDITION_NUMBER then
			local var_10_4 = iter_10_1[4]

			CommanderConst = var_1_10009

			if var_10_4 == var_1_10009.DESTROY_ATTR_ID then
				var_10_0 = var_10_0 + iter_10_1[5]
			end
		end
	end

	return var_10_0
end

function var_0_1.getDestoryExpRetio(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.getConfig(var_11_1, "add")

	ipairs = var_11_1

	for iter_11_0, iter_11_1 in var_11_1(var_11_2) do
		local var_11_3 = iter_11_1[1]

		CommanderConst = var_1_10009

		if var_11_3 == var_1_10009.TALENT_ADDITION_RATIO then
			local var_11_4 = iter_11_1[4]

			CommanderConst = var_1_10009

			if var_11_4 == var_1_10009.DESTROY_ATTR_ID then
				var_11_0 = var_11_0 + iter_11_1[5]
			end
		end
	end

	return var_11_0
end

function var_0_1.getDesc(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.getConfig(var_12_1, "add_desc")

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_2) do
		if var_12_0[iter_12_1[1]] then
			var_12_0[var_8].value = var_12_0[var_8].value + iter_12_1[2]

			goto label_12_0
		end

		local var_12_3 = {
			value = iter_12_1[2]
		}

		if iter_12_1[3] then
			CommanderConst = var_12_4

			do
				local var_12_4

				if not var_12_4.TALENT_ADDITION_RATIO then
					CommanderConst = var_12_4
					var_12_4 = var_12_4.TALENT_ADDITION_NUMBER
				end

				var_12_3.type = var_12_4
				var_12_0[var_8] = var_12_3
			end

			::label_12_0::
		end
	end

	return var_12_0
end

return var_0_1
