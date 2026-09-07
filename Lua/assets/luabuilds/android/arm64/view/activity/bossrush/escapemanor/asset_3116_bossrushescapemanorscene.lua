local BossRushEscapeManorScene = class("BossRushEscapeManorScene", import("view.base.BaseUI"))

BossRushEscapeManorScene.DISPLAY = {
	STORY = "Story",
	BATTLE = "Battle"
}

function BossRushEscapeManorScene:getUIName()
	return "BossRushEscapeManorUI"
end

function BossRushEscapeManorScene:init()
	self.top = self._tf:Find("Top")
	self.ptBtn = self.top:Find("right/pt")
	self.ptTip = self.ptBtn:Find("tip")
	self.rankBtn = self.top:Find("right/rank")

	setText(self.rankBtn:Find("Text"), i18n("escape_series_rank"))

	self.taskBtn = self.top:Find("right/task")

	setText(self.taskBtn:Find("Text"), i18n("escape_series_task"))

	self.taskTip = self.taskBtn:Find("tip")
	self.seriesNodes = {}

	eachChild(self._tf:Find("Battle/Nodes"), function(arg_3_0, arg_3_1)
		self.seriesNodes[arg_3_0.name] = arg_3_0

		return
	end)

	self.nodes = {}

	eachChild(self._tf:Find("Story/Nodes"), function(arg_4_0, arg_4_1)
		self.nodes[arg_4_0.name] = arg_4_0

		return
	end)

	self.switchToggle = self.top:Find("bottom/switch_toggle")
	self.ActionSequence = {}

	self:UpdateRatioScale()

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_5_0, arg_5_1)
		self:UpdateRatioScale()

		return
	end)
	self.storyAward = self.top:Find("bottom/Award")
	self.progressText = self.storyAward:Find("desc")

	return
end

function BossRushEscapeManorScene:SetActivity(arg_6_1)
	self.activity = arg_6_1

	return
end

function BossRushEscapeManorScene:SetPtActivity(arg_7_1)
	self.ptActivity = arg_7_1
	self.ptData = ActivityPtData.New(self.ptActivity)

	return
end

