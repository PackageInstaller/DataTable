class = var_0_10000

local var_0_0 = "CurlingGamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.progressTpl = var_1.Find(var_1_0, "ProgressTpl")

	local var_1_1 = arg_1_0._tf

	arg_1_0.progressTplContainer = var_1.Find(var_1_1, "ProgressList")
	UIItemList = var_1
	arg_1_0.progressUIItemList = var_1.New(arg_1_0.progressTplContainer, arg_1_0.progressTpl)

	local var_1_2 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_2, "GoBtn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_id")

	getProxy = var_1_10002
	MiniGameProxy = var_4

	local var_2_2 = var_1_10002(var_4)
	local var_2_3 = var_2.GetHubByHubId(var_2_2, var_2_1)

	arg_2_0.needCount = var_2.getConfig(var_2_3, "reward_need")
	arg_2_0.leftCount = var_2.count
	arg_2_0.playedCount = var_2.usedtime
	arg_2_0.isGotAward = var_2.ultimate > 0
	arg_2_0.curDay = arg_2_0.leftCount + arg_2_0.playedCount

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.progressUIItemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Unlocked")
			local var_4_1 = arg_4_2
			local var_4_2 = arg_4_2.Find(var_4_1, "Finished")
			local var_4_3 = arg_4_2:Find("Current")

			setActive = var_4_1

			var_4_1(var_4_3, arg_4_1 == arg_3_0.playedCount)

			if arg_4_1 <= arg_3_0.curDay then
				setActive = var_6

				var_6(var_4_0, arg_4_1 > arg_3_0.playedCount)

				setActive = var_6

				var_6(var_4_2, arg_4_1 <= arg_3_0.playedCount and arg_4_1 ~= arg_3_0.needCount)
			else
				setActive = var_6

				var_6(var_4_0, false)

				setActive = var_6

				var_6(var_4_2, false)
			end
		end

		return
	end)

	local var_3_1 = arg_3_0.progressUIItemList

	var_1.align(var_3_1, arg_3_0.needCount)

	onButton = var_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.goBtn

	local function var_3_4()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.GO_MINI_GAME, 33)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_2, var_3_3, var_3_4, var_1_10006)
	arg_3_0:tryGetFinalAward()

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

function var_0_1.tryGetFinalAward(arg_8_0)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.getConfig(var_8_0, "config_id")

	getProxy = var_1_10002
	MiniGameProxy = var_4

	local var_8_2 = var_1_10002(var_4)
	local var_8_3 = var_2.GetHubByHubId(var_8_2, var_8_1).usedtime
	local var_8_4 = var_2:getConfig("reward_need")
	local var_8_5 = var_2.ultimate
	local var_8_6 = 0 < var_8_5

	if var_8_4 <= var_8_3 and not var_8_6 then
		pg = var_6

		local var_8_7 = var_6.m02
		local var_8_8 = var_6.sendNotification

		GAME = var_1_10009

		local var_8_9 = var_1_10009.SEND_MINI_GAME_OP
		local var_8_10 = {
			hubid = var_2.id
		}

		MiniGameOPCommand = var_11
		var_8_10.cmd = var_11.CMD_ULTIMATE
		var_8_10.args1 = {}

		var_8_8(var_8_7, var_8_9, var_8_10)
	end

	return
end

return var_0_1
