local InviterPage = class("InviterPage")

InviterPage.REFRESH_TIME = 1800

function InviterPage:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._event = arg_1_2
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.ptTxt = self._tf:Find("pt_panel/slider/Text"):GetComponent(typeof(Text))
	self.phaseTotalTxt = self._tf:Find("pt_panel/total_progress"):GetComponent(typeof(Text))
	self.phaseTxt = self._tf:Find("pt_panel/progress"):GetComponent(typeof(Text))
	self.progress = self._tf:Find("pt_panel/slider")
	self.getBtn = self._tf:Find("pt_panel/get")
	self.awardTF = self._tf:Find("pt_panel/item")
	self.awardOverView = self._tf:Find("pt_panel/award_overview")
	self.bg = self._tf:Find("bg"):GetComponent(typeof(Image))
	self.returnerList = UIItemList.New(self._tf:Find("returners/content"), self._tf:Find("returners/content/tpl"))
	self.help = self._tf:Find("help")
	self.pushBtn = self._tf:Find("push_btn")
	self.pushedBtn = self._tf:Find("pushed_btn")
	self.pushDisBtn = self._tf:Find("push_btn_dis")
	self.codeTxt = self._tf:Find("code"):GetComponent(typeof(Text))
	self.taskLockPanel = self._tf:Find("task_lock_panel")

	setText(self.taskLockPanel:Find("Text"), i18n("word_sell_lock"))

	self.taskPanel = self._tf:Find("task_panel")
	self.taskItemTF = self._tf:Find("task_panel/item")
	self.taskProgress = self._tf:Find("task_panel/progress")
	self.taskDesc = self._tf:Find("task_panel/desc")
	self.taskGoBtn = self._tf:Find("task_panel/go")
	self.taskGotBtn = self._tf:Find("task_panel/got")
	self.taskGetBtn = self._tf:Find("task_panel/get")
	self.taskProgressTxt = self._tf:Find("task_panel/p"):GetComponent(typeof(Text))

	setText(self._tf:Find("pt_panel/title"), i18n("activity_return_reward_pt"))
	self:Init()

	return
end

function InviterPage:Init()
	onButton(self, self.getBtn, function()
		self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = self.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_GET_AWARD,
			arg1 = self.nextTarget
		})

		return
	end, SFX_PANEL)
	onButton(self, self.awardOverView, function()
		self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			cmd = ActivityConst.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW,
			arg1 = {
				blur = true,
				dropList = self.config.drop_client,
				targets = self.config.target,
				fetchList = self.fetchList,
				count = self.pt,
				resId = self.config.pt
			}
		})

		return
	end, SFX_PANEL)
	onButton(self, self.pushBtn, function()
		if self.isPush then
			return
		end

		if not self.returners or #self.returners >= 3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("returner_max_count"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("returner_push_tip"),
			onYes = function()
				self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = self.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_PUSH_UID,
					arg1 = self.code
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function InviterPage:Update(arg_7_1)
	self.activity = arg_7_1

	local var_7_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if not ActivityMainScene.FetchReturnersTime or var_7_0 >= ActivityMainScene.FetchReturnersTime then
		ActivityMainScene.FetchReturnersTime = var_7_0 + InviterPage.REFRESH_TIME

		self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = self.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_GET_RETRUNERS
		})

		return
	end

	self:UpdateData()
	self:UpdateUI()
	self:UpdateReturners()

	return
end

function InviterPage:getTotalPt(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.returners) do
		var_8_0 = var_8_0 + iter_8_1:getPt()
	end

	return var_8_0 + arg_8_1
end

