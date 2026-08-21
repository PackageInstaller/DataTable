local var_0_0 = class("TacticRoomBuilding", import(".NavalAcademyBuilding"))

function var_0_0.GetGameObjectName(arg_1_0)
	return "tacticRoom"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("school_title_xueyuan")
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0:emit(NavalAcademyMediator.ON_OPEN_TACTICROOM)

	return
end

function var_0_0.IsTip(arg_4_0)
	local var_4_0 = getProxy(NavalAcademyProxy):getStudents()

	if #var_4_0 <= 0 then
		return false
	end

	local var_4_1 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_4_2

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_3 = iter_4_1:getFinishTime() - var_4_1

		if not var_4_2 or var_4_3 < var_4_2 then
			var_4_2 = var_4_3
		end

		if var_4_3 <= 0 then
			return true
		end
	end

	arg_4_0:RemoveTimer()

	if var_4_2 and var_4_2 > 0 then
		arg_4_0:AddTimer(var_4_2)
	end

	return false
end

function var_0_0.AddTimer(arg_5_0, arg_5_1)
	arg_5_0.timer = Timer.New(function()
		arg_5_0:RefreshTip()

		return
	end, arg_5_1, 1)

	arg_5_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_0
