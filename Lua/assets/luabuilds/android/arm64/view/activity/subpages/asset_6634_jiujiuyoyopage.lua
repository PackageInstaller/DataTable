local JiujiuYoyoPage = class("JiujiuYoyoPage", import("...base.BaseActivityPage"))
local var_0_1 = PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT

function JiujiuYoyoPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.helpBtn = self.bg:Find("help_btn")
	self.taskBtn = self.bg:Find("task_btn")
	self.taskRedDot = self.taskBtn:Find("red_dot")
	self.ticketNumTF = self.bg:Find("ticket_num")
	self.rollingCountTF = self.bg:Find("rolling_count")
	self.rollingBlink = self.bg:Find("blink")

	if var_0_1 then
		self.awardTpl = self.bg:Find("item_jp")
		self.awardContainter = self.bg:Find("award_list_jp")
	else
		self.awardTpl = self.bg:Find("item")
		self.awardContainter = self.bg:Find("award_list")
	end

	self.awardUIList = UIItemList.New(self.awardContainter, self.awardTpl)
	self.finalGot = self.bg:Find("final_got_jp")
	self.rollingAni = self.bg:Find("rolling_mask")
	self.rollingSpine = self.rollingAni:Find("rolling"):GetComponent("SpineAnimUI")
	self.rollingGraphic = self.rollingAni:Find("rolling"):GetComponent("SkeletonGraphic")
	self.forbidMask = self.bg:Find("forbid_mask")
	self.taskWindow = self._tf:Find("TaskWindow")
	self.closeBtn = self.taskWindow:Find("panel/close_btn")
	self.taskTpl = self.taskWindow:Find("panel/scrollview/item")
	self.taskContainter = self.taskWindow:Find("panel/scrollview/items")
	self.taskUIList = UIItemList.New(self.taskContainter, self.taskTpl)

	self:register()

	return
end

function JiujiuYoyoPage:register()
	self:bind(ActivityMediator.ON_SHAKE_BEADS_RESULT, function(arg_3_0, arg_3_1)
		self:displayResult(arg_3_1.awards, arg_3_1.number, function()
			arg_3_1.callback()

			return
		end)

		return
	end)

	return
end

function JiujiuYoyoPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = pg.activity_template[self.activity:getConfig("config_client").taskActID].config_data
	self.startTime = self.activity:getStartTime()
	self.totalNumList = {}
	self.remainNumList = {}
	self.remainTotalNum = 0
	self.awardList = {}
	self.finalAward = self.activity:getConfig("config_client").finalAward
	self.awardConifg = self.activity:getConfig("config_client").award
	self.beadsConfig = self.activity:getConfig("config_data")[1]

	for iter_5_0, iter_5_1 in ipairs(self.beadsConfig) do
		self.awardList[iter_5_1[1]] = self.awardConifg[iter_5_1[1]]
		self.totalNumList[iter_5_1[1]] = iter_5_1[2]
	end

	return
end

