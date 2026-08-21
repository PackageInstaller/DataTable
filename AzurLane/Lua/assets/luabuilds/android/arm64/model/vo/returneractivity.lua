local var_0_0 = class("ReturnerActivity", import(".Activity"))

var_0_0.TYPE_INVITER = 1
var_0_0.TYPE_RETURNER = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.roleType = arg_1_0.data1

	return
end

function var_0_0.IsPush(arg_2_0)
	return arg_2_0.data2_list[1] == 1
end

function var_0_0.IsInviter(arg_3_0)
	return arg_3_0.roleType == var_0_0.TYPE_INVITER
end

function var_0_0.IsReturner(arg_4_0)
	return arg_4_0.roleType == var_0_0.TYPE_RETURNER
end

function var_0_0.ShouldAcceptTasks(arg_5_0)
	if arg_5_0:IsInviter() then
		return arg_5_0:ShouldAcceptTasksIfInviter()
	elseif arg_5_0:IsReturner() then
		return arg_5_0:ShouldAcceptTasksIfReturner()
	end

	return
end

function var_0_0.ShouldAcceptTasksIfInviter(arg_6_0)
	if arg_6_0:IsPush() then
		local var_6_0 = arg_6_0:getDataConfigTable("tasklist")
		local var_6_1 = getProxy(TaskProxy)
		local var_6_2 = 0

		for iter_6_0 = #var_6_0, 1, -1 do
			if arg_6_0:GetTask(var_6_0[iter_6_0]) then
				var_6_2 = iter_6_0

				break
			end
		end

		local var_6_3 = arg_6_0:GetTask(var_6_0[var_6_2])

		if (not var_6_3 or var_6_3:isReceive()) and var_6_2 < arg_6_0:getDayIndex() and (var_6_2 ~= #var_6_0 or not var_6_3 or not var_6_3:isReceive()) then
			return true
		end
	end

	return false
end

function var_0_0.GetTask(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(TaskProxy)

	return var_7_0:getTaskById(arg_7_1) or var_7_0:getFinishTaskById(arg_7_1)
end

function var_0_0.ShouldAcceptTasksIfReturner(arg_8_0)
	local var_8_0 = arg_8_0.data4

	if arg_8_0.data2 == 0 then
		return false
	end

	if arg_8_0.data4 == 0 then
		return true
	end

	local var_8_1 = arg_8_0:getDataConfigTable("task_list")
	local var_8_2 = getProxy(TaskProxy)
	local var_8_3 = _.all(var_8_1[arg_8_0.data4], function(arg_9_0)
		return var_8_2:getFinishTaskById(arg_9_0) ~= nil
	end)
	local var_8_4 = arg_8_0.data4 == #var_8_1

	return _.all(var_8_1[arg_8_0.data4], function(arg_10_0)
		return var_8_2:getTaskById(arg_10_0) == nil and var_8_2:getFinishTaskById(arg_10_0) == nil
	end) or var_8_3 and not var_8_4 and var_8_5()
end

function var_0_0.getDataConfigTable(arg_12_0, arg_12_1)
	if arg_12_0:IsInviter() then
		return pg.activity_template_headhunting[arg_12_0.id][arg_12_1]
	elseif arg_12_0:IsReturner() then
		return pg.activity_template_returnner[arg_12_0.id][arg_12_1]
	end

	return
end

return var_0_0
