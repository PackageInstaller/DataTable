local GuildOfficeTaskPage = class("GuildOfficeTaskPage", import("...base.GuildBasePage"))

function GuildOfficeTaskPage:getTargetUI()
	return "GuildOfficeTaskBluePage", "GuildOfficeTaskRedPage"
end

function GuildOfficeTaskPage:OnLoaded()
	self.selectTaskPage = GuildOfficeSelectTaskPage.New(self._tf.parent, self.event)
	self.taskTF = self._tf:Find("TaskPanel")
	self.taskUnOpenTF = self._tf:Find("TaskPanel/unopen")
	self.unOpenAdmin = self.taskUnOpenTF:Find("select")
	self.unOpenUnAdmin = self.taskUnOpenTF:Find("lock")
	self.taskOpenTF = self._tf:Find("TaskPanel/open")
	self.taskDescTxt = self.taskOpenTF:Find("top/desc/Text"):GetComponent(typeof(Text))
	self.taskAwardTxt = self.taskOpenTF:Find("top/desc1/Text"):GetComponent(typeof(Text))
	self.taskProgressTxt = self.taskOpenTF:Find("top/progress"):GetComponent(typeof(Text))
	self.taskProgressBar = self.taskOpenTF:Find("top/progress_bar")
	self.privateTaskDesc = self.taskOpenTF:Find("bottom/desc"):GetComponent(typeof(Text))
	self.privateTaskGetBtn = self.taskOpenTF:Find("bottom/get")
	self.privateTaskAcceptBtn = self.taskOpenTF:Find("bottom/accept")
	self.privateTaskProgressTxt = self.taskOpenTF:Find("bottom/progress/Text"):GetComponent(typeof(Text))
	self.privateTaskReapeatFlag = self.taskOpenTF:Find("bottom/reapeat")
	self.privateTaskResTxt = self.taskOpenTF:Find("bottom/res/Text"):GetComponent(typeof(Text))
	self.taskMaskAll = self._tf:Find("TaskPanel/open/mask_all")
	self.taskMaskTop = self._tf:Find("TaskPanel/open/mask_top")
	self.contributionList = UIItemList.New(self._tf:Find("TaskPanel/SubmitPanel/list"), self._tf:Find("TaskPanel/SubmitPanel/list/tpl"))
	self.contributionCntTxt = self._tf:Find("TaskPanel/SubmitPanel/cnt/Text"):GetComponent(typeof(Text))
	self.supplyFrame = self._tf:Find("TaskPanel/SupplyPanel/frame")
	self.supplyOpenTF = self._tf:Find("TaskPanel/SupplyPanel/frame/open")
	self.supplyOpenTimeTxt = self.supplyOpenTF:Find("time"):GetComponent(typeof(Text))
	self.supplyOpenLetfCntTxt = self.supplyOpenTF:Find("Text"):GetComponent(typeof(Text))
	self.supplyOpenGetBtn = self.supplyOpenTF:Find("get")
	self.supplyOpenGotBtn = self.supplyOpenTF:Find("got")
	self.supplyUnOpenTF = self._tf:Find("TaskPanel/SupplyPanel/frame/unopen")
	self.supplyUnOpenAdminTF = self.supplyUnOpenTF:Find("purchase")
	self.supplyUnOpenResTF = self.supplyUnOpenAdminTF:Find("Text"):GetComponent(typeof(Text))
	self.supplyUnOpenLockTF = self.supplyUnOpenTF:Find("lock")

	return
end

function GuildOfficeTaskPage:OnInit()
	pg.UIMgr.GetInstance():OverlayPanel(self.taskTF, {
		pbList = {
			self.taskTF
		},
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})
	onButton(self, self.supplyUnOpenAdminTF, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_start_supply_consume_tip", (self.guild:getSupplyConsume())),
			onYes = function()
				self:emit(GuildOfficeMediator.ON_PURCHASE_SUPPLY)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.supplyOpenGetBtn, function()
		self:emit(GuildOfficeMediator.GET_SUPPLY_AWARD)

		return
	end, SFX_PANEL)
	onButton(self, self.supplyFrame, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_supply_help_tip.tip
		})

		return
	end, SFX_PANEL)

	return
