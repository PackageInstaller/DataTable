local var_0_0 = class("EatFoodPage", import("...base.BaseActivityPage"))
local var_0_1 = 35
local var_0_2 = 31

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
	arg_1_0.locks = {
		arg_1_0._tf:Find("AD/bg/lock1"),
		arg_1_0._tf:Find("AD/bg/lock2"),
		arg_1_0._tf:Find("AD/bg/lock3"),
		arg_1_0._tf:Find("AD/bg/lock4"),
		arg_1_0._tf:Find("AD/bg/lock5"),
		arg_1_0._tf:Find("AD/bg/lock6"),
		arg_1_0._tf:Find("AD/bg/lock7")
	}
	arg_1_0.helpBtn = arg_1_0._tf:Find("AD/help")
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go")

	local var_1_0 = Drop.Create(pg.mini_game_hub[var_0_1].reward_display)

	onButton(arg_1_0, arg_1_0._tf:Find("AD/btnFinalAward"), function()
		arg_1_0:emit(BaseUI.ON_DROP, var_1_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetData(arg_3_0)
	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0_1)

	arg_3_0.data = var_3_0
	arg_3_0.ultimate = var_3_0.ultimate
	arg_3_0.usedtime = var_3_0.usedtime
	arg_3_0.count = var_3_0.count

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	arg_4_0:SetData()
	onButton(arg_4_0, arg_4_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_2)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.eatgame_tips.tip
		})

		return
	end, SFX_PANEL)
	arg_4_0:UpdateSigned()
	arg_4_0:CheckGet()

	return
end

function var_0_0.UpdateSigned(arg_7_0)
	local var_7_0 = arg_7_0.data:getConfig("reward_need")
	local var_7_1 = arg_7_0.usedtime
	local var_7_3 = var_7_1 + arg_7_0.count

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.icons) do
		local var_7_4 = iter_7_0 <= var_7_1
		local var_7_5 = iter_7_0 <= var_7_3

		setActive(arg_7_0.icons[iter_7_0], false)
		setActive(arg_7_0.locks[iter_7_0], false)

		if var_7_4 then
			setActive(arg_7_0.icons[iter_7_0], var_7_4)
		elseif not var_7_5 then
			setActive(arg_7_0.locks[iter_7_0], not var_7_5)
		end
	end

	return
end

function var_0_0.CheckGet(arg_8_0)
	if arg_8_0.ultimate == 0 then
		if arg_8_0.data:getConfig("reward_need") > arg_8_0.usedtime then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_0_1,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
