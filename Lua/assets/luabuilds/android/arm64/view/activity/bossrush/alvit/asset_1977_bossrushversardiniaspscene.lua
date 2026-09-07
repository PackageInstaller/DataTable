local BossRushVerSardiniaSPScene = class("BossRushVerSardiniaSPScene", import("view.base.BaseUI"))

BossRushVerSardiniaSPScene.DISPLAY = {
	STORY = "Story",
	BATTLE = "Battle"
}

function BossRushVerSardiniaSPScene:getUIName()
	return "BossRushVerSardiniaSPUI"
end

function BossRushVerSardiniaSPScene:init()
	self.top = self._tf:Find("Top")
	self.seriesNodes = {}

	eachChild(self._tf:Find("Battle/Nodes"), function(arg_3_0, arg_3_1)
		self.seriesNodes[arg_3_0.name] = arg_3_0

		return
	end)

	self.progressText = self.rtStoryAward:Find("Text")

	for iter_2_0 = 1, self.rtStoryItems.childCount do
		local var_2_0 = self.rtStoryItems:GetChild(iter_2_0 - 1)

		if iter_2_0 == self.index then
			var_2_0:GetComponent(typeof(LayoutElement)).preferredWidth = self.EXPAND_WIDTH or self.CLOSE_WIDTH
		end

		setCanvasGroupAlpha(var_2_0:Find("close"), iter_2_0 == self.index and 0 or 1)
		setText(var_2_0:Find("get/Text"), i18n("SardiniaSPCoreActivityUI_unlock"))
		onButton(self, var_2_0, function()
			if self.blockAnim then
				return
			end

			self:SelectItem(iter_2_0)

			return
		end, SFX_PANEL)
	end

	self.ActionSequence = {}

	return
end

function BossRushVerSardiniaSPScene:SetActivity(arg_5_1)
	self.activity = arg_5_1

	return
end

function BossRushVerSardiniaSPScene:SetPtActivity(arg_6_1)
	self.ptActivity = arg_6_1

	setText(self.countPT, self.ptActivity.data1)
	setActive(self.tipPT, Activity.IsActivityReady(self.ptActivity))

	return
end

function BossRushVerSardiniaSPScene:SetStoryActivity(arg_7_1)
	self.storyActivity = arg_7_1
	self.storyList = arg_7_1:GetConfigClientSetting("story")

	return
end

function BossRushVerSardiniaSPScene:SetTasksActivity(arg_8_1)
	self.tasksActivity = arg_8_1

	return
end

