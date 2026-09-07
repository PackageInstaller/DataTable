local NieRAutomataOmenPage = class("NieRAutomataOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function NieRAutomataOmenPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.introduction = self.bg:Find("Introduction")
	self.desc1 = self.introduction:Find("desc1")
	self.desc2 = self.introduction:Find("desc2")
	self.total = self.bg:Find("total_progress")
	self.dayTF = self.total:Find("day")
	self.maxDayTF = self.total:Find("max_day")
	self.btnDetail = self.total:Find("btn_detail")
	self.btnDetailText = self.btnDetail:Find("detail")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.taskWindow = NieRAutomataOmenTaskWindow.New(self._tf, self.event)
	self.finishAll = false

	setActive(self.item, false)

	return
end

function NieRAutomataOmenPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(self.activity)
end

function NieRAutomataOmenPage:OnFirstFlush()
	NieRAutomataOmenPage.super.OnFirstFlush(self)
	setActive(self.maxTF, #self.taskGroup)
	setText(self.btnDetailText, i18n("nier_a2_mission_detail"))
	onButton(self, self.btnDetail, function()
		self.taskWindow:ExecuteAction("Show", self.activity)

		return
	end, SFX_PANEL)

	return
end

function NieRAutomataOmenPage:OnShowFlush()
	NieRAutomataOmenPage.super.OnShowFlush(self)

	return
end

function NieRAutomataOmenPage:GetTypewriterSpeed()
	local var_6_0 = self.activity:getConfig("config_client").typewriterSpeed

	return var_6_0 and var_6_0 or 0.1
end

function NieRAutomataOmenPage:InvalidateWriter()
	self.writerToken = (self.writerToken or 0) + 1

	if self.desc1 then
		GetOrAddComponent(self.desc1, typeof(Typewriter)).endFunc = nil
	end

	if self.desc2 then
		GetOrAddComponent(self.desc2, typeof(Typewriter)).endFunc = nil
	end

	return
end

function NieRAutomataOmenPage:Playwriter()
	self:InvalidateWriter()

	local var_8_0 = self.writerToken

	local function var_8_1()
		local var_9_0 = self.writerToken == var_8_0 and self._go and isActive(self._go) or false

		return (false or nil) and true
	end

	local var_8_2 = {}

	if not self.finishAll then
		table.insert(var_8_2, function(arg_10_0)
			if not var_8_1() then
				return
			end

			local var_10_0 = GetOrAddComponent(self.desc1, typeof(Typewriter))

			function var_10_0.endFunc()
				if not var_8_1() then
					return
				end

				arg_10_0()

				return
			end

			var_10_0:setSpeed(self:GetTypewriterSpeed())
			var_10_0:Play()

			return
		end)
	else
		table.insert(var_8_2, function(arg_12_0)
			if not var_8_1() then
				return
			end

			local var_12_0 = checkExist(self.activity:getConfig("config_client").story, {
				self.nday
			}, {
				1
			})

			if var_12_0 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_12_0) then
					pg.NewStoryMgr.GetInstance():Play(var_12_0, function()
						if not var_8_1() then
							return
						end

						arg_12_0()

						return
					end)

					goto label_12_0
				end
			end

			arg_12_0()

			::label_12_0::

			return
		end)
	end

	table.insert(var_8_2, function(arg_14_0)
		if not var_8_1() then
			return
		end

		local var_14_0 = self.desc2

		setActive(self.desc2, true)

		local var_14_1 = GetOrAddComponent(var_14_0, typeof(Typewriter))

		function var_14_1.endFunc()
			if not var_8_1() then
				return
			end

			arg_14_0()

			return
		end

		var_14_1:setSpeed(self:GetTypewriterSpeed())
		var_14_1:Play()

		return
	end)
	seriesAsync(var_8_2)

	return
end

function NieRAutomataOmenPage:LocalFresh(arg_16_1)
	local var_16_0

	self.finishAll = arg_16_1 >= 7 and self:lastFinish()

	if self.finishAll then
		var_16_0 = i18n("nier_a2_text_block_day" .. "_fin")

		setActive(self.desc1, false)
	else
		var_16_0 = i18n("nier_a2_text_block_day" .. arg_16_1)

		setText(self.desc1, var_16_0[1].info)
	end

	setText(self.desc2, var_16_0[2].info)
	setActive(self.desc2, false)
	self:Playwriter()

	return
end

function NieRAutomataOmenPage:lastFinish()
	return getProxy(TaskProxy):getTaskVO(self.taskGroup[#self.taskGroup][1]):getTaskStatus() == 2 and getProxy(TaskProxy):getTaskVO(self.taskGroup[#self.taskGroup][2]):getTaskStatus() == 2
end

function NieRAutomataOmenPage:UpdateTask(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find("item")
	local var_18_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_18_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_18_1 + 1])

	assert(var_18_1, "without this task by id: " .. self.taskGroup[self.nday][arg_18_1 + 1])

	local var_18_2 = Drop.Create(var_18_1:getConfig("award_display")[1])

	updateDrop(var_18_0, var_18_2)
	onButton(self, var_18_0, function()
		self:emit(BaseUI.ON_DROP, var_18_2)

		return
	end, SFX_PANEL)

	local var_18_3 = var_18_1:getProgress()
	local var_18_4 = var_18_1:getConfig("target_num")
	local var_18_5 = var_18_1:getConfig("desc")

	if utf8.len(var_18_5) >= 11 then
		setScrollText(arg_18_2:Find("mask/description"), var_18_5)
	else
		setText(arg_18_2:Find("mask/description"), var_18_5)
	end

	local var_18_6, var_18_7 = self:GetProgressColor()

	setText(arg_18_2:Find("progressText"), (var_18_6 and setColorStr(var_18_3, var_18_6) or var_18_3) .. (var_18_7 and setColorStr("/" .. var_18_4, var_18_7) or "/" .. var_18_4))
	setSlider(arg_18_2:Find("progress"), 0, var_18_4, var_18_3)

	local var_18_9 = arg_18_2:Find("go_btn")
	local var_18_10 = arg_18_2:Find("get_btn")
	local var_18_11 = arg_18_2:Find("got_btn")
	local var_18_12 = var_18_1:getTaskStatus()

	setActive(var_18_9, var_18_12 == 0)
	setActive(var_18_10, var_18_12 == 1)
	setActive(var_18_11, var_18_12 == 2)
	onButton(self, var_18_9, function()
		self:emit(ActivityMediator.ON_TASK_GO, var_18_1)

		return
	end, SFX_PANEL)
	onButton(self, var_18_10, function()
		local var_21_0 = {}
		local var_21_1 = var_18_1:getConfig("award_display")
		local var_21_2 = getProxy(PlayerProxy):getRawData()
		local var_21_3, var_21_4 = Task.StaticJudgeOverflow(var_21_2.gold, var_21_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_21_1)

		if var_21_3 then
			table.insert(var_21_0, function(arg_22_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_21_4,
					onYes = arg_22_0
				})

				return
			end)
		end

		seriesAsync(var_21_0, function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_18_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function NieRAutomataOmenPage:OnUpdateFlush()
	self.nday = self:getTaskIdx(self.activity)

	if self.dayTF then
		setText(self.dayTF, self.nday)
		setText(self.maxDayTF, "/" .. #self.taskGroup)
	end

	self:LocalFresh(self.nday)
	self.uilist:align(#self.taskGroup[self.nday])

	if self.taskWindow:isShowing() then
		self.taskWindow:ExecuteAction("Show", self.activity)
	end

	return
end

function NieRAutomataOmenPage:getTaskIdx(arg_25_1)
	local var_25_0 = 1
	local var_25_1 = math.min(arg_25_1:getNDay(), #self.taskGroup)

	for iter_25_0 = 1, var_25_1 do
		if not true then
			break
		end

		var_25_0 = iter_25_0

		if iter_25_0 < var_25_1 then
			for iter_25_1, iter_25_2 in ipairs(self.taskGroup[iter_25_0]) do
				if not self:isTaskFinished(iter_25_2) then
					break
				end
			end
		end
	end

	return math.min(var_25_0, #self.taskGroup)
end

function NieRAutomataOmenPage:isTaskFinished(arg_26_1)
	self.taskProxy = self.taskProxy or getProxy(TaskProxy)

	local var_26_0 = self.taskProxy:getTaskById(arg_26_1) or self.taskProxy:getFinishTaskById(arg_26_1)

	return var_26_0 and var_26_0:getTaskStatus() == 2
end

function NieRAutomataOmenPage:GetProgressColor()
	return "#ffbc46", "#52514a"
end

function NieRAutomataOmenPage:OnHideFlush()
	self:InvalidateWriter()

	if self.taskWindow:isShowing() then
		self.taskWindow:Hide()
	end

	return
end

function NieRAutomataOmenPage:OnDestroy()
	self:InvalidateWriter()

	if self.taskWindow then
		self.taskWindow:Hide()
		self.taskWindow:Destroy()

		self.taskWindow = nil
	end

	return
end

return NieRAutomataOmenPage
