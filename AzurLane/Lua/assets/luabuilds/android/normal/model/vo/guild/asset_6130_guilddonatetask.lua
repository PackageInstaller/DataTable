class = var_0_10000

local var_0_0 = "GuildDonateTask"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.guild_contribution_template
end

function var_0_1.getCommitItem(arg_3_0)
	return {
		arg_3_0:getConfig("type"),
		arg_3_0:getConfig("type_id"),
		arg_3_0:getConfig("consume")
	}
end

function var_0_1.getCapital(arg_4_0)
	return arg_4_0:getConfig("award_capital")
end

function var_0_1.GetLivenessAddition(arg_5_0)
	return arg_5_0:getConfig("guild_active")
end

function var_0_1.canCommit(arg_6_0)
	local var_6_0 = arg_6_0:getCommitItem()[1]

	DROP_TYPE_RESOURCE = var_1_10003

	if var_6_0 == var_1_10003 then
		getProxy = var_6_0
		PlayerProxy = var_1_10003
		var_1_10003 = var_6_0(var_1_10003)

		local var_6_1 = var_2.getData(var_1_10003)

		id2res = var_1_10003

		if var_6_1[var_1_10003(var_1[2])] < var_1[3] then
			return false
		end
	else
		local var_6_2 = var_1[1]

		DROP_TYPE_ITEM = var_1_10003

		if var_6_2 == var_1_10003 then
			getProxy = var_6_2
			BagProxy = var_1_10003

			local var_6_3 = var_6_2(var_1_10003)

			if var_6_2.getItemCountById(var_6_3, var_1[2]) < var_1[3] then
				return false
			end
		else
			assert = var_6_2

			var_6_2(false)
		end
	end

	return true
end

return var_0_1
