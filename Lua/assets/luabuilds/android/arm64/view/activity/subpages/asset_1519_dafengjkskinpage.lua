local DaFengJKSkinPage = class("DaFengJKSkinPage", import("...base.BaseActivityPage"))

function DaFengJKSkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.getBtn = self.bg:Find("available")
	self.unavailableTF = self.bg:Find("unavailable")
	self.phaseTF = self.bg:Find("phase")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function DaFengJKSkinPage:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")[1]
	self.submitVO = nil

	return
end

function DaFengJKSkinPage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		local var_4_0 = self.taskProxy:getTaskById(self.taskList[arg_4_1]) or self.taskProxy:getFinishTaskById(self.taskList[arg_4_1])

		assert(var_4_0, "without this task by id: " .. self.taskList[arg_4_1])

		if arg_4_0 == UIItemList.EventInit then
			local var_4_1 = var_4_0:getConfig("award_display")[1]
			local var_4_2 = {
				type = var_4_1[1],
				id = var_4_1[2],
				count = var_4_1[3]
			}

			updateDrop(arg_4_2:Find("item"), var_4_2)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_2)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("got"), var_4_0:getTaskStatus() == 2)
		end

		return
	end)
	onButton(self, self.getBtn, function()
		if self.submitVO then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, self.submitVO)
		end

		return
	end, SFX_PANEL)

	return
end

function DaFengJKSkinPage:OnUpdateFlush()
	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(self.taskList) do
		local var_7_2 = self.taskProxy:getTaskById(iter_7_1) or self.taskProxy:getFinishTaskById(iter_7_1)

		assert(var_7_2, "without this task by id: " .. iter_7_1)

		if var_7_2:getTaskStatus() == 1 then
			var_7_0 = var_7_0 + 1
			self.submitVO = self.submitVO or var_7_2
		end

		if var_7_2:getTaskStatus() == 2 then
			var_7_1 = var_7_1 + 1
		end
	end

	setActive(self.getBtn, var_7_0 > 0)
	setActive(self.unavailableTF, var_7_0 <= 0)
	eachChild(self.phaseTF, function(arg_8_0)
		setActive(arg_8_0, tonumber(arg_8_0.name) <= var_7_0 + var_7_1)

		return
	end)
	self.itemList:align(#self.taskList)

	return
end

function DaFengJKSkinPage:OnDestroy()
	return
end

return DaFengJKSkinPage