function JiujiuYoyoPage:OnFirstFlush()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("tips_shakebeads")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self:openTask()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closeTask()

		return
	end, SFX_PANEL)
	onButton(self, self.taskWindow:Find("mask"), function()
		self:closeTask()

		return
	end, SFX_PANEL)
	onButton(self, self.rollingBlink, function()
		if self.ticketNum <= 0 then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	setActive(self.taskRedDot, false)

	if LeanTween.isTweening(self.rollingBlink) then
		LeanTween.cancel(self.rollingBlink)
	end

	setImageAlpha(self.rollingBlink, 1)
	blinkAni(self.rollingBlink, 0.5)

	return
end

function JiujiuYoyoPage:OnUpdateFlush()
	self.curDay = pg.TimeMgr.GetInstance():DiffDay(self.startTime, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	self.ticketNum = self.activity.data1
	self.hasNumList = self.activity.data1KeyValueList[1]
	self.remainTotalNum = 0

	for iter_12_0, iter_12_1 in ipairs(self.beadsConfig) do
		self.hasNumList[iter_12_1[1]] = self.hasNumList[iter_12_1[1]] or 0
		self.remainNumList[iter_12_1[1]] = self.totalNumList[iter_12_1[1]] - self.hasNumList[iter_12_1[1]]
		self.remainTotalNum = self.remainTotalNum + self.remainNumList[iter_12_1[1]]
	end

	setText(self.ticketNumTF, self.ticketNum)
	setText(self.rollingCountTF, self.remainTotalNum)
	setActive(self.rollingBlink, self.ticketNum > 0)
	self:initAwardList()
	self:initTaskWindow()

	self.isFirst = PlayerPrefs.GetInt("jiujiuyoyo_first_" .. getProxy(PlayerProxy):getData().id)

	if self.isFirst == 0 then
		setActive(self.taskRedDot, true)
	end

	if #self.finishItemList > 0 then
		self:openTask()
	end

	setActive(self.finalGot, var_0_1 and self.activity.data2 == 1)
	self:CheckFinalAward()

	return
end

function JiujiuYoyoPage:initAwardList()
	self.awardUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = arg_14_1 + 1
			local var_14_1 = self.remainNumList[arg_14_1 + 1]

			if self.remainNumList[arg_14_1 + 1] == 0 then
				setTextColor(arg_14_2:Find("num"), Color.New(0.55, 0.55, 0.55, 1))
				setOutlineColor(arg_14_2:Find("num"), Color.New(0.26, 0.26, 0.26, 1))
			end

			setText(arg_14_2:Find("num"), var_14_1 .. "/" .. self.totalNumList[arg_14_1 + 1])
			setActive(arg_14_2:Find("got"), var_14_1 == 0)

			local var_14_2 = arg_14_2:Find("award_mask/award")
			local var_14_3 = {
				type = self.awardList[var_14_0][1],
				id = self.awardList[var_14_0][2],
				count = self.awardList[var_14_0][3] * var_14_1
			}

			updateDrop(var_14_2, var_14_3)
			onButton(self, var_14_2, function()
				self:emit(BaseUI.ON_DROP, var_14_3)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.awardUIList:align(#self.awardList)

	return
end

function JiujiuYoyoPage:initTaskWindow()
	self.finishItemList = {}
	self.finishTaskVOList = {}

	self.taskUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_17_1 + 1
			local var_17_1 = arg_17_2:Find("award/award")
			local var_17_2 = self.taskProxy:getTaskById(self.taskList[arg_17_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskList[arg_17_1 + 1])

			assert(var_17_2, "without this task by id: " .. self.taskList[arg_17_1 + 1])

			local var_17_3 = var_17_2:getProgress()
			local var_17_4 = var_17_2:getConfig("target_num")
			local var_17_5 = var_17_2:getTaskStatus()
			local var_17_6 = var_17_2:getConfig("award_display")[1]
			local var_17_7 = var_17_0 > self.curDay

			setText(arg_17_2:Find("description"), (var_17_2:getConfig("desc")))
			setText(arg_17_2:Find("progress/progressText"), var_17_3 .. "/" .. var_17_4)
			setSlider(arg_17_2:Find("progress"), 0, var_17_4, var_17_3)

			local var_17_8 = {
				type = var_17_6[1],
				id = var_17_6[2],
				count = var_17_6[3]
			}

			updateDrop(var_17_1, var_17_8)
			onButton(self, arg_17_2:Find("award/Image"), function()
				self:emit(BaseUI.ON_DROP, var_17_8)

				return
			end, SFX_PANEL)

			local var_17_9 = arg_17_2:Find("go_btn")
			local var_17_10 = arg_17_2:Find("get_btn")

			setActive(var_17_9, var_17_5 == 0)
			setActive(var_17_10, var_17_5 == 1)
			onButton(self, var_17_9, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_17_2)

				return
			end, SFX_PANEL)
			onButton(self, var_17_10, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_17_2)

				return
			end, SFX_PANEL)
			setActive(arg_17_2:Find("finnal"), var_17_5 == 2 and not var_17_7)
			setText(arg_17_2:Find("lock/tip"), i18n("unlock_tips", var_17_0))
			setActive(arg_17_2:Find("lock"), var_17_7)

			if var_17_5 == 1 and not var_17_7 then
				table.insert(self.finishItemList, arg_17_2)
				table.insert(self.finishTaskVOList, var_17_2)
			end
		end

		return
	end)
	self.taskUIList:align(#self.taskList)

	return
end

function JiujiuYoyoPage:closeTask()
	setActive(self.taskWindow, false)

	return
end

function JiujiuYoyoPage:openTask()
	setActive(self.taskWindow, true)

	if self.isFirst == 0 then
		PlayerPrefs.SetInt("jiujiuyoyo_first_" .. getProxy(PlayerProxy):getData().id, 1)
		setActive(self.taskRedDot, false)
	end

	self.hasClickTask = true

	eachChild(self.taskContainter, function(arg_23_0)
		if isActive(arg_23_0:Find("finnal")) then
			arg_23_0:SetAsLastSibling()
		end

		return
	end)

	if #self.finishItemList > 0 then
		self:autoFinishTask()
	end

	return
end

function JiujiuYoyoPage:autoFinishTask()
	local var_24_0 = 0.01
	local var_24_1 = 0.5

	for iter_24_0, iter_24_1 in ipairs(self.finishItemList) do
		local var_24_2 = GetOrAddComponent(iter_24_1, typeof(CanvasGroup))

		self:managedTween(LeanTween.delayedCall, function()
			iter_24_1:SetAsFirstSibling()
			LeanTween.value(go(iter_24_1), 1, 0, var_24_1):setOnUpdate(System.Action_float(function(arg_26_0)
				var_24_2.alpha = arg_26_0

				return
			end)):setOnComplete(System.Action(function()
				var_24_2.alpha = 1

				setActive(iter_24_1:Find("finnal"), true)
				iter_24_1:SetAsLastSibling()

				return
			end))

			return
		end, var_24_0, nil)

		var_24_0 = var_24_0 + 0.5 + 0.1
	end

	self:managedTween(LeanTween.delayedCall, function()
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = self.finishTaskVOList
		})

		return
	end, var_24_0, nil)

	return
end

function JiujiuYoyoPage:CheckFinalAward()
	if var_0_1 and self.activity.data2 == 0 and self.remainTotalNum == 0 then
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = self.activity.id
		})
	end

	return
