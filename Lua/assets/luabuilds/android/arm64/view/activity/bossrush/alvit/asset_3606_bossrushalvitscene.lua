local BossRushAlvitScene = class("BossRushAlvitScene", import("view.base.BaseUI"))

BossRushAlvitScene.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function BossRushAlvitScene:getUIName()
	return "BossRushAlvitUI"
end

function BossRushAlvitScene:init()
	self.top = self._tf:Find("Top")
	self.ptBtn = self.top:Find("right/pt")
	self.ptText = self.ptBtn:Find("value/Text")
	self.ptTip = self.ptBtn:Find("tip")
	self.rankBtn = self.top:Find("right/rank")
	self.taskBtn = self.top:Find("right/task")
	self.taskTip = self.taskBtn:Find("tip")
	self.seriesNodes = {}

	local var_2_0 = self._tf:Find("Battle/Nodes")

	for iter_2_0 = 1, var_2_0.childCount do
		local var_2_1 = var_2_0:GetChild(iter_2_0 - 1)

		if isActive(var_2_1) then
			table.insert(self.seriesNodes, var_2_1)
		end
	end

	self.nodes = {}

	for iter_2_1 = 1, self._tf:Find("Story/Nodes").childCount do
		local var_2_2 = self._tf:Find("Story/Nodes"):GetChild(iter_2_1 - 1)

		self.nodes[var_2_2.name] = var_2_2
	end

	self.progressText = self._tf:Find("Story/Desc/Text")
	self.storyAward = self._tf:Find("Story/Award")
	self.ActionSequence = {}

	return
end

function BossRushAlvitScene:SetActivity(arg_3_1)
	self.activity = arg_3_1

	return
end

function BossRushAlvitScene:SetPtActivity(arg_4_1)
	self.ptActivity = arg_4_1
	self.ptData = ActivityPtData.New(self.ptActivity)

	return
end

function BossRushAlvitScene:didEnter()
	onButton(self, self.top:Find("top/back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.top:Find("top/home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.rankBtn, function()
		self:emit(BossRushAlvitMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.ptBtn, function()
		self:emit(BossRushAlvitMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolPtMediator,
			viewComponent = ChildishnessSchoolPtPage
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self:emit(BossRushAlvitMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolTaskMediator,
			viewComponent = ChildishnessSchoolTaskPage
		}))

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Battle/Story"), function()
		self:SetDisplayMode(BossRushAlvitScene.DISPLAY.STORY)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Story/Battle"), function()
		self:SetDisplayMode(BossRushAlvitScene.DISPLAY.BATTLE)

		return
	end, SFX_PANEL)

	self.storyNodesDict = {}

	_.each(self.activity:getConfig("config_client").storys or {}, function(arg_13_0)
		self.storyNodesDict[arg_13_0] = BossRushStoryNode.New({
			id = arg_13_0
		})

		return
	end)
	self:UpdateStoryTask()

	self.contextData.displayMode = nil

	self:SetDisplayMode(self.contextData.displayMode or BossRushAlvitScene.DISPLAY.BATTLE)

	return
end

function BossRushAlvitScene:getBGM()
	if not pg.voice_bgm[self.__cname] then
		return nil
	end

	if self.contextData.displayMode == BossRushAlvitScene.DISPLAY.BATTLE then
		return pg.voice_bgm[self.__cname].bgm
	elseif self.contextData.displayMode == BossRushAlvitScene.DISPLAY.STORY then
		return "story-richang-11"
	end

	return
end

function BossRushAlvitScene:SetDisplayMode(arg_15_1)
	if arg_15_1 == self.contextData.displayMode then
		return
	end

	self.contextData.displayMode = arg_15_1

	self:PlayBGM()
	self:UpdateView()

	return
end

function BossRushAlvitScene:UpdateView()
	local var_16_0 = self.contextData.displayMode == BossRushAlvitScene.DISPLAY.BATTLE

	setActive(self._tf:Find("Battle"), self.contextData.displayMode == BossRushAlvitScene.DISPLAY.BATTLE)
	setActive(self._tf:Find("Story"), not var_16_0)
	self:UpdateBattle()

	if not var_16_0 then
		self:UpdateStory()
	end

	self:UpdateTaskTip()

	local var_16_1 = self.contextData.displayMode

	self:addbubbleMsgBoxList({
		function(arg_17_0)
			local var_17_0

			if var_16_1 == BossRushAlvitScene.DISPLAY.BATTLE then
				var_17_0 = self.activity:getConfig("config_client").openActivityStory
			elseif var_16_1 == BossRushAlvitScene.DISPLAY.STORY then
				var_17_0 = self.activity:getConfig("config_client").openStory
			end

			self:PlayStory(var_17_0, arg_17_0)

			return
		end,
		function(arg_18_0)
			if underscore.all(underscore.values(self.storyNodesDict), function(arg_19_0)
				return arg_19_0:IsReaded()
			end) and self.storyTask and self.storyTask:getTaskStatus() == 2 then
				self:PlayStory(self.activity:getConfig("config_client").endStory, function(arg_20_0)
					arg_18_0()

					if arg_20_0 then
						self:UpdateView()
					end

					return
				end)

				return
			end

			arg_18_0()

			return
		end
	})

	return
end

function BossRushAlvitScene:UpdateBattle()
	local var_21_0 = self.activity
	local var_21_1 = self.activity:GetActiveSeriesIds()

	table.Foreach(self.seriesNodes, function(arg_22_0, arg_22_1)
		local var_22_0 = BossRushSeriesData.New({
			id = var_21_1[arg_22_0],
			actId = var_21_0.id
		})
		local var_22_1 = var_22_0:IsUnlock(var_21_0)

		setActive(arg_22_1, var_22_1)

		local var_22_2 = true

		if var_22_0:GetType() == BossRushSeriesData.TYPE.SP then
			local var_22_3 = var_21_0:GetUsedBonus()[arg_22_0] or 0
			local var_22_4 = var_22_0:GetMaxBonusCount()

			setText(arg_22_1:Find("count/Text"), i18n("series_enemy_SP_count") .. math.max(0, var_22_4 - var_22_3) .. "/" .. var_22_4)

			var_22_2 = var_22_4 - var_22_3 > 0
		end

		local function var_22_5()
			if not var_22_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_22_0:GetPreSeriesId()
				}):GetName()))

				return
			end

			if not var_22_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_SP_error"))

				return
			end

			self:emit(BossRushAlvitMediator.ON_FLEET_SELECT, var_22_0)

			return
		end

		onButton(self, arg_22_1:Find("icon"), function()
			var_22_5()

			return
		end, SFX_PANEL)
		onButton(self, arg_22_1:Find("text"), function()
			var_22_5()

			return
		end, SFX_PANEL)

		return
	end)
	setText(self.ptText, self.ptActivity.data1)
	self:UpdateTpTip()
	setActive(self._tf:Find("Battle/Story/new"), self.storyTask and self.storyTask:getTaskStatus() ~= 2)

	return
end

function BossRushAlvitScene:UpdateTpTip()
	setActive(self.ptTip, Activity.IsActivityReady(self.ptActivity))

	return
end

