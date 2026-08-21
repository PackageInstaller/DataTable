local var_0_0 = class("FourthInvitePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.icons = {
		arg_1_0._tf:Find("AD/bg/npc1"),
		arg_1_0._tf:Find("AD/bg/npc2"),
		arg_1_0._tf:Find("AD/bg/npc3"),
		arg_1_0._tf:Find("AD/bg/npc4"),
		arg_1_0._tf:Find("AD/bg/npc5"),
		arg_1_0._tf:Find("AD/bg/npc6"),
		arg_1_0._tf:Find("AD/bg/npc7")
	}
	arg_1_0.helpBtn = arg_1_0._tf:Find("AD/help")
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go")
	arg_1_0.gotBtn = arg_1_0._tf:Find("AD/got")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.gameId = arg_2_0.activity:getConfig("config_client").mini_game_id
	arg_2_0.hubId = pg.mini_game[arg_2_0.gameId].hub_id
	arg_2_0.data = getProxy(MiniGameProxy):GetHubByHubId(arg_2_0.hubId)
	arg_2_0.ultimate = arg_2_0.data.ultimate
	arg_2_0.usedtime = arg_2_0.data.usedtime
	arg_2_0.maxtime = arg_2_0.data:getConfig("reward_need")

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, arg_3_0.gameId)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.catchteasure_help.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	SetActive(arg_6_0.gotBtn, arg_6_0.ultimate == 1)
	arg_6_0:UpdateSigned()
	arg_6_0:CheckGet()

	return
end

function var_0_0.UpdateSigned(arg_7_0)
	local var_7_1 = arg_7_0.usedtime

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.icons) do
		setActive(iter_7_1, iter_7_0 <= var_7_1)
	end

	return
end

function var_0_0.CheckGet(arg_8_0)
	if arg_8_0.ultimate == 0 then
		if arg_8_0.maxtime > arg_8_0.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_8_0.hubId,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