function BossRushVerSardiniaSPScene:SelectItem(arg_9_1)
	if self.index == arg_9_1 then
		return
	end

	self.index = arg_9_1
	self.blockAnim = true

	for iter_9_0, iter_9_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_9_1)
	end

	self.LTList = {}

	for iter_9_2 = 1, self.rtStoryItems.childCount do
		local var_9_0 = self.rtStoryItems:GetChild(iter_9_2 - 1)
		local var_9_1 = var_9_0:GetComponent(typeof(LayoutElement))
		local var_9_2 = var_9_1.preferredWidth

		if iter_9_2 == arg_9_1 then
			local var_9_3 = self.EXPAND_WIDTH or self.CLOSE_WIDTH

			if var_9_2 ~= var_9_3 then
				local var_9_4 = math.abs(var_9_3 - var_9_2) / self.DURATION_PARAMETER

				table.insert(self.LTList, LeanTween.value(go(var_9_0), var_9_2, var_9_3, var_9_4):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_10_0)
					var_9_1.preferredWidth = arg_10_0

					return
				end)).uniqueId)

				local var_9_5 = var_9_0:Find("close")
				local var_9_6 = LeanTween:alphaCanvas(iter_9_2 == arg_9_1 and 0 or 1, var_9_4)

				table.insert(self.LTList, var_9_6.setEase(var_9_6:GetComponent(typeof(CanvasGroup)), LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	local var_9_8 = pg.NewStoryMgr.GetInstance()

	if self.index ~= 1 and self.storyActivity.data1 > 0 and not var_9_8:IsPlayed(self.storyList[self.index - 1][1]) then
		self:emit(BossRushVerSardiniaSPMediator.ON_ACTIVITY_UNLOCKSTOIRY, self.storyActivity.id, var_9_8:StoryName2StoryId(self.storyList[self.index - 1][1]))
	else
		self:UpdataStoryState()
	end

	return
end

function BossRushVerSardiniaSPScene:didEnter()
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHome, function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("SardiniaSPCoreActivityUI_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnRank, function()
		self:emit(BossRushVerSardiniaSPMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.btnPT, function()
		self:emit(BossRushVerSardiniaSPMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = self.ptActivity.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnTask, function()
		self:emit(BossRushVerSardiniaSPMediator.GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.switchToggle:Find("Story"), function()
		if self.blockAnim then
			return
		end

		self:SetDisplayMode(BossRushVerSardiniaSPScene.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)
	onButton(self, self.switchToggle:Find("Battle"), function()
		if self.blockAnim then
			return
		end

		self:SetDisplayMode(BossRushVerSardiniaSPScene.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	self:SetDisplayMode(self.contextData.displayMode or BossRushVerSardiniaSPScene.DISPLAY.BATTLE)

	return
end

function BossRushVerSardiniaSPScene:SetDisplayMode(arg_20_1)
	self.contextData.displayMode = arg_20_1

	self:UpdateView()

	return
end

function BossRushVerSardiniaSPScene:UpdateView()
	local var_21_0 = self.contextData.displayMode == BossRushVerSardiniaSPScene.DISPLAY.BATTLE

	self.switchToggle:Find(self.contextData.displayMode):SetAsLastSibling()
	setActive(self.rtPageBattle, var_21_0)
	setActive(self.rtPageStory, not var_21_0)

	if var_21_0 then
		self:UpdateBattle()
	else
		self:UpdateStory()
	end

	self:UpdateTipDisplay()

	return
end

function BossRushVerSardiniaSPScene:UpdateBattle()
	local var_22_0 = self.contextData.showFlash and underscore.to_array(self.activity:GetPassCounts()) or nil

	self.contextData.showFlash = nil

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self.activity:getConfig("config_data")) do
		local var_22_2 = self.seriesNodes[tostring(iter_22_1)]
		local var_22_3 = BossRushSeriesData.New({
			id = iter_22_1,
			actId = self.activity.id
		})

		var_22_1[iter_22_0] = var_22_3

		local var_22_4 = var_22_3:IsUnlock(self.activity)

		setActive(var_22_2:Find("lock"), not var_22_4)
		setActive(var_22_2:Find("finish"), (self.activity:HasPassSeries(var_22_3.id)))

		local var_22_5 = var_22_2:Find("finish"):GetChild(0)
		local var_22_6

		if var_22_0 then
			::label_22_0::

			var_22_6 = self.contextData.passCounts and not table.contains(self.contextData.passCounts, var_22_3.id) and table.contains(var_22_0, var_22_3.id)
		end

		setActive(var_22_5, var_22_6)

		local var_22_7 = true

		if var_22_3:GetType() == BossRushSeriesData.TYPE.SP then
			setActive(var_22_2:Find("times"), var_22_4)

			local var_22_8 = self.activity:GetUsedBonus()[iter_22_0] or 0
			local var_22_9 = var_22_3:GetMaxBonusCount()

			var_22_7 = var_22_9 - var_22_8 > 0

			setText(var_22_2:Find("times/Text"), i18n("series_enemy_SP_count") .. setColorStr(math.max(0, var_22_9 - var_22_8) .. "/" .. var_22_9, "#f77d24"))
		end

		onButton(self, var_22_2, function()
			if not var_22_4 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_22_3:GetPreSeriesId()
				}):GetName()))

				return
			end

			if not var_22_7 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end

			local var_23_0 = {}

			if iter_22_0 > 1 and var_22_3:IsFleetsEmpty() then
				table.insert(var_23_0, function(arg_24_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("SardiniaSPCoreActivityUI_fleetconfirm"),
						onYes = function()
							var_22_3:CopyFleetsByOther(var_22_1[iter_22_0 - 1])
							arg_24_0()

							return
						end,
						onNo = arg_24_0
					})

					return
				end)
			end

			seriesAsync(var_23_0, function()
				self:emit(BossRushVerSardiniaSPMediator.ON_FLEET_SELECT, var_22_3)

				return
			end)

			return
		end, SFX_PANEL)
	end

	return
end

BossRushVerSardiniaSPScene.EXPAND_WIDTH = 628
BossRushVerSardiniaSPScene.CLOSE_WIDTH = 136
BossRushVerSardiniaSPScene.DURATION_PARAMETER = 1500

function BossRushVerSardiniaSPScene:UpdateStory()
	if not self.index then
		self:SelectItem(1)
	else
		self:UpdataStoryState()
	end

	return
end

function BossRushVerSardiniaSPScene:UpdataStoryState(arg_28_1)
	local var_28_0 = pg.NewStoryMgr.GetInstance()
	local var_28_1 = arg_28_1 and var_28_0:StoryId2StoryName(arg_28_1) or nil

	assert(not arg_28_1 or self.storyList[self.index - 1][1] == var_28_1)
	eachChild(self.rtStoryItems, function(arg_29_0, arg_29_1)
		arg_29_1 = arg_29_1 + 1

		local var_29_0
		local var_29_2

		if arg_29_1 == 1 then
			var_29_0 = false
			var_29_2 = false
		else
			var_29_0 = self.index == arg_29_1 and arg_28_1
			var_29_0 = var_29_0 or var_28_0:IsPlayed(self.storyList[arg_29_1 - 1][1])
			var_29_2 = self.storyActivity.data1 > 0
		end

		setActive(arg_29_0:Find("got"), var_29_0)
		setActive(arg_29_0:Find("get"), not var_29_0 and var_29_2)

		return
	end)

	local var_28_2 = {}

	if self.index == 1 then
		local var_28_3 = self.activity:GetConfigClientSetting("openStory")

		if not var_28_0:IsPlayed(var_28_3) then
			table.insert(var_28_2, function(arg_30_0)
				var_28_0:Play(var_28_3, arg_30_0)

				return
			end)
		end
	end

	if var_28_1 and not var_28_0:IsPlayed(var_28_1) then
		table.insert(var_28_2, function(arg_31_0)
			var_28_0:Play(var_28_1, arg_31_0)

			return
		end)
	end

	local var_28_4 = self.activity:GetConfigClientSetting("endStory")

	if not var_28_0:IsPlayed(var_28_4) and underscore.all(self.storyList, function(arg_32_0)
		return var_28_0:IsPlayed(arg_32_0[1]) or arg_32_0[1] == var_28_1
	end) then
		table.insert(var_28_2, function(arg_33_0)
			var_28_0:Play(var_28_4, arg_33_0)

			return
		end)
	end

	self.blockAnim = false

	seriesAsync(var_28_2, function()
		self:UpdateStoryTask()

		return
	end)

	return
end

function BossRushVerSardiniaSPScene:PlayStory(arg_35_1, arg_35_2)
	if not arg_35_1 then
		return existCall(arg_35_2)
	end

	local var_35_0 = pg.NewStoryMgr.GetInstance()
	local var_35_1 = var_35_0:IsPlayed(arg_35_1)

	seriesAsync({
		function(arg_36_0)
			if var_35_1 then
				return arg_36_0()
			end

			local var_36_0 = tonumber(arg_35_1)

			if var_36_0 and var_36_0 > 0 then
				self:emit(BossRushVerSardiniaSPMediator.ON_PERFORM_COMBAT, var_36_0)
			else
				var_35_0:Play(arg_35_1, arg_36_0)
			end

			return
		end
	}, arg_35_2)

	return
end

function BossRushVerSardiniaSPScene:UpdateStoryTask()
	local var_37_0 = self.activity:GetConfigClientSetting("tasks")[1]
	local var_37_1 = getProxy(TaskProxy):getTaskVO(var_37_0)

	var_37_1 = var_37_1 or Task.New({
		submit_time = 1,
		id = var_37_0
	})
	self.storyTask = var_37_1

	local var_37_2 = self.storyTask:getTargetNumber()

	setText(self.progressText, i18n("SardiniaSPCoreActivityUI_story_reward_count", self.storyActivity.data1, (self.storyTask:getProgress())))

	local var_37_3 = Drop.Create(self.storyTask:getConfig("award_display")[1])
	local var_37_4 = self.rtStoryAward:Find("IconTpl")

	updateDrop(var_37_4, var_37_3)
	onButton(self, var_37_4, function()
		self:emit(BaseUI.ON_DROP, var_37_3)

		return
	end, SFX_PANEL)

	local var_37_5 = self.storyTask:getTaskStatus()

	setActive(var_37_4:Find("get"), var_37_5 == 1)
	setActive(var_37_4:Find("got"), var_37_5 == 2)

	if var_37_5 == 1 then
		self:emit(BossRushVerSardiniaSPMediator.ON_TASK_SUBMIT, self.storyTask)
	end

	return
end

function BossRushVerSardiniaSPScene:addbubbleMsgBoxList(arg_39_1)
	local var_39_0 = #self.ActionSequence == 0

	table.insertto(self.ActionSequence, arg_39_1)

	if not var_39_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushVerSardiniaSPScene:addbubbleMsgBox(arg_40_1)
	local var_40_0 = #self.ActionSequence == 0

	table.insert(self.ActionSequence, arg_40_1)

	if not var_40_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushVerSardiniaSPScene:resumeBubble()
	if #self.ActionSequence == 0 then
		return
	end

	local function var_41_1()
		if self.ActionSequence[1] then
			self.ActionSequence[1](function()
				table.remove(self.ActionSequence, 1)
				var_41_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function BossRushVerSardiniaSPScene:CleanBubbleMsgbox()
	table.clean(self.ActionSequence)

	return
end

function BossRushVerSardiniaSPScene:UpdateTipDisplay()
	setActive(self.rtToggleTip, self.contextData.displayMode == BossRushVerSardiniaSPScene.DISPLAY.BATTLE and self:IsStoryTip())
	setActive(self.btnTask:Find("tip"), Activity.IsActivityReady(self.tasksActivity))

	return
end

function BossRushVerSardiniaSPScene:IsStoryTip()
	local var_46_0 = pg.NewStoryMgr.GetInstance()

	if not var_46_0:IsPlayed(self.activity:GetConfigClientSetting("openStory")) then
		return true
	end

	if Activity.IsActivityReady(self.storyActivity) then
		return true
	end

	if not var_46_0:IsPlayed(self.activity:GetConfigClientSetting("endStory")) and underscore.all(self.storyList, function(arg_47_0)
		return var_46_0:IsPlayed(arg_47_0[1])
	end) then
		return true
	end

	local var_46_1 = self.activity:GetConfigClientSetting("tasks")[1]
	local var_46_2 = var_46_1 and getProxy(TaskProxy):getTaskVO(var_46_1)

	if var_46_2 and var_46_2:getTaskStatus() == 1 then
		return true
	end

	return false
end

function BossRushVerSardiniaSPScene:willExit()
	self.contextData.passCounts = underscore.to_array(self.activity:GetPassCounts())

	return
end

return BossRushVerSardiniaSPScene
