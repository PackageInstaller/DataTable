local ChildishnessSchoolTaskPage = class("ChildishnessSchoolTaskPage", import("view.base.BaseUI"))

function ChildishnessSchoolTaskPage:getUIName()
	return "ChildishnessSchoolTaskPage"
end

function ChildishnessSchoolTaskPage:init()
	self.bg = self._tf:Find("bg")
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/Tasktpl"))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.getBtn = self._tf:Find("window/btn_get")

	return
end

function ChildishnessSchoolTaskPage:didEnter()
	onButton(self, self.closeBtn, function()
		self.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self.anim:Play("anim_kinder_schoolPT_out")

		return
	end, SFX_PANEL)
	self:Show()

	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self.anim:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:closeView()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChildishnessSchoolTaskPage:Show()
	self:UpdateTaskData()

	self.canGetTaskVOs = {}
	self.canGetTaskIds = {}

	self:sort(self.taskVOs)
	self:UpdateList(self.taskVOs)
	Canvas.ForceUpdateCanvases()

	return
end

function ChildishnessSchoolTaskPage:sort(arg_8_1)
	local var_8_0 = {}

	self.canGetAward = false

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if iter_8_1:getTaskStatus() == 1 then
			table.insert(var_8_0, iter_8_1)
			table.insert(self.canGetTaskVOs, iter_8_1)
			table.insert(self.canGetTaskIds, iter_8_1.id)

			self.canGetAward = true
		end
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_1) do
		if iter_8_3:getTaskStatus() == 0 then
			table.insert(var_8_0, iter_8_3)
		end
	end

	for iter_8_4, iter_8_5 in pairs(arg_8_1) do
		if iter_8_5:getTaskStatus() == 2 then
			table.insert(var_8_0, iter_8_5)
		end
	end

	self.taskVOs = var_8_0

	return
end

function ChildishnessSchoolTaskPage:UpdateList(arg_9_1)
	self.UIlist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText(arg_10_2:Find("frame/desc"), arg_9_1[arg_10_1 + 1]:getConfig("desc"))

			local var_10_1 = arg_9_1[arg_10_1 + 1]:getConfig("target_num")
			local var_10_2 = math.min(arg_9_1[arg_10_1 + 1]:getProgress(), var_10_1)

			setText(arg_10_2:Find("frame/progress"), var_10_2 .. "/" .. var_10_1)

			arg_10_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_10_2 / var_10_1

			local var_10_3 = arg_10_2:Find("frame/awards")

			self:updateAwards(arg_9_1[arg_10_1 + 1]:getConfig("award_display"), var_10_3, (var_10_3:GetChild(0)))

			local var_10_4 = arg_10_2:Find("frame/go_btn")
			local var_10_5 = arg_10_2:Find("frame/get_btn")
			local var_10_6 = arg_10_2:Find("frame/got_btn")

			if arg_9_1[arg_10_1 + 1]:getTaskStatus() == 0 then
				setActive(var_10_4, true)
				setActive(var_10_5, false)
				setActive(var_10_6, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 1 then
				setActive(var_10_4, false)
				setActive(var_10_5, true)
				setActive(var_10_6, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 2 then
				setActive(var_10_4, false)
				setActive(var_10_5, false)
				setActive(var_10_6, true)
			end

			onButton(self, var_10_4, function()
				self:emit(ChildishnessSchoolTaskMediator.ON_TASK_GO, var_10_0)

				return
			end, SFX_PANEL)
			onButton(self, var_10_5, function()
				self:emit(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT, var_10_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.UIlist:align(#arg_9_1)

	if self.canGetAward then
		setActive(self.getBtn, true)
		onButton(self, self.getBtn, function()
			local var_13_0 = {}
			local var_13_1 = {}

			for iter_13_0, iter_13_1 in pairs(self.canGetTaskVOs) do
				for iter_13_2, iter_13_3 in ipairs((iter_13_1:getConfig("award_display"))) do
					local var_13_3 = false

					for iter_13_4, iter_13_5 in pairs(var_13_1) do
						if iter_13_5[1] == iter_13_3[1] and iter_13_5[2] == iter_13_3[2] then
							var_13_3 = true
							iter_13_5[3] = iter_13_5[3] + iter_13_3[3]

							break
						end
					end

					if not var_13_3 then
						table.insert(var_13_1, iter_13_3)
					end
				end
			end

			local var_13_4 = getProxy(PlayerProxy):getRawData()
			local var_13_5, var_13_6 = Task.StaticJudgeOverflow(var_13_4.gold, var_13_4.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_13_1)

			if var_13_5 then
				table.insert(var_13_0, function(arg_14_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_13_6,
						onYes = arg_14_0
					})

					return
				end)
			end

			seriesAsync(var_13_0, function()
				self:emit(ChildishnessSchoolTaskMediator.ON_TASK_SUBMIT_ONESTEP, ActivityConst.ALVIT_TASK_ACT_ID, self.canGetTaskIds)

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

function ChildishnessSchoolTaskPage:updateAwards(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = _.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo(arg_16_3, arg_16_2)
	end

	for iter_16_1 = 1, arg_16_2.childCount do
		local var_16_1 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_2 = iter_16_1 <= #var_16_0

		setActive(var_16_1, iter_16_1 <= #var_16_0)

		if var_16_2 then
			local var_16_3 = {
				type = var_16_0[iter_16_1][1],
				id = var_16_0[iter_16_1][2],
				count = var_16_0[iter_16_1][3]
			}

			updateDrop(var_16_1:Find("mask"), var_16_3)

			if var_16_3.type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(var_16_1:Find("specialFrame"), true)
			else
				setActive(var_16_1:Find("specialFrame"), false)
			end

			onButton(self, var_16_1, function()
				self:emit(BaseUI.ON_DROP, var_16_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function ChildishnessSchoolTaskPage:UpdateTaskData()
	self.taskVOs = {}

	for iter_18_0, iter_18_1 in pairs((getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID):getConfig("config_data"))) do
		table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_18_1))
	end

	return
end

function ChildishnessSchoolTaskPage:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChildishnessSchoolTaskPage
