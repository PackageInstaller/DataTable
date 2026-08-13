class = var_0_10000

local var_0_0 = "SeventhInvitePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtMarks = var_1.Find(var_1_0, "AD/progress")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtFinish = var_1.Find(var_1_1, "AD/award")

	local var_1_2 = arg_1_0._tf

	arg_1_0.rtBtns = var_1.Find(var_1_2, "AD/btn_list")

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
	local var_3_1 = arg_3_0.rtBtns
	local var_3_2 = var_3.Find(var_3_1, "go")

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, arg_3_0.gameId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.rtBtns
	local var_3_6 = var_3.Find(var_3_5, "get")

	local function var_3_7()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.SEND_MINI_GAME_OP
		local var_5_3 = {
			hubid = arg_3_0.hubId
		}

		MiniGameOPCommand = var_4
		var_5_3.cmd = var_4.CMD_ULTIMATE
		var_5_3.args1 = {}

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.maxtime
	local var_6_1 = arg_6_0.usedtime
	local var_6_2 = arg_6_0.rtMarks.childCount

	for iter_6_0 = 1, var_6_2 do
		local var_6_3 = arg_6_0.rtMarks
		local var_6_4 = var_8.GetChild(var_6_3, iter_6_0 - 1)

		setActive = var_6_3

		var_6_3(var_6_4:Find("mark"), iter_6_0 <= var_6_1)

		setActive = var_6_3

		var_6_3(var_6_4:Find("icon"), iter_6_0 == var_6_1 and arg_6_0.ultimate == 0)
	end

	setActive = var_4

	local var_6_5 = arg_6_0.rtFinish

	var_4(var_5.Find(var_6_5, "got"), arg_6_0.ultimate == 1)

	setActive = var_4

	local var_6_6 = arg_6_0.rtBtns

	var_4(var_5.Find(var_6_6, "get"), arg_6_0.ultimate == 0 and var_6_1 == var_6_0)

	setActive = var_4

	local var_6_7 = arg_6_0.rtBtns

	var_4(var_5.Find(var_6_7, "got"), arg_6_0.ultimate == 1)

	setActive = var_4

	local var_6_8 = arg_6_0.rtBtns

	var_4(var_5.Find(var_6_8, "go"), var_6_1 < var_6_0)

	setActive = var_4

	local var_6_9 = arg_6_0.rtBtns

	var_4(var_5.Find(var_6_9, "red"), var_6_1 <= var_6_0 and arg_6_0.ultimate ~= 1 and arg_6_0.data.count > 0)

	return
end

return var_0_1
