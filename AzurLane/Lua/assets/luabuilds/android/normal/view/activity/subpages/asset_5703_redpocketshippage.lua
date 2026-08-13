class = var_0_10000

local var_0_0 = "RedPocketShipPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))
local var_0_2 = 7
local var_0_3 = {
	[0] = 705.6,
	807.608,
	897.5893,
	987.5705,
	1077.552,
	1167.533,
	1257.514,
	1387.6
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.tip = var_1.Find(var_1_1, "tip")

	local var_1_2 = arg_1_0._tf

	arg_1_0.btn = var_1.Find(var_1_2, "btn")

	local var_1_3 = arg_1_0._tf

	arg_1_0.mainAward = var_1.Find(var_1_3, "main_award")

	local var_1_4 = arg_1_0._tf

	arg_1_0.subAward = var_1.Find(var_1_4, "sub_award")

	local var_1_5 = arg_1_0._tf

	arg_1_0.itemIcon = var_1.Find(var_1_5, "icon")

	local var_1_6 = arg_1_0._tf

	arg_1_0.slider = var_1.Find(var_1_6, "slider")
	UIItemList = var_1

	local var_1_7 = var_1.New
	local var_1_8 = arg_1_0.subAward
	local var_1_9 = arg_1_0.subAward

	arg_1_0.uilist = var_1_7(var_1_8, var_3.Find(var_1_9, "1"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	onButton = var_1_10002

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.tip

	local function var_2_3()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		pg = var_2_10003
		var_3_2.helps = var_2_10003.gametip.metalgearsub_help_tip.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_2_1, var_2_2, var_2_3, var_1_10006)

	onButton = var_1_10002

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.btn

	local function var_2_6()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.GO_SUBMARINE_RUN
		local var_4_3 = var_2_0
		local var_4_4 = var_3.getConfig(var_4_3, "config_client").stage_ids

		math = var_4_3

		var_4_1(var_4_0, var_4_2, var_4_4[var_4_3.min(arg_2_0.progess + 1, arg_2_0.maxday)])

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_2_4, var_2_5, var_2_6, var_1_10006)

	Drop = var_1_10002

	local var_2_7 = var_1_10002.Create(var_2_0:getConfig("config_client")[2])

	onButton = var_3

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.mainAward

	local function var_2_10()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_DROP, var_2_7)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_8, var_2_9, var_2_10, var_1_10007)

	local var_2_11 = var_2_0:getConfig("config_client")[1]
	local var_2_12 = {
		type = var_2_11[1],
		id = var_2_11[2],
		count = var_2_11[3]
	}

	onButton = var_5

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.itemIcon

	local function var_2_15()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_2_12)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_2_13, var_2_14, var_2_15, var_1_10009)

	local var_2_16 = arg_2_0.uilist

	var_5.make(var_2_16, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		local var_7_2

		if arg_7_0 == var_2_10003.EventUpdate then
			LeanTween = var_7_2

			if var_7_2.isTweening(arg_7_2) then
				LeanTween = var_7_2

				var_7_2.cancel(arg_7_2)
			end

			if arg_7_1 < arg_2_0.progess then
				setImageAlpha = var_7_2

				var_7_2(arg_7_2, 1)
			else
				LeanTween = var_7_2

				local var_7_0 = var_7_2.alpha(arg_7_2, 1, 1)
				local var_7_1 = var_7_2.setFrom(var_7_0, 0.4)

				var_7_2 = var_7_2.setEase
				LeanTweenType = var_5

				local var_7_3 = var_7_2(var_7_1, var_5.easeInOutSine)

				var_7_2.setLoopPingPong(var_7_3)
			end
		else
			UIItemList = var_7_2

			if arg_7_0 == var_7_2.EventExcess then
				LeanTween = var_3

				if var_3.isTweening(arg_7_2) then
					LeanTween = var_3

					var_3.cancel(arg_7_2)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	local var_8_0 = arg_8_0.activity

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()

	math = var_1_10003
	arg_8_0.progess = var_1_10003.min(var_8_0.data2, var_0_2)
	math = var_3
	arg_8_0.maxday = var_3.min(var_8_1:DiffDay(var_8_0.data1, var_8_1:GetServerTime()) + 1, var_0_2)

	local var_8_2 = arg_8_0.uilist
	local var_8_3 = var_3.align

	math = var_5

	var_8_3(var_8_2, var_5.min(arg_8_0.maxday, var_0_2 - 1))

	setSlider = var_8_3

	var_8_3(arg_8_0.slider, var_0_3[0], var_0_3[var_0_2], var_0_3[arg_8_0.progess])

	setActive = var_8_3
	findTF = var_4

	var_8_3(var_4(arg_8_0.mainAward, "dis"), not var_8_0.data4 or var_8_0.data4 == 0)

	setActive = var_8_3
	findTF = var_4

	var_8_3(var_4(arg_8_0.mainAward, "dis/lock"), arg_8_0.maxday < var_0_2)

	setActive = var_8_3
	findTF = var_4

	var_8_3(var_4(arg_8_0.mainAward, "get"), var_8_0.data4 > 0)

	local var_8_5

	if var_8_0.data4 == 0 and arg_8_0.progess >= var_0_2 then
		local var_8_4 = arg_8_0

		var_8_5 = arg_8_0.emit
		ActivityMediator = var_5

		var_8_5(var_8_4, var_5.EVENT_OPERATION, {
			cmd = 3,
			activity_id = var_8_0.id
		})

		goto label_8_0
	end

	defaultValue = var_8_5

	if not (var_8_5(var_8_0.data2_list[1], 0) > 0) then
		defaultValue = var_3

		if var_3(var_8_0.data2_list[2], 0) > 0 then
			local var_8_6 = arg_8_0
			local var_8_7 = arg_8_0.emit

			ActivityMediator = var_5

			var_8_7(var_8_6, var_5.EVENT_OPERATION, {
				cmd = 2,
				activity_id = var_8_0.id
			})
		end

		::label_8_0::

		return
	end
end

function var_0_1.OnDestroy(arg_9_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_9_0.bg)

	return
end

return var_0_1
