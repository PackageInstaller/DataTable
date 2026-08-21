local var_0_0 = class("BossRushDALCollabStageView", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BossRushStageInfoUIDALCollab"
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0:RegisterEvent()

	return
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0._series = arg_3_1

	local var_3_0 = arg_3_1:GetBossHpRate()

	arg_3_0._barVct2.x = var_3_0 * arg_3_0._barL
	arg_3_0._progressBar.sizeDelta = arg_3_0._barVct2

	if not arg_3_0._series:GetDefeated((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB))) and arg_3_0._series:IsPass() then
		setText(arg_3_0._hpRate, "HOLD")
	else
		setText(arg_3_0._hpRate, var_3_0 * 100 .. "%")
	end

	setText(arg_3_0._stageName, arg_3_1:GetSeriesName())

	local var_3_1, var_3_2 = arg_3_1:GetCurrentProfile()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._labelList) do
		if not var_3_1[iter_3_0] then
			setActive(iter_3_1, false)
		else
			setActive(iter_3_1, true)
			setText(iter_3_1:Find("desc"), var_3_1[iter_3_0])
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_2) do
		setText(arg_3_0._labelList[iter_3_2]:Find("state"), iter_3_3)
	end

	setText(arg_3_0._goBtnNormal:Find("text"), arg_3_1:GetName(arg_3_1.DIFF.NORMAL))
	setText(arg_3_0._goBtnHard:Find("text"), arg_3_1:GetName(arg_3_1.DIFF.HARD))

	if arg_3_0._series:GetBossTimeStamp() == 0 then
		setText(arg_3_0._delta, "-" .. arg_3_1:GetDamagePerH() * 100 .. "%")
		setActive(arg_3_0._delta, true)
		setActive(arg_3_0._timeStamp, false)
	else
		local var_3_3 = os.date("*t", (arg_3_1:GetBossTimeStamp()))

		setText(arg_3_0._timeStamp:Find("date"), string.format("%02d/%02d %02d:%02d", var_3_3.month, var_3_3.day, var_3_3.hour, var_3_3.min))
		setActive(arg_3_0._delta, false)
		setActive(arg_3_0._timeStamp, true)
	end

	UIItemList.StaticAlign(arg_3_0._arwardList, arg_3_0._arwardList:GetChild(0), #arg_3_0._series:GetRewardDisplay(), function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 ~= UIItemList.EventUpdate then
			return
		end

		updateDrop(arg_4_2, (Drop.Create(var_0[arg_4_1 + 1])))

		if arg_3_0._series:IsPass() then
			if getProxy(TaskProxy):getTaskById(arg_3_0._series:GetReplaceTaskIDList()[1]) then
				setActive(arg_3_0._rewardRemind, true)
				setActive(arg_4_2:Find("got"), false)
			else
				setActive(arg_3_0._rewardRemind, false)
				setActive(arg_4_2:Find("got"), true)
			end
		else
			setActive(arg_3_0._rewardRemind, false)
			setActive(arg_4_2:Find("got"), false)
		end

		return
	end)

	return
end

function var_0_0.Show(arg_5_0)
	var_0_0.super.Show(arg_5_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.Hide(arg_6_0)
	var_0_0.super.Hide(arg_6_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf, arg_6_0._parentTf)

	return
end

function var_0_0.OnLoaded(arg_7_0)
	arg_7_0.parentTr = arg_7_0._tf.parent
	arg_7_0._bg = arg_7_0._tf:Find("BG")
	arg_7_0._stageName = arg_7_0._tf:Find("Panel/Progress/name")
	arg_7_0._delta = arg_7_0._tf:Find("Panel/Progress/delta")
	arg_7_0._hpRate = arg_7_0._tf:Find("Panel/Progress/value")
	arg_7_0._timeStamp = arg_7_0._tf:Find("Panel/Progress/timestamp")
	arg_7_0._progressBar = arg_7_0._tf:Find("Panel/Progress/progress_bar")
	arg_7_0._barL = arg_7_0._progressBar.rect.width
	arg_7_0._barVct2 = Vector2(arg_7_0._progressBar.rect.width, arg_7_0._progressBar.rect.height)

	setText(arg_7_0._timeStamp:Find("label"), i18n("DAL_stage_finish_at"))

	arg_7_0._labelList = {}

	table.insert(arg_7_0._labelList, arg_7_0._tf:Find("Panel/StageInfo/label_1"))
	table.insert(arg_7_0._labelList, arg_7_0._tf:Find("Panel/StageInfo/label"))
	table.insert(arg_7_0._labelList, arg_7_0._tf:Find("Panel/StageInfo/commander_label"))
	table.insert(arg_7_0._labelList, arg_7_0._tf:Find("Panel/StageInfo/label_2"))
	setText(arg_7_0._tf:Find("Panel/StageInfo/label_1/label/text"), i18n("DAL_stage_label_data"))
	setText(arg_7_0._tf:Find("Panel/StageInfo/label/label/text"), i18n("DAL_stage_label_data"))
	setText(arg_7_0._tf:Find("Panel/StageInfo/commander_label/label/text"), i18n("DAL_stage_label_commander"))
	setText(arg_7_0._tf:Find("Panel/StageInfo/label_2/label/text"), i18n("DAL_stage_label_support"))

	arg_7_0._rewardRemind = arg_7_0._tf:Find("Panel/Reward/remind")

	setText(arg_7_0._rewardRemind:Find("text"), i18n("dal_chapter_tip2"))
	setText(arg_7_0._tf:Find("Panel/Reward/label"), i18n("item_type17_tip1"))

	arg_7_0._arwardList = arg_7_0._tf:Find("Panel/Reward/Items")
	arg_7_0._goBtnNormal = arg_7_0._tf:Find("Panel/Battle/normal")
	arg_7_0._goBtnHard = arg_7_0._tf:Find("Panel/Battle/hard")
	arg_7_0._closeBtn = arg_7_0._tf:Find("Panel/close_btn")

	arg_7_0:RegisterEvent()

	return
end

function var_0_0.RegisterEvent(arg_8_0)
	onButton(arg_8_0, arg_8_0._closeBtn, function()
		arg_8_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._goBtnNormal, function()
		arg_8_0._series:SetDifficulty(CollabrateBossRushSeriesData.DIFF.NORMAL)
		arg_8_0.event:emit(BossRushDALCollabMediator.ON_FLEET_SELECT, arg_8_0._series)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._goBtnHard, function()
		arg_8_0._series:SetDifficulty(CollabrateBossRushSeriesData.DIFF.HARD)
		arg_8_0.event:emit(BossRushDALCollabMediator.ON_FLEET_SELECT, arg_8_0._series)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0._bg, function()
		arg_8_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.exited = true

	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_0
