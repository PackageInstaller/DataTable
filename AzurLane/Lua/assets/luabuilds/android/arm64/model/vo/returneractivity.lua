class = var_0_10000

local var_0_0 = "ReturnerActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Activity"))

var_0_1.TYPE_INVITER = 1
var_0_1.TYPE_RETURNER = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.roleType = arg_1_0.data1

	return
end

function var_0_1.IsPush(arg_2_0)
	return arg_2_0.data2_list[1] == 1
end

function var_0_1.IsInviter(arg_3_0)
	return arg_3_0.roleType == var_0_1.TYPE_INVITER
end

function var_0_1.IsReturner(arg_4_0)
	return arg_4_0.roleType == var_0_1.TYPE_RETURNER
end

function var_0_1.ShouldAcceptTasks(arg_5_0)
	if arg_5_0:IsInviter() then
		return arg_5_0:ShouldAcceptTasksIfInviter()
	elseif arg_5_0:IsReturner() then
		return arg_5_0:ShouldAcceptTasksIfReturner()
	end

	return
end

function var_0_1.ShouldAcceptTasksIfInviter(arg_6_0)
	if arg_6_0:IsPush() then
		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.getDataConfigTable(var_6_0, "tasklist")
		local var_6_2 = arg_6_0:getDayIndex()

		getProxy = var_6_0
		TaskProxy = var_1_10005

		local var_6_3 = var_6_0(var_1_10005)
		local var_6_4 = 0

		for iter_6_0 = #var_6_1, 1, -1 do
			if arg_6_0:GetTask(var_6_1[iter_6_0]) then
				var_6_4 = iter_6_0

				break
			end
		end

		if (not arg_6_0:GetTask(var_6_1[var_6_4]) or var_5:isReceive()) and var_6_4 < var_6_2 and (var_6_4 ~= #var_6_1 or not var_5 or not var_5:isReceive()) then
			return true
		end
	end

	return false
end

function var_0_1.GetTask(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_7_0 = var_1_10002(var_1_10004)
	local var_7_1

	if not var_2.getTaskById(var_7_0, arg_7_1) then
		var_7_1 = var_2:getFinishTaskById(arg_7_1)
	end

	return var_7_1
end

function var_0_1.ShouldAcceptTasksIfReturner(arg_8_0)
	local var_8_0 = arg_8_0.data4

	if arg_8_0.data2 == 0 then
		return false
	end

	if var_8_0 == 0 then
		return true
	end

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.getDataConfigTable(var_8_1, "task_list")

	getProxy = var_1_10004
	TaskProxy = var_6

	local var_8_3 = var_1_10004(var_6)

	_ = var_8_1

	local var_8_4 = var_8_1.all(var_8_2[var_8_0], function(arg_9_0)
		local var_9_0 = var_8_3

		return var_1.getFinishTaskById(var_9_0, arg_9_0) ~= nil
	end)

	_ = var_6

	local var_8_5 = var_6.all(var_8_2[var_8_0], function(arg_10_0)
		local var_10_0 = var_8_3

		if var_1.getTaskById(var_10_0, arg_10_0) == nil then
			local var_10_1 = var_8_3
			local var_10_2

			if var_1.getFinishTaskById(var_10_1, arg_10_0) ~= nil then
				var_10_2 = false
			else
				var_10_2 = true
			end

			return var_10_2
		end
	end)
	local var_8_6 = var_8_0 == #var_8_2

	local function var_8_7()
		pg = var_2_10000

		local var_11_0 = var_2_10000.TimeMgr.GetInstance()
		local var_11_1 = var_0.GetServerTime(var_11_0)

		pg = var_2_10001

		local var_11_2 = var_2_10001.TimeMgr.GetInstance()
		local var_11_3 = var_1.DiffDay
		local var_11_4 = arg_8_0

		return var_11_3(var_11_2, var_4.getStartTime(var_11_4), var_11_1) + 1 > var_8_0
	end

	return var_8_5 or var_8_4 and not var_8_6 and var_8_7()
end

function var_0_1.getDataConfigTable(arg_12_0, arg_12_1)
	if arg_12_0:IsInviter() then
		pg = var_2

		return var_2.activity_template_headhunting[arg_12_0.id][arg_12_1]
	elseif arg_12_0:IsReturner() then
		pg = var_2

		return var_2.activity_template_returnner[arg_12_0.id][arg_12_1]
	end

	return
end

return var_0_1
