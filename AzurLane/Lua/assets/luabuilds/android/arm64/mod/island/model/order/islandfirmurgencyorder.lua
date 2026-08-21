local var_0_0 = class("IslandFirmUrgencyOrder", import(".IslandUrgencyOrder"))

function var_0_0.IsFirm(arg_1_0)
	return true
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_order
end

function var_0_0.GetDisappearTime(arg_3_0)
	return arg_3_0.startTime + arg_3_0:getConfig("effective_time")
end

function var_0_0.GetAwardItemAndExp(arg_4_0)
	return arg_4_0:GenAwards((arg_4_0:getConfig("award")))
end

return var_0_0
