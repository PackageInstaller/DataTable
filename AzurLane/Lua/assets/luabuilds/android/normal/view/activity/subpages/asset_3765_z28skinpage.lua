class = var_0_10000

local var_0_0 = "Z28SkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewYearSnackPage"))

function var_0_1.OnDataSetting(arg_1_0)
	local var_1_0 = arg_1_0.activity
	local var_1_1 = var_1.getConfig(var_1_0, "config_id")

	getProxy = var_1_0
	MiniGameProxy = var_3

	local var_1_2 = var_1_0(var_3)
	local var_1_3 = var_2.GetHubByHubId(var_1_2, var_1_1)

	arg_1_0.needCount = var_2.getConfig(var_1_3, "reward_need")
	arg_1_0.leftCount = var_2.count
	arg_1_0.playedCount = var_2.usedtime
	arg_1_0.isGotAward = var_2.ultimate > 0
	arg_1_0.curDay = arg_1_0.leftCount + arg_1_0.playedCount

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.progressUIItemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			arg_3_1 = arg_3_1 + 1

			local var_3_0 = arg_3_2:Find("Locked")
			local var_3_1 = arg_3_2:Find("Unlocked")
			local var_3_2 = arg_3_2:Find("Finished")
			local var_3_3 = arg_3_2
			local var_3_4 = arg_3_2.Find(var_3_3, "FinalFinished")

			setActive = var_3_3

			var_3_3(var_3_0, arg_3_1 > arg_2_0.curDay)

			if arg_3_1 <= arg_2_0.curDay then
				setActive = var_7

				var_7(var_3_1, arg_3_1 > arg_2_0.playedCount)

				setActive = var_7

				var_7(var_3_2, arg_3_1 <= arg_2_0.playedCount and arg_3_1 ~= arg_2_0.needCount)

				setActive = var_7

				var_7(var_3_4, arg_3_1 <= arg_2_0.playedCount and arg_3_1 == arg_2_0.needCount)
			else
				setActive = var_7

				var_7(var_3_1, false)

				setActive = var_7

				var_7(var_3_2, false)

				setActive = var_7

				var_7(var_3_4, false)
			end
		end

		return
	end)

	local var_2_1 = 36

	onButton = var_2_0

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.goBtn

	local function var_2_4()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_MINI_GAME, var_2_1, {
			callback = function()
				Context = var_3_10000

				local var_5_0 = var_3_10000.New()

				SCENE = var_3_10001

				local var_5_1 = var_3_10001.SetSceneInfo
				local var_5_2 = var_5_0

				SCENE = var_3_10003

				var_5_1(var_5_2, var_3_10003.NEWYEAR_BACKHILL_2022)

				getProxy = var_5_1
				ContextProxy = var_5_2

				local var_5_3 = var_5_1(var_5_2)

				var_1.PushContext2Prev(var_5_3, var_5_0)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_2_0(var_2_2, var_2_3, var_2_4, var_1_10006)

	onButton = var_2_0

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.helpBtn

	local function var_2_7()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		i18n = var_2_10003
		var_6_2.helps = var_2_10003("help_xinnian2022_z28")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2_0(var_2_5, var_2_6, var_2_7, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.progressUIItemList

	var_1.align(var_7_0, arg_7_0.needCount)
	arg_7_0:tryGetFinalAward()

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

function var_0_1.tryGetFinalAward(arg_9_0)
	local var_9_0 = arg_9_0.activity
	local var_9_1 = var_1.getConfig(var_9_0, "config_id")

	getProxy = var_9_0
	MiniGameProxy = var_3

	local var_9_2 = var_9_0(var_3)
	local var_9_3 = var_2.GetHubByHubId(var_9_2, var_9_1).usedtime
	local var_9_4 = var_2:getConfig("reward_need")
	local var_9_5 = var_2.ultimate
	local var_9_6 = 0 < var_9_5

	if var_9_4 <= var_9_3 and not var_9_6 then
		pg = var_6

		local var_9_7 = var_6.m02
		local var_9_8 = var_6.sendNotification

		GAME = var_1_10008

		local var_9_9 = var_1_10008.SEND_MINI_GAME_OP
		local var_9_10 = {
			hubid = var_2.id
		}

		MiniGameOPCommand = var_10
		var_9_10.cmd = var_10.CMD_ULTIMATE
		var_9_10.args1 = {}

		var_9_8(var_9_7, var_9_9, var_9_10)
	end

	return
end

return var_0_1
