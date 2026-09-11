local CombineGamePoolTaskItem = class("CombineGamePoolTaskItem", ReduxView)

function CombineGamePoolTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function CombineGamePoolTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGamePoolTaskItem:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.typeController = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, CommonItem)
end

function CombineGamePoolTaskItem:SetItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = self.cfg.reward[arg_4_1][1],
		number = self.cfg.reward[arg_4_1][2]
	})
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
end

function CombineGamePoolTaskItem:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId) then
			return
		end

		TaskAction:SubmitTask(self.taskId)
	end)
end

function CombineGamePoolTaskItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index = arg_8_1
	self.taskId = arg_8_2
	self.cfg = AssignmentCfg[arg_8_2]
	self.activityId = arg_8_3
	self.showBar = true

	self:UpdateView()
end

function CombineGamePoolTaskItem:HideBar()
	self.showBar = false

	SetActive(self.barGo_, self.showBar)
	SetActive(self.processTxt_.gameObject, self.showBar)
end

function CombineGamePoolTaskItem:UpdateView()
	local var_10_0 = TaskData2:GetTask(self.taskId)
	local var_10_1 = 0

	self.controller:SetSelectedState("cannotGet")

	if var_10_0 then
		var_10_1 = var_10_0.progress
	end

	if var_10_1 >= self.cfg.need then
		var_10_1 = self.cfg.need

		self.controller:SetSelectedState("get")
	end

	if var_10_0 ~= nil and TaskData2:GetTaskComplete(self.taskId) then
		self.controller:SetSelectedState("getted")
	end

	self.typeController:SetSelectedState(self.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "false" or "true")
	self.list:StartScroll(#self.cfg.reward)

	self.descTxt_.text = GetI18NText(self.cfg.desc)
	self.processTxt_.text = var_10_1 .. "/" .. self.cfg.need
	self.barImg_.fillAmount = var_10_1 / self.cfg.need

	SetActive(self.barGo_, self.showBar)
	SetActive(self.processTxt_.gameObject, self.showBar)
end

function CombineGamePoolTaskItem:OnEnter()
	self:UpdateView()
end

function CombineGamePoolTaskItem:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CombineGamePoolTaskItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGamePoolTaskItem
