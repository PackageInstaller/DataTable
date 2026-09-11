local ReversePacmanTaskScene = class("ReversePacmanTaskScene", import("view.base.BaseUI"))

function ReversePacmanTaskScene:getUIName()
	return "ReversePacmanTaskUI"
end

function ReversePacmanTaskScene:init()
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.uiGetAllBtn, function()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(self.taskList) do
			if iter_5_1:getTaskStatus() == 1 then
				table.insert(var_5_0, iter_5_1.id)
			end
		end

		if #var_5_0 <= 0 then
			return
		end

		self:emit(ReversePacmanTaskMediator.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, self.taskActivityID, var_5_0)

		return
	end, SFX_PANEL)

	self.itemList = {}
	self.uiLScroll = GetComponent(self.uiScroll, "LScrollRect")
	self.onInitItemHandler = handler(self, self.OnInitItem)
	self.onUpdateItemHandler = handler(self, self.OnUpdateItem)
	self.uiLScroll.onInitItem = self.onInitItemHandler
	self.uiLScroll.onUpdateItem = self.onUpdateItemHandler

	return
end

function ReversePacmanTaskScene:didEnter()
	self:BlurView()
	self:RefreshUI()

	return
end

function ReversePacmanTaskScene:willExit()
	self:UnBlurView()

	self.uiLScroll.onInitItem = nil
	self.uiLScroll.onUpdateItem = nil
	self.onInitItemHandler = nil
	self.onUpdateItemHandler = nil

	return
end

function ReversePacmanTaskScene:BlurView()
	self:BlurPanel(self._tf)

	return
end

function ReversePacmanTaskScene:UnBlurView()
	self:UnOverlayPanel(self._tf)

	return
end

function ReversePacmanTaskScene:GetTaskList()
	local var_10_0 = getProxy(TaskProxy)
	local var_10_1 = ReversePacmanTools.GetActivity():getConfig("config_client").taskActivityID
	local var_10_2 = getProxy(ActivityProxy):getActivityById(var_10_1)

	self.taskActivityID = var_10_1

	local var_10_3 = {}
	local var_10_4 = getProxy(TaskProxy)

	for iter_10_0, iter_10_1 in ipairs(pg.activity_template[var_10_1].config_data) do
		table.insert(var_10_3, var_10_4:getTaskVO(iter_10_1))
	end

	return var_10_3
end

function ReversePacmanTaskScene:RefreshUI()
	self.taskList = self:GetTaskList()

	self:Sort(self.taskList)
	self.uiLScroll:SetTotalCount(#self.taskList)

	if self.contextData.taskID then
		self:ScrollToTask(self.contextData.taskID)

		self.contextData.taskID = nil
	end

	setGray(self.uiGetAllBtn, not self:IsTip())

	return
end

function ReversePacmanTaskScene:ScrollToTask(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.taskList) do
		if iter_12_1.id == arg_12_1 then
			self.uiLScroll:ScrollTo(math.clamp(self.uiLScroll:HeadIndexToValue(iter_12_0 - 1), 0, 1))

			return
		end
	end

	return
end

function ReversePacmanTaskScene:OnInitItem(arg_13_1)
	self.itemList[arg_13_1] = ReversePacmanTaskItem.New(tf(arg_13_1), self)

	return
end

function ReversePacmanTaskScene:OnUpdateItem(arg_14_1, arg_14_2)
	if self.itemList[arg_14_2] == nil then
		self:OnInitItem(arg_14_2)
	end

	self.itemList[arg_14_2]:SetData(self.taskList[arg_14_1 + 1])

	return
end

function ReversePacmanTaskScene:Sort()
	local function var_15_0(arg_16_0, arg_16_1, arg_16_2)
		local function var_16_0(arg_17_0)
			for iter_17_0, iter_17_1 in ipairs(arg_16_2) do
				if arg_17_0 == iter_17_1 then
					return iter_17_0
				end
			end

			return
		end

		return var_16_0(arg_16_0) < var_16_0(arg_16_1)
	end

	table.sort(self.taskList, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0:getTaskStatus()
		local var_18_1 = arg_18_1:getTaskStatus()

		if var_18_0 == var_18_1 then
			return arg_18_0.id < arg_18_1.id
		end

		return var_15_0(var_18_0, var_18_1, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

function ReversePacmanTaskScene:IsTip()
	for iter_19_0, iter_19_1 in ipairs(self.taskList) do
		if iter_19_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return ReversePacmanTaskScene
