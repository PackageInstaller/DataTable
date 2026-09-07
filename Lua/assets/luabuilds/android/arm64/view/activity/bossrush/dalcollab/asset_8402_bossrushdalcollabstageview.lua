local BossRushDALCollabStageView = class("BossRushDALCollabStageView", import("view.base.BaseSubView"))

function BossRushDALCollabStageView:getUIName()
	return "BossRushStageInfoUIDALCollab"
end

function BossRushDALCollabStageView:SetUp(arg_2_1)
	self:RegisterEvent()

	return
end

function BossRushDALCollabStageView:SetData(arg_3_1)
	self._series = arg_3_1

	local var_3_0 = arg_3_1:GetBossHpRate()

	self._barVct2.x = var_3_0 * self._barL
	self._progressBar.sizeDelta = self._barVct2

	if not self._series:GetDefeated((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB))) and self._series:IsPass() then
		setText(self._hpRate, "HOLD")
	else
		setText(self._hpRate, var_3_0 * 100 .. "%")
	end

	setText(self._stageName, arg_3_1:GetSeriesName())

	local var_3_1, var_3_2 = arg_3_1:GetCurrentProfile()

	for iter_3_0, iter_3_1 in ipairs(self._labelList) do
		if not var_3_1[iter_3_0] then
			setActive(iter_3_1, false)
		else
			setActive(iter_3_1, true)
			setText(iter_3_1:Find("desc"), var_3_1[iter_3_0])
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_2) do
		setText(self._labelList[iter_3_2]:Find("state"), iter_3_3)
	end

	setText(self._goBtnNormal:Find("text"), arg_3_1:GetName(arg_3_1.DIFF.NORMAL))
	setText(self._goBtnHard:Find("text"), arg_3_1:GetName(arg_3_1.DIFF.HARD))

	if self._series:GetBossTimeStamp() == 0 then
		setText(self._delta, "-" .. arg_3_1:GetDamagePerH() * 100 .. "%")
		setActive(self._delta, true)
		setActive(self._timeStamp, false)
	else
		local var_3_3 = os.date("*t", (arg_3_1:GetBossTimeStamp()))

		setText(self._timeStamp:Find("date"), string.format("%02d/%02d %02d:%02d", var_3_3.month, var_3_3.day, var_3_3.hour, var_3_3.min))
		setActive(self._delta, false)
		setActive(self._timeStamp, true)
	end

	local var_3_4 = self._series:GetRewardDisplay()

	UIItemList.StaticAlign(self._arwardList, self._arwardList:GetChild(0), #var_3_4, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 ~= UIItemList.EventUpdate then
			return
		end

		updateDrop(arg_4_2, (Drop.Create(var_3_4[arg_4_1 + 1])))

		if self._series:IsPass() then
			if getProxy(TaskProxy):getTaskById(self._series:GetReplaceTaskIDList()[1]) then
				setActive(self._rewardRemind, true)
				setActive(arg_4_2:Find("got"), false)
			else
				setActive(self._rewardRemind, false)
				setActive(arg_4_2:Find("got"), true)
			end
		else
			setActive(self._rewardRemind, false)
			setActive(arg_4_2:Find("got"), false)
		end

		return
	end)

	return
end

function BossRushDALCollabStageView:Show()
	BossRushDALCollabStageView.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function BossRushDALCollabStageView:Hide()
	BossRushDALCollabStageView.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function BossRushDALCollabStageView:OnLoaded()
	self.parentTr = self._tf.parent
	self._bg = self._tf:Find("BG")
	self._stageName = self._tf:Find("Panel/Progress/name")
	self._delta = self._tf:Find("Panel/Progress/delta")
	self._hpRate = self._tf:Find("Panel/Progress/value")
	self._timeStamp = self._tf:Find("Panel/Progress/timestamp")
	self._progressBar = self._tf:Find("Panel/Progress/progress_bar")
	self._barL = self._progressBar.rect.width
	self._barVct2 = Vector2(self._progressBar.rect.width, self._progressBar.rect.height)

	setText(self._timeStamp:Find("label"), i18n("DAL_stage_finish_at"))

	self._labelList = {}

	table.insert(self._labelList, self._tf:Find("Panel/StageInfo/label_1"))
	table.insert(self._labelList, self._tf:Find("Panel/StageInfo/label"))
	table.insert(self._labelList, self._tf:Find("Panel/StageInfo/commander_label"))
	table.insert(self._labelList, self._tf:Find("Panel/StageInfo/label_2"))
	setText(self._tf:Find("Panel/StageInfo/label_1/label/text"), i18n("DAL_stage_label_data"))
	setText(self._tf:Find("Panel/StageInfo/label/label/text"), i18n("DAL_stage_label_data"))
	setText(self._tf:Find("Panel/StageInfo/commander_label/label/text"), i18n("DAL_stage_label_commander"))
	setText(self._tf:Find("Panel/StageInfo/label_2/label/text"), i18n("DAL_stage_label_support"))

	self._rewardRemind = self._tf:Find("Panel/Reward/remind")

	setText(self._rewardRemind:Find("text"), i18n("dal_chapter_tip2"))
	setText(self._tf:Find("Panel/Reward/label"), i18n("item_type17_tip1"))

	self._arwardList = self._tf:Find("Panel/Reward/Items")
	self._goBtnNormal = self._tf:Find("Panel/Battle/normal")
	self._goBtnHard = self._tf:Find("Panel/Battle/hard")
	self._closeBtn = self._tf:Find("Panel/close_btn")

	self:RegisterEvent()

	return
end

function BossRushDALCollabStageView:RegisterEvent()
	onButton(self, self._closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._goBtnNormal, function()
		self._series:SetDifficulty(CollabrateBossRushSeriesData.DIFF.NORMAL)
		self.event:emit(BossRushDALCollabMediator.ON_FLEET_SELECT, self._series)

		return
	end, SFX_PANEL)
	onButton(self, self._goBtnHard, function()
		self._series:SetDifficulty(CollabrateBossRushSeriesData.DIFF.HARD)
		self.event:emit(BossRushDALCollabMediator.ON_FLEET_SELECT, self._series)

		return
	end, SFX_PANEL)
	onButton(self, self._bg, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function BossRushDALCollabStageView:OnDestroy()
	self.exited = true

	if self:isShowing() then
		self:Hide()
	end

	return
end

return BossRushDALCollabStageView
