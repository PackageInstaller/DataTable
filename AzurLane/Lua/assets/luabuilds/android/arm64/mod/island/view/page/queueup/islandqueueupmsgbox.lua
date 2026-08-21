local var_0_0 = class("IslandQueueUpMsgBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandQueueUpUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.contentTxt = arg_2_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")

	setText(arg_2_0._tf:Find("frame/title"), i18n("island_msg_info"))
	setText(arg_2_0._tf:Find("frame/cancel/Text"), i18n("island_cancel_queue"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Destroy()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Flush(arg_5_2)
	arg_5_0:AddTimer(arg_5_1)

	return
end

function var_0_0.Flush(arg_6_0, arg_6_1)
	arg_6_0.contentTxt.text = i18n("island_queue_display", arg_6_1)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1)
	arg_7_0.timer = Timer.New(function()
		arg_7_0:Send(arg_7_1)

		return
	end, IslandConst.QUEUE_UP_REFRESH_TIME, -1)

	arg_7_0.timer:Start()

	return
end

function var_0_0.Send(arg_9_0, arg_9_1)
	pg.ConnectionMgr.GetInstance():Send(21208, {
		island_id = arg_9_1
	}, 21203, function(arg_10_0)
		if arg_10_0.result == 0 then
			arg_9_0:Destroy()
			pg.m02:sendNotification(GAME.ISLAND_GET_DATA, {
				id = arg_10_0.island_id,
				list = arg_10_0.player_list
			})
		elseif arg_10_0.result == 6 then
			arg_9_0:Flush(arg_10_0.pos)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_10_0.result] .. arg_10_0.result)
		end

		return
	end)

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimer()
	arg_12_0:Reset()

	return
end

return var_0_0
