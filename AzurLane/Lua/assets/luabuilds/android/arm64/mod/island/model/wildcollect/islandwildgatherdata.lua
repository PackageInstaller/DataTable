class = var_0_10000

local var_0_0 = "IslandWildGatherData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.pos = arg_1_1.pos
	arg_1_0.state = arg_1_1.state
	arg_1_0.mark = arg_1_1.mark
	arg_1_0.refresh_time = arg_1_1.refresh_time
	arg_1_0.isSelfIsLand = arg_1_2

	return
end

function var_0_1.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3

	if arg_2_1.pos ~= arg_2_0.pos then
		var_2_0 = true
		var_2_1 = arg_2_0.pos
		var_2_2 = true
		var_2_3 = arg_2_1.pos
	end

	arg_2_0.pos = arg_2_1.pos

	if arg_2_1.state ~= arg_2_0.state then
		if arg_2_1.state == 0 then
			var_2_2 = true
			var_2_3 = arg_2_0.pos
		else
			var_2_0 = true
			var_2_1 = arg_2_0.pos
		end
	end

	arg_2_0.state = arg_2_1.state
	arg_2_0.mark = arg_2_1.mark

	return var_2_2, var_2_0, var_2_3, var_2_1
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_wild_gather
end

function var_0_1.CheckCofigShow(arg_4_0)
	if arg_4_0.isSelfIsLand then
		return true
	end

	local var_4_0 = arg_4_0:getConfigTable().show

	IslandGatherCollectAgency = var_1_10002

	return var_4_0 ~= var_1_10002.ShowTpye.OnlySelf
end

function var_0_1.IsShow(arg_5_0)
	local var_5_0

	if arg_5_0:CheckCofigShow() then
		var_5_0 = arg_5_0.state == 0
	end

	return var_5_0
end

function var_0_1.StartGaher(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	local var_6_0 = var_1_10003.m02
	local var_6_1 = var_3.sendNotification

	GAME = var_1_10006

	var_6_1(var_6_0, var_1_10006.ISLAND_START_WILD_GATHER, {
		unitId = arg_6_1,
		island_id = arg_6_2,
		gather_id = arg_6_0.id
	})

	return
end

function var_0_1.StartGaherSign(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.m02
	local var_7_1 = var_3.sendNotification

	GAME = var_1_10006

	var_7_1(var_7_0, var_1_10006.ISLAND_START_WILD_GATHER_SIGN, {
		unitId = arg_7_1,
		island_id = arg_7_2,
		gather_id = arg_7_0.id
	})

	return
end

function var_0_1.CheckGatherCanSign(arg_8_0)
	return arg_8_0:getConfigTable().show == 3
end

return var_0_1
