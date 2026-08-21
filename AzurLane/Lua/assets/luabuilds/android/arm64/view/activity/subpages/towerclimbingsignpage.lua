local var_0_0 = class("TowerClimbingSignPage", import("...base.BaseActivityPage"))

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

	return
end

function var_0_0.SetData(arg_2_0)
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId(9)

	arg_2_0.data = var_2_0
	arg_2_0.ultimate = var_2_0.ultimate
	arg_2_0.usedtime = var_2_0.usedtime

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0:SetData()
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 13)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.towerclimbing_sign_help.tip
		})

		return
	end, SFX_PANEL)
	arg_3_0:UpdateSigned()
	arg_3_0:CheckGet()

	return
end

function var_0_0.UpdateSigned(arg_6_0)
	local var_6_0 = arg_6_0.data:getConfig("reward_need")
	local var_6_1 = arg_6_0.usedtime

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.icons) do
		setActive(iter_6_1, iter_6_0 <= var_6_1)
	end

	return
end

function var_0_0.CheckGet(arg_7_0)
	if arg_7_0.ultimate == 0 then
		if arg_7_0.data:getConfig("reward_need") > arg_7_0.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = 9,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
