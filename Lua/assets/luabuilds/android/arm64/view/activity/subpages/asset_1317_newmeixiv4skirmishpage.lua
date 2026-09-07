local NewMeixiV4SkirmishPage = class("NewMeixiV4SkirmishPage", import("...base.BaseActivityPage"))

function NewMeixiV4SkirmishPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.progressBar = self.bg:Find("progress/bar")
	self.curNum = self.bg:Find("progress/cur_num")
	self.curSection = self.bg:Find("progress/cur_section")
	self.item = self.bg:Find("scrollview/item")
	self.items = self.bg:Find("scrollview/items")
	self.uilist = UIItemList.New(self.items, self.item)

	return
end

function NewMeixiV4SkirmishPage:OnDataSetting()
	self:initTaskData()

	return updateActivityTaskStatus(self.activity)
end

function NewMeixiV4SkirmishPage:initTaskData()
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_data
	self.taskList = {}

	for iter_3_0, iter_3_1 in ipairs(self.taskGroup) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			table.insert(self.taskList, iter_3_3)
		end
	end

	self:SetClearNum()
	self:SetCurIndex()

	return
end

function NewMeixiV4SkirmishPage:SetClearNum()
	self.clearTaskNum = 0

	for iter_4_0, iter_4_1 in ipairs(self.taskList) do
		if self.taskProxy:getTaskById(iter_4_1) or self.taskProxy:getFinishTaskById(iter_4_1) then
			self.clearTaskNum = iter_4_0 - 1

			return
		end
	end

	return
end

function NewMeixiV4SkirmishPage:SetCurIndex()
	self.curTaskIndex = 1

	for iter_5_0, iter_5_1 in ipairs(self.taskList) do
		local var_5_0 = self.taskProxy:getTaskById(iter_5_1) or self.taskProxy:getFinishTaskById(iter_5_1)
		local var_5_1 = self.taskList[iter_5_0 + 1]

		if var_5_0 and var_5_0:getTaskStatus() == 2 then
			self.curTaskIndex = self.curTaskIndex + 1

			if not var_5_1 or not (self.taskProxy:getTaskById(self.taskList[iter_5_0 + 1]) or self.taskProxy:getFinishTaskById(var_5_1)) then
				self.curTaskIndex = self.curTaskIndex - 1
			end
		end
	end

	self.curTaskIndex = self.curTaskIndex + self.clearTaskNum

	return
end

function NewMeixiV4SkirmishPage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NEWMEIXIV4_SKIRMISH, {
			taskList = self.taskList
		})

		return
	end, SFX_PANEL)
	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_8_1 + 1
			local var_8_1 = arg_8_2:Find("item")
			local var_8_2 = self.taskProxy:getTaskById(self.taskList[arg_8_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskList[arg_8_1 + 1])

			setActive(arg_8_2:Find("finish"), var_8_2 and var_8_2:getTaskStatus() == 2 or var_8_0 <= self.clearTaskNum)
			setActive(arg_8_2:Find("lock"), false)
			setText(arg_8_2:Find("title"), "P" .. var_8_0)
		end

		return
	end)
	self.uilist:align(#self.taskList)

	return
end

function NewMeixiV4SkirmishPage:OnUpdateFlush()
	self:SetCurIndex()
	setText(self.curNum, string.format("%02d", self.curTaskIndex))
	setText(self.curSection, "POSITION " .. string.format("%02d", self.curTaskIndex))

	self.progressBar:GetComponent(typeof(Image)).fillAmount = self.curTaskIndex / #self.taskList
	self.items.anchoredPosition = {
		x = 0,
		y = 55 * (self.curTaskIndex - 1)
	}

	return
end

function NewMeixiV4SkirmishPage.IsShowRed()
	local var_10_0 = getProxy(TaskProxy)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(pg.activity_template[ActivityConst.NEWMEIXIV4_SKIRMISH_ID].config_data) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			table.insert(var_10_1, iter_10_3)
		end
	end

	local var_10_2 = 1

	for iter_10_4, iter_10_5 in ipairs(var_10_1) do
		local var_10_3 = var_10_0:getTaskById(iter_10_5) or var_10_0:getFinishTaskById(iter_10_5)
		local var_10_4 = var_10_1[iter_10_4 + 1]

		if var_10_3 and var_10_3:getTaskStatus() == 2 then
			var_10_2 = var_10_2 + 1

			if not var_10_4 or not (var_10_0:getTaskById(var_10_1[iter_10_4 + 1]) or var_10_0:getFinishTaskById(var_10_4)) then
				var_10_2 = var_10_2 - 1
			end
		end
	end

	local var_10_5 = var_10_1[var_10_2 + (function()
		for iter_11_0, iter_11_1 in ipairs(var_10_1) do
			if var_10_0:getTaskById(iter_11_1) or var_10_0:getFinishTaskById(iter_11_1) then
				return iter_11_0 - 1
			end
		end

		return 0
	end)()]
	local var_10_6 = var_10_0:getTaskById(var_10_5) or var_10_0:getFinishTaskById(var_10_5)

	return var_10_6 and var_10_6:getTaskStatus() == 1
end

return NewMeixiV4SkirmishPage
