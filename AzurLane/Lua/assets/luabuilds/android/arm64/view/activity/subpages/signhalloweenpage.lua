local var_0_0 = class("SignHalloweenPage", import("...base.BaseActivityPage"))
local var_0_1 = 15

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
	arg_1_0.opens = {
		arg_1_0._tf:Find("AD/bg/open1"),
		arg_1_0._tf:Find("AD/bg/open2"),
		arg_1_0._tf:Find("AD/bg/open3"),
		arg_1_0._tf:Find("AD/bg/open4"),
		arg_1_0._tf:Find("AD/bg/open5"),
		arg_1_0._tf:Find("AD/bg/open6"),
		arg_1_0._tf:Find("AD/bg/open7")
	}
	arg_1_0.helpBtn = arg_1_0._tf:Find("AD/help")
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go")

	return
end

function var_0_0.SetData(arg_2_0)
	arg_2_0.hubId = arg_2_0.activity:getConfig("config_id")

	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_2_0.hubId)

	arg_2_0.data = var_2_0
	arg_2_0.ultimate = var_2_0.ultimate
	arg_2_0.usedtime = var_2_0.usedtime
	arg_2_0.count = var_2_0.count

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0:SetData()
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_candymagic.tip
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
	local var_6_3 = var_6_1 + arg_6_0.count

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.icons) do
		local var_6_4 = iter_6_0 <= var_6_1
		local var_6_5 = iter_6_0 <= var_6_3

		setActive(arg_6_0.icons[iter_6_0], false)
		setActive(arg_6_0.opens[iter_6_0], false)

		if var_6_4 then
			setActive(arg_6_0.icons[iter_6_0], var_6_4)
		elseif var_6_5 then
			setActive(arg_6_0.opens[iter_6_0], var_6_5)
		end
	end

	return
end

function var_0_0.CheckGet(arg_7_0)
	if arg_7_0.ultimate == 0 then
		if arg_7_0.data:getConfig("reward_need") > arg_7_0.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_7_0.hubId,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
