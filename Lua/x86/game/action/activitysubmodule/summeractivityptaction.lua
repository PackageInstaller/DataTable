local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	SummerActivityPtData:Reset()

	if var_0_1 then
		return
	end

	manager.net:Bind(61009, function(arg_2_0)
		SummerActivityPtData:InitWithServer(arg_2_0.pt_challenge_info)
		var_0_0.UpdateRedPoint(arg_2_0.activity_id)
	end)

	var_0_1 = true
end

function var_0_0.UpdateRedPoint(arg_3_0)
	local var_3_0 = RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_" .. arg_3_0

	if not ActivityData:GetActivityData(arg_3_0):IsActivitying() then
		manager.redPoint:setTip(var_3_0, 0)

		return
	end

	local var_3_1 = ActivityData:GetActivityData(arg_3_0)

	if var_3_1 ~= nil and manager.time:GetServerTime() >= var_3_1.startTime and manager.time:GetServerTime() <= var_3_1.stopTime then
		if not getData("activity_pt_" .. arg_3_0, "opened") then
			manager.redPoint:setTip(var_3_0, 1)
		else
			manager.redPoint:setTip(var_3_0, 0)
		end
	else
		manager.redPoint:setTip(var_3_0, 0)
	end
end

return var_0_0
