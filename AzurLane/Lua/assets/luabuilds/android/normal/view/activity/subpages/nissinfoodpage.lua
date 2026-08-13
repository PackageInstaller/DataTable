class = var_0_10000

local var_0_0 = "NissinFoodPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_1, "help_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.startBtn = var_1.Find(var_1_2, "start_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.cupList = var_1.Find(var_1_3, "cup_list")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.hubID = var_1.getConfig(var_2_0, "config_id")

	local var_2_1 = arg_2_0.activity

	arg_2_0.drop_list = var_1.getConfig(var_2_1, "config_client")
	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.helpBtn

	local function var_2_4()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		i18n = var_2_10003
		var_3_2.helps = var_2_10003("chazi_tips")

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.startBtn

	local function var_2_7()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, 29)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_5, var_2_6, var_2_7, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.GetHubByHubId(var_5_0, arg_5_0.hubID)

	eachChild = var_5_0

	var_5_0(arg_5_0.cupList, function(arg_6_0)
		tonumber = var_2_10001

		local var_6_0 = var_2_10001(arg_6_0.name)

		setActive = var_2

		var_2(arg_6_0:Find("lock"), var_6_0 > var_5_1.count + var_5_1.usedtime)

		setActive = var_2

		var_2(arg_6_0:Find("got"), var_6_0 <= var_5_1.usedtime)

		local var_6_1 = arg_6_0:Find("mask/award")
		local var_6_2 = arg_5_0.drop_list[var_6_0]
		local var_6_3 = {
			type = var_6_2[1],
			id = var_6_2[2],
			count = var_6_2[3]
		}

		updateDrop = var_5

		var_5(var_6_1, var_6_3)

		onButton = var_5

		local var_6_4 = arg_5_0
		local var_6_5 = var_6_1

		local function var_6_6()
			local var_7_0 = arg_5_0
			local var_7_1 = var_0.emit

			BaseUI = var_3_10002

			var_7_1(var_7_0, var_3_10002.ON_DROP, var_6_3)

			return
		end

		SFX_PANEL = var_2_10009

		var_5(var_6_4, var_6_5, var_6_6, var_2_10009)

		return
	end)

	if var_5_1.ultimate == 0 then
		local var_5_2 = var_5_1.usedtime
		local var_5_3 = var_5_1

		if var_5_2 >= var_5_1.getConfig(var_5_3, "reward_need") then
			pg = var_5_2

			local var_5_4 = var_5_2.m02
			local var_5_5 = var_3.sendNotification

			GAME = var_5_3

			local var_5_6 = var_5_3.SEND_MINI_GAME_OP
			local var_5_7 = {
				hubid = var_5_1.id
			}

			MiniGameOPCommand = var_7
			var_5_7.cmd = var_7.CMD_ULTIMATE
			var_5_7.args1 = {}

			var_5_5(var_5_4, var_5_6, var_5_7)
		end
	end

	return
end

return var_0_1
