local var_0_0 = class("GuildDonateTask", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.guild_contribution_template
end

function var_0_0.getCommitItem(arg_3_0)
	return {
		arg_3_0:getConfig("type"),
		arg_3_0:getConfig("type_id"),
		arg_3_0:getConfig("consume")
	}
end

function var_0_0.getCapital(arg_4_0)
	return arg_4_0:getConfig("award_capital")
end

function var_0_0.GetLivenessAddition(arg_5_0)
	return arg_5_0:getConfig("guild_active")
end

function var_0_0.canCommit(arg_6_0)
	local var_6_0 = arg_6_0:getCommitItem()

	if var_6_0[1] == DROP_TYPE_RESOURCE then
		if getProxy(PlayerProxy):getData()[id2res(var_6_0[2])] < var_6_0[3] then
			return false
		end
	elseif var_6_0[1] == DROP_TYPE_ITEM then
		if getProxy(BagProxy):getItemCountById(var_6_0[2]) < var_6_0[3] then
			return false
		end
	else
		assert(false)
	end

	return true
end

return var_0_0
