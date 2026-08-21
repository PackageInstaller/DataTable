local var_0_0 = class("RapidSeasideMonopolyPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.startBtn = arg_1_0._tf:Find("AD/start")
	arg_1_0.leftCountTxt = arg_1_0.startBtn:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.turnTxt = arg_1_0._tf:Find("AD/loop_cnt/turn"):GetComponent(typeof(Text))
	arg_1_0.turnCntTxt = arg_1_0._tf:Find("AD/loop_cnt/turn_cnt"):GetComponent(typeof(Text))
	arg_1_0.progressTxt = arg_1_0._tf:Find("AD/loop_cnt/progress"):GetComponent(typeof(Text))
	arg_1_0.progressCntTxt = arg_1_0._tf:Find("AD/loop_cnt/progress_cnt"):GetComponent(typeof(Text))
	arg_1_0.turnAwards = {
		arg_1_0._tf:Find("AD/turn_awards/award_1"),
		arg_1_0._tf:Find("AD/turn_awards/award_2"),
		arg_1_0._tf:Find("AD/turn_awards/award_3")
	}
	arg_1_0.turnGetBtn = arg_1_0._tf:Find("AD/turn_awards/get_btn")
	arg_1_0.turnGotBtn = arg_1_0._tf:Find("AD/turn_awards/got_btn")
	arg_1_0.progressImage = arg_1_0._tf:Find("AD/turn_awards/progress/bar")
	arg_1_0.title = arg_1_0._tf:Find("AD/RapidSeasideTitle Variant/Main/title")
	arg_1_0._paintingParticles = arg_1_0._tf:Find("AD/RapidSeasideTitle Variant/Main/title/title_2/Particle System")
	arg_1_0._paintingParticleSystem = arg_1_0._paintingParticles:GetComponent(typeof(ParticleSystem))
	arg_1_0.btnManual = arg_1_0._tf:Find("TopPage/top/manual")
	arg_1_0.Txtmanual = arg_1_0.btnManual:Find("Text")
	arg_1_0.redMalPoint = arg_1_0.btnManual:Find("tip")

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.turnAwards) do
		setActive(iter_1_1:Find("can_get_mask"), false)
	end

	onButton(arg_1_0, arg_1_0.startBtn, function()
		if not arg_1_0.activity or arg_1_0.activity:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		setActive(arg_1_0.title, false)
		arg_1_0._paintingParticleSystem:Stop(true)
		arg_1_0:emit(ActivityMediator.GO_MONOPOLY2026, arg_1_0.activity.id, function()
			setActive(arg_1_0.title, true)
			arg_1_0._paintingParticleSystem:Play()
			arg_1_0:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)

	arg_1_0.taskGoBtn = arg_1_0._tf:Find("AD/loop_progress/go_btn")
	arg_1_0.taskGetBtn = arg_1_0._tf:Find("AD/loop_progress/get_btn")
	arg_1_0.taskGotBtn = arg_1_0._tf:Find("AD/loop_progress/got_btn")
	arg_1_0.taskDesc = arg_1_0._tf:Find("AD/loop_progress/Text"):GetComponent(typeof(Text))
	arg_1_0.taskAward = arg_1_0._tf:Find("AD/loop_progress/award")
	arg_1_0.taskProgress = arg_1_0._tf:Find("AD/loop_progress/taskProgress")

	return
end

function var_0_0.OnDataSetting(arg_4_0)
	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.turnAwards) do
		setText(iter_5_1:Find("bg_lock/Text"), i18n("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))
		setText(iter_5_1:Find("bg_unlock/Text"), i18n("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))
	end

	onButton(arg_5_0, arg_5_0.btnManual, function()
		arg_5_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = RapidSeasideMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	setText(arg_5_0.Txtmanual, i18n("anniversary_nine_main_page"))
	arg_5_0:UpdateRed()

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0:UpdateTurnAwards()
	arg_7_0:UpdateTask()
	arg_7_0:UpdateRed()

	return
end

function var_0_0.UpdateTurnAwards(arg_8_0)
	local var_8_0 = arg_8_0.activity

	if pg.gameset.MONOPOLY_AWARD_LIST then
		local var_8_1 = pg.gameset.MONOPOLY_AWARD_LIST.description or {
			3,
			6,
			9
		}
		local var_8_2 = var_8_1[3]
		local var_8_3 = arg_8_0.activity.data1_list[3] or 1
		local var_8_4 = var_8_3 - 1
		local var_8_5 = arg_8_0.activity.data1_list[6] or 0

		arg_8_0.turnTxt.text = i18n("RapidSeasideMonopolyPage_turn_cnt_tip")
		arg_8_0.turnCntTxt.text = var_8_4 .. "/" .. var_8_2

		local var_8_6 = arg_8_0.activity:getDataConfig("map") or {}
		local var_8_7 = (math.max(arg_8_0.activity.data2, 1) - 1) / #var_8_6

		if var_8_7 == 0 and var_8_4 > 0 then
			var_8_7 = 1
		end

		arg_8_0.progressTxt.text = i18n("RapidSeasideMonopolyPage_progress_tip")
		arg_8_0.progressCntTxt.text = string.format("%.1f", var_8_7 * 100) .. "%"

		local var_8_8 = arg_8_0.activity:getDataConfig("sum_lap_reward_show")
		local var_8_9 = false
		local var_8_10 = 0

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.turnAwards) do
			local var_8_11 = var_8_1[iter_8_0]
			local var_8_12 = var_8_1[iter_8_0] <= var_8_4 and var_8_5 < var_8_11

			updateDrop(iter_8_1:Find("mask"), (Drop.New({
				type = var_8_8[iter_8_0][1],
				id = var_8_8[iter_8_0][2],
				count = var_8_8[iter_8_0][3]
			})))
			onButton(arg_8_0, iter_8_1, function()
				arg_8_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(iter_8_1:Find("got"), var_8_11 <= var_8_5)
			setActive(iter_8_1:Find("bg_lock"), var_8_11 <= var_8_4)
			setActive(iter_8_1:Find("bg_unlock"), var_8_4 < var_8_11)

			if var_8_10 == 0 and var_8_12 then
				var_8_10 = var_8_11
			end

			setActive(iter_8_1:Find("can_get_mask"), var_8_12)

			var_8_9 = var_8_9 or var_8_12
		end

		setActive(arg_8_0.turnGotBtn, not var_8_9)
		setActive(arg_8_0.turnGetBtn, var_8_9)

		local var_8_13 = arg_8_0.activity.data1_list[1] or 0
		local var_8_14 = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_8_0.activity.data1) / 0) * arg_8_0.activity:getDataConfig("daily_time") + var_8_13
		local var_8_15 = arg_8_0.activity.data1_list[2] or 0

		arg_8_0.leftCountTxt.text = i18n("MonopolyCar2024Game_total_num_tip", var_8_14 - var_8_15)

		onButton(arg_8_0, arg_8_0.turnGetBtn, function()
			pg.m02:sendNotification(GAME.MONOPOLY_OP, {
				activity_id = var_8_0.id,
				arg1 = var_8_10,
				cmd = ActivityConst.MONOPOLY_OP_ROUND_AWD
			})

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.UpdateTask(arg_11_0)
	local var_11_0 = getProxy(TaskProxy)
	local var_11_1 = var_11_0:getTaskById(pg.activity_template[pg.activity_template[arg_11_0.activity.id].config_data[1]].config_data[1]) or var_11_0:getFinishTaskById(pg.activity_template[pg.activity_template[arg_11_0.activity.id].config_data[1]].config_data[1]) or Task.New({
		id = pg.activity_template[pg.activity_template[arg_11_0.activity.id].config_data[1]].config_data[1]
	})
	local var_11_2 = var_11_0:getTaskById(pg.activity_template[pg.activity_template[arg_11_0.activity.id].config_data[1]].config_data[1])
	local var_11_3 = var_11_1:getConfig("award_display")[1]

	updateDrop(arg_11_0.taskAward:Find("mask"), (Drop.New({
		type = var_11_3[1],
		id = var_11_3[2],
		count = var_11_3[3]
	})))
	onButton(arg_11_0, arg_11_0.taskAward, function()
		arg_11_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_11_4 = var_11_1:getConfig("target_num")

	if var_11_2 ~= nil then
		local var_11_5 = math.min(var_11_1:getProgress(), var_11_4)

		setSlider(arg_11_0.taskProgress, 0, var_11_4, var_11_5)

		local var_11_6 = var_11_1:getConfig("desc")

		for iter_11_0, iter_11_1 in ipairs({
			var_11_5
		}) do
			var_11_6 = string.gsub(var_11_6, "$" .. iter_11_0, iter_11_1)
		end

		arg_11_0.taskDesc.text = var_11_6

		local var_11_7 = var_11_1:isFinish()
		local var_11_8 = var_11_1:isReceive()

		setActive(arg_11_0.taskGoBtn, not var_11_7 and not var_11_8)
		setActive(arg_11_0.taskGetBtn, var_11_7 and not var_11_8)
		setActive(arg_11_0.taskGotBtn, var_11_8)
	else
		local var_11_9 = var_11_4

		setSlider(arg_11_0.taskProgress, 0, var_11_4, var_11_4)

		local var_11_10 = var_11_1:getConfig("desc")

		for iter_11_2, iter_11_3 in ipairs({
			var_11_9
		}) do
			var_11_10 = string.gsub(var_11_10, "$" .. iter_11_2, iter_11_3)
		end

		arg_11_0.taskDesc.text = var_11_10

		setActive(arg_11_0.taskGoBtn, false)
		setActive(arg_11_0.taskGetBtn, false)
		setActive(arg_11_0.taskGotBtn, true)
	end

	onButton(arg_11_0, arg_11_0.taskGetBtn, function()
		arg_11_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_1, function(arg_14_0)
			if arg_14_0 then
				arg_11_0:OnUpdateFlush()
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.taskGoBtn, function()
		arg_11_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateRed(arg_16_0)
	if pg.activity_template[arg_16_0.activity.id].config_client.is_showMedal then
		setActive(arg_16_0.redMalPoint, ActivityMedalGroup.showTip(pg.activity_template[arg_16_0.activity.id].config_client.medal_group_id))
	end

	return
end

function var_0_0.OnHideFlush(arg_17_0)
	return
end

function var_0_0.OnDestroy(arg_18_0)
	return
end

return var_0_0
