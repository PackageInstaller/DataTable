local var_0_0 = class("HelenaPTPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.task_bg = arg_1_0.bg:Find("task_bg")
	arg_1_0.slider = arg_1_0.task_bg:Find("slider")
	arg_1_0.step = arg_1_0.task_bg:Find("step")
	arg_1_0.progres = arg_1_0.task_bg:Find("progres")
	arg_1_0.displayBtn = arg_1_0.task_bg:Find("display_btn")
	arg_1_0.awardTF = arg_1_0.task_bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.task_bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.task_bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.task_bg:Find("got_btn")
	arg_1_0.skinBtn = arg_1_0.bg:Find("skinbtn")
	arg_1_0.scenario = HelenaScenarioPage.New(arg_1_0._tf, arg_1_0.event)

	arg_1_0.scenario:SetCoreStoryPage(arg_1_0)
	arg_1_0.scenario:RegisterView(arg_1_0.coreActivityUI)

	arg_1_0.loader = AutoLoader.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil

	setText(arg_1_0.task_bg:Find("Text"), i18n("Outpost_20250904_Progress"))
	setText(arg_1_0.task_bg:Find("display_btn/Text"), i18n("other_world_temple_award"))

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

function var_0_0.OnShowFlush(arg_3_0)
	var_0_0.super.OnShowFlush(arg_3_0)

	if arg_3_0.contextData.activeScenario then
		triggerButton(arg_3_0.skinBtn)
	end

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	onButton(arg_4_0, arg_4_0.displayBtn, function()
		arg_4_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			blur = true,
			type = arg_4_0.ptData.type,
			dropList = arg_4_0.ptData.dropList,
			targets = arg_4_0.ptData.targets,
			level = arg_4_0.ptData.level,
			count = arg_4_0.ptData.count,
			resId = arg_4_0.ptData.resId,
			unlockStamps = arg_4_0.ptData:GetDayUnlockStamps()
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.battleBtn, function()
		arg_4_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		arg_4_0:GetAllAward()

		return
	end, SFX_PANEL)
	arg_4_0:OnAddUI()
	arg_4_0:OnUpdateFlush()

	return
end

function var_0_0.OnAddUI(arg_8_0)
	onButton(arg_8_0, arg_8_0.skinBtn, function()
		arg_8_0.scenario:Load()
		arg_8_0.scenario:SetActivity(arg_8_0.activity)
		arg_8_0.scenario:UpdateStoryTask()
		arg_8_0.scenario:ActionInvoke("UpdateView")
		arg_8_0:ShowScenarioLayer(true)

		return
	end, SFX_PANEL)
	setActive(arg_8_0.skinBtn:Find("red"), arg_8_0.scenario:IsShowRed(arg_8_0.activity))

	return
end

function var_0_0.SwitchBG(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or #arg_10_1 <= 0 then
		existCall(arg_10_2)

		return
	elseif arg_10_3 then
		-- block empty
	elseif table.equal(arg_10_0.currentBG, arg_10_1) then
		return
	end

	arg_10_0.currentBG = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.mapGroup) do
		arg_10_0.loader:ClearRequest(iter_10_1)
	end

	table.clear(arg_10_0.mapGroup)
	table.insert(arg_10_0.mapGroup, (arg_10_0.loader:GetSpriteDirect("bg/" .. arg_10_1[1].BG, "", function(arg_11_0)
		setImageSprite(arg_10_0.bg, arg_11_0)
		SetActive(arg_10_0.bg, true)

		return
	end)))

	return
end

function var_0_0.ShowScenarioLayer(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.coreActivityUI:ActiveScenarioLayer(true)
		arg_12_0.scenario:ActionInvoke("Show")
	else
		arg_12_0.scenario:Hide()
		setActive(arg_12_0.skinBtn:Find("red"), arg_12_0.scenario:IsShowRed(arg_12_0.activity))
		arg_12_0.coreActivityUI:ActiveScenarioLayer(false)
	end

	return
end

function var_0_0.IsShowingPopWindow(arg_13_0)
	return arg_13_0.scenario:isShowing()
end

function var_0_0.ClosePopWindow(arg_14_0)
	arg_14_0.scenario:Hide()
	arg_14_0:ShowScenarioLayer(false)

	return
end

function var_0_0.GetAllAward(arg_15_0)
	local var_15_0 = arg_15_0.ptData:GetAward()
	local var_15_1 = getProxy(PlayerProxy):getRawData()
	local var_15_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_15_3, var_15_4 = Task.StaticJudgeOverflow(var_15_1.gold, var_15_1.oil, var_15_2, true, true, {
		{
			var_15_0.type,
			var_15_0.id,
			var_15_0.count
		}
	})

	if var_15_3 then
		table.insert({}, function(arg_16_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_15_4,
				onYes = arg_16_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		local var_17_0, var_17_1 = arg_15_0.ptData:GetResProgress()

		arg_15_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_15_0.ptData:GetId(),
			arg1 = var_17_1
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = arg_18_0.ptData:GetLevelProgress()

	if arg_18_0.step then
		setText(arg_18_0.step, var_18_0 .. "/" .. var_18_1)
	end

	local var_18_3 = arg_18_0.activity:getConfig("config_client").story

	if checkExist(var_18_3, {
		var_18_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_18_3[var_18_0][1])
	end

	local var_18_4, var_18_5, var_18_6 = arg_18_0.ptData:GetResProgress()

	if var_18_5 < var_18_4 then
		var_18_4 = var_18_5
	end

	setText(arg_18_0.progres, setColorStr(var_18_4, "#3f93d4") .. setColorStr("/" .. var_18_5, "#747c88"))
	setSlider(arg_18_0.slider, 0, 1, var_18_6)

	local var_18_7 = arg_18_0.ptData:CanGetAward()
	local var_18_8 = arg_18_0.ptData:CanGetNextAward()

	setActive(arg_18_0.battleBtn, arg_18_0.ptData:CanGetMorePt() and not var_18_7 and var_18_8)
	setActive(arg_18_0.getBtn, var_18_7)
	setActive(arg_18_0.gotBtn, not var_18_8)
	updateDrop(arg_18_0.awardTF, (arg_18_0.ptData:GetAward()))
	onButton(arg_18_0, arg_18_0.awardTF, function()
		arg_18_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_20_0)
	if arg_20_0.scenario:isShowing() then
		arg_20_0.scenario:Hide()
	end

	arg_20_0.scenario:Destroy()

	return
end

function var_0_0.GetWorldPtData(arg_21_0, arg_21_1)
	local var_21_0 = ActivityMainScene.Data2Time or 0

	if arg_21_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_21_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_21_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_21_0.ptData:GetId()
		})
	end

	return
end

return var_0_0
