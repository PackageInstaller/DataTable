local SixYearUsTaskScene = class("SixYearUsTaskScene", import("view.base.BaseUI"))
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
local var_0_2 = 65011

function SixYearUsTaskScene:getUIName()
	return "SixYearUsTaskPage"
end

function SixYearUsTaskScene:init()
	self.bg = self._tf:Find("bg")
	self.scrollPanel = self._tf:Find("window/panel")
	self.UIlist = UIItemList.New(self._tf:Find("window/panel/list"), self._tf:Find("window/panel/list/Tasktpl"))
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.getBtn = self._tf:Find("window/btn_get")

	return
end

function SixYearUsTaskScene:didEnter()
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

function SixYearUsTaskScene:Show()
	self:UpdateTaskData()

	self.canGetTaskVOs = {}
	self.canGetTaskIds = {}

	self:sort(self.taskVOs)
	self:UpdateList(self.taskVOs)
	Canvas.ForceUpdateCanvases()

	return
end

function SixYearUsTaskScene:sort(arg_8_1)
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

function SixYearUsTaskScene:UpdateList(arg_9_1)
	self.UIlist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_1[arg_10_1 + 1]

			setText(arg_10_2:Find("frame/desc"), arg_9_1[arg_10_1 + 1]:getConfig("desc"))

			local var_10_1, var_10_2 = self:getTaskProgress(arg_9_1[arg_10_1 + 1])
			local var_10_3, var_10_4 = self:getTaskTarget(arg_9_1[arg_10_1 + 1])

			setText(arg_10_2:Find("frame/progress"), var_10_2 .. "/" .. var_10_4)

			arg_10_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = math.min(var_10_1, var_10_3) / var_10_3

			local var_10_5 = arg_10_2:Find("frame/awards")

			self:updateAwards(arg_9_1[arg_10_1 + 1]:getConfig("award_display"), var_10_5, (var_10_5:GetChild(0)))

			local var_10_6 = arg_10_2:Find("frame/go_btn")
			local var_10_7 = arg_10_2:Find("frame/get_btn")
			local var_10_8 = arg_10_2:Find("frame/got_btn")

			if arg_9_1[arg_10_1 + 1]:getTaskStatus() == 0 then
				setActive(var_10_6, true)
				setActive(var_10_7, false)
				setActive(var_10_8, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 1 then
				setActive(var_10_6, false)
				setActive(var_10_7, true)
				setActive(var_10_8, false)
			elseif arg_9_1[arg_10_1 + 1]:getTaskStatus() == 2 then
				setActive(var_10_6, false)
				setActive(var_10_7, false)
				setActive(var_10_8, true)
			end

			onButton(self, var_10_6, function()
				self:emit(SixYearUsTaskMediator.ON_TASK_GO, var_10_0)

				return
			end, SFX_PANEL)
			onButton(self, var_10_7, function()
				self:checkAwardOverFlow({
					var_10_0
				}, function()
					self:emit(SixYearUsTaskMediator.ON_TASK_SUBMIT, var_10_0)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.UIlist:align(#arg_9_1)

	if self.canGetAward then
		setActive(self.getBtn, true)
		onButton(self, self.getBtn, function()
			self:checkAwardOverFlow(self.canGetTaskVOs, function()
				self:emit(SixYearUsTaskMediator.ON_TASK_SUBMIT_ONESTEP, self.canGetTaskIds)

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

function SixYearUsTaskScene:checkAwardOverFlow(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		for iter_16_2, iter_16_3 in ipairs((iter_16_1:getConfig("award_display"))) do
			local var_16_3 = false

			for iter_16_4, iter_16_5 in pairs(var_16_1) do
				if iter_16_5[1] == iter_16_3[1] and iter_16_5[2] == iter_16_3[2] then
					var_16_3 = true
					iter_16_5[3] = iter_16_5[3] + iter_16_3[3]

					break
				end
			end

			if not var_16_3 then
				table.insert(var_16_1, {
					iter_16_3[1],
					iter_16_3[2],
					iter_16_3[3]
				})
			end
		end
	end

	local var_16_4 = 0

	for iter_16_6, iter_16_7 in ipairs(var_16_1) do
		if iter_16_7[2] == var_0_2 then
			var_16_4 = iter_16_7[3]
		end
	end

	local var_16_5, var_16_6 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN):IsOverGold(var_16_4)
	local var_16_7

	if var_16_5 then
		var_16_7 = {
			id = var_0_2,
			type = DROP_TYPE_VITEM,
			count = "<color=#FF5C5CFF>" .. math.abs(var_16_6) .. "</color>"
		}
	end

	local var_16_8 = getProxy(PlayerProxy):getRawData()
	local var_16_9, var_16_10 = Task.StaticJudgeOverflow(var_16_8.gold, var_16_8.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_16_1)

	var_16_10 = var_16_10 or {}

	if var_16_7 then
		table.insert(var_16_10, var_16_7)
	end

	if var_16_9 or var_16_5 then
		table.insert(var_16_0, function(arg_17_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_16_10,
				onYes = arg_17_0
			})

			return
		end)
	end

	seriesAsync(var_16_0, arg_16_2)

	return
end

function SixYearUsTaskScene:updateAwards(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = _.slice(arg_18_1, 1, 3)

	for iter_18_0 = arg_18_2.childCount, #var_18_0 - 1 do
		cloneTplTo(arg_18_3, arg_18_2)
	end

	for iter_18_1 = 1, arg_18_2.childCount do
		local var_18_1 = arg_18_2:GetChild(iter_18_1 - 1)
		local var_18_2 = iter_18_1 <= #var_18_0

		setActive(var_18_1, iter_18_1 <= #var_18_0)

		if var_18_2 then
			local var_18_3 = {
				type = var_18_0[iter_18_1][1],
				id = var_18_0[iter_18_1][2],
				count = var_18_0[iter_18_1][3]
			}

			updateDrop(var_18_1:Find("mask"), var_18_3)

			if var_18_3.type == DROP_TYPE_EQUIPMENT_SKIN then
				setActive(var_18_1:Find("specialFrame"), true)
			else
				setActive(var_18_1:Find("specialFrame"), false)
			end

			onButton(self, var_18_1, function()
				self:emit(BaseUI.ON_DROP, var_18_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function SixYearUsTaskScene:UpdateTaskData()
	local var_20_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_ACT_ID)
	local var_20_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_2_ACT_ID)

	self.taskVOs = {}

	if var_20_0 and not var_20_0:isEnd() then
		for iter_20_0, iter_20_1 in pairs((var_20_0:getConfig("config_data"))) do
			table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_20_1))
		end
	end

	if var_20_1 and not var_20_1:isEnd() then
		for iter_20_2, iter_20_3 in pairs((var_20_1:getConfig("config_data"))) do
			table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_20_3))
		end
	end

	return
end

function SixYearUsTaskScene:getTaskProgress(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(var_0_1) do
		if iter_21_1[1] == arg_21_1:getConfig("type") and iter_21_1[2] == arg_21_1:getConfig("sub_type") then
			local var_21_0 = arg_21_1:getProgress() / 1000
			local var_21_1 = string.format("%.2d", arg_21_1:getProgress() / 1000)

			return
		end
	end

	local var_21_2 = arg_21_1:getProgress()
	local var_21_3 = tostring(arg_21_1:getProgress())
end

function SixYearUsTaskScene:getTaskTarget(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(var_0_1) do
		if iter_22_1[1] == arg_22_1:getConfig("type") and iter_22_1[2] == arg_22_1:getConfig("sub_type") then
			local var_22_0 = arg_22_1:getConfig("target_num") / 1000
			local var_22_1 = string.format("%.2d", arg_22_1:getConfig("target_num") / 1000)

			return
		end
	end

	local var_22_2 = arg_22_1:getConfig("target_num")
	local var_22_3 = tostring(arg_22_1:getConfig("target_num"))
end

function SixYearUsTaskScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SixYearUsTaskScene
