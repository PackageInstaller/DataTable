class = var_0_10000

local var_0_0 = "MsgboxSubPanel"

BaseSubPanel = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

function var_0_1.Load(arg_1_0)
	if arg_1_0._state ~= var_0_1.STATES.NONE then
		return
	end

	arg_1_0._state = var_0_1.STATES.LOADING
	pg = var_1

	local var_1_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_1_0)

	PoolMgr = var_1

	local var_1_1 = var_1.GetInstance()

	var_1.GetUI(var_1_1, arg_1_0:getUIName(), false, function(arg_2_0)
		if arg_1_0._state == var_0_1.STATES.DESTROY then
			pg = var_1

			local var_2_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_2_0)

			local var_2_1 = var_0
			local var_2_2 = var_1.ReturnUI
			local var_2_3 = arg_1_0

			var_2_2(var_2_1, var_3.getUIName(var_2_3), arg_2_0)
		else
			local var_2_4 = arg_1_0

			var_1.Loaded(var_2_4, arg_2_0)

			local var_2_5 = arg_1_0

			var_1.Init(var_2_5)
		end

		return
	end)

	return
end

function var_0_1.SetWindowSize(arg_3_0, arg_3_1)
	setSizeDelta = var_1_10002

	var_1_10002(arg_3_0.viewParent._window, arg_3_1)

	return
end

function var_0_1.UpdateView(arg_4_0, arg_4_1)
	arg_4_0:PreRefresh(arg_4_1)
	arg_4_0:OnRefresh(arg_4_1)
	arg_4_0:PostRefresh(arg_4_1)

	return
end

function var_0_1.PreRefresh(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.viewParent

	var_2.commonSetting(var_5_0, arg_5_1)
	arg_5_0:Show()

	return
end

function var_0_1.PostRefresh(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.viewParent

	var_2.Loaded(var_6_0, arg_6_1)

	return
end

function var_0_1.OnRefresh(arg_7_0, arg_7_1)
	return
end

function var_0_1.closeView(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.MsgboxMgr.GetInstance()

	var_1.hide(var_8_0)

	return
end

return var_0_1
