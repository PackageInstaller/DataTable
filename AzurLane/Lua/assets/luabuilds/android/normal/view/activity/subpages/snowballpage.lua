class = var_0_10000

local var_0_0 = "SnowballPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 14
local var_0_3 = 18

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

	local var_1_8 = {}
	local var_1_9 = arg_1_0._tf

	var_1_8[1] = var_2.Find(var_1_9, "AD/bg/open1")

	local var_1_10 = arg_1_0._tf

	var_1_8[2] = var_2.Find(var_1_10, "AD/bg/open2")

	local var_1_11 = arg_1_0._tf

	var_1_8[3] = var_2.Find(var_1_11, "AD/bg/open3")

	local var_1_12 = arg_1_0._tf

	var_1_8[4] = var_2.Find(var_1_12, "AD/bg/open4")

	local var_1_13 = arg_1_0._tf

	var_1_8[5] = var_2.Find(var_1_13, "AD/bg/open5")

	local var_1_14 = arg_1_0._tf

	var_1_8[6] = var_2.Find(var_1_14, "AD/bg/open6")

	local var_1_15 = arg_1_0._tf

	var_1_8[7] = var_2.Find(var_1_15, "AD/bg/open7")
	arg_1_0.opens = var_1_8

	local var_1_16 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_16, "AD/help")

	local var_1_17 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_17, "AD/go")

	return
end

function var_0_1.SetData(arg_2_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	arg_2_0.data = var_1.GetHubByHubId(var_2_0, var_0_2)
	arg_2_0.ultimate = var_2.ultimate
	arg_2_0.usedtime = var_2.usedtime
	arg_2_0.count = var_2.count

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

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, var_0_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

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
		var_5_2.helps = var_2_10003.gametip.help_candymagic.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)
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

	local var_6_4 = var_6_2 + arg_6_0.count

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(arg_6_0.icons) do
		local var_6_5 = iter_6_0 <= var_6_2
		local var_6_6 = iter_6_0 <= var_6_4

		setActive = var_1_10012

		var_1_10012(arg_6_0.icons[iter_6_0], false)

		setActive = var_1_10012

		var_1_10012(arg_6_0.opens[iter_6_0], false)

		if var_6_5 then
			setActive = var_1_10012

			var_1_10012(arg_6_0.icons[iter_6_0], var_6_5)
		elseif var_6_6 then
			setActive = var_1_10012

			var_1_10012(arg_6_0.opens[iter_6_0], var_6_6)
		end
	end

	return
end

function var_0_1.CheckGet(arg_7_0)
	if arg_7_0.ultimate == 0 then
		local var_7_0 = arg_7_0.data

		if var_1.getConfig(var_7_0, "reward_need") > arg_7_0.usedtime then
			return
		end

		pg = var_3

		local var_7_1 = var_3.m02
		local var_7_2 = var_3.sendNotification

		GAME = var_1_10005

		local var_7_3 = var_1_10005.SEND_MINI_GAME_OP
		local var_7_4 = {
			hubid = var_0_2
		}

		MiniGameOPCommand = var_7
		var_7_4.cmd = var_7.CMD_ULTIMATE
		var_7_4.args1 = {}

		var_7_2(var_7_1, var_7_3, var_7_4)
	end

	return
end

return var_0_1
