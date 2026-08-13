class = var_0_10000

local var_0_0 = "BossRushDALCollabStageView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushStageInfoUIDALCollab"
end

function var_0_1.SetUp(arg_2_0, arg_2_1)
	arg_2_0:RegisterEvent()

	return
end

function var_0_1.SetData(arg_3_0, arg_3_1)
	arg_3_0._series = arg_3_1

	local var_3_0 = arg_3_1:GetBossHpRate()

	arg_3_0._barVct2.x = var_3_0 * arg_3_0._barL

	local var_3_1 = arg_3_0._progressBar

	var_3_1.sizeDelta = arg_3_0._barVct2

	local var_3_2 = var_3_0 * 100

	getProxy = var_3_1
	ActivityProxy = var_1_10005

	local var_3_3 = var_3_1(var_1_10005)
	local var_3_4 = var_3.getActivityByType

	ActivityConst = var_1_10006

	local var_3_5 = var_3_4(var_3_3, var_1_10006.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)
	local var_3_6 = arg_3_0._series

	if not var_4.GetDefeated(var_3_6, var_3_5) then
		local var_3_7 = arg_3_0._series

		if var_4.IsPass(var_3_7) then
			setText = var_4

			var_4(arg_3_0._hpRate, "HOLD")

			goto label_3_0
		end
	end

	setText = var_4

	var_4(arg_3_0._hpRate, var_3_2 .. "%")

	::label_3_0::

	setText = var_4

	var_4(arg_3_0._stageName, arg_3_1:GetSeriesName())

	local var_3_8 = arg_3_1
	local var_3_9, var_3_10 = arg_3_1.GetCurrentProfile(var_3_8)

	ipairs = var_3_8

	for iter_3_0, iter_3_1 in var_3_8(arg_3_0._labelList) do
		if not var_3_9[iter_3_0] then
			setActive = var_1_10011

			var_1_10011(iter_3_1, false)
		else
			setActive = var_1_10011

			var_1_10011(iter_3_1, true)

			setText = var_1_10011

			var_1_10011(iter_3_1:Find("desc"), var_3_9[iter_3_0])
		end
	end

	ipairs = var_6

	for iter_3_2, iter_3_3 in var_6(var_3_10) do
		setText = var_1_10011

		local var_3_11 = arg_3_0._labelList[iter_3_2]

		var_1_10011(var_13.Find(var_3_11, "state"), iter_3_3)
	end

	setText = var_6

	local var_3_12 = arg_3_0._goBtnNormal

	var_6(var_8.Find(var_3_12, "text"), arg_3_1:GetName(arg_3_1.DIFF.NORMAL))

	setText = var_6

	local var_3_13 = arg_3_0._goBtnHard
	local var_3_14 = var_8.Find(var_3_13, "text")
	local var_3_15 = arg_3_1

	var_6(var_3_14, arg_3_1.GetName(var_3_15, arg_3_1.DIFF.HARD))

	local var_3_16 = arg_3_0._series
	local var_3_20

	if var_6.GetBossTimeStamp(var_3_16) == 0 then
		local var_3_17 = arg_3_1:GetDamagePerH() * 100

		setText = var_3_20

		var_3_20(arg_3_0._delta, "-" .. var_3_17 .. "%")

		setActive = var_3_20

		var_3_20(arg_3_0._delta, true)

		setActive = var_3_20

		var_3_20(arg_3_0._timeStamp, false)
	else
		local var_3_18 = arg_3_1
		local var_3_19 = arg_3_1.GetBossTimeStamp(var_3_18)

		os = var_3_20
		var_3_20 = var_3_20.date("*t", var_3_19)
		setText = var_3_18

		local var_3_21 = arg_3_0._timeStamp
		local var_3_22 = var_10.Find(var_3_21, "date")

		string = var_3_15

		var_3_18(var_3_22, var_3_15.format("%02d/%02d %02d:%02d", var_3_20.month, var_3_20.day, var_3_20.hour, var_3_20.min))

		setActive = var_3_18

		var_3_18(arg_3_0._delta, false)

		setActive = var_3_18

		var_3_18(arg_3_0._timeStamp, true)
	end

	local var_3_23 = arg_3_0._series
	local var_3_24 = var_6.GetRewardDisplay(var_3_23)

	UIItemList = var_3_20

	local var_3_25 = var_3_20.StaticAlign
	local var_3_26 = arg_3_0._arwardList
	local var_3_27 = arg_3_0._arwardList

	var_3_25(var_3_26, var_10.GetChild(var_3_27, 0), #var_3_24, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_4_0 = var_3_24[arg_4_1 + 1]

		Drop = var_4

		local var_4_1 = var_4.Create(var_4_0)

		updateDrop = var_2_10005

		var_2_10005(arg_4_2, var_4_1)

		local var_4_2 = arg_3_0._series
		local var_4_3 = var_5.GetReplaceTaskIDList(var_4_2)[1]

		getProxy = var_6
		TaskProxy = var_8

		local var_4_4 = var_6(var_8)
		local var_4_5 = var_6.getTaskById(var_4_4, var_4_3)
		local var_4_6 = arg_3_0._series

		if var_7.IsPass(var_4_6) then
			if var_4_5 then
				setActive = var_7

				var_7(arg_3_0._rewardRemind, true)

				setActive = var_7

				var_7(arg_4_2:Find("got"), false)
			else
				setActive = var_7

				var_7(arg_3_0._rewardRemind, false)

				setActive = var_7

				var_7(arg_4_2:Find("got"), true)
			end
		else
			setActive = var_7

			var_7(arg_3_0._rewardRemind, false)

			setActive = var_7

			var_7(arg_4_2:Find("got"), false)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_5_0)
	var_0_1.super.Show(arg_5_0)

	pg = var_1

	local var_5_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_1.Hide(arg_6_0)
	var_0_1.super.Hide(arg_6_0)

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf, arg_6_0._parentTf)

	return