end

function GuildOfficeTaskPage:Update(arg_8_1, arg_8_2)
	self:OnUpdateGuild(arg_8_1, arg_8_2)
	self:UpdateTaskPanel(false)
	self:UpdateContributionPanel()
	self:UpdateSupplyPanel()
	self:Show()

	return
end

function GuildOfficeTaskPage:OnUpdateGuild(arg_9_1, arg_9_2)
	self.guild = arg_9_1
	self.isAdmin = arg_9_2

	return
end

function GuildOfficeTaskPage:OnUpdateContribution()
	self:UpdateContributionPanel()

	return
end

function GuildOfficeTaskPage:OnUpdateTask(arg_11_1)
	self:UpdateTaskPanel(arg_11_1)

	return
end

function GuildOfficeTaskPage:OnUpdateSupplyPanel()
	self:UpdateSupplyPanel()

	return
end

function GuildOfficeTaskPage:UpdateTaskPanel(arg_13_1)
	local var_13_0 = self.guild:getWeeklyTask()
	local var_13_1 = var_13_0:getState()

	if var_13_1 == GuildTask.STATE_EMPTY then
		self:UpdateLockTask()
	elseif var_13_1 == GuildTask.STATE_ONGOING or var_13_1 == GuildTask.STATE_FINISHED then
		self:UpdatePubliceTask(var_13_0)
		self:UpdatePrivateTask(var_13_0)
	end

	setActive(self.taskOpenTF, var_13_1 ~= GuildTask.STATE_EMPTY)
	setActive(self.taskUnOpenTF, var_13_1 == GuildTask.STATE_EMPTY)

	if arg_13_1 or self.guild:shouldRefreshWeeklyTaskProgress() then
		self:emit(GuildOfficeMediator.UPDATE_WEEKLY_TASK)
	end

	return
end

function GuildOfficeTaskPage:UpdateLockTask()
	setActive(self.unOpenAdmin, self.isAdmin)
	setActive(self.unOpenUnAdmin, not self.isAdmin)

	if self.isAdmin then
		onButton(self, self.unOpenAdmin, function()
			self.selectTaskPage:ExecuteAction("Show", self.guild, self.isAdmin)

			return
		end, SFX_PANEL)
	end

	return
end

function GuildOfficeTaskPage:UpdatePrivateTask(arg_16_1)
	local var_16_0 = not self.guild:hasWeeklyTaskFlag()
	local var_16_1 = arg_16_1:GetPresonTaskId()
	local var_16_2 = getProxy(TaskProxy)
	local var_16_3 = var_16_2:getTaskById(var_16_1) or var_16_2:getFinishTaskById(var_16_1)
	local var_16_4 = var_16_3 ~= nil

	if var_16_3 == nil then
		var_16_3 = Task.New({
			id = var_16_1
		})
	end

	self.privateTaskDesc.text = var_16_3:getConfig("desc")
	self.privateTaskProgressTxt.text = var_16_3.progress .. "/" .. var_16_3:getConfig("target_num")
	self.privateTaskResTxt.text = arg_16_1:GetPrivateAward()

	onButton(self, self.privateTaskAcceptBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_task_accept", arg_16_1:getConfig("name"), var_16_3:getConfig("name"), var_16_3:getConfig("name")),
			onYes = function()
				self:emit(GuildOfficeMediator.ON_ACCEPT_TASK, var_16_1)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.privateTaskGetBtn, function()
		self:emit(GuildOfficeMediator.ON_SUBMIT_TASK, var_16_1)

		return
	end, SFX_PANEL)

	if var_16_3:isFinish() and not var_16_3:isReceive() and not var_16_0 then
		self:emit(GuildOfficeMediator.ON_SUBMIT_TASK, var_16_1)
	elseif not var_16_4 and var_16_0 then
		self:emit(GuildOfficeMediator.ON_ACCEPT_TASK, var_16_1)
	end

	local var_16_5 = not var_16_0
	local var_16_6 = arg_16_1:isFinished() and (not var_16_4 or not var_16_0)

	setActive(self.taskMaskAll, var_16_6)
	setActive(self.taskMaskTop, not var_16_6 and arg_16_1:isFinished())
	setActive(self.privateTaskReapeatFlag, var_16_5)
	setActive(self.privateTaskResTxt.gameObject.transform.parent, not var_16_5)
	setActive(self.privateTaskAcceptBtn, not var_16_4 or var_16_3:isReceive())
	setActive(self.privateTaskGetBtn, var_16_4 and var_16_3:isFinish() and not var_16_3:isReceive())
	setActive(self.privateTaskProgressTxt.gameObject.transform.parent, var_16_4 and not var_16_3:isFinish())

	return
