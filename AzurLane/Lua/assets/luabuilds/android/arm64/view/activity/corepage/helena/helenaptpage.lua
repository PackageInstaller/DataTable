class = var_0_10000

local var_0_0 = "HelenaPTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.task_bg = var_1.Find(var_1_1, "task_bg")

	local var_1_2 = arg_1_0.task_bg

	arg_1_0.slider = var_1.Find(var_1_2, "slider")

	local var_1_3 = arg_1_0.task_bg

	arg_1_0.step = var_1.Find(var_1_3, "step")

	local var_1_4 = arg_1_0.task_bg

	arg_1_0.progres = var_1.Find(var_1_4, "progres")

	local var_1_5 = arg_1_0.task_bg

	arg_1_0.displayBtn = var_1.Find(var_1_5, "display_btn")

	local var_1_6 = arg_1_0.task_bg

	arg_1_0.awardTF = var_1.Find(var_1_6, "award")

	local var_1_7 = arg_1_0.task_bg

	arg_1_0.battleBtn = var_1.Find(var_1_7, "battle_btn")

	local var_1_8 = arg_1_0.task_bg

	arg_1_0.getBtn = var_1.Find(var_1_8, "get_btn")

	local var_1_9 = arg_1_0.task_bg

	arg_1_0.gotBtn = var_1.Find(var_1_9, "got_btn")

	local var_1_10 = arg_1_0.bg

	arg_1_0.skinBtn = var_1.Find(var_1_10, "skinbtn")
	HelenaScenarioPage = var_1
	arg_1_0.scenario = var_1.New(arg_1_0._tf, arg_1_0.event)

	local var_1_11 = arg_1_0.scenario

	var_1.SetCoreStoryPage(var_1_11, arg_1_0)

	local var_1_12 = arg_1_0.scenario

	var_1.RegisterView(var_1_12, arg_1_0.coreActivityUI)

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil
	setText = var_1

	local var_1_13 = arg_1_0.task_bg
	local var_1_14 = var_3.Find(var_1_13, "Text")

	i18n = var_4

	var_1(var_1_14, var_4("Outpost_20250904_Progress"))

	setText = var_1

	local var_1_15 = arg_1_0.task_bg
	local var_1_16 = var_3.Find(var_1_15, "display_btn/Text")

	i18n = var_4

	var_1(var_1_16, var_4("other_world_temple_award"))

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

	return
end

