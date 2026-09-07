local SailingShip3SkinLayer = class("SailingShip3SkinLayer", import("view.base.BaseUI"))
local var_0_1

function SailingShip3SkinLayer:getUIName()
	return "SailingShip3SkinUI"
end

function SailingShip3SkinLayer:init()
	var_0_1 = ActivityConst.SAILING_SHIP_3_SKIN_ACT_ID
	self.activity = getProxy(ActivityProxy):getActivityById(var_0_1)
	self.story = self.activity:getConfig("config_client").story
	self.storyStateDic = {}
	self.item = self._tf:Find("task/item")
	self.items = self._tf:Find("task/items")
	self.uilist = UIItemList.New(self.items, self.item)

	setActive(self.item, false)
	onButton(self, self._tf:Find("des/itemDes"), function()
		self:emit(BaseUI.ON_DROP, {
			type = DROP_TYPE_VITEM,
			id = self.activity:getConfig("config_id"),
			count = getProxy(ActivityProxy):getActivityById(var_0_1).data1
		})

		return
	end)
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	self.taskProxy = getProxy(TaskProxy)

	self:OnUpdateFlush()
	self:UpdateItemView(self.activity)
	self:ShowMask(false)

	self.isPlaying = false

	self:InitStoryState()
	self:UpdateStoryView()
	self:DisplayBigTask()
	setText(self._tf:Find("task/taskAll/taskallReward/hasRewardText"), i18n("activity_1024_memory_get"))

	return
end

