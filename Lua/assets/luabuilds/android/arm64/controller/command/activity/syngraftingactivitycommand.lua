local var_0_0 = class("SynGraftingActivityCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(ActivityProxy)
	local var_1_2 = var_1_1:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_GRAFTING)

	if #var_1_2 == 0 then
		return
	end

	local var_1_3 = var_1_1:getActivityById(var_1_0)

	if not var_1_3 or var_1_3:isEnd() then
		return
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		if var_1_4(iter_1_1, var_1_0) then
			arg_1_0:HandleLinkAct(iter_1_1, var_1_3)
		end
	end

	return
end

function var_0_0.HandleLinkAct(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0:IsBuildShipType(arg_3_2:getConfig("type")) then
		arg_3_0:SynBuildShipAct(arg_3_1, arg_3_2)
	end

	return
end

function var_0_0.IsBuildShipType(arg_4_0, arg_4_1)
	return arg_4_1 == ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1 or arg_4_1 == ActivityConst.ACTIVITY_TYPE_BUILD or arg_4_1 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

function var_0_0.SynBuildShipAct(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.data1 = arg_5_2.data1
	arg_5_1.data2 = arg_5_2.data2

	print("syn........", arg_5_1.data1, arg_5_1.data2)
	getProxy(ActivityProxy):updateActivity(arg_5_1)

	return
end

return var_0_0
