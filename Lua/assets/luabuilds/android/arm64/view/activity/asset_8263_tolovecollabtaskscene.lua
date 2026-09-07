local ToLoveCollabTaskScene = class("ToLoveCollabTaskScene", import("view.base.BaseUI"))
local var_0_1 = {
	{
		6,
		9004
	},
	{
		16,
		1006
	}
}

function ToLoveCollabTaskScene:getUIName()
	return "ToLoveCollabTaskPage"
end

function ToLoveCollabTaskScene:init()
	self.bg = self._tf:Find("bg")
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/Tasktpl"))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.getBtn = self._tf:Find("window/btn_get")

	return
end

function ToLoveCollabTaskScene:didEnter()
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	self:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ToLoveCollabTaskScene:Show()
	self:UpdateTaskData()

	self.canGetTaskVOs = {}
	self.canGetTaskIds = {}

	self:sort(self.taskVOs)
	self:UpdateList(self.taskVOs)
	Canvas.ForceUpdateCanvases()

	return
end

function ToLoveCollabTaskScene:sort(arg_7_1)
	local var_7_0 = {}

	self.canGetAward = false

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if iter_7_1:getTaskStatus() == 1 then
			table.insert(var_7_0, iter_7_1)
			table.insert(self.canGetTaskVOs, iter_7_1)
			table.insert(self.canGetTaskIds, iter_7_1.id)

			self.canGetAward = true
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_1) do
		if iter_7_3:getTaskStatus() == 0 then
			table.insert(var_7_0, iter_7_3)
		end
	end

	for iter_7_4, iter_7_5 in pairs(arg_7_1) do
		if iter_7_5:getTaskStatus() == 2 then
			table.insert(var_7_0, iter_7_5)
		end
	end

	self.taskVOs = var_7_0

	return
end

