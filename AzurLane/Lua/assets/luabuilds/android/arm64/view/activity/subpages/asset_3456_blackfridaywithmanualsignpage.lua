class = var_0_10000

local var_0_0 = "BlackFridayWithManualSignPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BlackFridayPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	UIItemList = var_1

	local var_1_0 = var_1.New
	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_3.Find(var_1_1, "AD/singlist")
	local var_1_3 = arg_1_0._tf

	arg_1_0.signList = var_1_0(var_1_2, var_4.Find(var_1_3, "AD/singlist/Award"))

	local var_1_4 = arg_1_0._tf

	arg_1_0.signBtn = var_1.Find(var_1_4, "AD/signBtn")
	setText = var_1

	local var_1_5 = arg_1_0.signBtn
	local var_1_6 = var_3.Find(var_1_5, "Text")

	i18n = var_4

	var_1(var_1_6, var_4("SkinMagazinePage2_tip"))

	return
end

function var_0_1.GetPageLink(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")[2]

	return {
		var_2_1
	}
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)

	local var_3_0 = arg_3_0.activity

	arg_3_0.signInActId = var_1.getConfig(var_3_0, "config_client")[2]

	return
end

function var_0_1.FlushSignBtn(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = not var_1.getActivityById(var_4_0, arg_4_0.signInActId) or var_1:isEnd()

	onButton = var_4_0

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.signBtn

	local function var_4_4()
		local var_5_0 = arg_4_0

		var_0.Sign(var_5_0, var_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_4_0(var_4_2, var_4_3, var_4_4, var_1_10008)

	setActive = var_4_0

	var_4_0(arg_4_0.signBtn, not var_4_1 and var_1:AnyAwardCanGet())

	return
end

function var_0_1.FlushSignActivity(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	if not var_1.getActivityById(var_6_0, arg_6_0.signInActId) or var_1:isEnd() then
		arg_6_0:FlushEmptyList()
	else
		arg_6_0:FlushSignList(var_1)
	end

	return
end

function var_0_1.FlushEmptyList(arg_7_0)
	local var_7_0 = arg_7_0.signList

	var_1.align(var_7_0, 0)

	return
end

function var_0_1.FlushSignList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetDropList()
	local var_8_1 = arg_8_1:GetCanGetAwardIndexList()
	local var_8_2 = {}
	local var_8_3 = arg_8_1:getConfig("config_client")

	type = var_1_10006

	local var_8_4 = var_1_10006(var_8_3) == "table" and var_8_3 or {}
	local var_8_5 = arg_8_0.signList

	var_7.make(var_8_5, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_1
			local var_9_1 = var_3.GetAwardState(var_9_0, arg_9_1 + 1)
			local var_9_2 = arg_8_0

			var_4.UpdateSignAward(var_9_2, arg_8_1, var_9_1, var_8_0[arg_9_1 + 1], arg_9_2)

			ManualSignActivity = var_4

			if var_9_1 == var_4.STATE_GOT then
				table = var_4

				var_4.insert(var_8_2, var_8_4[arg_9_1 + 1])
			end
		end

		return
	end)

	local var_8_6 = arg_8_0.signList

	var_7.align(var_8_6, #var_8_0)
	arg_8_0:TryPlayStory(var_8_2)

	return
end

function var_0_1.TryPlayStory(arg_10_0, arg_10_1)
	if #arg_10_1 <= 0 then
		return
	end

	_ = var_2

	if #var_2.select(arg_10_1, function(arg_11_0)
		pg = var_2_10001

		local var_11_0 = var_2_10001.NewStoryMgr.GetInstance()

		return not var_1.IsPlayed(var_11_0, arg_11_0)
	end) > 0 then
		pg = var_3

		local var_10_0 = var_3.NewStoryMgr.GetInstance()

		var_3.SeriesPlay(var_10_0, var_2)
	end

	return
end

function var_0_1.UpdateSignAward(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	updateDrop = var_1_10005

	var_1_10005(arg_12_4, arg_12_3)

	setActive = var_1_10005

	local var_12_0 = arg_12_4:Find("got")

	ManualSignActivity = var_8

	var_1_10005(var_12_0, arg_12_2 == var_8.STATE_GOT)

	setActive = var_1_10005

	local var_12_1 = arg_12_4:Find("get")

	ManualSignActivity = var_8

	var_1_10005(var_12_1, arg_12_2 == var_8.STATE_CAN_GET)

	onButton = var_1_10005

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_4

	local function var_12_4()
		local var_13_0 = arg_12_2

		ManualSignActivity = var_2_10001

		if var_13_0 == var_2_10001.STATE_CAN_GET then
			local var_13_1 = arg_12_0

			var_0.Sign(var_13_1, arg_12_1)
		end

		return
	end

	SFX_PANEL = var_10

	var_1_10005(var_12_2, var_12_3, var_12_4, var_10)

	return
end

function var_0_1.Sign(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0 = var_1_10002.m02
	local var_14_1 = var_2.sendNotification

	GAME = var_1_10005

	local var_14_2 = var_1_10005.ACT_MANUAL_SIGN
	local var_14_3 = {
		activity_id = arg_14_1.id
	}

	ManualSignActivity = var_7
	var_14_3.cmd = var_7.OP_GET_AWARD

	var_14_1(var_14_0, var_14_2, var_14_3)

	return
end

function var_0_1.OnUpdateFlush(arg_15_0)
	var_0_1.super.OnUpdateFlush(arg_15_0)
	arg_15_0:FlushSignActivity()
	arg_15_0:FlushSignBtn()

	return
end

return var_0_1
