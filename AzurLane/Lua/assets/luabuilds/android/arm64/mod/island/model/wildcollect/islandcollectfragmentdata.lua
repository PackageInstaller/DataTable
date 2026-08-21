local var_0_0 = class("IslandCollectFragmentData", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.pos = arg_1_1.pos
	arg_1_0.mark = arg_1_1.mark
	arg_1_0.isSelfIsLand = arg_1_2

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3

	arg_2_0.id = arg_2_1.id

	if arg_2_1.pos ~= arg_2_0.pos then
		var_2_0 = true
		var_2_2 = arg_2_0.pos
		var_2_1 = true
		var_2_3 = arg_2_1.pos
	end

	arg_2_0.pos = arg_2_1.pos
	arg_2_0.mark = arg_2_1.mark

	return var_2_1, var_2_0, var_2_3, var_2_2
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_collect_fragment
end

function var_0_0.IsShow(arg_4_0)
	if arg_4_0.isSelfIsLand then
		return true
	end

	return arg_4_0:getConfigTable().show ~= IslandGatherCollectAgency.ShowTpye.OnlySelf
end

function var_0_0.StartCollect(arg_5_0, arg_5_1, arg_5_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_COLLECT, {
		unitId = arg_5_1,
		island_id = arg_5_2,
		fragment_id = arg_5_0.id
	})

	return
end

function var_0_0.StartCollectSign(arg_6_0, arg_6_1, arg_6_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_COLLECT_SIGN, {
		unitId = arg_6_1,
		island_id = arg_6_2,
		gather_id = arg_6_0.id
	})

	return
end

function var_0_0.CheckCollectCanSign(arg_7_0)
	return arg_7_0:getConfigTable().show == 3
end

return var_0_0