function BossRushEscapeManorScene:didEnter()
	onButton(self, self.top:Find("top/back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.top:Find("top/home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.top:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("escape_manor_series_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.rankBtn, function()
		self:emit(BossRushEscapeManorMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(self, self.ptBtn, function()
		self:emit(BossRushEscapeManorMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = self.ptActivity.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self:emit(BossRushEscapeManorMediator.GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onToggle(self, self.switchToggle:Find("Story"), function(arg_15_0)
		if arg_15_0 then
			if self.blockAnim then
				self.blockAnim = false
			end

			self:SetDisplayMode(BossRushEscapeManorScene.DISPLAY.STORY)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.switchToggle:Find("Battle"), function(arg_16_0)
		if arg_16_0 then
			if self.blockAnim then
				self.blockAnim = false
			end

			self:SetDisplayMode(BossRushEscapeManorScene.DISPLAY.BATTLE)
		end

		return
	end, SFX_PANEL)

	self.storyNodesDict = {}

	for iter_8_0, iter_8_1 in ipairs(self.activity:getConfig("config_client").storys) do
		self.storyNodesDict[iter_8_1] = BossRushStoryNode.New({
			id = iter_8_1
		})
	end

	self.blockAnim = true

	triggerToggle(self.switchToggle:Find(self.contextData.displayMode or BossRushEscapeManorScene.DISPLAY.BATTLE), true)

	return
end

function BossRushEscapeManorScene:getBGM()
	if self.contextData.displayMode ~= BossRushEscapeManorScene.DISPLAY.STORY then
		return BossRushEscapeManorScene.super.getBGM(self)
	else
		local var_17_0 = self.activity:getConfig("config_client").storybgm
		local var_17_1 = pg.TimeMgr.GetInstance():GetServerHour()
		local var_17_2 = var_17_0[#var_17_0][2]

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if var_17_1 < iter_17_1[1] then
				break
			else
				var_17_2 = iter_17_1[2]
			end
		end

		return var_17_2
	end

	return
end

function BossRushEscapeManorScene:getBG()
	if self.contextData.displayMode ~= BossRushEscapeManorScene.DISPLAY.STORY then
		return "bg1"
	else
		return "bg2"
	end

	return
end

function BossRushEscapeManorScene:SetDisplayMode(arg_19_1)
	self.contextData.displayMode = arg_19_1

	self:UpdateView()

	return
end

function BossRushEscapeManorScene:UpdateRatioScale(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs({
		"Mask",
		"Battle",
		"Story"
	}) do
		local var_20_1 = self._tf:Find(iter_20_1)

		var_20_0 = var_20_0 or var_20_1.rect.height > 1440 and var_20_1.rect.height / 1440 or 1

		setLocalScale(var_20_1, {
			x = var_20_0,
			y = var_20_0
		})
	end

	return
end

function BossRushEscapeManorScene:UpdateView()
	local var_21_0 = self.contextData.displayMode == BossRushEscapeManorScene.DISPLAY.BATTLE

	setActive(self._tf:Find("Battle"), self.contextData.displayMode == BossRushEscapeManorScene.DISPLAY.BATTLE)
	setActive(self._tf:Find("Story"), not var_21_0)
	setActive(self.storyAward, not var_21_0)

	if var_21_0 then
		self:UpdateBattle()
	else
		self:UpdateStory()
	end

	self:UpdateStoryTask()

	local var_21_1 = self:getBG()

	eachChild(self._tf:Find("Mask"), function(arg_22_0, arg_22_1)
		setActive(arg_22_0, arg_22_0.name == var_21_1 or arg_22_0.name == "FX")

		return
	end)
	self:PlayBGM()
	setText(self.ptBtn:Find("Text"), i18n("escape_series_pt", self.ptActivity.data1))
	setActive(self.ptTip, Activity.IsActivityReady(self.ptActivity))

	local var_21_2 = self.contextData.displayMode

	self:addbubbleMsgBoxList({
		function(arg_23_0)
			local var_23_0

			if var_21_2 == BossRushEscapeManorScene.DISPLAY.BATTLE then
				var_23_0 = self.activity:getConfig("config_client").openActivityStory
			elseif var_21_2 == BossRushEscapeManorScene.DISPLAY.STORY then
				var_23_0 = self.activity:getConfig("config_client").openStory
			end

			self:PlayStory(var_23_0, arg_23_0)

			return
		end,
		function(arg_24_0)
			if underscore.all(underscore.values(self.storyNodesDict), function(arg_25_0)
				return arg_25_0:IsReaded()
			end) and self.storyTask and self.storyTask:getTaskStatus() == 2 then
				self:PlayStory(self.activity:getConfig("config_client").endStory, arg_24_0)
			else
				arg_24_0()
			end

			return
		end
	})

	return
end

function BossRushEscapeManorScene:UpdateBattle()
	for iter_26_0, iter_26_1 in ipairs((self.activity:GetActiveSeriesIds())) do
		local var_26_0 = self.seriesNodes[tostring(iter_26_1)]
		local var_26_1 = BossRushSeriesData.New({
			id = iter_26_1,
			actId = self.activity.id
		})
		local var_26_2 = var_26_1:IsUnlock(self.activity)

		setActive(var_26_0, var_26_2)

		local var_26_3 = var_26_1:GetType()

		setActive(var_26_0:Find("blue"), var_26_3 == BossRushSeriesData.TYPE.NORMAL)
		setActive(var_26_0:Find("red"), var_26_3 ~= BossRushSeriesData.TYPE.NORMAL)

		local var_26_4 = var_26_3 == BossRushSeriesData.TYPE.NORMAL and var_26_0:Find("blue") or var_26_0:Find("red")

		setText(var_26_4:Find("Text"), var_26_1:GetName())
		setText(var_26_4:Find("diff/Text"), switch(iter_26_1, {
			[6001] = function()
				return i18n("zengke_series_easy")
			end,
			[6002] = function()
				return i18n("zengke_series_normal")
			end,
			[6003] = function()
				return i18n("zengke_series_hard")
			end,
			[6004] = function()
				return i18n("zengke_series_sp")
			end,
			[6005] = function()
				return i18n("zengke_series_ex")
			end
		}))

		local var_26_5 = var_26_3 == BossRushSeriesData.TYPE.SP

		setActive(var_26_0:Find("times"), var_26_3 == BossRushSeriesData.TYPE.SP)

		if var_26_5 then
			local var_26_7 = self.activity:GetUsedBonus()[iter_26_0] or 0
			local var_26_8 = var_26_1:GetMaxBonusCount()

			setText(var_26_0:Find("times/Text"), i18n("series_enemy_SP_count") .. setColorStr(math.max(0, var_26_8 - var_26_7) .. "/" .. var_26_8, var_26_8 - var_26_7 > 0 and "#6EE868" or "#7f7f7f"))
		end

		onButton(self, var_26_0, function()
			if not var_26_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_unlock", BossRushSeriesData.New({
					id = var_26_1:GetPreSeriesId()
				}):GetName()))

				return
			end

			self:emit(BossRushEscapeManorMediator.ON_FLEET_SELECT, var_26_1)

			return
		end, SFX_PANEL)
	end

	return
end

function BossRushEscapeManorScene:UpdateStory()
	local var_33_0 = pg.NewStoryMgr.GetInstance()
	local var_33_1 = 0
	local var_33_2 = 0

	for iter_33_0, iter_33_1 in pairs(self.storyNodesDict) do
		print("find node id " .. tostring(iter_33_1.id))

		local var_33_3 = self.nodes[tostring(iter_33_1.id)]
		local var_33_4 = iter_33_1:IsActive(self.activity, self.ptActivity)

		setActive(var_33_3, var_33_4)
		setText(var_33_3:Find("main/char/bg/Text"), iter_33_1:GetName())

		local var_33_5 = iter_33_1:IsReaded()

		var_33_1 = var_33_1 + (var_33_5 and 1 or 0)
		var_33_2 = var_33_2 + 1

		setActive(var_33_3:Find("main/char"), not var_33_5)
		setActive(var_33_3:Find("main/talk"), var_33_5)
		onButton(self, var_33_3, function()
			if not var_33_4 or var_33_5 then
				return
			end

			self:PlayStory(iter_33_1:GetStory(), function()
				self:UpdateView()

				return
			end)

			return
		end)
	end

	setText(self.progressText, i18n("escape_story_reward_count"))
	setText(findTF(self.progressText, "progress"), setColorStr(var_33_1, "#f34f66") .. "/" .. var_33_2)

	if self.storyTask then
		local var_33_6 = Drop.Create(self.storyTask:getConfig("award_display")[1])
		local var_33_7 = self.storyAward:Find("award_bg")

		updateDrop(var_33_7:Find("IconTpl"), var_33_6)
		onButton(self, var_33_7, function()
			self:emit(BaseUI.ON_DROP, var_33_6)

			return
		end, SFX_PANEL)

		local var_33_8 = self.storyTask:getTaskStatus()

		setActive(var_33_7:Find("get"), var_33_8 == 1)
		setActive(var_33_7:Find("got"), var_33_8 == 2)
	end

	return
end

function BossRushEscapeManorScene:PlayStory(arg_37_1, arg_37_2)
	if not arg_37_1 then
		return existCall(arg_37_2)
	end

	local var_37_0 = pg.NewStoryMgr.GetInstance()
	local var_37_1 = var_37_0:IsPlayed(arg_37_1)

	seriesAsync({
		function(arg_38_0)
			if var_37_1 then
				return arg_38_0()
			end

			local var_38_0 = tonumber(arg_37_1)

			if var_38_0 and var_38_0 > 0 then
				self:emit(BossRushEscapeManorMediator.ON_PERFORM_COMBAT, var_38_0)
			else
				var_37_0:Play(arg_37_1, arg_38_0)
			end

			return
		end
	}, arg_37_2)

	return
end

function BossRushEscapeManorScene:UpdateStoryTask()
	local var_39_0 = self.activity:getConfig("config_client").tasks[1]
	local var_39_1 = getProxy(TaskProxy):getTaskVO(var_39_0)

	var_39_1 = var_39_1 or Task.New({
		submit_time = 1,
		id = var_39_0
	})
	self.storyTask = var_39_1

	setActive(self.switchToggle:Find("Story/new"), self.storyTask and self.storyTask:getTaskStatus() ~= 2)
	setActive(self.taskTip, Activity.IsActivityReady(getProxy(ActivityProxy):getActivityById(ActivityConst.ESCAPE_BOSS_RUSH_TASK_ACT_ID)))

	local var_39_5

	if self.storyTask then
		local var_39_2 = Drop.Create(self.storyTask:getConfig("award_display")[1])
		local var_39_3 = self.storyAward:Find("award_bg")

		updateDrop(var_39_3:Find("IconTpl"), var_39_2)
		onButton(self, var_39_3:Find("IconTpl"), function()
			self:emit(BaseUI.ON_DROP, var_39_2)

			return
		end, SFX_PANEL)

		local var_39_4 = self.storyTask:getTaskStatus()

		setActive(var_39_3:Find("get"), var_39_4 == 1)
		setActive(var_39_3:Find("got"), var_39_4 == 2)

		var_39_5 = self.storyAward:Find("award_bg")
	end

	updateDrop(var_39_5:Find("IconTpl"), (Drop.Create(self.storyTask:getConfig("award_display")[1])))
	onButton(self, var_39_5, function()
		return
	end, SFX_PANEL)

	local var_39_6 = self.storyTask:getTaskStatus()

	setActive(var_39_5:Find("get"), var_39_6 == 1)
	setActive(var_39_5:Find("got"), var_39_6 == 2)

	if var_39_6 == 1 then
		self:emit(BossRushEscapeManorMediator.ON_TASK_SUBMIT, self.storyTask)
	end

	return
end

function BossRushEscapeManorScene:addbubbleMsgBoxList(arg_42_1)
	local var_42_0 = #self.ActionSequence == 0

	table.insertto(self.ActionSequence, arg_42_1)

	if not var_42_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushEscapeManorScene:addbubbleMsgBox(arg_43_1)
	local var_43_0 = #self.ActionSequence == 0

	table.insert(self.ActionSequence, arg_43_1)

	if not var_43_0 then
		return
	end

	self:resumeBubble()

	return
end

function BossRushEscapeManorScene:resumeBubble()
	if #self.ActionSequence == 0 then
		return
	end

	local function var_44_1()
		if self.ActionSequence[1] then
			self.ActionSequence[1](function()
				table.remove(self.ActionSequence, 1)
				var_44_1()

				return
			end)
		end

		return
	end

	;(nil)()

	return
end

function BossRushEscapeManorScene:CleanBubbleMsgbox()
	table.clean(self.ActionSequence)

	return
end

function BossRushEscapeManorScene:willExit()
	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return BossRushEscapeManorScene