function var_0_1.OnShowFlush(arg_3_0)
	var_0_1.super.OnShowFlush(arg_3_0)

	if arg_3_0.contextData.activeScenario then
		triggerButton = var_1

		var_1(arg_3_0.skinBtn)
	end

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.displayBtn

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10004

		local var_5_3 = {
			blur = true,
			type = arg_4_0.ptData.type,
			dropList = arg_4_0.ptData.dropList,
			targets = arg_4_0.ptData.targets,
			level = arg_4_0.ptData.level,
			count = arg_4_0.ptData.count,
			resId = arg_4_0.ptData.resId
		}
		local var_5_4 = arg_4_0.ptData

		var_5_3.unlockStamps = var_6.GetDayUnlockStamps(var_5_4)

		var_5_1(var_5_0, var_5_2, var_2_10004, var_5_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.battleBtn

	local function var_4_5()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.getBtn

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.GetAllAward(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10006)
	arg_4_0:OnAddUI()
	arg_4_0:OnUpdateFlush()

	return
end

function var_0_1.OnAddUI(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.skinBtn

	local function var_8_2()
		local var_9_0 = arg_8_0.scenario

		var_0.Load(var_9_0)

		local var_9_1 = arg_8_0.scenario

		var_0.SetActivity(var_9_1, arg_8_0.activity)

		local var_9_2 = arg_8_0.scenario

		var_0.UpdateStoryTask(var_9_2)

		local var_9_3 = arg_8_0.scenario

		var_0.ActionInvoke(var_9_3, "UpdateView")

		local var_9_4 = arg_8_0

		var_0.ShowScenarioLayer(var_9_4, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	setActive = var_1_10001

	local var_8_3 = arg_8_0.skinBtn
	local var_8_4 = var_3.Find(var_8_3, "red")
	local var_8_5 = arg_8_0.scenario

	var_1_10001(var_8_4, var_4.IsShowRed(var_8_5, arg_8_0.activity))

	return
end

function var_0_1.SwitchBG(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or #arg_10_1 <= 0 then
		existCall = var_1_10004

		var_1_10004(arg_10_2)

		return
	elseif arg_10_3 then
		-- block empty
	else
		table = var_1_10004

		if var_1_10004.equal(arg_10_0.currentBG, arg_10_1) then
			return
		end
	end

	arg_10_0.currentBG = arg_10_1
	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_0.mapGroup) do
		local var_10_0 = arg_10_0.loader

		var_9.ClearRequest(var_10_0, iter_10_1)
	end

	table = var_4

	var_4.clear(arg_10_0.mapGroup)

	local var_10_1 = arg_10_0.loader
	local var_10_2 = var_4.GetSpriteDirect(var_10_1, "bg/" .. arg_10_1[1].BG, "", function(arg_11_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_10_0.bg, arg_11_0)

		SetActive = var_2_10001

		var_2_10001(arg_10_0.bg, true)

		return
	end)

	table = var_5

	var_5.insert(arg_10_0.mapGroup, var_10_2)

	return
end

function var_0_1.ShowScenarioLayer(arg_12_0, arg_12_1)
	if arg_12_1 then
		local var_12_0 = arg_12_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_12_0, true)

		local var_12_1 = arg_12_0.scenario

		var_2.ActionInvoke(var_12_1, "Show")
	else
		local var_12_2 = arg_12_0.scenario

		var_2.Hide(var_12_2)

		setActive = var_2

		local var_12_3 = arg_12_0.skinBtn
		local var_12_4 = var_4.Find(var_12_3, "red")
		local var_12_5 = arg_12_0.scenario

		var_2(var_12_4, var_5.IsShowRed(var_12_5, arg_12_0.activity))

		local var_12_6 = arg_12_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_12_6, false)
	end

	return
end

function var_0_1.IsShowingPopWindow(arg_13_0)
	local var_13_0 = arg_13_0.scenario

	return var_1.isShowing(var_13_0)
end

function var_0_1.ClosePopWindow(arg_14_0)
	local var_14_0 = arg_14_0.scenario

	var_1.Hide(var_14_0)
	arg_14_0:ShowScenarioLayer(false)

	return
end

function var_0_1.GetAllAward(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0.ptData
	local var_15_2 = var_2.GetAward(var_15_1)

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_15_3 = var_1_10003(var_1_10005)
	local var_15_4 = var_3.getRawData(var_15_3)

	pg = var_1_10005

	local var_15_5 = var_1_10005.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_15_3

	if var_15_3 then
		var_15_3 = 0
	else
		getProxy = var_15_3
		BagProxy = var_1_10008

		local var_15_6 = var_15_3(var_1_10008)

		var_15_3 = var_15_3.GetLimitCntById(var_15_6, var_15_5)
	end

	Task = var_1_10007

	local var_15_7, var_15_8 = var_1_10007.StaticJudgeOverflow(var_15_4.gold, var_15_4.oil, var_15_3, true, true, {
		{
			var_15_2.type,
			var_15_2.id,
			var_15_2.count
		}
	})

	if var_15_7 then
		table = var_9

		var_9.insert(var_15_0, function(arg_16_0)
			pg = var_2_10001

			local var_16_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_16_1 = var_1.ShowMsgBox
			local var_16_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_16_2.type = var_2_10005
			i18n = var_2_10005
			var_16_2.content = var_2_10005("award_max_warning")
			var_16_2.items = var_15_8
			var_16_2.onYes = arg_16_0

			var_16_1(var_16_0, var_16_2)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_15_0, function()
		local var_17_0 = arg_15_0.ptData
		local var_17_1, var_17_2 = var_0.GetResProgress(var_17_0)
		local var_17_3 = arg_15_0
		local var_17_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_17_5 = var_2_10005.EVENT_PT_OPERATION
		local var_17_6 = {
			cmd = 1
		}
		local var_17_7 = arg_15_0.ptData

		var_17_6.activity_id = var_7.GetId(var_17_7)
		var_17_6.arg1 = var_17_2

		var_17_4(var_17_3, var_17_5, var_17_6)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_18_0)
	local var_18_0 = arg_18_0.ptData
	local var_18_1, var_18_2, var_18_3 = var_1.GetLevelProgress(var_18_0)

	if arg_18_0.step then
		setText = var_4

		var_4(arg_18_0.step, var_18_1 .. "/" .. var_18_2)
	end

	local var_18_4 = arg_18_0.activity
	local var_18_5 = var_4.getConfig(var_18_4, "config_client").story

	checkExist = var_1_10005

	if var_1_10005(var_18_5, {
		var_18_1
	}, {
		1
	}) then
		pg = var_5

		local var_18_6 = var_5.NewStoryMgr.GetInstance()

		var_5.Play(var_18_6, var_18_5[var_18_1][1])
	end

	local var_18_7 = arg_18_0.ptData
	local var_18_8, var_18_9, var_18_10 = var_5.GetResProgress(var_18_7)

	if var_18_9 < var_18_8 then
		var_18_8 = var_18_9
	end

	setText = var_8

	local var_18_11 = arg_18_0.progres

	setColorStr = var_1_10011

	local var_18_12 = var_1_10011(var_18_8, "#3f93d4")

	setColorStr = var_1_10012

	var_8(var_18_11, var_18_12 .. var_1_10012("/" .. var_18_9, "#747c88"))

	setSlider = var_8

	var_8(arg_18_0.slider, 0, 1, var_18_10)

	local var_18_13 = arg_18_0.ptData
	local var_18_14 = var_8.CanGetAward(var_18_13)
	local var_18_15 = arg_18_0.ptData
	local var_18_16 = var_9.CanGetNextAward(var_18_15)
	local var_18_17 = arg_18_0.ptData
	local var_18_18 = var_10.CanGetMorePt(var_18_17)

	setActive = var_18_15

	var_18_15(arg_18_0.battleBtn, var_18_18 and not var_18_14 and var_18_16)

	setActive = var_18_15

	var_18_15(arg_18_0.getBtn, var_18_14)

	setActive = var_18_15

	var_18_15(arg_18_0.gotBtn, not var_18_16)

	local var_18_19 = arg_18_0.ptData
	local var_18_20 = var_11.GetAward(var_18_19)

	updateDrop = var_18_17

	var_18_17(arg_18_0.awardTF, var_18_20)

	onButton = var_18_17

	local var_18_21 = arg_18_0
	local var_18_22 = arg_18_0.awardTF

	local function var_18_23()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.emit

		BaseUI = var_2_10003

		var_19_1(var_19_0, var_2_10003.ON_DROP, var_18_20)

		return
	end

	SFX_PANEL = var_1_10017

	var_18_17(var_18_21, var_18_22, var_18_23, var_1_10017)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	local var_20_0 = arg_20_0.scenario

	if var_1.isShowing(var_20_0) then
		local var_20_1 = arg_20_0.scenario

		var_1.Hide(var_20_1)
	end

	local var_20_2 = arg_20_0.scenario

	var_1.Destroy(var_20_2)

	return
end

function var_0_1.GetWorldPtData(arg_21_0, arg_21_1)
	pg = var_1_10002

	local var_21_0 = var_1_10002.TimeMgr.GetInstance()
	local var_21_1 = var_2.GetServerTime(var_21_0)

	ActivityMainScene = var_1_10003

	local var_21_2

	if not var_1_10003.Data2Time then
		var_21_2 = 0
	end

	if arg_21_1 <= var_21_1 - var_21_2 then
		ActivityMainScene = var_2
		pg = var_21_2

		local var_21_3 = var_21_2.TimeMgr.GetInstance()

		var_2.Data2Time = var_3.GetServerTime(var_21_3)

		local var_21_4 = arg_21_0
		local var_21_5 = arg_21_0.emit

		ActivityMediator = var_21_3

		local var_21_6 = var_21_3.EVENT_PT_OPERATION
		local var_21_7 = {
			cmd = 2
		}
		local var_21_8 = arg_21_0.ptData

		var_21_7.activity_id = var_7.GetId(var_21_8)

		var_21_5(var_21_4, var_21_6, var_21_7)
	end

	return
end

return var_0_1
