local LiquorFloorTaskScene = class("LiquorFloorTaskScene", import("view.base.BaseUI"))

function LiquorFloorTaskScene:getUIName()
	return "LiquorFloorTaskUI"
end

function LiquorFloorTaskScene:init()
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setText(self.uiTitleText, i18n("LiquorFloorTaskUI_title"))

	self.itemList = {}
	self.uiLScroll = GetComponent(self.uiScroll, "LScrollRect")
	self.onInitItemHandler = handler(self, self.OnInitItem)
	self.onUpdateItemHandler = handler(self, self.OnUpdateItem)
	self.uiLScroll.onInitItem = self.onInitItemHandler
	self.uiLScroll.onUpdateItem = self.onUpdateItemHandler

	return
end

function LiquorFloorTaskScene:didEnter()
	self:BlurView()
	self:RefreshUI()

	return
end

function LiquorFloorTaskScene:willExit()
	self:UnBlurView()

	self.uiLScroll.onInitItem = nil
	self.uiLScroll.onUpdateItem = nil
	self.onInitItemHandler = nil
	self.onUpdateItemHandler = nil

	return
end

function LiquorFloorTaskScene:BlurView()
	self:BlurPanel(self._tf)

	return
end

function LiquorFloorTaskScene:UnBlurView()
	self:UnOverlayPanel(self._tf)

	return
end

function LiquorFloorTaskScene:GetTaskList()
	local var_9_0 = getProxy(TaskProxy)
	local var_9_1 = getProxy(ActivityProxy):getActivityById(self.contextData.activityID):getConfig("config_client").taskActivityID
	local var_9_2 = getProxy(ActivityProxy):getActivityById(var_9_1)
	local var_9_3 = {}
	local var_9_4 = getProxy(TaskProxy)

	for iter_9_0, iter_9_1 in ipairs(pg.activity_template[var_9_1].config_data) do
		table.insert(var_9_3, var_9_4:getTaskVO(iter_9_1))
	end

	return var_9_3
end

function LiquorFloorTaskScene:RefreshUI()
	self.taskList = self:GetTaskList()

	self:Sort(self.taskList)
	self.uiLScroll:SetTotalCount(#self.taskList)

	return
end

function LiquorFloorTaskScene:OnInitItem(arg_11_1)
	self.itemList[arg_11_1] = LiquorFloorTaskItem.New(tf(arg_11_1), self)

	return
end

function LiquorFloorTaskScene:OnUpdateItem(arg_12_1, arg_12_2)
	if self.itemList[arg_12_2] == nil then
		self:OnInitItem(arg_12_2)
	end

	self.itemList[arg_12_2]:SetData(self.taskList[arg_12_1 + 1])

	return
end

function LiquorFloorTaskScene:Sort()
	local function var_13_0(arg_14_0, arg_14_1, arg_14_2)
		local function var_14_0(arg_15_0)
			for iter_15_0, iter_15_1 in ipairs(arg_14_2) do
				if arg_15_0 == iter_15_1 then
					return iter_15_0
				end
			end

			return
		end

		return var_14_0(arg_14_0) < var_14_0(arg_14_1)
	end

	table.sort(self.taskList, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:getTaskStatus()
		local var_16_1 = arg_16_1:getTaskStatus()

		if var_16_0 == var_16_1 then
			return arg_16_0.id < arg_16_1.id
		end

		return var_13_0(var_16_0, var_16_1, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

return LiquorFloorTaskScene
