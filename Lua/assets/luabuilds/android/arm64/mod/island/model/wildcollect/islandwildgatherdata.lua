local var_0_0 = class("IslandWildGatherData", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.pos = arg_1_1.pos
	arg_1_0.state = arg_1_1.state
	arg_1_0.mark = arg_1_1.mark
	arg_1_0.refresh_time = arg_1_1.refresh_time
	arg_1_0.isSelfIsLand = arg_1_2

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
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

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_wild_gather
end

function var_0_0.CheckCofigShow(arg_4_0)
	if arg_4_0.isSelfIsLand then
		return true
	end

	return arg_4_0:getConfigTable().show ~= IslandGatherCollectAgency.ShowTpye.OnlySelf
end

function var_0_0.IsShow(arg_5_0)
	return arg_5_0:CheckCofigShow() and arg_5_0.state == 0
end

function var_0_0.StartGaher(arg_6_0, arg_6_1, arg_6_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_GATHER, {
		unitId = arg_6_1,
		island_id = arg_6_2,
		gather_id = arg_6_0.id
	})

	return
end

function var_0_0.StartGaherSign(arg_7_0, arg_7_1, arg_7_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_GATHER_SIGN, {
		unitId = arg_7_1,
		island_id = arg_7_2,
		gather_id = arg_7_0.id
	})

	return
end

function var_0_0.CheckGatherCanSign(arg_8_0)
	return arg_8_0:getConfigTable().show == 3
end

return var_0_0
