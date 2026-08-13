class = var_0_10000

local var_0_0 = var_0_10000("MainCheckShipNumSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local function var_1_0(arg_2_0)
		local var_2_0 = arg_1_0

		if var_1.Check(var_2_0, arg_2_0) then
			arg_1_1()
		end

		return
	end

	pg = var_1_10003

	local var_1_1 = var_1_10003.m02
	local var_1_2 = var_3.sendNotification

	GAME = var_1_10006

	var_1_2(var_1_1, var_1_10006.GET_SHIP_CNT, {
		callback = var_1_0
	})

	return
end

function var_0_0.Check(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	if not (arg_3_1 <= var_2.getRawShipCount(var_3_0)) then
		originalPrint = var_3_0

		var_3_0(arg_3_1, var_2)
		arg_3_0:ShowTip()
	end

	return var_3
end

function var_0_0.ShowTip(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_4_1 = var_1.ShowMsgBox
	local var_4_2 = {
		modal = true,
		hideNo = true,
		hideClose = true
	}

	i18n = var_1_10005
	var_4_2.content = var_1_10005("dockyard_data_loss_detected")

	function var_4_2.onYes()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.LOGOUT, {
			code = 0
		})

		return
	end

	var_4_1(var_4_0, var_4_2)

	return
end

return var_0_0
