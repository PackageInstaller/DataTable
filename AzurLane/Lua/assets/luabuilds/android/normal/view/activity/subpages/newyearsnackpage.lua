class = var_0_10000

local var_0_0 = "NewYearSnackPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.progressTpl = var_1.Find(var_1_0, "ProgressTpl")

	local var_1_1 = arg_1_0._tf

	arg_1_0.progressTplContainer = var_1.Find(var_1_1, "ProgressList")
	UIItemList = var_1
	arg_1_0.progressUIItemList = var_1.New(arg_1_0.progressTplContainer, arg_1_0.progressTpl)

	local var_1_2 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_2, "HelpBtn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_3, "GoBtn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").linkMiniGameID

	getProxy = var_2_0
	MiniGameProxy = var_3

	local var_2_2 = var_2_0(var_3)
	local var_2_3 = var_2.GetMiniGameData(var_2_2, var_2_1)
	local var_2_4 = var_2.getConfig(var_2_3, "hub_id")

	getProxy = var_2_3
	MiniGameProxy = var_5

	local var_2_5 = var_2_3(var_5)
	local var_2_6 = var_4.GetHubByHubId(var_2_5, var_2_4)

	arg_2_0.needCount = var_4.getConfig(var_2_6, "reward_need")
	arg_2_0.leftCount = var_4.count
	arg_2_0.playedCount = var_4.usedtime
	arg_2_0.isGotAward = var_4.ultimate > 0
	arg_2_0.curDay = arg_2_0.leftCount + arg_2_0.playedCount

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.progressUIItemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Locked")
			local var_4_1 = arg_4_2:Find("Unlocked")
			local var_4_2 = arg_4_2:Find("Finished")
			local var_4_3 = arg_4_2
			local var_4_4 = arg_4_2.Find(var_4_3, "FinalFinished")

			setActive = var_4_3

			var_4_3(var_4_0, arg_4_1 > arg_3_0.curDay)

			if arg_4_1 <= arg_3_0.curDay then
				setActive = var_7

				var_7(var_4_1, arg_4_1 > arg_3_0.playedCount)

				setActive = var_7

				var_7(var_4_2, arg_4_1 <= arg_3_0.playedCount and arg_4_1 ~= arg_3_0.needCount)

				setActive = var_7

				var_7(var_4_4, arg_4_1 <= arg_3_0.playedCount and arg_4_1 == arg_3_0.needCount)
			else
				setActive = var_7

				var_7(var_4_1, false)

				setActive = var_7

				var_7(var_4_2, false)

				setActive = var_7

				var_7(var_4_4, false)
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

		GAME = var_2_10002

		var_5_1(var_5_0, var_2_10002.GO_MINI_GAME, 19, {
			callback = function()
				Context = var_3_10000

				local var_6_0 = var_3_10000.New()

				SCENE = var_3_10001

				local var_6_1 = var_3_10001.SetSceneInfo
				local var_6_2 = var_6_0

				SCENE = var_3_10003

				var_6_1(var_6_2, var_3_10003.NEWYEAR_BACKHILL)

				getProxy = var_6_1
				ContextProxy = var_6_2

				local var_6_3 = var_6_1(var_6_2)

				var_1.PushContext2Prev(var_6_3, var_6_0)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_2, var_3_3, var_3_4, var_1_10005)

	onButton = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.helpBtn

	local function var_3_7()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		i18n = var_2_10003
		var_7_2.helps = var_2_10003("help_xinnian2021__meishiyemian")

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_5, var_3_6, var_3_7, var_1_10005)
	arg_3_0:tryGetFinalAward()

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

function var_0_1.tryGetFinalAward(arg_10_0)
	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_1.getConfig(var_10_0, "config_client").linkMiniGameID

	getProxy = var_10_0
	MiniGameProxy = var_3

	local var_10_2 = var_10_0(var_3)
	local var_10_3 = var_2.GetMiniGameData(var_10_2, var_10_1)
	local var_10_4 = var_2.getConfig(var_10_3, "hub_id")

	getProxy = var_10_3
	MiniGameProxy = var_5

	local var_10_5 = var_10_3(var_5)
	local var_10_6 = var_4.GetHubByHubId(var_10_5, var_10_4).usedtime
	local var_10_7 = var_4:getConfig("reward_need")
	local var_10_8 = var_4.ultimate
	local var_10_9 = 0 < var_10_8

	if var_10_7 <= var_10_6 and not var_10_9 then
		pg = var_8

		local var_10_10 = var_8.m02
		local var_10_11 = var_8.sendNotification

		GAME = var_1_10010

		local var_10_12 = var_1_10010.SEND_MINI_GAME_OP
		local var_10_13 = {
			hubid = var_4.id
		}

		MiniGameOPCommand = var_12
		var_10_13.cmd = var_12.CMD_ULTIMATE
		var_10_13.args1 = {}

		var_10_11(var_10_10, var_10_12, var_10_13)
	end

	return
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_11_0 = var_1_10000(var_1_10001)
	local var_11_1 = var_0.getActivityById

	pg = var_1_10002

	if var_11_1(var_11_0, var_1_10002.activity_const.NEWYEAR_SNACK_PAGE_ID.act_id) and not var_0:isEnd() then
		local var_11_2 = var_0
		local var_11_3 = var_0.getConfig(var_11_2, "config_client").linkMiniGameID

		getProxy = var_11_2
		MiniGameProxy = var_3

		local var_11_4 = var_11_2(var_3)
		local var_11_5 = var_2.GetMiniGameData(var_11_4, var_11_3)
		local var_11_6 = var_2.getConfig(var_11_5, "hub_id")

		getProxy = var_11_5
		MiniGameProxy = var_5

		local var_11_7 = var_11_5(var_5)
		local var_11_8 = var_4.GetHubByHubId(var_11_7, var_11_6).usedtime
		local var_11_9 = var_4:getConfig("reward_need")
		local var_11_10 = var_4.ultimate > 0

		if var_11_9 <= var_11_8 and not var_11_10 then
			return true
		elseif var_4.count > 0 then
			return true
		else
			return false
		end
	end

	return
end

return var_0_1
