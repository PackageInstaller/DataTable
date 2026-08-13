class = var_0_10000

local var_0_0 = "OtherWorldTempleScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = 3
local var_0_3 = "other_world_temple_toggle_1"
local var_0_4 = "other_world_temple_toggle_2"
local var_0_5 = "other_world_temple_toggle_3"
local var_0_6 = "other_world_temple_char"
local var_0_7 = "other_world_temple_award"
local var_0_8 = "other_world_temple_got"
local var_0_9 = "other_world_temple_progress"
local var_0_10 = "other_world_temple_char_title"
local var_0_11 = "other_world_temple_lottery_all"
local var_0_12 = "other_world_temple_award_desc"
local var_0_13 = "other_world_temple_pay"
local var_0_14 = "temple_consume_not_enough"
local var_0_15 = 30

function var_0_1.getUIName(arg_1_0)
	return "OtherWorldTempleUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_template

	ActivityConst = var_1_10002
	arg_2_0.templeIds = var_2_0[var_1_10002.OTHER_WORLD_TERMINAL_LOTTERY_ID].config_data
	arg_2_0.shopDatas = {}
	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.templeIds) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.activity_random_award_template[iter_2_1]
		var_1_10007 = {}
		ipairs = var_1_10008

		for iter_2_2, iter_2_3 in var_1_10008(var_1_10006.item_list) do
			table = var_1_10013

			var_1_10013.insert(var_1_10007, {
				id = iter_2_3[1],
				count = iter_2_3[2]
			})
		end

		table = var_1_10008

		var_1_10008.insert(arg_2_0.shopDatas, var_1_10007)
	end

	arg_2_0.charIds = {}
	ipairs = var_1
	pg = var_3

	for iter_2_4, iter_2_5 in var_1(var_3.guardian_template.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.guardian_template[iter_2_5]
		table = var_1_10007

		if var_1_10007.contains(arg_2_0.templeIds, var_1_10006.guardian_gain_pool) then
			table = var_1_10007

			var_1_10007.insert(arg_2_0.charIds, iter_2_5)
		end
	end

	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001

	local var_3_0 = var_1_10001(arg_3_0._tf, "ad")

	findTF = var_1_10002

	local var_3_1 = var_1_10002(arg_3_0._tf, "pop")

	findTF = var_3
	arg_3_0.picTf = var_3(var_3_0, "pic")
	onButton = var_3

	local var_3_2 = arg_3_0

	findTF = var_6

	local var_3_3 = var_6(var_3_0, "btnBack")

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_3_2, var_3_3, var_3_4, var_8)

	onButton = var_3

	local var_3_5 = arg_3_0

	findTF = var_3_3

	local var_3_6 = var_3_3(var_3_0, "btnHelp")

	local function var_3_7()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.other_world_temple_tip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_5, var_3_6, var_3_7, var_8)

	arg_3_0.pageToggles = {}

	for iter_3_0 = 1, var_0_2 do
		findTF = var_3_7
		var_3_7 = var_3_7(var_3_0, "pageToggle/bg/" .. iter_3_0)
		table = var_8

		var_8.insert(arg_3_0.pageToggles, var_3_7)

		onButton = var_8

		local var_3_8 = arg_3_0
		local var_3_9 = var_3_7

		local function var_3_10()
			local var_6_0 = iter_3_0
			local var_6_1 = arg_3_0

			var_1.selectPage(var_6_1, var_6_0)

			local var_6_2 = arg_3_0

			var_1.updateUI(var_6_2)

			return
		end

		SFX_CONFIRM = var_1_10013

		var_8(var_3_8, var_3_9, var_3_10, var_1_10013)
	end

	onButton = var_3

	local var_3_11 = arg_3_0

	findTF = iter_3_0

	local var_3_12 = iter_3_0(var_3_0, "btnDetail")

	local function var_3_13()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		OtherWorldTempleMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.OPEN_TERMINAL)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_11, var_3_12, var_3_13, var_8)

	onButton = var_3

	local var_3_14 = arg_3_0

	findTF = var_3_12

	local var_3_15 = var_3_12(var_3_0, "btnAward")

	local function var_3_16()
		local var_8_0 = arg_3_0._awardPage

		var_0.updateSelect(var_8_0, arg_3_0._selectIndex)

		local var_8_1 = arg_3_0._awardPage

		var_0.setActive(var_8_1, true)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_14, var_3_15, var_3_16, var_8)

	onButton = var_3

	local var_3_17 = arg_3_0

	findTF = var_3_15

	local var_3_18 = var_3_15(var_3_0, "btnPay")

	local function var_3_19()
		local var_9_0 = arg_3_0.activityPools[arg_3_0.templeIds[arg_3_0._selectIndex]]
		local var_9_1

		if var_0.getleftItemCount(var_9_0) < arg_3_0.lotteryCount then
			var_9_1 = var_0
		end

		local var_9_2 = arg_3_0
		local var_9_3 = var_2.getResCount(var_9_2)
		local var_9_4 = arg_3_0
		local var_9_5 = var_3.getConsume(var_9_4) * var_9_1
		local var_9_7

		if 0 < var_9_1 and var_9_5 <= var_9_3 then
			if arg_3_0.activity.data1 ~= arg_3_0.templeIds[arg_3_0._selectIndex] then
				pg = var_9_7

				local var_9_6 = var_9_7.m02

				var_9_7 = var_9_7.sendNotification
				GAME = var_2_10007
				var_2_10007 = var_2_10007.ACTIVITY_OPERATION

				local var_9_8 = {
					cmd = 2
				}

				ActivityConst = var_2_10009
				var_9_8.activity_id = var_2_10009.OTHER_WORLD_TERMINAL_LOTTERY_ID
				var_9_8.arg1 = arg_3_0.templeIds[arg_3_0._selectIndex]

				var_9_7(var_9_6, var_2_10007, var_9_8)

				var_9_7 = arg_3_0

				function var_9_7._payToLotterCallback()
					local var_10_0 = arg_3_0

					var_0.payToLottery(var_10_0, var_9_1)

					return
				end
			else
				local var_9_9 = arg_3_0

				var_9_7.payToLottery(var_9_9, var_9_1)
			end
		elseif var_9_3 < var_9_5 then
			pg = var_9_7

			local var_9_10 = var_9_7.TipsMgr.GetInstance()
			local var_9_11 = var_4.ShowTips

			i18n = var_2_10007

			var_9_11(var_9_10, var_2_10007(var_0_14))
		end

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_17, var_3_18, var_3_19, var_8)

	onButton = var_3

	local var_3_20 = arg_3_0

	findTF = var_3_18

	local var_3_21 = var_3_18(var_3_0, "btnChars")

	local function var_3_22()
		local var_11_0 = arg_3_0._charPage

		var_0.updateSelect(var_11_0)

		local var_11_1 = arg_3_0._charPage

		var_0.setActive(var_11_1, true)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_20, var_3_21, var_3_22, var_8)

	onButton = var_3

	local var_3_23 = arg_3_0

	findTF = var_3_21

	local var_3_24 = var_3_21(var_3_0, "btnMain")

	local function var_3_25()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_3_23, var_3_24, var_3_25, var_8)

	findTF = var_3
	arg_3_0._coinText = var_3(var_3_0, "coin/text")
	OtherWorldTempleChars = var_3

	local var_3_26 = var_3.New

	findTF = var_5
	arg_3_0._charPage = var_3_26(var_5(arg_3_0._tf, "pop/charPage"), arg_3_0)

	local var_3_27 = arg_3_0._charPage

	var_3.setData(var_3_27, arg_3_0.charIds)

	OtherWorldTempleAward = var_3

	local var_3_28 = var_3.New

	findTF = var_3_27
	arg_3_0._awardPage = var_3_28(var_3_27(arg_3_0._tf, "pop/awardPage"), arg_3_0)

	local var_3_29 = arg_3_0._awardPage

	var_3.setData(var_3_29, arg_3_0.templeIds, arg_3_0.shopDatas)

	local var_3_30 = arg_3_0._charPage

	var_3.setActive(var_3_30, false)

	local var_3_31 = arg_3_0._awardPage

	var_3.setActive(var_3_31, false)

	setText = var_3
	findTF = var_3_31

	local var_3_32 = var_3_31(var_3_0, "pageToggle/bg/1/unSelect/text")

	i18n = var_6

	var_3(var_3_32, var_6(var_0_3))

	setText = var_3
	findTF = var_3_32

	local var_3_33 = var_3_32(var_3_0, "pageToggle/bg/2/unSelect/text")

	i18n = var_6

	var_3(var_3_33, var_6(var_0_4))

	setText = var_3
	findTF = var_3_33

	local var_3_34 = var_3_33(var_3_0, "pageToggle/bg/3/unSelect/text")

	i18n = var_6

	var_3(var_3_34, var_6(var_0_5))

	setText = var_3
	findTF = var_3_34

	local var_3_35 = var_3_34(var_3_0, "btnChars/img/text")

	i18n = var_6

	var_3(var_3_35, var_6(var_0_6))

	setText = var_3
	findTF = var_3_35

	local var_3_36 = var_3_35(var_3_0, "btnAward/img/text")

	i18n = var_6

	var_3(var_3_36, var_6(var_0_7))

	setText = var_3
	findTF = var_3_36

	local var_3_37 = var_3_36(var_3_0, "desc/text")

	i18n = var_6

	var_3(var_3_37, var_6(var_0_12))

	setText = var_3
	findTF = var_3_37

	local var_3_38 = var_3_37(var_3_0, "btnComplete/img/text")

	i18n = var_6

	var_3(var_3_38, var_6(var_0_11))
	arg_3_0:selectPage(1)
	arg_3_0:updateActivity()

	return