function ToLoveCollabTaskScene:UpdateList(arg_8_1)
	self.UIlist:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_1[arg_9_1 + 1]
			local var_9_1, var_9_2 = self:getTaskProgress(arg_8_1[arg_9_1 + 1])
			local var_9_3, var_9_4 = self:getTaskTarget(var_9_0)
			local var_9_5 = math.min(var_9_1, var_9_3)

			setText(arg_9_2:Find("frame/desc"), var_9_0:getConfig("desc") .. " (" .. tostring(var_9_5) .. "/" .. var_9_4 .. ")")

			arg_9_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_9_5 / var_9_3

			local var_9_6 = arg_9_2:Find("frame/awards")

			self:updateAwards(var_9_0:getConfig("award_display"), var_9_6, (var_9_6:GetChild(0)))

			local var_9_7 = arg_9_2:Find("frame/go_btn")
			local var_9_8 = arg_9_2:Find("frame/get_btn")
			local var_9_9 = arg_9_2:Find("frame/got_btn")
			local var_9_10 = arg_9_2:Find("frame/bg_go")
			local var_9_11 = arg_9_2:Find("frame/bg_get")
			local var_9_12 = arg_9_2:Find("frame/bg_got")

			setActive(var_9_7, var_9_0:getTaskStatus() == 0)
			setActive(var_9_10, var_9_0:getTaskStatus() == 0)
			setActive(var_9_8, var_9_0:getTaskStatus() == 1)
			setActive(var_9_11, var_9_0:getTaskStatus() == 1)
			setActive(var_9_9, var_9_0:getTaskStatus() == 2)
			setActive(var_9_12, var_9_0:getTaskStatus() == 2)
			onButton(self, var_9_7, function()
				self:emit(ToLoveCollabTaskMediator.ON_TASK_GO, var_9_0)

				return
			end, SFX_PANEL)
			onButton(self, var_9_8, function()
				self:checkAwardOverFlow({
					var_9_0
				}, function()
					self:emit(ToLoveCollabTaskMediator.ON_TASK_SUBMIT, var_9_0)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.UIlist:align(#arg_8_1)

	if self.canGetAward then
		setActive(self.getBtn, true)
		onButton(self, self.getBtn, function()
			self:checkAwardOverFlow(self.canGetTaskVOs, function()
				self:emit(ToLoveCollabTaskMediator.ON_TASK_SUBMIT_ONESTEP, self.canGetTaskIds)

				return
			end)

			return
		end, SFX_PANEL)
	else
		setActive(self.getBtn, false)
		removeOnButton(self.getBtn)
	end

	return
end

function ToLoveCollabTaskScene:checkAwardOverFlow(arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		for iter_15_2, iter_15_3 in ipairs((iter_15_1:getConfig("award_display"))) do
			local var_15_3 = false

			for iter_15_4, iter_15_5 in pairs(var_15_1) do
				if iter_15_5[1] == iter_15_3[1] and iter_15_5[2] == iter_15_3[2] then
					var_15_3 = true
					iter_15_5[3] = iter_15_5[3] + iter_15_3[3]

					break
				end
			end

			if not var_15_3 then
				table.insert(var_15_1, {
					iter_15_3[1],
					iter_15_3[2],
					iter_15_3[3]
				})
			end
		end
	end

	local var_15_4 = getProxy(PlayerProxy):getRawData()
	local var_15_5, var_15_6 = Task.StaticJudgeOverflow(var_15_4.gold, var_15_4.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_15_1)

	if var_15_5 then
		table.insert(var_15_0, function(arg_16_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_15_6,
				onYes = arg_16_0
			})

			return
		end)
	end

	seriesAsync(var_15_0, arg_15_2)

	return
end

function ToLoveCollabTaskScene:updateAwards(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = _.slice(arg_17_1, 1, 3)

	for iter_17_0 = arg_17_2.childCount, #var_17_0 - 1 do
		cloneTplTo(arg_17_3, arg_17_2)
	end

	for iter_17_1 = 1, arg_17_2.childCount do
		local var_17_1 = arg_17_2:GetChild(iter_17_1 - 1)
		local var_17_2 = iter_17_1 <= #var_17_0

		setActive(var_17_1, iter_17_1 <= #var_17_0)

		if var_17_2 then
			local var_17_3 = {
				type = var_17_0[iter_17_1][1],
				id = var_17_0[iter_17_1][2],
				count = var_17_0[iter_17_1][3]
			}

			updateDrop(var_17_1:Find("mask"), var_17_3)

			if var_17_3.type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(var_17_1:Find("specialFrame"), true)
			else
				setActive(var_17_1:Find("specialFrame"), false)
			end

			onButton(self, var_17_1, function()
				self:emit(BaseUI.ON_DROP, var_17_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function ToLoveCollabTaskScene:UpdateTaskData()
	local var_19_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_TASK_ID)

	self.taskVOs = {}

	if var_19_0 and not var_19_0:isEnd() then
		for iter_19_0, iter_19_1 in pairs((var_19_0:getConfig("config_data"))) do
			table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_19_1))
		end
	end

	return
end

function ToLoveCollabTaskScene:getTaskProgress(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(var_0_1) do
		if iter_20_1[1] == arg_20_1:getConfig("type") and iter_20_1[2] == arg_20_1:getConfig("sub_type") then
			local var_20_0 = arg_20_1:getProgress() / 1000
			local var_20_1 = string.format("%.2d", arg_20_1:getProgress() / 1000)

			return
		end
	end

	local var_20_2 = arg_20_1:getProgress()
	local var_20_3 = tostring(arg_20_1:getProgress())
end

function ToLoveCollabTaskScene:getTaskTarget(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(var_0_1) do
		if iter_21_1[1] == arg_21_1:getConfig("type") and iter_21_1[2] == arg_21_1:getConfig("sub_type") then
			local var_21_0 = arg_21_1:getConfig("target_num") / 1000
			local var_21_1 = string.format("%.2d", arg_21_1:getConfig("target_num") / 1000)

			return
		end
	end

	local var_21_2 = arg_21_1:getConfig("target_num")
	local var_21_3 = tostring(arg_21_1:getConfig("target_num"))
end

function ToLoveCollabTaskScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ToLoveCollabTaskScene