end

function GuildOfficeTaskPage:UpdatePubliceTask(arg_20_1)
	local var_20_0 = arg_20_1:getProgress()
	local var_20_1 = arg_20_1:getMaxProgress()

	self.taskProgressTxt.text = var_20_0 .. "/<size=40>" .. var_20_1 .. "</size>"

	setFillAmount(self.taskProgressBar, var_20_0 / var_20_1)

	self.taskDescTxt.text = var_20_0
	self.taskAwardTxt.text = arg_20_1:GetCurrCaptailAward()

	return
end

function GuildOfficeTaskPage:UpdateContributionPanel()
	local var_21_0 = self.guild:getDonateTasks()
	local var_21_1 = self.guild:getRemainDonateCnt() + self.guild:GetExtraDonateCnt()

	self.contributionList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]
			local var_22_1 = GuildDonateCard.New(arg_22_2)

			var_22_1:update(var_21_0[arg_22_1 + 1])
			onButton(self, var_22_1.commitBtn, function()
				local var_23_0 = var_22_0:getCommitItem()
				local var_23_1 = Drop.New({
					type = var_23_0[1],
					id = var_23_0[2],
					count = var_23_0[3]
				})
				local var_23_2 = var_22_1:GetResCntByAward(var_23_0)

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("guild_donate_tip", var_23_1:getConfig("name"), var_23_0[3], var_23_2, var_23_2 < var_23_0[3] and "#FF5C5CFF" or "#92FC63FF"),
					onYes = function()
						self:emit(GuildOfficeMediator.ON_COMMIT, var_22_0.id)

						return
					end
				})

				return
			end, SFX_PANEL)
			setButtonEnabled(var_22_1.commitBtn, var_21_1 > 0)
		end

		return
	end)
	self.contributionList:align(#var_21_0)

	self.contributionCntTxt.text = i18n("guild_left_donate_cnt", var_21_1)

	return
end

function GuildOfficeTaskPage:UpdateSupplyPanel()
	local var_25_0 = self.guild:isOpenedSupply()

	setActive(self.supplyOpenTF, var_25_0)
	setActive(self.supplyUnOpenTF, not var_25_0)

	if not var_25_0 then
		setActive(self.supplyUnOpenAdminTF, self.isAdmin)
		setActive(self.supplyUnOpenLockTF, not self.isAdmin)

		if self.isAdmin then
			self.supplyUnOpenResTF.text = self.guild:getSupplyConsume()
		end
	else
		local var_25_1 = self.guild:getSupplyCnt()
		local var_25_2 = self.guild:getSupplyLeftCnt()

		setActive(self.supplyOpenGetBtn, var_25_1 > 0)
		setActive(self.supplyOpenGotBtn, var_25_1 <= 0)

		self.supplyOpenTimeTxt.text = var_25_2 < 0 and i18n("guild_exist_unreceived_supply_award") or i18n("guild_left_supply_day", var_25_2)
		self.supplyOpenLetfCntTxt.text = i18n1(var_25_1 .. "/" .. GuildConst.MAX_SUPPLY_CNT)
	end

	return
end

function GuildOfficeTaskPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.taskTF, self._tf)
	self.selectTaskPage:Destroy()

	return
end

return GuildOfficeTaskPage
