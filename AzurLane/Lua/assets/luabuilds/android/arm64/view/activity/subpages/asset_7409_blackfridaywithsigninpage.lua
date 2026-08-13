class = var_0_10000

local var_0_0 = "BlackFridayWithSignInPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BlackFridayPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	UIItemList = var_1

	local var_1_0 = var_1.New
	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_3.Find(var_1_1, "AD/signIn")
	local var_1_3 = arg_1_0._tf

	arg_1_0.signInUIlist = var_1_0(var_1_2, var_4.Find(var_1_3, "AD/signIn/award"))

	local var_1_4 = {}
	local var_1_5 = arg_1_0._tf

	var_1_4[1] = var_2.Find(var_1_5, "AD/toggles/skin")

	local var_1_6 = arg_1_0._tf

	var_1_4[2] = var_2.Find(var_1_6, "AD/toggles/sign")
	arg_1_0.toggles = var_1_4

	local var_1_7 = arg_1_0._tf

	arg_1_0.lockSignBtn = var_1.Find(var_1_7, "AD/toggles/sign/lock")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.lockSignBtn

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.TipsMgr.GetInstance()
		local var_3_1 = var_0.ShowTips

		i18n = var_2_10003

		var_3_1(var_3_0, var_2_10003("common_activity_end"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	local var_2_3 = arg_2_0.activity

	arg_2_0.signInActId = var_1.getConfig(var_2_3, "config_client")[2]

	arg_2_0:FlushSignInInfo()

	if arg_2_0.contextData.showByNextAct then
		local var_2_4 = arg_2_0.contextData

		var_2_4.showByNextAct = nil
		triggerToggle = var_2_4

		var_2_4(arg_2_0.toggles[2], true)
	end

	return
end

function var_0_1.GetSignInAct(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	return (var_1.getActivityById(var_4_0, arg_4_0.signInActId))
end

function var_0_1.ClientSignInActIsEnd(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.activity_template[arg_5_0.signInActId]

	pg = var_2

	local var_5_1 = var_2.TimeMgr.GetInstance()
	local var_5_2 = var_2.parseTimeFromConfig(var_5_1, var_5_0.time[3])

	pg = var_1_10003

	local var_5_3 = var_1_10003.TimeMgr.GetInstance()
	local var_5_4 = var_3.parseTimeFromConfig(var_5_3, var_5_0.time[2])

	pg = var_5_1

	local var_5_5 = var_5_1.TimeMgr.GetInstance()

	return var_5_2 < var_4.GetServerTime(var_5_5) or var_4 < var_5_4
end

function var_0_1.FlushSignInInfo(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetSignInAct(var_6_0) and not var_1:isEnd()

	pg = var_6_0

	local var_6_2 = var_6_0.activity_template[arg_6_0.signInActId]
	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.ClientSignInActIsEnd(var_6_3)

	if not var_6_1 and var_6_4 then
		triggerToggle = var_6_3

		var_6_3(arg_6_0.toggles[1], true)

		setToggleEnabled = var_6_3

		var_6_3(arg_6_0.toggles[2], false)
	end

	setActive = var_6_3

	var_6_3(arg_6_0.lockSignBtn, var_5)

	local var_6_5 = var_6_2.config_id

	pg = var_1_10007

	local var_6_6 = var_1_10007.activity_7_day_sign[var_6_5].front_drops
	local var_6_7 = arg_6_0.signInUIlist

	var_8.make(var_6_7, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_6_6[arg_7_1 + 1]
			local var_7_1 = {
				type = var_7_0[1],
				id = var_7_0[2],
				count = var_7_0[3]
			}

			updateDrop = var_5

			var_5(arg_7_2, var_7_1)

			onButton = var_5

			local var_7_2 = arg_6_0
			local var_7_3 = arg_7_2

			local function var_7_4()
				local var_8_0 = arg_6_0
				local var_8_1 = var_0.emit

				BaseUI = var_3_10003

				var_8_1(var_8_0, var_3_10003.ON_DROP, var_7_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_7_2, var_7_3, var_7_4, var_2_10010)
		end

		return
	end)

	local var_6_8 = arg_6_0.signInUIlist

	var_8.align(var_6_8, #var_6_6)

	return
end

function var_0_1.FlushSignAwardsState(arg_9_0)
	local var_9_0

	if not (arg_9_0:GetSignInAct() and not var_1:isEnd()) or not var_1.data1 then
		var_9_0 = 0
	end

	local var_9_1 = arg_9_0:ClientSignInActIsEnd()
	local var_9_2 = arg_9_0.signInUIlist

	var_5.each(var_9_2, function(arg_10_0, arg_10_1)
		if not var_9_1 and not var_0 then
			setActive = var_2

			var_2(arg_10_1:Find("got"), true)
		else
			setActive = var_2

			var_2(arg_10_1:Find("got"), arg_10_0 + 1 <= var_9_0)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	var_0_1.super.OnUpdateFlush(arg_11_0)
	arg_11_0:FlushSignAwardsState()

	return
end

return var_0_1
