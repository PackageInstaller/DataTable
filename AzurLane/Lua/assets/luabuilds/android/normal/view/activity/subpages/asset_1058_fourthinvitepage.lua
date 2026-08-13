class = var_0_10000

local var_0_0 = "FourthInvitePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = arg_1_0._tf

	var_1_0[1] = var_2.Find(var_1_1, "AD/bg/npc1")

	local var_1_2 = arg_1_0._tf

	var_1_0[2] = var_2.Find(var_1_2, "AD/bg/npc2")

	local var_1_3 = arg_1_0._tf

	var_1_0[3] = var_2.Find(var_1_3, "AD/bg/npc3")

	local var_1_4 = arg_1_0._tf

	var_1_0[4] = var_2.Find(var_1_4, "AD/bg/npc4")

	local var_1_5 = arg_1_0._tf

	var_1_0[5] = var_2.Find(var_1_5, "AD/bg/npc5")

	local var_1_6 = arg_1_0._tf

	var_1_0[6] = var_2.Find(var_1_6, "AD/bg/npc6")

	local var_1_7 = arg_1_0._tf

	var_1_0[7] = var_2.Find(var_1_7, "AD/bg/npc7")
	arg_1_0.icons = var_1_0

	local var_1_8 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_8, "AD/help")

	local var_1_9 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_9, "AD/go")

	local var_1_10 = arg_1_0._tf

	arg_1_0.gotBtn = var_1.Find(var_1_10, "AD/got")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.gameId = var_1.getConfig(var_2_0, "config_client").mini_game_id
	pg = var_1
	arg_2_0.hubId = var_1.mini_game[arg_2_0.gameId].hub_id
	getProxy = var_1
	MiniGameProxy = var_2

	local var_2_1 = var_1(var_2)

	arg_2_0.data = var_1.GetHubByHubId(var_2_1, arg_2_0.hubId)
	arg_2_0.ultimate = arg_2_0.data.ultimate
	arg_2_0.usedtime = arg_2_0.data.usedtime

	local var_2_2 = arg_2_0.data

	arg_2_0.maxtime = var_1.getConfig(var_2_2, "reward_need")

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.goBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, arg_3_0.gameId)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.catchteasure_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	SetActive = var_1_10001

	var_1_10001(arg_6_0.gotBtn, arg_6_0.ultimate == 1)
	arg_6_0:UpdateSigned()
	arg_6_0:CheckGet()

	return
end

function var_0_1.UpdateSigned(arg_7_0)
	local var_7_0 = arg_7_0.maxtime
	local var_7_1 = arg_7_0.usedtime

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.icons) do
		local var_7_2 = iter_7_0 <= var_7_1

		setActive = var_1_10009

		var_1_10009(iter_7_1, var_7_2)
	end

	return
end

function var_0_1.CheckGet(arg_8_0)
	if arg_8_0.ultimate == 0 then
		if arg_8_0.maxtime > arg_8_0.usedtime then
			return
		end

		pg = var_1_10003

		local var_8_0 = var_1_10003.m02
		local var_8_1 = var_3.sendNotification

		GAME = var_1_10005

		local var_8_2 = var_1_10005.SEND_MINI_GAME_OP
		local var_8_3 = {
			hubid = arg_8_0.hubId
		}

		MiniGameOPCommand = var_7
		var_8_3.cmd = var_7.CMD_ULTIMATE
		var_8_3.args1 = {}

		var_8_1(var_8_0, var_8_2, var_8_3)
	end

	return
end

return var_0_1
