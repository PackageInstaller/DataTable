local var_0_0 = class("MonopolyCar2024Page", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.startBtn = arg_1_0._tf:Find("AD/start")
	arg_1_0.leftCountTxt = arg_1_0.startBtn:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.turnCntTxt = arg_1_0._tf:Find("AD/turn"):GetComponent(typeof(Text))
	arg_1_0.progressTxt = arg_1_0._tf:Find("AD/progress"):GetComponent(typeof(Text))
	arg_1_0.turnAwards = {
		arg_1_0._tf:Find("AD/turn_awards/award_1"),
		arg_1_0._tf:Find("AD/turn_awards/award_2"),
		arg_1_0._tf:Find("AD/turn_awards/award_3")
	}
	arg_1_0.turnGoBtn = arg_1_0._tf:Find("AD/turn_awards/battle_btn")
	arg_1_0.turnGetBtn = arg_1_0._tf:Find("AD/turn_awards/get_btn")
	arg_1_0.progressImage = arg_1_0._tf:Find("AD/turn_awards/progress/bar")

	onButton(arg_1_0, arg_1_0.startBtn, function()
		if not arg_1_0.activity or arg_1_0.activity:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		for iter_2_0, iter_2_1 in ipairs(arg_1_0.turnAwards) do
			setActive(iter_2_1:Find("mark/get"), false)
		end

		arg_1_0:emit(ActivityMediator.GO_MONOPOLY2024, arg_1_0.activity.id, function()
			for iter_3_0, iter_3_1 in ipairs(arg_1_0.turnAwards) do
				setActive(iter_3_1:Find("mark/get"), true)
			end

			return
		end)

		return
	end, SFX_PANEL)

	arg_1_0.taskGoBtn = arg_1_0._tf:Find("AD/battle_btn")
	arg_1_0.taskGetBtn = arg_1_0._tf:Find("AD/get_btn")
	arg_1_0.taskGotBtn = arg_1_0._tf:Find("AD/got_btn")
	arg_1_0.taskDesc = arg_1_0._tf:Find("AD/Text"):GetComponent(typeof(Text))
	arg_1_0.taskAward = arg_1_0._tf:Find("AD/award")
	arg_1_0.taskProgress = arg_1_0._tf:Find("AD/taskProgress")

	return
end

function var_0_0.OnDataSetting(arg_4_0)
	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0:UpdateTurnAwards()
	arg_6_0:UpdateTask()

	return
end

function var_0_0.UpdateTurnAwards(arg_7_0)
	local var_7_0 = arg_7_0.activity
	local var_7_1 = arg_7_0.activity.data1_list[3] or 1
	local var_7_2 = var_7_1 - 1
	local var_7_3 = arg_7_0.activity.data1_list[6] or 0

	arg_7_0.turnCntTxt.text = var_7_2 .. "/" .. 3

	local var_7_4 = arg_7_0.activity:getDataConfig("map") or {}
	local var_7_5 = (math.max(arg_7_0.activity.data2, 1) - 1) / #var_7_4

	if var_7_5 == 0 and var_7_2 > 0 then
		var_7_5 = 1
	end

	arg_7_0.progressTxt.text = string.format("%.1f", var_7_5 * 100) .. "%"

	local var_7_6 = var_7_3 + 1
	local var_7_7 = arg_7_0.activity:getDataConfig("sum_lap_reward_show")

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.turnAwards) do
		updateDrop(iter_7_1:Find("mask"), (Drop.New({
			type = var_7_7[iter_7_0][1],
			id = var_7_7[iter_7_0][2],
			count = var_7_7[iter_7_0][3]
		})))
		onButton(arg_7_0, iter_7_1, function()
			arg_7_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setActive(iter_7_1:Find("mark"), iter_7_0 == var_7_6)
		setActive(iter_7_1:Find("got"), iter_7_0 <= var_7_3)
	end

	local var_7_8 = 3 < var_7_6
	local var_7_9 = var_7_6 <= var_7_2

	setActive(arg_7_0.turnGoBtn, not (var_7_6 <= var_7_2) and not var_7_8)
	setActive(arg_7_0.turnGetBtn, var_7_9 and not var_7_8)

	if var_7_2 <= 0 then
		setFillAmount(arg_7_0.progressImage, 0)
	else
		local var_7_11 = ({
			0.183,
			0.587,
			1
		})[var_7_2]

		if not ({
			0.183,
			0.587,
			1
		})[var_7_2] then
			var_7_11 = 1
		end

		var_7_10(arg_7_0.progressImage, var_7_11)
	end

	local var_7_12 = pg.TimeMgr.GetInstance()
	local var_7_13 = arg_7_0.activity.data1_list[1] or 0
	local var_7_14 = math.ceil((var_7_12:GetServerTime() - arg_7_0.activity.data1) / 0) * arg_7_0.activity:getDataConfig("daily_time") + var_7_13
	local var_7_15 = arg_7_0.activity.data1_list[2] or 0

	arg_7_0.leftCountTxt.text = i18n("MonopolyCar2024Game_total_num_tip", var_7_14 - var_7_15)

	onButton(arg_7_0, arg_7_0.turnGetBtn, function()
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = var_7_0.id,
			arg1 = var_7_6,
			cmd = ActivityConst.MONOPOLY_OP_ROUND_AWD
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTask(arg_10_0)
	local var_10_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.MONOPOLY_TASK_ACT_ID.act_id)

	if not var_10_0 or var_10_0:isEnd() then
		return
	end

	local var_10_1 = var_10_0:getConfig("config_data")[1]
	local var_10_2 = getProxy(TaskProxy)
	local var_10_3 = var_10_2:getTaskById(var_10_1) or var_10_2:getFinishTaskById(var_10_1) or Task.New({
		id = var_10_1
	})
	local var_10_4 = var_10_2:getTaskById(var_10_1)
	local var_10_5 = var_10_3:getConfig("award_display")[1]

	updateDrop(arg_10_0.taskAward:Find("mask"), (Drop.New({
		type = var_10_5[1],
		id = var_10_5[2],
		count = var_10_5[3]
	})))
	onButton(arg_10_0, arg_10_0.taskAward, function()
		arg_10_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_10_6 = var_10_3:getConfig("target_num")

	if var_10_4 ~= nil then
		local var_10_7 = math.min(var_10_3:getProgress(), var_10_6)

		setSlider(arg_10_0.taskProgress, 0, var_10_6, var_10_7)

		local var_10_8 = var_10_3:getConfig("desc")

		for iter_10_0, iter_10_1 in ipairs({
			var_10_7
		}) do
			var_10_8 = string.gsub(var_10_8, "$" .. iter_10_0, iter_10_1)
		end

		arg_10_0.taskDesc.text = var_10_8

		local var_10_9 = var_10_3:isFinish()
		local var_10_10 = var_10_3:isReceive()

		setActive(arg_10_0.taskGoBtn, not var_10_9 and not var_10_10)
		setActive(arg_10_0.taskGetBtn, var_10_9 and not var_10_10)
		setActive(arg_10_0.taskGotBtn, var_10_10)
	else
		local var_10_11 = var_10_6

		setSlider(arg_10_0.taskProgress, 0, var_10_6, var_10_6)

		local var_10_12 = var_10_3:getConfig("desc")

		for iter_10_2, iter_10_3 in ipairs({
			var_10_11
		}) do
			var_10_12 = string.gsub(var_10_12, "$" .. iter_10_2, iter_10_3)
		end

		arg_10_0.taskDesc.text = var_10_12

		setActive(arg_10_0.taskGoBtn, false)
		setActive(arg_10_0.taskGetBtn, false)
		setActive(arg_10_0.taskGotBtn, true)
	end

	onButton(arg_10_0, arg_10_0.taskGetBtn, function()
		arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_10_3, function(arg_13_0)
			if arg_13_0 then
				arg_10_0:OnUpdateFlush()
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnHideFlush(arg_14_0)
	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0
