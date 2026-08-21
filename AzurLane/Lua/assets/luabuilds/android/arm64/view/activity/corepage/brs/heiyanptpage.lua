local var_0_0 = class("HeiYanPtPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.task_bg = arg_1_0.bg:Find("task_bg")
	arg_1_0.slider = arg_1_0.task_bg:Find("slider")
	arg_1_0.step = arg_1_0.task_bg:Find("step")
	arg_1_0.progress = arg_1_0.task_bg:Find("progress")
	arg_1_0.progres = arg_1_0.task_bg:Find("progres")
	arg_1_0.displayBtn = arg_1_0.task_bg:Find("display_btn")
	arg_1_0.awardTF = arg_1_0.task_bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.task_bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.task_bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.task_bg:Find("got_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		arg_2_0.ptData:Update(arg_2_0.activity)
	else
		arg_2_0.ptData = ActivityPtData.New(arg_2_0.activity)
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.displayBtn, function()
		arg_3_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			blur = true,
			type = arg_3_0.ptData.type,
			dropList = arg_3_0.ptData.dropList,
			targets = arg_3_0.ptData.targets,
			level = arg_3_0.ptData.level,
			count = arg_3_0.ptData.count,
			resId = arg_3_0.ptData.resId,
			unlockStamps = arg_3_0.ptData:GetDayUnlockStamps()
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:GetAllAward()

		return
	end, SFX_PANEL)
	arg_3_0:OnUpdateFlush()

	return
end

function var_0_0.GetAllAward(arg_7_0)
	local var_7_0 = arg_7_0.ptData:GetAward()
	local var_7_1 = getProxy(PlayerProxy):getRawData()
	local var_7_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_1.gold, var_7_1.oil, var_7_2, true, true, {
		{
			var_7_0.type,
			var_7_0.id,
			var_7_0.count
		}
	})

	if var_7_3 then
		table.insert({}, function(arg_8_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_7_4,
				onYes = arg_8_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		local var_9_0, var_9_1 = arg_7_0.ptData:GetResProgress()

		arg_7_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_7_0.ptData:GetId(),
			arg1 = var_9_1
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = arg_10_0.ptData:GetLevelProgress()

	if arg_10_0.step then
		setText(arg_10_0.step, var_10_0 .. "/" .. var_10_1)
	end

	local var_10_3 = arg_10_0.activity:getConfig("config_client").story

	if checkExist(var_10_3, {
		var_10_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_10_3[var_10_0][1])
	end

	local var_10_4, var_10_5, var_10_6 = arg_10_0.ptData:GetResProgress()

	setText(arg_10_0.progress, "/" .. var_10_5)

	local var_10_7 = var_10_6 >= 1 and setColorStr(var_10_4, "#6ef0ff") or var_10_4

	setText(arg_10_0.progres, var_10_7)
	setSlider(arg_10_0.slider, 0, 1, var_10_6)

	local var_10_8 = arg_10_0.ptData:CanGetAward()
	local var_10_9 = arg_10_0.ptData:CanGetNextAward()

	setActive(arg_10_0.battleBtn, arg_10_0.ptData:CanGetMorePt() and not var_10_8 and var_10_9)
	setActive(arg_10_0.getBtn, var_10_8)
	setActive(arg_10_0.gotBtn, not var_10_9)
	updateDrop(arg_10_0.awardTF, (arg_10_0.ptData:GetAward()))
	onButton(arg_10_0, arg_10_0.awardTF, function()
		arg_10_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

function var_0_0.GetWorldPtData(arg_13_0, arg_13_1)
	local var_13_0 = ActivityMainScene.Data2Time or 0

	if arg_13_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_13_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_13_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_13_0.ptData:GetId()
		})
	end

	return
end

return var_0_0