end

function var_0_1.payToLottery(arg_13_0, arg_13_1)
	if arg_13_0.waitActivityUpdate == true then
		return
	end

	arg_13_0.checkCharAward = true
	arg_13_0.waitActivityUpdate = true

	local var_13_0 = arg_13_0.activityPools[arg_13_0.templeIds[arg_13_0._selectIndex]]

	arg_13_0.poolFetchCount = var_2.getFetchCount(var_13_0)
	pg = var_2

	local var_13_1 = var_2.m02
	local var_13_2 = var_2.sendNotification

	GAME = var_1_10005

	local var_13_3 = var_1_10005.ACTIVITY_OPERATION
	local var_13_4 = {
		cmd = 1
	}

	ActivityConst = var_1_10007
	var_13_4.activity_id = var_1_10007.OTHER_WORLD_TERMINAL_LOTTERY_ID
	var_13_4.arg1 = arg_13_1
	var_13_4.arg2 = arg_13_0.templeIds[arg_13_0._selectIndex]

	var_13_2(var_13_1, var_13_3, var_13_4)

	return
end

function var_0_1.selectPage(arg_14_0, arg_14_1)
	arg_14_0._lastSelectIndex = arg_14_0._selectIndex
	arg_14_0._selectIndex = arg_14_1

	for iter_14_0 = 1, var_0_2 do
		var_1_10006 = arg_14_0.pageToggles[iter_14_0]
		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(var_1_10006, "select"), iter_14_0 == arg_14_0._selectIndex)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(var_1_10006, "unSelect"), iter_14_0 ~= arg_14_0._selectIndex)

		local var_14_0

		if not arg_14_0._lastSelectIndex then
			var_1_10007 = iter_14_0 == arg_14_0._selectIndex and "alphaOn" or "alphaOff"
			GetComponent = var_1_10008
			findTF = var_14_0
			var_14_0 = var_14_0(arg_14_0.picTf, "img/" .. iter_14_0)
			typeof = var_11
			Animator = var_13
			var_14_0 = var_1_10008(var_14_0, var_11(var_13))

			var_1_10008.SetTrigger(var_14_0, var_1_10007)
		elseif arg_14_0._selectIndex ~= arg_14_0._lastSelectIndex then
			if arg_14_0._lastSelectIndex < arg_14_0._selectIndex then
				GetComponent = var_1_10007
				findTF = var_1_10009
				var_1_10009 = var_1_10009(arg_14_0.picTf, "img/" .. arg_14_0._lastSelectIndex)
				typeof = var_14_0
				Animator = var_12
				var_1_10009 = var_1_10007(var_1_10009, var_14_0(var_12))

				var_1_10007.SetTrigger(var_1_10009, "leftOut")

				GetComponent = var_1_10007
				findTF = var_1_10009
				var_1_10009 = var_1_10009(arg_14_0.picTf, "img/" .. arg_14_0._selectIndex)
				typeof = var_14_0
				Animator = var_12
				var_1_10009 = var_1_10007(var_1_10009, var_14_0(var_12))

				var_1_10007.SetTrigger(var_1_10009, "rightIn")
			else
				GetComponent = var_1_10007
				findTF = var_1_10009
				var_1_10009 = var_1_10009(arg_14_0.picTf, "img/" .. arg_14_0._lastSelectIndex)
				typeof = var_14_0
				Animator = var_12
				var_1_10009 = var_1_10007(var_1_10009, var_14_0(var_12))

				var_1_10007.SetTrigger(var_1_10009, "rightOut")

				GetComponent = var_1_10007
				findTF = var_1_10009
				var_1_10009 = var_1_10009(arg_14_0.picTf, "img/" .. arg_14_0._selectIndex)
				typeof = var_10
				Animator = var_12
				var_1_10009 = var_1_10007(var_1_10009, var_10(var_12))

				var_1_10007.SetTrigger(var_1_10009, "leftIn")
			end
		end
	end

	local var_14_1 = arg_14_0:getResIconPath()

	LoadImageSpriteAsync = var_3

	local var_14_2 = var_14_1

	findTF = var_1_10006

	var_3(var_14_2, var_1_10006(arg_14_0._tf, "ad/pt/img/icon"), false)

	LoadImageSpriteAsync = var_3

	local var_14_3 = var_14_1

	findTF = var_6

	var_3(var_14_3, var_6(arg_14_0._tf, "ad/btnPay/img/icon"), false)

	return
