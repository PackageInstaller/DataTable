class = var_0_10000

local var_0_0 = "SynGraftingActivityCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getActivitiesByType

	ActivityConst = var_1_10008

	if #var_1_3(var_1_2, var_1_10008.ACTIVITY_TYPE_GRAFTING) == 0 then
		return
	end

	local var_1_4 = var_4

	if not var_4.getActivityById(var_1_4, var_1_1) or var_6:isEnd() then
		return
	end

	local function var_1_5(arg_2_0, arg_2_1)
		if not arg_2_0 or arg_2_0:isEnd() then
			return false
		end

		return arg_2_1 == arg_2_0:getConfig("config_id")
	end

	ipairs = var_1_4

	for iter_1_0, iter_1_1 in var_1_4(var_5) do
		if var_1_5(iter_1_1, var_1_1) then
			arg_1_0:HandleLinkAct(iter_1_1, var_6)
		end
	end

	return
end

function var_0_1.HandleLinkAct(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0:IsBuildShipType(arg_3_2:getConfig("type")) then
		arg_3_0:SynBuildShipAct(arg_3_1, arg_3_2)
	end

	return
end

function var_0_1.IsBuildShipType(arg_4_0, arg_4_1)
	ActivityConst = var_1_10002

	local var_4_0

	if arg_4_1 ~= var_1_10002.ACTIVITY_TYPE_BUILDSHIP_1 then
		ActivityConst = var_2

		if arg_4_1 ~= var_2.ACTIVITY_TYPE_BUILD then
			ActivityConst = var_2

			if arg_4_1 ~= var_2.ACTIVITY_TYPE_NEWSERVER_BUILD then
				var_4_0 = false

				goto label_4_0
			end
		end
	end

	var_4_0 = true

	::label_4_0::

	return var_4_0
end

function var_0_1.SynBuildShipAct(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.data1 = arg_5_2.data1
	arg_5_1.data2 = arg_5_2.data2
	print = var_3

	var_3("syn........", arg_5_1.data1, arg_5_1.data2)

	getProxy = var_3
	ActivityProxy = var_5

	local var_5_0 = var_3(var_5)

	var_3.updateActivity(var_5_0, arg_5_1)

	return
end

return var_0_1
