local ReturnerPage = class("ReturnerPage")

function ReturnerPage:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self._event = arg_1_2
	self.bg = self._tf:Find("bg"):GetComponent(typeof(Image))
	self.input = self._tf:Find("InputField")
	self.inputPlaceholder = self._tf:Find("InputField/Placeholder"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("confim_btn")
	self.taskUIlist = UIItemList.New(self._tf:Find("task_list"), self._tf:Find("task_list/tpl"))
	self.totalProgress = self._tf:Find("total_progress"):GetComponent(typeof(Text))
	self.progress = self._tf:Find("progress"):GetComponent(typeof(Text))
	self.awrdOverviewBtn = self._tf:Find("award_overview")
	self.help = self._tf:Find("help")
	self.ptTxt = self._tf:Find("pt"):GetComponent(typeof(Text))
	self.matchBtn = self._tf:Find("match_btn")
	self.matchedBtn = self._tf:Find("matched_btn")

	self:Init()

	return
end

function ReturnerPage:Init()
	onButton(self, self.confirmBtn, function()
		if self.code ~= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("return_have_participated_in_act"))

			return
		end

		local var_3_0 = getInputText(self.input)

		if not var_3_0 or var_3_0 == "" then
			return
		end

		if tonumber(var_3_0) > 2147483647 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_notExist"))

			return
		end

		self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = self.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_SET_RETRUNER,
			arg1 = tonumber(var_3_0)
		})

		return
	end, SFX_PANEL)
	onButton(self, self.awrdOverviewBtn, function()
		self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			cmd = ActivityConst.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW,
			arg1 = {
				blur = true,
				tasklist = self.config.task_list,
				ptId = pg.activity_template_headhunting[self.activity.id].pt,
				totalPt = self.pt,
				index = self.taskIndex
			}
		})

		return
	end, SFX_PANEL)
	onButton(self, self.matchBtn, function()
		if self.code ~= 0 then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("returner_match_tip"),
			onYes = function()
				self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = self.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_MATCH
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function ReturnerPage:Update(arg_7_1)
	self.activity = arg_7_1

	self:UpdateData()

	if self:ShouldAcceptTasks() then
		self:AcceptTasks()
	else
		self:UpdateTasks()
	end

	local var_7_0 = self.code ~= 0

	if self.code == 0 then
		self.inputPlaceholder.text = i18n("input_returner_code")
	else
		self.inputPlaceholder.text = self.code

		setInputText(self.input, "")
	end

	self.input:GetComponent(typeof(InputField)).interactable = not var_7_0

	setActive(self.matchBtn, not var_7_0)
	setActive(self.matchedBtn, var_7_0)

	return
end

function ReturnerPage:ShouldAcceptTasks()
	if self.code == 0 then
		return false
	end

	local var_8_2
	local var_8_1

	if self.taskIndex == 0 then
		do return true end

		local var_8_0 = getProxy(TaskProxy)

		var_8_1 = _.all(self.config.task_list[self.taskIndex], function(arg_9_0)
			return var_8_0:getFinishTaskById(arg_9_0) ~= nil
		end)
		var_8_2 = _.all(self.config.task_list[self.taskIndex], function(arg_10_0)
			return var_8_0:getTaskById(arg_10_0) == nil and var_8_0:getFinishTaskById(arg_10_0) == nil
		end)
	end

	return var_8_2 or var_8_1 and self.taskIndex ~= #self.config.task_list and (function()
		return self.day > self.taskIndex
	end)()
end

function ReturnerPage:AcceptTasks()
	self._event:emit(ActivityMediator.RETURN_AWARD_OP, {
		activity_id = self.activity.id,
		cmd = ActivityConst.RETURN_AWARD_OP_RETURNER_GET_AWARD
	})

	return
end

function ReturnerPage:UpdateData()
	self.config = pg.activity_template_returnner[self.activity.id]
	self.code = self.activity.data2
	self.pt = self.activity.data3
	self.taskIndex = self.activity.data4
	self.ptTxt.text = self.pt
	self.day = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), (pg.TimeMgr.GetInstance():GetServerTime())) + 1

	return
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:getConfig("award_display")[1]
	local var_14_1 = {
		type = var_14_0[1],
		id = var_14_0[2],
		count = var_14_0[3]
	}

	updateDrop(arg_14_1:Find("item"), var_14_1)
	onButton(arg_14_0, arg_14_1:Find("item"), function()
		arg_14_0._event:emit(BaseUI.ON_DROP, var_14_1)

		return
	end, SFX_PANEL)
	setText(arg_14_1:Find("desc"), arg_14_2:getConfig("desc"))
	setFillAmount(arg_14_1:Find("slider"), arg_14_2:getProgress() / arg_14_2:getConfig("target_num"))

	local var_14_2 = arg_14_1:Find("go")
	local var_14_3 = arg_14_1:Find("get")

	setActive(var_14_2, not arg_14_2:isFinish())
	setActive(var_14_3, arg_14_2:isFinish() and not arg_14_2:isReceive())
	setActive(arg_14_1:Find("got"), arg_14_2:isReceive())
	onButton(arg_14_0, var_14_2, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_GO, arg_14_2)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, var_14_3, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_SUBMIT, arg_14_2)

		return
	end, SFX_PANEL)

	return
end

function ReturnerPage:UpdateTasks()
	local var_18_0 = self.config.task_list[self.taskIndex] or {}

	self.taskUIlist:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = getProxy(TaskProxy)
			local var_19_1 = var_19_0:getTaskById(var_18_0[arg_19_1 + 1]) or var_19_0:getFinishTaskById(var_18_0[arg_19_1 + 1])

			assert(var_19_1)
			var_0_1(self, arg_19_2, var_19_1)
		end

		return
	end)
	self.taskUIlist:align(#var_18_0)

	self.totalProgress.text = #self.config.task_list
	self.progress.text = self.taskIndex

	return
end

function ReturnerPage:Dispose()
	pg.DelegateInfo.Dispose(self)

	self.bg.sprite = nil

	return
end

return ReturnerPage
