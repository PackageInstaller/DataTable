class = var_0_10000

local var_0_0 = "WarspiteTransformationPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.btn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.tip = var_1.Find(var_1_2, "help")

	local var_1_3 = arg_1_0.bg

	arg_1_0.mainAward = var_1.Find(var_1_3, "award")
	CustomIndexLayer = var_1

	local var_1_4 = var_1.Clone2Full
	local var_1_5 = arg_1_0.bg

	arg_1_0.subAwards = var_1_4(var_2.Find(var_1_5, "list"), 7)

	local var_1_6 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_6, "receivetimes")

	local var_1_7 = arg_1_0.bg

	arg_1_0.score = var_1.Find(var_1_7, "highscore")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_1

	if arg_2_0.activity.data4 == 0 and var_1.data2 >= 7 then
		local var_2_0 = arg_2_0

		var_2_1 = arg_2_0.emit
		ActivityMediator = var_1_10004

		var_2_1(var_2_0, var_1_10004.EVENT_OPERATION, {
			cmd = 3,
			activity_id = var_1.id
		})

		do return true end

		goto label_2_0
	end

	defaultValue = var_2_1

	if not (var_2_1(var_1.data2_list[1], 0) > 0) then
		defaultValue = var_2

		if var_2(var_1.data2_list[2], 0) > 0 then
			local var_2_2 = arg_2_0
			local var_2_3 = arg_2_0.emit

			ActivityMediator = var_4

			var_2_3(var_2_2, var_4.EVENT_OPERATION, {
				cmd = 2,
				activity_id = var_1.id
			})

			return true
		end

		::label_2_0::

		return
	end
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client")[2]
	local var_3_2 = {
		type = var_3_1[1],
		id = var_3_1[2],
		count = var_3_1[3]
	}

	onButton = var_4

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.mainAward

	local function var_3_5()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_DROP, var_3_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_3_3, var_3_4, var_3_5, var_1_10008)

	for iter_3_0 = 1, 7 do
		var_1_10008 = arg_3_0.subAwards[iter_3_0]

		local var_3_6 = var_1:getConfig("config_client")[1]
		local var_3_7 = {
			type = var_3_6[1],
			id = var_3_6[2],
			count = var_3_6[3]
		}

		onButton = var_11

		local var_3_8 = arg_3_0
		local var_3_9 = var_1_10008

		local function var_3_10()
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			BaseUI = var_2_10002

			var_5_1(var_5_0, var_2_10002.ON_DROP, var_3_7)

			return
		end

		SFX_PANEL = var_1_10015

		var_11(var_3_8, var_3_9, var_3_10, var_1_10015)
	end

	onButton = var_4

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.tip

	local function var_3_13()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.goldship_help_tip.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_3_11, var_3_12, var_3_13, var_1_10008)

	onButton = var_4

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.btn

	local function var_3_16()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_DODGEM)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_3_14, var_3_15, var_3_16, var_1_10008)

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	local var_8_0 = arg_8_0.activity

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()
	local var_8_2 = var_2.DiffDay(var_8_1, var_8_0.data1, var_2:GetServerTime()) + 1

	setActive = var_8_1
	findTF = var_5

	var_8_1(var_5(arg_8_0.mainAward, "get"), var_8_0.data4 > 0)

	for iter_8_0 = 1, 7 do
		local var_8_3 = arg_8_0.subAwards[iter_8_0]

		setActive = var_1_10009
		findTF = var_1_10010

		var_1_10009(var_1_10010(var_8_3, "get"), iter_8_0 <= var_8_0.data2)

		setActive = var_1_10009
		findTF = var_1_10010

		var_1_10009(var_1_10010(var_8_3, "lock"), var_8_2 < iter_8_0)
	end

	setText = var_4

	var_4(arg_8_0.step, var_8_0.data2)

	setText = var_4

	var_4(arg_8_0.score, var_8_0.data1_list[1])

	return
end

return var_0_1
