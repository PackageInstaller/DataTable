class = var_0_10000

local var_0_0 = "TacticRoomBuilding"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NavalAcademyBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "tacticRoom"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_xueyuan")
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NavalAcademyMediator = var_1_10004

	var_3_1(var_3_0, var_1_10004.ON_OPEN_TACTICROOM)

	return
end

function var_0_1.IsTip(arg_4_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	if #var_1.getStudents(var_4_0) <= 0 then
		return false
	end

	pg = var_2

	local var_4_1 = var_2.TimeMgr.GetInstance()
	local var_4_2 = var_2.GetServerTime(var_4_1)
	local var_4_3

	pairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_1) do
		local var_4_4 = iter_4_1:getFinishTime() - var_4_2

		if not var_4_3 or var_4_4 < var_4_3 then
			var_4_3 = var_4_4
		end

		if var_4_4 <= 0 then
			return true
		end
	end

	arg_4_0:RemoveTimer()

	if var_4_3 and var_4_3 > 0 then
		arg_4_0:AddTimer(var_4_3)
	end

	return false
end

function var_0_1.AddTimer(arg_5_0, arg_5_1)
	Timer = var_1_10002
	arg_5_0.timer = var_1_10002.New(function()
		local var_6_0 = arg_5_0

		var_0.RefreshTip(var_6_0)

		return
	end, arg_5_1, 1)

	local var_5_0 = arg_5_0.timer

	var_2.Start(var_5_0)

	return
end

function var_0_1.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_1
