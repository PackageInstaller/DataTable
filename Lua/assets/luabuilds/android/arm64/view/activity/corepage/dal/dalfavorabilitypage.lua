local var_0_0 = class("DALFavorabilityPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.progres = arg_1_0.bg:Find("progres")
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.displayBtn = arg_1_0.bg:Find("display_btn")
	arg_1_0.vx_get = arg_1_0.bg:Find("vx_get")

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
	SetActive(arg_3_0.vx_get, false)
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
	SetActive(arg_7_0.vx_get, true)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	updateDrop(arg_10_0.awardTF:Find("IconTpl"), (arg_10_0.ptData:GetAward()))

	local var_10_0, var_10_1, var_10_2 = arg_10_0.ptData:GetResProgress()

	setText(arg_10_0.progres, setColorStr(var_10_0, "#ffffff") .. setColorStr("/" .. var_10_1, "#DD9D9D"))

	local var_10_3 = arg_10_0.ptData:CanGetAward()
	local var_10_4 = arg_10_0.ptData:CanGetNextAward()

	setActive(arg_10_0.battleBtn, arg_10_0.ptData:CanGetMorePt() and not var_10_3 and var_10_4)
	setActive(arg_10_0.getBtn, var_10_3)
	setActive(arg_10_0.gotBtn, not var_10_4)

	for iter_10_0 = 1, 10 do
		if iter_10_0 <= arg_10_0.ptData:GetLevel() then
			SetActive(arg_10_0.bg:Find("schedule/" .. iter_10_0 .. "/on"), true)
			SetActive(arg_10_0.bg:Find("schedule/" .. iter_10_0 .. "/not"), false)
		else
			SetActive(arg_10_0.bg:Find("schedule/" .. iter_10_0 .. "/on"), false)
			SetActive(arg_10_0.bg:Find("schedule/" .. iter_10_0 .. "/not"), true)
		end
	end

	return
end

function var_0_0.GetWorldPtData(arg_11_0, arg_11_1)
	local var_11_0 = ActivityMainScene.Data2Time or 0

	if arg_11_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_11_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_11_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_11_0.ptData:GetId()
		})
	end

	return
end

return var_0_0