end

function var_0_1.OnLoaded(arg_7_0)
	arg_7_0.parentTr = arg_7_0._tf.parent

	local var_7_0 = arg_7_0._tf

	arg_7_0._bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0._stageName = var_1.Find(var_7_1, "Panel/Progress/name")

	local var_7_2 = arg_7_0._tf

	arg_7_0._delta = var_1.Find(var_7_2, "Panel/Progress/delta")

	local var_7_3 = arg_7_0._tf

	arg_7_0._hpRate = var_1.Find(var_7_3, "Panel/Progress/value")

	local var_7_4 = arg_7_0._tf

	arg_7_0._timeStamp = var_1.Find(var_7_4, "Panel/Progress/timestamp")

	local var_7_5 = arg_7_0._tf

	arg_7_0._progressBar = var_1.Find(var_7_5, "Panel/Progress/progress_bar")
	arg_7_0._barL = arg_7_0._progressBar.rect.width
	Vector2 = var_1
	arg_7_0._barVct2 = var_1(arg_7_0._progressBar.rect.width, arg_7_0._progressBar.rect.height)
	setText = var_1

	local var_7_6 = arg_7_0._timeStamp
	local var_7_7 = var_3.Find(var_7_6, "label")

	i18n = var_4

	var_1(var_7_7, var_4("DAL_stage_finish_at"))

	arg_7_0._labelList = {}
	table = var_1

	local var_7_8 = var_1.insert
	local var_7_9 = arg_7_0._labelList
	local var_7_10 = arg_7_0._tf

	var_7_8(var_7_9, var_4.Find(var_7_10, "Panel/StageInfo/label_1"))

	table = var_7_8

	local var_7_11 = var_7_8.insert
	local var_7_12 = arg_7_0._labelList
	local var_7_13 = arg_7_0._tf

	var_7_11(var_7_12, var_4.Find(var_7_13, "Panel/StageInfo/label"))

	table = var_7_11

	local var_7_14 = var_7_11.insert
	local var_7_15 = arg_7_0._labelList
	local var_7_16 = arg_7_0._tf

	var_7_14(var_7_15, var_4.Find(var_7_16, "Panel/StageInfo/commander_label"))

	table = var_7_14

	local var_7_17 = var_7_14.insert
	local var_7_18 = arg_7_0._labelList
	local var_7_19 = arg_7_0._tf

	var_7_17(var_7_18, var_4.Find(var_7_19, "Panel/StageInfo/label_2"))

	setText = var_7_17

	local var_7_20 = arg_7_0._tf
	local var_7_21 = var_3.Find(var_7_20, "Panel/StageInfo/label_1/label/text")

	i18n = var_4

	var_7_17(var_7_21, var_4("DAL_stage_label_data"))

	setText = var_7_17

	local var_7_22 = arg_7_0._tf
	local var_7_23 = var_3.Find(var_7_22, "Panel/StageInfo/label/label/text")

	i18n = var_4

	var_7_17(var_7_23, var_4("DAL_stage_label_data"))

	setText = var_7_17

	local var_7_24 = arg_7_0._tf
	local var_7_25 = var_3.Find(var_7_24, "Panel/StageInfo/commander_label/label/text")

	i18n = var_4

	var_7_17(var_7_25, var_4("DAL_stage_label_commander"))

	setText = var_7_17

	local var_7_26 = arg_7_0._tf
	local var_7_27 = var_3.Find(var_7_26, "Panel/StageInfo/label_2/label/text")

	i18n = var_4

	var_7_17(var_7_27, var_4("DAL_stage_label_support"))

	local var_7_28 = arg_7_0._tf

	arg_7_0._rewardRemind = var_1.Find(var_7_28, "Panel/Reward/remind")
	setText = var_1

	local var_7_29 = arg_7_0._rewardRemind
	local var_7_30 = var_3.Find(var_7_29, "text")

	i18n = var_4

	var_1(var_7_30, var_4("dal_chapter_tip2"))

	setText = var_1

	local var_7_31 = arg_7_0._tf
	local var_7_32 = var_3.Find(var_7_31, "Panel/Reward/label")

	i18n = var_4

	var_1(var_7_32, var_4("item_type17_tip1"))

	local var_7_33 = arg_7_0._tf

	arg_7_0._arwardList = var_1.Find(var_7_33, "Panel/Reward/Items")

	local var_7_34 = arg_7_0._tf

	arg_7_0._goBtnNormal = var_1.Find(var_7_34, "Panel/Battle/normal")

	local var_7_35 = arg_7_0._tf

	arg_7_0._goBtnHard = var_1.Find(var_7_35, "Panel/Battle/hard")

	local var_7_36 = arg_7_0._tf

	arg_7_0._closeBtn = var_1.Find(var_7_36, "Panel/close_btn")

	arg_7_0:RegisterEvent()

	return
end

function var_0_1.RegisterEvent(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._closeBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0._goBtnNormal

	local function var_8_5()
		local var_10_0 = arg_8_0._series
		local var_10_1 = var_0.SetDifficulty

		CollabrateBossRushSeriesData = var_2_10003

		var_10_1(var_10_0, var_2_10003.DIFF.NORMAL)

		local var_10_2 = arg_8_0.event
		local var_10_3 = var_0.emit

		BossRushDALCollabMediator = var_3

		var_10_3(var_10_2, var_3.ON_FLEET_SELECT, arg_8_0._series)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0._goBtnHard

	local function var_8_8()
		local var_11_0 = arg_8_0._series
		local var_11_1 = var_0.SetDifficulty

		CollabrateBossRushSeriesData = var_2_10003

		var_11_1(var_11_0, var_2_10003.DIFF.HARD)

		local var_11_2 = arg_8_0.event
		local var_11_3 = var_0.emit

		BossRushDALCollabMediator = var_3

		var_11_3(var_11_2, var_3.ON_FLEET_SELECT, arg_8_0._series)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onButton = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0._bg

	local function var_8_11()
		local var_12_0 = arg_8_0

		var_0.Hide(var_12_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10006)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0.exited = true

	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_1
