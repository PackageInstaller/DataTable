class = var_0_10000

local var_0_0 = "EatFoodPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
local var_0_2 = 35
local var_0_3 = 31

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

	var_1_8[1] = var_2.Find(var_1_9, "AD/bg/lock1")

	local var_1_10 = arg_1_0._tf

	var_1_8[2] = var_2.Find(var_1_10, "AD/bg/lock2")

	local var_1_11 = arg_1_0._tf

	var_1_8[3] = var_2.Find(var_1_11, "AD/bg/lock3")

	local var_1_12 = arg_1_0._tf

	var_1_8[4] = var_2.Find(var_1_12, "AD/bg/lock4")

	local var_1_13 = arg_1_0._tf

	var_1_8[5] = var_2.Find(var_1_13, "AD/bg/lock5")

	local var_1_14 = arg_1_0._tf

	var_1_8[6] = var_2.Find(var_1_14, "AD/bg/lock6")

	local var_1_15 = arg_1_0._tf

	var_1_8[7] = var_2.Find(var_1_15, "AD/bg/lock7")
	arg_1_0.locks = var_1_8

	local var_1_16 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_16, "AD/help")

	local var_1_17 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_17, "AD/go")
	pg = var_1

	local var_1_18 = var_1.mini_game_hub[var_0_2].reward_display

	Drop = var_2

	local var_1_19 = var_2.Create(var_1_18)
	local var_1_20 = arg_1_0._tf
	local var_1_21 = var_3.Find(var_1_20, "AD/btnFinalAward")

	onButton = var_4

	local var_1_22 = arg_1_0
	local var_1_23 = var_1_21

	local function var_1_24()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		BaseUI = var_2_10003

		var_2_1(var_2_0, var_2_10003.ON_DROP, var_1_19)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_1_22, var_1_23, var_1_24, var_1_10009)

	return
end

function var_0_1.SetData(arg_3_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.data = var_1.GetHubByHubId(var_3_0, var_0_2)
	arg_3_0.ultimate = var_2.ultimate
	arg_3_0.usedtime = var_2.usedtime
	arg_3_0.count = var_2.count

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	arg_4_0:SetData()

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.goBtn

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.GO_MINI_GAME, var_0_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.helpBtn

	local function var_4_5()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.eatgame_tips.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)
	arg_4_0:UpdateSigned()
	arg_4_0:CheckGet()

	return
end

function var_0_1.UpdateSigned(arg_7_0)
	local var_7_0 = arg_7_0.data
	local var_7_1 = var_1.getConfig(var_7_0, "reward_need")
	local var_7_2 = arg_7_0.usedtime
	local var_7_3

	var_7_3 = arg_7_0.ultimate == 0

	local var_7_4 = var_7_2 + arg_7_0.count

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(arg_7_0.icons) do
		local var_7_5 = iter_7_0 <= var_7_2
		local var_7_6 = iter_7_0 <= var_7_4

		setActive = var_1_10012

		var_1_10012(arg_7_0.icons[iter_7_0], false)

		setActive = var_1_10012

		var_1_10012(arg_7_0.locks[iter_7_0], false)

		if var_7_5 then
			setActive = var_1_10012

			var_1_10012(arg_7_0.icons[iter_7_0], var_7_5)
		elseif not var_7_6 then
			setActive = var_1_10012

			var_1_10012(arg_7_0.locks[iter_7_0], not var_7_6)
		end
	end

	return
end

function var_0_1.CheckGet(arg_8_0)
	if arg_8_0.ultimate == 0 then
		local var_8_0 = arg_8_0.data

		if var_1.getConfig(var_8_0, "reward_need") > arg_8_0.usedtime then
			return
		end

		pg = var_8_0

		local var_8_1 = var_8_0.m02
		local var_8_2 = var_3.sendNotification

		GAME = var_1_10006

		local var_8_3 = var_1_10006.SEND_MINI_GAME_OP
		local var_8_4 = {
			hubid = var_0_2
		}

		MiniGameOPCommand = var_8
		var_8_4.cmd = var_8.CMD_ULTIMATE
		var_8_4.args1 = {}

		var_8_2(var_8_1, var_8_3, var_8_4)
	end

	return
end

return var_0_1
