class = var_0_10000

local var_0_0 = "TowerClimbingSignPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

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

	return
end

function var_0_1.SetData(arg_2_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	arg_2_0.data = var_1.GetHubByHubId(var_2_0, 9)
	arg_2_0.ultimate = var_2.ultimate
	arg_2_0.usedtime = var_2.usedtime

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	arg_3_0:SetData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.goBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_MINI_GAME, 13)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.towerclimbing_sign_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:UpdateSigned()
	arg_3_0:CheckGet()

	return
end

function var_0_1.UpdateSigned(arg_6_0)
	local var_6_0 = arg_6_0.data
	local var_6_1 = var_1.getConfig(var_6_0, "reward_need")
	local var_6_2 = arg_6_0.usedtime
	local var_6_3

	var_6_3 = arg_6_0.ultimate == 0
	ipairs = var_4

	for iter_6_0, iter_6_1 in var_4(arg_6_0.icons) do
		local var_6_4 = iter_6_0 <= var_6_2

		setActive = var_1_10010

		var_1_10010(iter_6_1, var_6_4)
	end

	return
end

function var_0_1.CheckGet(arg_7_0)
	if arg_7_0.ultimate == 0 then
		local var_7_0 = arg_7_0.data

		if var_1.getConfig(var_7_0, "reward_need") > arg_7_0.usedtime then
			return
		end

		pg = var_7_0

		local var_7_1 = var_7_0.m02
		local var_7_2 = var_3.sendNotification

		GAME = var_1_10006

		local var_7_3 = var_1_10006.SEND_MINI_GAME_OP
		local var_7_4 = {
			hubid = 9
		}

		MiniGameOPCommand = var_1_10008
		var_7_4.cmd = var_1_10008.CMD_ULTIMATE
		var_7_4.args1 = {}

		var_7_2(var_7_1, var_7_3, var_7_4)
	end

	return
end

return var_0_1
