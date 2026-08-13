class = var_0_10000

local var_0_0 = "MikasaRepairePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.layer = var_1.Find(var_1_0, "layer")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	arg_3_0:update_task_list_mikasa_museum(arg_3_0.activity, arg_3_0.layer, 1)

	return
end

function var_0_1.update_task_list_mikasa_museum(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	getProxy = var_1_10004
	TaskProxy = var_1_10005

	local var_4_0 = var_1_10004(var_1_10005)
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getConfig(var_4_1, "config_data")

	getProxy = var_4_1
	ActivityProxy = var_7

	local var_4_3 = var_4_1(var_7)
	local var_4_4 = arg_4_2:Find("AD")
	local var_4_5 = arg_4_2:Find("item")
	local var_4_6 = var_8.Find(var_4_5, "helpBtn")

	onButton = var_4_5

	local var_4_7 = arg_4_0
	local var_4_8 = var_4_6

	local function var_4_9()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.word_museum_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10014

	var_4_5(var_4_7, var_4_8, var_4_9, var_1_10014)

	local var_4_10
	local var_4_11
	local var_4_12
	local var_4_13 = {}
	local var_4_14
	local var_4_15

	for iter_4_0 = 1, 4 do
		local var_4_16 = var_8:Find("Panel/layout_layer/repair_panel" .. iter_4_0 .. "/Panel")
		local var_4_17 = var_10.Find(var_4_16, "btn_repair")

		var_4_13[iter_4_0] = nil

		for iter_4_1 = 1, 4 do
			local var_4_18 = var_10:Find("repair" .. iter_4_1)
			local var_4_19 = var_4_2[(iter_4_0 - 1) * 4 + iter_4_1]

			arg_4_0:set_mikasa_btn(var_4_19, var_4_18, iter_4_1 == 1 and 0 or var_4_2[(iter_4_0 - 1) * 4 + iter_4_1 - 1], iter_4_1 >= 4)

			local var_4_20

			if not var_4_13[iter_4_0] then
				var_4_20 = var_4_0:getTaskById(var_4_19) and var_4_19 or nil
				var_4_13[iter_4_0] = var_4_20
			end
		end

		local var_4_21 = var_4_2[(iter_4_0 - 1) * 4 + 1]
		local var_4_22 = var_4_0:getTaskById(var_4_21) or var_4_0:getFinishTaskById(var_4_21)

		setActive = var_1_10020

		var_1_10020(var_10:Find("line1/unselected"), not var_4_22:isReceive())

		setActive = var_1_10020

		var_1_10020(var_10:Find("line1/selected"), var_4_22:isReceive())

		local var_4_23 = var_4_2[(iter_4_0 - 1) * 4 + 2]
		local var_4_24 = var_4_0:getTaskById(var_4_23) or var_4_0:getFinishTaskById(var_4_23)

		setActive = var_1_10020

		var_1_10020(var_10:Find("line2/unselected"), not var_4_24:isReceive())

		setActive = var_1_10020

		var_1_10020(var_10:Find("line2/selected"), var_4_24:isReceive())

		local var_4_25 = var_4_2[(iter_4_0 - 1) * 4 + 3]
		local var_4_26 = var_4_0:getTaskById(var_4_25) or var_4_0:getFinishTaskById(var_4_25)

		setActive = var_1_10020

		var_1_10020(var_10:Find("to_award/unselected"), not var_4_26:isReceive())

		setActive = var_1_10020

		local var_4_27 = var_10:Find("to_award/selected")
		local var_4_28 = var_4_26

		var_1_10020(var_4_27, var_4_26.isReceive(var_4_28))

		local var_4_29 = var_4_2[iter_4_0 * 4]
		local var_4_30 = var_4_0:getTaskById(var_4_29) or var_4_0:getFinishTaskById(var_4_29)
		local var_4_31 = var_4_17

		var_1_10020 = var_4_17.GetComponent
		typeof = var_22
		Image = var_4_28
		var_1_10020 = var_1_10020(var_4_31, var_22(var_4_28))
		var_1_10020.enabled = not var_4_30:isFinish()
		setActive = var_1_10020

		local var_4_32 = var_4_17:Find("get")
		local var_4_33

		if var_4_30:isFinish() then
			var_4_33 = not var_4_30:isReceive()
		end

		var_1_10020(var_4_32, var_4_33)

		setActive = var_1_10020

		var_1_10020(var_4_17:Find("got"), var_4_30:isReceive())

		onButton = var_1_10020

		local var_4_34 = arg_4_0
		local var_4_35 = var_4_17

		local function var_4_36()
			local var_6_0 = arg_4_0
			local var_6_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_6_2 = var_2_10002.ON_TASK_SUBMIT
			local var_6_3 = var_4_0

			var_6_1(var_6_0, var_6_2, var_3.getTaskById(var_6_3, var_4_13[iter_4_0]))

			return
		end

		SFX_PANEL = var_4_20

		var_1_10020(var_4_34, var_4_35, var_4_36, var_4_20)

		setActive = var_1_10020

		local var_4_37 = var_10:Find("gear")
		local var_4_38 = var_4_30

		var_1_10020(var_4_37, not var_4_30.isFinish(var_4_38))

		if not var_4_30:isFinish() then
			var_1_10020 = var_4_0:getTaskById(var_4_13[iter_4_0])

			local var_4_39 = var_4_3
			local var_4_40 = var_4_3.getVirtualItemNumber

			tonumber = var_4_38

			local var_4_41 = var_4_40(var_4_39, var_4_38(var_1_10020:getConfig("target_id")))

			setText = var_4_39

			var_4_39(var_10:Find("gear/test_bg/Text"), var_4_41 .. "/" .. var_1_10020:getConfig("target_num"))
		end

		local var_4_42 = var_4_13[iter_4_0] and (var_4_0:getTaskById(var_14) or var_4_0:getFinishTaskById(var_14)) or nil

		setButtonEnabled = var_1_10020

		var_1_10020(var_4_17, var_4_42 and var_4_42:isFinish())

		setActive = var_1_10020

		var_1_10020(var_4_17:Find("mask"), var_4_42 and var_4_42:isFinish())
	end

	local var_4_43 = var_8:Find("btn_main")
	local var_4_44 = var_4_2[#var_4_2]
	local var_4_45 = var_4_0:getTaskById(var_4_44) or var_4_0:getFinishTaskById(var_4_44)
	local var_4_46 = var_4_43
	local var_4_47 = var_4_43.GetComponent

	typeof = var_18
	Image = iter_4_0

	local var_4_48 = var_4_47(var_4_46, var_18(iter_4_0))

	var_4_48.enabled = not var_4_45:isFinish()
	setActive = var_4_48

	local var_4_49 = var_4_43:Find("get")
	local var_4_50

	if var_4_45:isFinish() then
		var_4_50 = not var_4_45:isReceive()
	end

	var_4_48(var_4_49, var_4_50)

	setActive = var_4_48

	var_4_48(var_4_43:Find("got"), var_4_45:isReceive())

	onButton = var_4_48

	local var_4_51 = arg_4_0
	local var_4_52 = var_4_43

	local function var_4_53()
		local var_7_0 = var_4_45

		if not var_0.isFinish(var_7_0) then
			local var_7_1 = var_4_3
			local var_7_2 = var_0.getActivityById

			ActivityConst = var_2_10002

			local var_7_3 = var_7_2(var_7_1, var_2_10002.MIKASA_DAILY_TASK_ACTIVITY)

			pg = var_7_1

			local var_7_4 = var_7_1.TimeMgr.GetInstance()

			var_2_10002 = var_1.DiffDay(var_7_4, var_7_3.data1, var_1:GetServerTime()) + 1
			math = var_7_4
			var_2_10002 = var_7_4.clamp(var_2_10002, 1, #var_7_3:getConfig("config_data"))
			_ = var_3

			local var_7_5 = var_3.all

			_ = var_4

			if var_7_5(var_4.flatten({
				var_7_3:getConfig("config_data")[var_2_10002]
			}), function(arg_8_0)
				local var_8_0 = var_4_0

				return var_1.getFinishTaskById(var_8_0, arg_8_0) ~= nil
			end) then
				pg = var_3

				local var_7_6 = var_3.TipsMgr.GetInstance()
				local var_7_7 = var_3.ShowTips

				i18n = var_5

				var_7_7(var_7_6, var_5("word_museum_1"))
			else
				local var_7_8 = arg_4_0
				local var_7_9 = var_3.emit

				ActivityMediator = var_5

				local var_7_10 = var_5.EVENT_GO_SCENE

				SCENE = var_6

				var_7_9(var_7_8, var_7_10, var_6.TASK, {
					page = "activity"
				})
			end
		else
			local var_7_11 = arg_4_0
			local var_7_12 = var_0.emit

			ActivityMediator = var_2_10002

			var_7_12(var_7_11, var_2_10002.ON_TASK_SUBMIT, var_4_45)
		end

		return
	end

	SFX_PANEL = var_1_10020

	var_4_48(var_4_51, var_4_52, var_4_53, var_1_10020)

	setButtonEnabled = var_4_48

	var_4_48(var_4_43, not var_4_45:isReceive())

	local var_4_54 = var_8:Find("repair_main")

	arg_4_0:set_mikasa_btn(var_4_44, var_4_54, 0, true, arg_4_1:getConfig("config_client").story)

	for iter_4_2 = 1, 4 do
		setActive = var_20

		var_20(var_8:Find("repair_phase/point" .. iter_4_2), iter_4_2 <= var_4_45:getProgress())

		if 1 < iter_4_2 then
			setActive = var_20

			var_20(var_8:Find("repair_phase/line" .. iter_4_2 - 1), iter_4_2 <= var_4_45:getProgress())
		end
	end

	setText = var_16

	var_16(var_8:Find("repair_phase/Text"), var_4_45:getProgress() .. "/4")

	return
end

function var_0_1.set_mikasa_btn(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	getProxy = var_1_10006
	TaskProxy = var_1_10007

	local var_9_0 = var_1_10006(var_1_10007)
	local var_9_1

	if not var_6.getTaskById(var_9_0, arg_9_1) then
		var_9_1 = var_6:getFinishTaskById(arg_9_1)
	end

	local var_9_2 = arg_9_2:Find("award")
	local var_9_3 = arg_9_2
	local var_9_4 = arg_9_2.Find(var_9_3, "face")

	if arg_9_4 then
		setActive = var_9_3

		var_9_3(var_9_2, true)

		setActive = var_9_3

		var_9_3(var_9_4, false)

		pg = var_9_3

		local var_9_5 = var_9_3.task_data_template[arg_9_1].award_display[1]
		local var_9_6 = {
			type = var_9_5[1],
			id = var_9_5[2],
			count = var_9_5[3]
		}

		setActive = var_13

		var_13(var_9_2, var_9_5)

		updateDrop = var_13

		var_13(var_9_2, var_9_6)

		onButton = var_13

		local var_9_7 = arg_9_0
		local var_9_8 = var_9_2

		local function var_9_9()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_DROP, var_9_6)

			return
		end

		SFX_PANEL = var_1_10017

		var_13(var_9_7, var_9_8, var_9_9, var_1_10017)

		setActive = var_13

		var_13(var_9_2:Find("mask"), var_9_1:isReceive())

		setActive = var_13

		var_13(var_9_2:Find("black_block"), var_9_1:isReceive())

		setActive = var_13

		var_13(arg_9_2:Find("Text"), false)
	else
		setActive = var_9_3

		var_9_3(var_9_2, false)

		setActive = var_9_3

		var_9_3(var_9_4, true)

		setActive = var_9_3

		var_9_3(var_9_4:Find("bg_select"), arg_9_3 == 0 or var_6:getFinishTaskById(arg_9_3))

		setActive = var_9_3

		var_9_3(var_9_4:Find("mask"), var_6:getFinishTaskById(arg_9_1))

		setActive = var_9_3

		var_9_3(var_9_4:Find("black_block"), var_6:getFinishTaskById(arg_9_1))
	end

	if var_9_1:getConfig("sub_type") == 90 and arg_9_5 then
		ipairs = var_10

		for iter_9_0, iter_9_1 in var_10(arg_9_5) do
			if iter_9_1[1] == arg_9_1 and iter_9_1[2] == var_9_1:getProgress() then
				pg = var_15

				local var_9_10 = var_15.NewStoryMgr.GetInstance()

				if not var_15.IsPlayed(var_9_10, iter_9_1[3]) then
					pg = var_15

					local var_9_11 = var_15.NewStoryMgr.GetInstance()

					var_15.Play(var_9_11, iter_9_1[3])

					break
				end
			end
		end
	end

	return
end

return var_0_1
