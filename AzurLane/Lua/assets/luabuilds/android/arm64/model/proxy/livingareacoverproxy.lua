class = var_0_10000

local var_0_0 = "LivingAreaCoverProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ON_UPDATE = "LivingAreaCoverProxy:ON_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.coverId = 0
	ipairs = var_1
	pg = var_1_10003

	for iter_1_0, iter_1_1 in var_1(var_1_10003.livingarea_cover.all) do
		local var_1_0 = arg_1_0.data

		LivingAreaCover = var_1_10007
		var_1_0[iter_1_1] = var_1_10007.New({
			id = iter_1_1,
			unlock = iter_1_1 == 0
		})
	end

	arg_1_0:on(11003, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.coverId = arg_2_0.cover.id
		ipairs = var_2_0

		local var_2_1

		if not arg_2_0.cover.covers then
			var_2_1 = {}
		end

		for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
			local var_2_2 = arg_1_0.data[iter_2_1]

			var_6.SetUnlock(var_2_2, true)
		end

		return
	end)

	return
end

function var_0_1.GetCoverId(arg_3_0)
	return arg_3_0.coverId
end

function var_0_1.GetCurCover(arg_4_0)
	return arg_4_0:GetCover(arg_4_0:GetCoverId())
end

function var_0_1.UpdateCoverId(arg_5_0, arg_5_1)
	arg_5_0.coverId = arg_5_1

	return
end

function var_0_1.GetCover(arg_6_0, arg_6_1)
	return arg_6_0.data[arg_6_1]
end

function var_0_1.GetCover(arg_7_0, arg_7_1)
	return arg_7_0.data[arg_7_1]
end

function var_0_1.GetUnlockList(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.data) do
		if iter_8_1:IsUnlock() then
			table = var_7

			var_7.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_1.GetLockList(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.data) do
		if not iter_9_1:IsUnlock() then
			table = var_7

			var_7.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_1.UpdateCover(arg_10_0, arg_10_1)
	arg_10_0.data[arg_10_1.id] = arg_10_1

	arg_10_0:sendNotification(var_0_1.ON_UPDATE)

	return
end

function var_0_1.IsTip(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.data) do
		if iter_11_1:IsNew() then
			return true
		end
	end

	return false
end

function var_0_1.remove(arg_12_0)
	return
end

return var_0_1