function InviterPage:UpdateData()
	self.isPush = self.activity.data2_list[1] == 1
	self.code = getProxy(PlayerProxy):getRawData().id
	self.fetchList = self.activity.data1_list
	self.config = pg.activity_template_headhunting[self.activity.id]
	self.targets = self.config.target
	self.nextIndex = -1

	for iter_9_0 = 1, #self.targets do
		if not table.contains(self.fetchList, self.targets[iter_9_0]) then
			self.nextIndex = iter_9_0

			break
		end
	end

	if self.nextIndex == -1 then
		self.fetchIndex = #self.targets
		self.nextIndex = #self.targets
	else
		self.fetchIndex = math.max(self.nextIndex - 1, 0)
	end

	self.drops = self.config.drop_client
	self.nextDrops = self.config.drop_client[self.nextIndex]
	self.nextTarget = self.targets[self.nextIndex]
	self.returners = self.activity:getClientList()
	self.pt = self:getTotalPt(self.activity.data3)

	setActive(self.pushBtn, not self.isPush and #self.returners < 3)
	setActive(self.pushedBtn, self.isPush)
	setActive(self.pushDisBtn, not self.isPush and #self.returners >= 3)

	return
end

function InviterPage:UpdateUI()
	self.codeTxt.text = self.code
	self.ptTxt.text = self.pt .. "/" .. self.nextTarget

	setActive(self.getBtn, self.fetchIndex ~= #self.targets and self.pt >= self.nextTarget)

	self.phaseTxt.text = self.fetchIndex
	self.phaseTotalTxt.text = #self.targets

	setFillAmount(self.progress, self.pt / self.nextTarget)

	local var_10_0 = {
		type = self.nextDrops[1],
		id = self.nextDrops[2],
		count = self.nextDrops[3]
	}

	updateDrop(self.awardTF, var_10_0)
	onButton(self, self.awardTF, function()
		self._event:emit(BaseUI.ON_DROP, var_10_0)

		return
	end, SFX_PANEL)
	self:UpdateTasks(pg.activity_template_headhunting[self.activity.id].tasklist)

	return
end

function InviterPage:getTask(arg_12_1)
	local var_12_0 = getProxy(TaskProxy)

	return var_12_0:getTaskById(arg_12_1) or var_12_0:getFinishTaskById(arg_12_1)
end

function InviterPage:UpdateTasks(arg_13_1)
	if self.isPush then
		local var_13_0 = getProxy(TaskProxy)
		local var_13_1 = 0

		for iter_13_0 = #arg_13_1, 1, -1 do
			if self:getTask(arg_13_1[iter_13_0]) then
				var_13_1 = iter_13_0

				break
			end
		end

		local var_13_2 = self:getTask(arg_13_1[var_13_1])

		if (not var_13_2 or var_13_2:isReceive()) and var_13_1 < self.activity:getDayIndex() then
			if var_13_1 == #arg_13_1 and var_13_2 and var_13_2:isReceive() then
				self:UpdateTaskTF(var_13_2)
			else
				self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = self.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_ACCEPT_TASK
				})
			end
		else
			assert(var_13_2)
			self:UpdateTaskTF(var_13_2)
		end
	else
		setActive(self.taskPanel, false)
		setActive(self.taskLockPanel, true)
	end

	return
end

function InviterPage:UpdateTaskTF(arg_14_1)
	setActive(self.taskLockPanel, false)
	setActive(self.taskPanel, true)

	local var_14_0 = arg_14_1:isFinish()
	local var_14_1 = arg_14_1:isReceive()

	setActive(self.taskGoBtn, arg_14_1 and not var_14_0)
	setActive(self.taskGotBtn, arg_14_1 and var_14_1)
	setActive(self.taskGetBtn, arg_14_1 and var_14_0 and not var_14_1)

	local var_14_2 = arg_14_1:getConfig("award_display")[1]
	local var_14_3 = {
		type = var_14_2[1],
		id = var_14_2[2],
		count = var_14_2[3]
	}

	updateDrop(self.taskItemTF, var_14_3)
	onButton(self, self.taskItemTF, function()
		self._event:emit(BaseUI.ON_DROP, var_14_3)

		return
	end, SFX_PANEL)
	setFillAmount(self.taskProgress, arg_14_1:getProgress() / arg_14_1:getConfig("target_num"))
	setText(self.taskDesc, arg_14_1:getConfig("desc"))

	self.taskProgressTxt.text = arg_14_1:getProgress() .. "/" .. arg_14_1:getConfig("target_num")

	onButton(self, self.taskGoBtn, function()
		self._event:emit(ActivityMediator.ON_TASK_GO, arg_14_1)

		return
	end, SFX_PANEL)
	onButton(self, self.taskGetBtn, function()
		self._event:emit(ActivityMediator.ON_TASK_SUBMIT, arg_14_1)

		return
	end, SFX_PANEL)

	return
end

local function var_0_1(arg_18_0, arg_18_1)
	LoadSpriteAsync("qicon/" .. arg_18_1:getPainting(), function(arg_19_0)
		if not IsNil(arg_18_0) then
			arg_18_0:GetComponent(typeof(Image)).sprite = arg_19_0
		end

		return
	end)
	UIItemList.New(arg_18_0:Find("starts"), arg_18_0:Find("starts/tpl")):align(arg_18_1:getStar())

	return
end

function InviterPage:UpdateReturners()
	local var_20_0 = self.returners

	self.returnerList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			if var_20_0[arg_21_1 + 1] then
				var_0_1(arg_21_2:Find("info/icon"), (Ship.New({
					configId = var_20_0[arg_21_1 + 1]:getIcon()
				})))
				setText(arg_21_2:Find("info/name"), var_20_0[arg_21_1 + 1]:getName())
				setText(arg_21_2:Find("info/pt/Text"), var_20_0[arg_21_1 + 1]:getPt())
			end

			setActive(arg_21_2:Find("empty"), not var_20_0[arg_21_1 + 1])
			setActive(arg_21_2:Find("info"), var_20_0[arg_21_1 + 1])
		end

		return
	end)
	self.returnerList:align(2)

	return
end

function InviterPage:Dispose()
	pg.DelegateInfo.Dispose(self)

	self.bg.sprite = nil

	return
end

return InviterPage
