class = var_0_10000

local var_0_0 = "IslandQueueUpMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandQueueUpUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.contentTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_3, "frame/cancel")
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/title")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("island_msg_info"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/cancel/Text")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("island_cancel_queue"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Destroy(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Flush(arg_5_2)
	arg_5_0:AddTimer(arg_5_1)

	return
end

function var_0_1.Flush(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.contentTxt

	i18n = var_1_10003
	var_6_0.text = var_1_10003("island_queue_display", arg_6_1)

	return
end

function var_0_1.AddTimer(arg_7_0, arg_7_1)
	Timer = var_1_10002

	local var_7_0 = var_1_10002.New

	local function var_7_1()
		local var_8_0 = arg_7_0

		var_0.Send(var_8_0, arg_7_1)

		return
	end

	IslandConst = var_1_10004
	arg_7_0.timer = var_7_0(var_7_1, var_1_10004.QUEUE_UP_REFRESH_TIME, -1)

	local var_7_2 = arg_7_0.timer

	var_2.Start(var_7_2)

	return
end

function var_0_1.Send(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_9_0, 21208, {
		island_id = arg_9_1
	}, 21203, function(arg_10_0)
		if arg_10_0.result == 0 then
			local var_10_0 = arg_9_0

			var_1.Destroy(var_10_0)

			pg = var_1

			local var_10_1 = var_1.m02
			local var_10_2 = var_1.sendNotification

			GAME = var_2_10003

			var_10_2(var_10_1, var_2_10003.ISLAND_GET_DATA, {
				id = arg_10_0.island_id,
				list = arg_10_0.player_list
			})
		elseif arg_10_0.result == 6 then
			local var_10_3 = arg_9_0

			var_1.Flush(var_10_3, arg_10_0.pos)
		else
			pg = var_1

			local var_10_4 = var_1.TipsMgr.GetInstance()
			local var_10_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_10_5(var_10_4, var_2_10003[arg_10_0.result] .. arg_10_0.result)
		end

		return
	end)

	return
end

function var_0_1.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimer()
	arg_12_0:Reset()

	return
end

return var_0_1