function SailingShip3SkinLayer:OnUpdateFlush()
	self:UpdataTaskData()
	self.uilist:align(#self.taskGroup)

	return
end

function SailingShip3SkinLayer:UpdataTaskData()
	self.taskGroup = {}

	local var_6_0 = self.activity:getConfig("config_client")

	self.allCompleteCount = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0.group_1) do
		local var_6_1 = (self.taskProxy:getTaskById(iter_6_1) or self.taskProxy:getFinishTaskById(iter_6_1)):getTaskStatus()

		if var_6_1 == 0 or var_6_1 == 1 or iter_6_0 == #var_6_0.group_1 then
			table.insert(self.taskGroup, iter_6_1)

			self.allCompleteCount = self.allCompleteCount + (iter_6_0 == #var_6_0.group_1 and var_6_1 == 2 and iter_6_0 or iter_6_0 - 1)

			break
		end
	end

	local var_6_3 = #var_6_0.group_2

	for iter_6_2, iter_6_3 in ipairs(var_6_0.group_2) do
		local var_6_4 = (self.taskProxy:getTaskById(iter_6_3) or self.taskProxy:getFinishTaskById(iter_6_3)):getTaskStatus()

		if var_6_4 == 0 or var_6_4 == 1 or iter_6_2 == var_6_3 then
			table.insert(self.taskGroup, iter_6_3)

			self.allCompleteCount = self.allCompleteCount + (iter_6_2 == var_6_3 and var_6_4 == 2 and iter_6_2 or iter_6_2 - 1)

			break
		end
	end

	return
end

function SailingShip3SkinLayer:UpdateTask(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:Find("item")
	local var_7_1 = self.taskProxy:getTaskById(self.taskGroup[arg_7_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[arg_7_1 + 1])

	assert(var_7_1, "without this task by id: " .. self.taskGroup[arg_7_1 + 1])

	local var_7_2 = Drop.Create(var_7_1:getConfig("award_display")[1])

	updateDrop(var_7_0, var_7_2)
	onButton(self, var_7_0, function()
		self:emit(BaseUI.ON_DROP, var_7_2)

		return
	end, SFX_PANEL)

	local var_7_3 = var_7_1:getProgress()
	local var_7_4 = var_7_1:getConfig("target_num")

	if self.allCompleteCount == 8 then
		var_7_3 = var_7_4
	end

	local var_7_5, var_7_6 = self:GetProgressColor()
	local var_7_7

	var_7_7 = var_7_5 and setColorStr(var_7_3, var_7_5) or var_7_3

	local var_7_8

	var_7_8 = var_7_6 and setColorStr("/" .. var_7_4, var_7_6) or "/" .. var_7_4

	setActive(arg_7_2:Find("progressText"), false)
	setText(arg_7_2:Find("description"), var_7_1:getConfig("desc") .. " (" .. var_7_7 .. var_7_8 .. ")")
	setSlider(arg_7_2:Find("progress"), 0, var_7_4, var_7_3)

	local var_7_9 = arg_7_2:Find("go_btn")
	local var_7_10 = arg_7_2:Find("get_btn")
	local var_7_11 = arg_7_2:Find("got_btn")
	local var_7_12 = var_7_1:getTaskStatus()

	if self.allCompleteCount == 8 then
		var_7_12 = 2
	end

	setActive(var_7_9, var_7_12 == 0)
	setActive(var_7_10, var_7_12 == 1)
	setActive(var_7_11, var_7_12 == 2)
	onButton(self, var_7_9, function()
		self:emit(SailingShip3SkinMediator.ON_TASK_GO, var_7_1)

		return
	end, SFX_PANEL)
	onButton(self, var_7_10, function()
		local var_10_0 = {}
		local var_10_1 = var_7_1:getConfig("award_display")
		local var_10_2 = getProxy(PlayerProxy):getRawData()
		local var_10_3, var_10_4 = Task.StaticJudgeOverflow(var_10_2.gold, var_10_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_10_1)

		if var_10_3 then
			table.insert(var_10_0, function(arg_11_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_10_4,
					onYes = arg_11_0
				})

				return
			end)
		end

		seriesAsync(var_10_0, function()
			self:emit(SailingShip3SkinMediator.ON_TASK_SUBMIT, var_7_1)

			return
		end)

		return
	end, SFX_PANEL)
	setActive(arg_7_2:Find("reddot"), self.allCompleteCount < 8 and var_7_12 == 1)

	return
end

function SailingShip3SkinLayer:DisplayBigTask()
	local var_13_0 = self.activity:getConfig("config_client").group_3[1]
	local var_13_1 = self.taskProxy:getTaskById(var_13_0) or self.taskProxy:getFinishTaskById(var_13_0)

	assert(var_13_1, "without this task by id: " .. var_13_0)

	local var_13_2 = self._tf:Find("task/allTaskItem")
	local var_13_3 = Drop.Create(var_13_1:getConfig("award_display")[1])

	updateDrop(var_13_2, var_13_3)
	onButton(self, var_13_2, function()
		self:emit(BaseUI.ON_DROP, var_13_3)

		return
	end, SFX_PANEL)
	setActive(self._tf:Find("task/taskAll/taskallReward"), var_13_1:getTaskStatus() == 2)

	return
end

function SailingShip3SkinLayer:GetProgressColor()
	return nil
end

function SailingShip3SkinLayer:InitStoryState()
	for iter_16_0, iter_16_1 in ipairs(self.story) do
		if checkExist(self.story, {
			iter_16_0
		}, {
			1
		}) then
			self.storyStateDic[pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_16_1[1])] = not not pg.NewStoryMgr.GetInstance():IsPlayed(iter_16_1[1])
		end
	end

	return
end

function SailingShip3SkinLayer:UpdateStoryView()
	for iter_17_0, iter_17_1 in ipairs({
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8"
	}) do
		local var_17_0 = pg.NewStoryMgr.GetInstance()
		local var_17_1 = var_17_0:StoryName2StoryId(self.story[iter_17_0][1])
		local var_17_2 = self._tf:Find("frame/" .. iter_17_1 .. "/locked")
		local var_17_3 = self._tf:Find("frame/" .. iter_17_1)

		setActive(var_17_0, not self.storyStateDic[var_17_1])

		if self.storyStateDic[var_17_1] then
			onButton(self, var_17_3, function()
				pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_17_1), nil, true)

				return
			end)
		else
			onButton(self, var_17_2, function()
				if getProxy(ActivityProxy):getActivityById(var_0_1).data1 <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("activity_1024_memory"))

					return
				end

				pg.m02:sendNotification(GAME.ACTIVITY_UNLOCKSTORY, {
					cmd = 1,
					activity_id = self.activity.id,
					arg1 = var_17_1
				})

				return
			end)
		end
	end

	return
end

function SailingShip3SkinLayer:UpdateItemView(arg_20_1)
	setText(self._tf:Find("des/count"), tostring(arg_20_1.data1))

	return
end

