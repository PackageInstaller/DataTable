local USDefTaskWindowView = class("USDefTaskWindowView", import("...base.BaseSubView"))

function USDefTaskWindowView:Load()
	self._tf = findTF(self._parentTf, "USDefTaskWindow")
	self._go = go(self._tf)

	pg.DelegateInfo.New(self)
	self:OnInit()

	return
end

function USDefTaskWindowView:Destroy()
	self:Hide()

	return
end

function USDefTaskWindowView:OnInit()
	self:initData()
	self:initUI()
	self:updateProgress()
	self:updateTaskList()
	self:Show()

	return
end

function USDefTaskWindowView:OnDestroy()
	return
end

function USDefTaskWindowView:initData()
	self.taskIDList = Clone(pg.task_data_template[self.contextData:getConfig("config_client")[1]].target_id)
	self.taskProxy = getProxy(TaskProxy)
	self.taskVOList = {}

	for iter_5_0, iter_5_1 in ipairs(self.taskIDList) do
		table.insert(self.taskVOList, (self.taskProxy:getTaskVO(iter_5_1)))
	end

	return
end

function USDefTaskWindowView:initUI()
	self.bg = self._tf:Find("BG")
	self.curNumTextTF = self._tf:Find("ProgressPanel/CurNumText")
	self.totalNumText = self._tf:Find("ProgressPanel/TotalNumText")
	self.taskTpl = self._tf:Find("TaskTpl")
	self.taskContainer = self._tf:Find("TaskList/Viewport/Content")
	self.taskList = UIItemList.New(self.taskContainer, self.taskTpl)

	onButton(self, self.bg, function()
		self:Destroy()

		return
	end, SFX_CANCEL)

	return
end

function USDefTaskWindowView:updateProgress()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.taskVOList) do
		if iter_8_1:getTaskStatus() >= 1 then
			var_8_0 = var_8_0 + 1
		end
	end

	setText(self.curNumTextTF, string.format("%2d", var_8_0))
	setText(self.totalNumText, string.format("%2d", #self.taskIDList))

	return
end

function USDefTaskWindowView:updateTaskList()
	self.taskList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_10_1 = arg_10_1 + 1

			local var_10_0 = self.taskVOList[arg_10_1]
			local var_10_1 = arg_10_2:Find("ItemBG/Finished")

			setText(arg_10_2:Find("IndexText"), string.format("%02d", arg_10_1))
			setText(arg_10_2:Find("TaskIndexText"), "TASK-" .. string.format("%02d", arg_10_1))
			setText(arg_10_2:Find("DescText"), (var_10_0:getConfig("desc")))

			local var_10_2 = tonumber(var_10_0:getConfig("target_id"))

			if not pg.ship_data_statistics[var_10_2] then
				var_10_2 = 205054
			end

			LoadImageSpriteAsync("SquareIcon/" .. pg.ship_skin_template[pg.ship_data_statistics[var_10_2].skin_id].painting, (arg_10_2:Find("ItemBG/Icon")))
			setActive(var_10_1, var_10_0:getTaskStatus() >= 1)
		end

		return
	end)
	self.taskList:align(#self.taskIDList)

	return
end

return USDefTaskWindowView
