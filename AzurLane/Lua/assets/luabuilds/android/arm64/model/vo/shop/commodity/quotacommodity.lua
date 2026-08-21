local var_0_0 = class("QuotaCommodity", import(".BaseCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_shop_template
end

function var_0_0.canPurchase(arg_2_0)
	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_0.GetPurchasableCnt(arg_3_0)
	return math.max(arg_3_0:GetLimitGoodCount() - arg_3_0:GetOwnedGoodCount(), 0)
end

function var_0_0.GetOwnedGoodCount(arg_4_0)
	return Drop.New({
		id = arg_4_0:getConfig("commodity_id"),
		type = arg_4_0:getConfig("commodity_type"),
		count = arg_4_0:getConfig("num")
	}):getOwnedCount()
end

function var_0_0.GetLimitGoodCount(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("limit_args")

	if type(var_5_0) == "table" then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1[1] == "quota" then
				return iter_5_1[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with id: " .. arg_5_0.id)

	return
end

return var_0_0