function SailingShip3SkinLayer:UpdataStoryState(arg_21_1)
	local var_21_0 = arg_21_1.storyId

	self.storyStateDic[arg_21_1.storyId] = true

	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(self.story) do
		if pg.NewStoryMgr.GetInstance():StoryName2StoryId(iter_21_1[1]) == arg_21_1.storyId then
			var_21_1 = iter_21_0
		end
	end

	for iter_21_2, iter_21_3 in ipairs({
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8"
	}) do
		if iter_21_2 == var_21_1 then
			local var_21_2 = self.storyStateDic[arg_21_1.storyId]
			local var_21_3 = self._tf:Find("frame/" .. iter_21_3 .. "/locked")
			local var_21_4 = self._tf:Find("frame/" .. iter_21_3)
			local var_21_5 = var_21_3:GetComponent(typeof(Animation))
			local var_21_6 = var_21_5:GetClip("anim_GhostSkin_unlock_1").length

			var_21_5:Play("anim_GhostSkin_unlock_1")
			self:ShowMask(true)

			self.isPlaying = true

			onDelayTick(function()
				self.isPlaying = false

				setActive(var_21_3, not var_21_2)
				self:ShowMask(false)
				pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_21_0), function()
					self:ShouldRewardAll(false)

					return
				end)

				return
			end, var_21_6)
			onButton(self, var_21_4, function()
				pg.NewStoryMgr.GetInstance():Play(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_21_0), nil, true)

				return
			end)
		end
	end

	return
end

function SailingShip3SkinLayer:ShouldRewardAll(arg_25_1)
	if (function()
		for iter_26_0, iter_26_1 in pairs(self.storyStateDic) do
			if iter_26_1 == false then
				return false
			end
		end

		return true
	end)() and (function()
		if not arg_25_1 then
			return true
		end

		local var_27_0 = self.activity:getConfig("config_client").group_3[1]
		local var_27_1 = self.taskProxy:getTaskById(var_27_0) or self.taskProxy:getFinishTaskById(var_27_0)

		assert(var_27_1, "without this task by id: " .. var_27_0)

		if var_27_1:getTaskStatus() == 1 then
			return true
		end

		return false
	end)() then
		local var_25_0 = {}
		local var_25_1 = self.activity:getConfig("config_client").group_3[1]
		local var_25_2 = self.taskProxy:getTaskById(var_25_1) or self.taskProxy:getFinishTaskById(var_25_1)
		local var_25_3 = var_25_2:getConfig("award_display")
		local var_25_4 = getProxy(PlayerProxy):getRawData()
		local var_25_5, var_25_6 = Task.StaticJudgeOverflow(var_25_4.gold, var_25_4.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_25_3)

		if var_25_5 then
			table.insert(var_25_0, function(arg_28_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_25_6,
					onYes = arg_28_0
				})

				return
			end)
		end

		seriesAsync(var_25_0, function()
			self:emit(SailingShip3SkinMediator.ON_TASK_SUBMIT, var_25_2)

			return
		end)
	end

	return
end

function SailingShip3SkinLayer:didEnter()
	onButton(self, self._tf:Find("title/back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	self:ShouldRewardAll(true)

	return
end

function SailingShip3SkinLayer:ShowMask(arg_32_1)
	GetOrAddComponent(self._tf:Find("mask"), typeof(CanvasGroup)).blocksRaycasts = arg_32_1

	return
end

function SailingShip3SkinLayer:onBackPressed()
	if self.isPlaying then
		return
	end

	self.super.onBackPressed(self)

	return
end

function SailingShip3SkinLayer.ShouldShowTip()
	local var_34_0 = getProxy(TaskProxy)
	local var_34_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SAILING_SHIP_3_SKIN_ACT_ID):getConfig("config_client")
	local var_34_2 = 0
	local var_34_3 = false

	for iter_34_0, iter_34_1 in ipairs(var_34_1.group_1) do
		local var_34_4 = var_34_0:getTaskById(iter_34_1) or var_34_0:getFinishTaskById(iter_34_1)

		if var_34_4 then
			local var_34_5 = var_34_4:getTaskStatus()

			if var_34_5 == 2 then
				var_34_2 = var_34_2 + 1
			elseif var_34_5 == 1 then
				var_34_3 = true
			end
		end
	end

	for iter_34_2, iter_34_3 in ipairs(var_34_1.group_2) do
		local var_34_6 = var_34_0:getTaskById(iter_34_3) or var_34_0:getFinishTaskById(iter_34_3)

		if var_34_6 then
			local var_34_7 = var_34_6:getTaskStatus()

			if var_34_7 == 2 then
				var_34_2 = var_34_2 + 1
			elseif var_34_7 == 1 then
				var_34_3 = true
			end
		end
	end

	return var_34_2 < 8 and var_34_3
end

return SailingShip3SkinLayer