end

function var_0_1.updateUI(arg_15_0)
	local var_15_0 = arg_15_0:getConsume()
	local var_15_1 = arg_15_0:getResCount()
	local var_15_2 = arg_15_0.activityPools[arg_15_0.templeIds[arg_15_0._selectIndex]]
	local var_15_3 = var_3.getleftItemCount(var_15_2)

	math = var_4

	local var_15_4 = var_4.min(var_15_3, var_0_15)

	math = var_15_2

	local var_15_5 = var_15_2.floor(var_15_1 / var_15_0)

	math = var_6
	arg_15_0.lotteryCount = var_6.min(var_15_4, var_15_5)

	if arg_15_0.lotteryCount <= 0 then
		arg_15_0.lotteryCount = 1
	end

	local var_15_6 = arg_15_0:getConsume() * arg_15_0.lotteryCount

	setText = var_7
	findTF = var_9

	var_7(var_9(arg_15_0._tf, "ad/btnPay/img/text"), var_15_6)

	setText = var_7
	findTF = var_9

	local var_15_7 = var_9(arg_15_0._tf, "ad/btnPay/img/desc")

	i18n = var_10

	var_7(var_15_7, var_10(var_0_13, arg_15_0.lotteryCount))

	setText = var_7
	findTF = var_15_7

	var_7(var_15_7(arg_15_0._tf, "ad/pt/img/text"), var_15_1)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_15_0._tf, "ad/btnPay"), var_15_3 > 0)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_15_0._tf, "ad/btnComplete"), var_15_3 <= 0)

	GetComponent = var_7
	findTF = var_9

	local var_15_8 = var_9(arg_15_0._tf, "ad/btnComplete/img/bg")

	typeof = var_10
	arg_15_0.grayComponent = var_7(var_15_8, var_10("UIGrayScale"))

	local var_15_9 = arg_15_0.grayComponent

	var_15_9.enabled = false
	onNextTick = var_15_9

	var_15_9(function()
		if arg_15_0.grayComponent then
			arg_15_0.grayComponent.enabled = true
		end

		return
	end)

	return