end

function JiujiuYoyoPage:displayResult(arg_30_1, arg_30_2, arg_30_3)
	self:setForbidMaskStatus(true)
	setActive(self.rollingAni, true)

	function self.aniCallback()
		arg_30_3()

		return
	end

	self.rollingSpine:SetActionCallBack(function(arg_32_0)
		if arg_32_0 == "finish" then
			setActive(self.rollingAni, false)
			arg_30_3()

			self.aniCallback = nil

			self:setForbidMaskStatus(false)
		end

		return
	end)
	self.rollingSpine:SetAction(tostring(arg_30_2), 0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/zhuanzhu")
	self:managedTween(LeanTween.delayedCall, function()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/zhengque")

		return
	end, 4, nil)

	return
end

function JiujiuYoyoPage:setForbidMaskStatus(arg_34_1)
	if arg_34_1 then
		setActive(self.forbidMask, true)
		pg.UIMgr.GetInstance():OverlayPanel(self.forbidMask)
	else
		setActive(self.forbidMask, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.forbidMask, self.bg)
	end

	return
end

function JiujiuYoyoPage.canFinishTask()
	local var_35_0 = pg.TimeMgr.GetInstance():DiffDay(pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[ActivityConst.JIUJIU_YOYO_ID].time[2]), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	local var_35_1 = false
	local var_35_2 = getProxy(TaskProxy)

	for iter_35_0, iter_35_1 in pairs(pg.activity_template[pg.activity_template[ActivityConst.JIUJIU_YOYO_ID].config_client.taskActID].config_data) do
		local var_35_3 = var_35_0 < iter_35_0
		local var_35_4 = var_35_2:getTaskById(iter_35_1) or var_35_2:getFinishTaskById(iter_35_1)

		assert(var_35_4, "without this task by id: " .. iter_35_1)

		if var_35_4:getTaskStatus() == 1 and not var_35_3 then
			var_35_1 = true

			break
		end
	end

	return var_35_1
end

function JiujiuYoyoPage.IsShowRed()
	return getProxy(ActivityProxy):getActivityById(ActivityConst.JIUJIU_YOYO_ID).data1 > 0 or JiujiuYoyoPage.canFinishTask()
end

return JiujiuYoyoPage