function BossRushAlvitScene:UpdateStory()
	local var_27_0 = pg.NewStoryMgr.GetInstance()
	local var_27_1 = 0
	local var_27_2 = 0

	table.Foreach(self.storyNodesDict, function(arg_28_0, arg_28_1)
		local var_28_0 = self.nodes[tostring(arg_28_1.id)]
		local var_28_1 = isActive(var_28_0)
		local var_28_2 = arg_28_1:IsActive(self.activity, self.ptActivity)

		if var_28_2 then
			if not var_28_1 then
				setActive(var_28_0, true)
			end

			setActive(var_28_0, true)

			if not var_28_1 then
				var_28_0:GetComponent(typeof(Animation)):Play("anim_kinder_bossrush_story_tip")
			end
		else
			setActive(var_28_0, false)
		end

		setText(var_28_0:Find("main/Text"), arg_28_1:GetName())

		local var_28_3 = arg_28_1:GetType()

		if var_28_3 == BossRushStoryNode.NODE_TYPE.NORMAL then
			setActive(var_28_0:Find("tags/story"), true)
			setActive(var_28_0:Find("tags/battle"), false)
		elseif var_28_3 == BossRushStoryNode.NODE_TYPE.EVENT then
			-- block empty
		elseif var_28_3 == BossRushStoryNode.NODE_TYPE.BATTLE then
			setActive(var_28_0:Find("tags/story"), false)
			setActive(var_28_0:Find("tags/battle"), true)
		end

		local var_28_4 = arg_28_1:IsReaded()

		var_27_1 = var_27_1 + (var_28_4 and 1 or 0)
		var_27_2 = var_27_2 + 1

		setActive(var_28_0:Find("main"), not var_28_4)
		setActive(var_28_0:Find("finish"), var_28_4)
		setActive(var_28_0:Find("finish_tag"), var_28_4)
		onButton(self, var_28_0, function()
			if not var_28_2 or var_28_4 then
				return
			end

			self:PlayStory(arg_28_1:GetStory(), function()
				self:UpdateView()

				return
			end)

			return
		end)

		return
	end)
	setText(self.progressText, 0 .. "/" .. 0)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_27_3 = self.storyTask:getConfig("award_display")
		local var_27_4 = Drop.New({
			type = var_27_3[1][1],
			id = var_27_3[1][2],
			count = var_27_3[1][3]
		})

		updateDrop(self.storyAward:GetChild(0), var_27_4)

		local var_27_5 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_27_5 == 1)
		setActive(self.storyAward:Find("got"), var_27_5 == 2)

		if var_27_5 == 1 then
			self:emit(BossRushAlvitMediator.ON_TASK_SUBMIT, self.storyTask)
		end

		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_27_4)

			return
		end)
	end

	return
end

function BossRushAlvitScene:PlayStory(arg_32_1, arg_32_2)
	if not arg_32_1 then
		return existCall(arg_32_2)
	end

	local var_32_0 = pg.NewStoryMgr.GetInstance()
	local var_32_1 = var_32_0:IsPlayed(arg_32_1)

	seriesAsync({
		function(arg_33_0)
			if var_32_1 then
				return arg_33_0()
			end

			local var_33_0 = tonumber(arg_32_1)

			if var_33_0 and var_33_0 > 0 then
				self:emit(BossRushAlvitMediator.ON_PERFORM_COMBAT, var_33_0)
			else
				var_32_0:Play(arg_32_1, arg_33_0)
			end

			return
		end,
		function(arg_34_0, ...)
			existCall(arg_32_2, ...)

			return
		end
	})

	return
end

function BossRushAlvitScene:UpdateStoryTask()
	local var_35_0 = self.activity:getConfig("config_client").tasks[1]
	local var_35_1 = getProxy(TaskProxy):getTaskVO(var_35_0)

	var_35_1 = var_35_1 or Task.New({
		submit_time = 1,
		id = var_35_0
	})
	self.storyTask = var_35_1

	return
end

function BossRushAlvitScene:UpdateTaskTip()
	setActive(self.taskTip, Activity.IsActivityReady(getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID)))

	return
end

function BossRushAlvitScene:addbubbleMsgBoxList(arg_37_1)
	local var_37_0 = #self.ActionSequence == 0

	table.insertto(self.ActionSequence, arg_37_1)

	if not var_37_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushAlvitScene:addbubbleMsgBox(arg_38_1)
	local var_38_0 = #self.ActionSequence == 0

	table.insert(self.ActionSequence, arg_38_1)

	if not var_38_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushAlvitScene:resumeBubble()
	if #self.ActionSequence == 0 then
		return
	end

	local function var_39_1()
		if self.ActionSequence[1] then
			self.ActionSequence[1](function()
				table.remove(self.ActionSequence, 1)
				var_39_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function BossRushAlvitScene:onBackPressed()
	self:emit(BossRushAlvitMediator.GO_SCENE, SCENE.KINDERGARTEN, {
		isBack = true
	})

	return
end

function BossRushAlvitScene:CleanBubbleMsgbox()
	table.clean(self.ActionSequence)

	return
end

return BossRushAlvitScene
