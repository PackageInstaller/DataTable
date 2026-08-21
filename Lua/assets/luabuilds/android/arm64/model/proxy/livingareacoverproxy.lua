local var_0_0 = class("LivingAreaCoverProxy", import(".NetProxy"))

var_0_0.ON_UPDATE = "LivingAreaCoverProxy:ON_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.coverId = 0

	for iter_1_0, iter_1_1 in ipairs(pg.livingarea_cover.all) do
		arg_1_0.data[iter_1_1] = LivingAreaCover.New({
			id = iter_1_1,
			unlock = iter_1_1 == 0
		})
	end

	arg_1_0:on(11003, function(arg_2_0)
		arg_1_0.coverId = arg_2_0.cover.id

		local var_2_0 = arg_2_0.cover.covers or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			arg_1_0.data[iter_2_1]:SetUnlock(true)
		end

		return
	end)

	return
end

function var_0_0.GetCoverId(arg_3_0)
	return arg_3_0.coverId
end

function var_0_0.GetCurCover(arg_4_0)
	return arg_4_0:GetCover(arg_4_0:GetCoverId())
end

function var_0_0.UpdateCoverId(arg_5_0, arg_5_1)
	arg_5_0.coverId = arg_5_1

	return
end

function var_0_0.GetCover(arg_6_0, arg_6_1)
	return arg_6_0.data[arg_6_1]
end

function var_0_0.GetCover(arg_7_0, arg_7_1)
	return arg_7_0.data[arg_7_1]
end

function var_0_0.GetUnlockList(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.data) do
		if iter_8_1:IsUnlock() then
			table.insert({}, iter_8_1)
		end
	end

	return {}
end

function var_0_0.GetLockList(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.data) do
		if not iter_9_1:IsUnlock() then
			table.insert({}, iter_9_1)
		end
	end

	return {}
end

function var_0_0.UpdateCover(arg_10_0, arg_10_1)
	arg_10_0.data[arg_10_1.id] = arg_10_1

	arg_10_0:sendNotification(var_0_0.ON_UPDATE)

	return
end

function var_0_0.IsTip(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.data) do
		if iter_11_1:IsNew() then
			return true
		end
	end

	return false
end

function var_0_0.remove(arg_12_0)
	return
end

return var_0_0
