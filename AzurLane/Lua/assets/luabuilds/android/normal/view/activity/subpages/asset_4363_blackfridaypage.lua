class = var_0_10000

local var_0_0 = "BlackFridayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.shopBtn = var_1.Find(var_1_0, "AD/shop_btn")
	UIItemList = var_1

	local var_1_1 = var_1.New
	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.Find(var_1_2, "AD/list")
	local var_1_4 = arg_1_0._tf

	arg_1_0.uiList = var_1_1(var_1_3, var_3.Find(var_1_4, "AD/list/award"))

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_1.Find(var_1_5, "AD/Text")
	local var_1_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_4
	arg_1_0.finishCntTxt = var_1_7(var_1_6, var_3(var_1_4))

	local var_1_8 = arg_1_0._tf

	arg_1_0.helpBtn = var_1.Find(var_1_8, "AD/help")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		local var_2_0 = arg_2_0.ptData

		var_1.Update(var_2_0, arg_2_0.activity)
	else
		ActivityPtData = var_1
		arg_2_0.ptData = var_1.New(arg_2_0.activity)
	end

	arg_2_0.endTime = arg_2_0.activity.stopTime

	local var_2_1 = arg_2_0.activity

	if var_1.getConfig(var_2_1, "config_client") and var_1[1] then
		type = var_2

		if var_2(var_1[1]) == "table" then
			pg = var_2

			local var_2_2 = var_2.TimeMgr.GetInstance()

			arg_2_0.endTime = var_2.parseTimeFromConfig(var_2_2, var_1[1])
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_3_0.helpBtn) then
		onButton = var_1

		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.helpBtn

		local function var_3_2()
			pg = var_2_10000

			local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_4_1 = var_0.ShowMsgBox
			local var_4_2 = {}

			MSGBOX_TYPE_HELP = var_2_10003
			var_4_2.type = var_2_10003
			pg = var_2_10003
			var_4_2.helps = var_2_10003.gametip.blackfriday_help.tip

			var_4_1(var_4_0, var_4_2)

			return
		end

		SFX_PANEL = var_1_10005

		var_1(var_3_0, var_3_1, var_3_2, var_1_10005)
	end

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.shopBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.TimeMgr.GetInstance()

		if var_0.GetServerTime(var_5_0) >= arg_3_0.endTime then
			pg = var_0

			local var_5_1 = var_0.TipsMgr.GetInstance()
			local var_5_2 = var_0.ShowTips

			i18n = var_2_10002

			var_5_2(var_5_1, var_2_10002("common_activity_end"))
		else
			local var_5_3 = arg_3_0
			local var_5_4 = var_0.emit

			ActivityMediator = var_2_10002

			local var_5_5 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_5_6 = var_2_10003.SKINSHOP
			local var_5_7 = {}

			NewSkinShopScene = var_2_10005
			var_5_7.page = var_2_10005.PAGE_RETURN

			var_5_4(var_5_3, var_5_5, var_5_6, var_5_7)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0.uiList

	var_1.make(var_3_6, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0

			var_3.UpdateAward(var_6_0, arg_6_1 + 1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_1.GetState(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 <= arg_7_0.finishCnt
	local var_7_1 = arg_7_0.ptData.targets[arg_7_1]

	table = var_1_10004

	if var_1_10004.contains(arg_7_0.finishList, var_7_1) then
		return var_0_4
	elseif not var_4 and var_7_0 then
		return var_0_3
	else
		return var_0_2
	end

	return
end

function var_0_1.UpdateAward(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.awards[arg_8_1]
	local var_8_1 = {
		type = var_8_0[1],
		id = var_8_0[2],
		count = var_8_0[3]
	}

	updateDrop = var_5

	var_5(arg_8_2, var_8_1)

	setActive = var_5

	local var_8_2 = arg_8_2:Find("icon_bg/count")
	local var_8_3 = var_8_1.count

	var_5(var_8_2, 0 < var_8_3)

	local var_8_4 = arg_8_2:Find("icon_bg/frame")
	local var_8_5 = var_5.GetComponent

	typeof = var_7
	Image = var_8

	local var_8_6 = var_8_5(var_8_4, var_7(var_8))

	Color = var_8_4
	var_8_6.color = var_8_4.New(0, 0, 0, 0)

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.GetState(var_8_7, arg_8_1)

	setActive = var_8_7

	var_8_7(arg_8_2:Find("got"), var_8_8 == var_0_4)

	setActive = var_8_7

	var_8_7(arg_8_2:Find("get"), var_8_8 == var_0_3)

	setActive = var_8_7

	var_8_7(arg_8_2:Find("lock"), var_8_8 == var_0_2)

	if var_8_8 == var_0_3 then
		onButton = var_6

		local var_8_9 = arg_8_0
		local var_8_10 = arg_8_2

		local function var_8_11()
			local var_9_0 = arg_8_0.ptData.targets[arg_8_1]
			local var_9_1 = arg_8_0
			local var_9_2 = var_1.emit

			ActivityMediator = var_2_10003

			local var_9_3 = var_2_10003.EVENT_PT_OPERATION
			local var_9_4 = {
				cmd = 1
			}
			local var_9_5 = arg_8_0.ptData

			var_9_4.activity_id = var_5.GetId(var_9_5)
			var_9_4.arg1 = var_9_0

			var_9_2(var_9_1, var_9_3, var_9_4)

			return
		end

		SFX_PANEL = var_10

		var_6(var_8_9, var_8_10, var_8_11, var_10)
	else
		onButton = var_6

		local var_8_12 = arg_8_0
		local var_8_13 = arg_8_2

		local function var_8_14()
			local var_10_0 = arg_8_0
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_DROP, var_8_1)

			return
		end

		SFX_PANEL = var_10

		var_6(var_8_12, var_8_13, var_8_14, var_10)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	arg_11_0.awards = arg_11_0.ptData.dropList
	arg_11_0.finishCnt = arg_11_0.ptData.count
	arg_11_0.finishList = arg_11_0.ptData.activity.data1_list
	arg_11_0.finishCntTxt.text = "X" .. arg_11_0.finishCnt

	local var_11_0 = arg_11_0.uiList

	var_1.align(var_11_0, #arg_11_0.awards)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