end

function var_0_1.getResCount(arg_17_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.getData(var_17_0)

	pg = var_1_10002

	local var_17_2 = var_1_10002.activity_random_award_template[arg_17_0.templeIds[arg_17_0._selectIndex]].resource_type
	local var_17_3

	if not var_17_1:getResById(var_17_2) then
		var_17_3 = 0
	end

	return var_17_3
end

function var_0_1.getConsume(arg_18_0)
	pg = var_1_10001

	return var_1_10001.activity_random_award_template[arg_18_0.templeIds[arg_18_0._selectIndex]].resource_num
end

function var_0_1.getResIconPath(arg_19_0)
	Drop = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = {}

	DROP_TYPE_RESOURCE = var_1_10004
	var_19_1.type = var_1_10004
	pg = var_1_10004
	var_19_1.id = var_1_10004.activity_random_award_template[arg_19_0.templeIds[arg_19_0._selectIndex]].resource_type

	local var_19_2 = var_19_0(var_19_1)

	return var_1.getIcon(var_19_2)
end

function var_0_1.updateActivity(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.getActivityById

	ActivityConst = var_1_10004
	arg_20_0.activity = var_20_1(var_20_0, var_1_10004.OTHER_WORLD_TERMINAL_LOTTERY_ID)

	local var_20_2 = arg_20_0.activity

	arg_20_0.awardInfos = var_1.getAwardInfos(var_20_2)
	arg_20_0.activityPools = {}
	ipairs = var_1

	for iter_20_0, iter_20_1 in var_1(arg_20_0.templeIds) do
		ActivityItemPool = var_1_10006
		var_1_10006 = var_1_10006.New({
			id = iter_20_1,
			awards = arg_20_0.awardInfos[iter_20_1],
			index = iter_20_0
		})
		arg_20_0.activityPools[var_1_10006.id] = var_1_10006
	end

	if arg_20_0._payToLotterCallback then
		print = var_1

		var_1("活动数据更新,当前奖池" .. arg_20_0.activity.data1)
		arg_20_0._payToLotterCallback()

		arg_20_0._payToLotterCallback = nil
	else
		arg_20_0:updateUI()

		local var_20_3 = arg_20_0._awardPage

		var_1.updateActivityPool(var_20_3, arg_20_0.activityPools)

		local var_20_4 = arg_20_0._charPage

		var_1.updateActivityPool(var_20_4, arg_20_0.activityPools)
	end

	arg_20_0.waitActivityUpdate = false

	return
end

function var_0_1.displayTempleCharAward(arg_21_0)
	if arg_21_0.checkCharAward then
		local var_21_0 = arg_21_0.activityPools[arg_21_0.templeIds[arg_21_0._selectIndex]]

		if var_1.getFetchCount(var_21_0) == arg_21_0.poolFetchCount then
			return
		end

		arg_21_0.checkCharAward = false

		if var_1:getTempleNewChar(arg_21_0.poolFetchCount) then
			local var_21_1 = #var_2

			if 0 < var_21_1 then
				local var_21_2 = {}

				ipairs = var_4

				for iter_21_0, iter_21_1 in var_4(var_2) do
					pg = var_1_10009
					var_1_10009 = var_1_10009.guardian_template[iter_21_1].drop
					ipairs = var_1_10010

					for iter_21_2, iter_21_3 in var_1_10010(var_1_10009) do
						table = var_1_10015
						var_1_10015 = var_1_10015.insert

						local var_21_3 = var_21_2

						Drop = var_1_10018

						var_1_10015(var_21_3, var_1_10018.New({
							type = iter_21_3[1],
							id = iter_21_3[2],
							count = iter_21_3[3]
						}))
					end
				end

				local var_21_4 = arg_21_0
				local var_21_5 = arg_21_0.emit

				OtherWorldTempleMediator = iter_21_0

				var_21_5(var_21_4, iter_21_0.SHOW_CHAR_AWARDS, var_21_2)
			end
		end
	end

	return
end

return var_0_1
