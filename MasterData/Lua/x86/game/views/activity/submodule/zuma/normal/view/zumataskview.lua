local ZumaTalentView = class("ZumaTalentView", ReduxView)
local var_0_1 = {
	showState = {
		showOneClick = "showOneClick",
		name = "clear",
		normal = "normal"
	}
}

function ZumaTalentView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaQuestPopup"
end

function ZumaTalentView:UIParent()
	return manager.ui.uiPop.transform
end

function ZumaTalentView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ZumaTalentView:InitUI()
	self:BindCfgUI()

	self.showStateController = self.controllerexcollection_:GetController(var_0_1.showState.name)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, ZumaTaskItem)
end

function ZumaTalentView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskDataList[arg_5_1])
end

function ZumaTalentView:OnTaskListChange()
	self.taskDataList = ZumaData:GetZumaTaskData()

	self.list_:StartScroll(#self.taskDataList)
	self:UpdateTaskData()
end

function ZumaTalentView:UpdateTaskData()
	self.taskDataList = ZumaData:GetZumaTaskData()

	self.list_:StartScroll(#self.taskDataList)

	local var_7_0 = false

	for iter_7_0, iter_7_1 in ipairs(self.taskDataList) do
		if iter_7_1.progress >= AssignmentCfg[iter_7_1.id].need and iter_7_1.complete_flag < 1 then
			var_7_0 = true

			return
		end
	end

	self.showStateController:SetSelectedState((var_7_0 or nil) and (var_0_1.showState.showOneClick or var_0_1.showState.normal))
end

function ZumaTalentView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnReceive()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function ZumaTalentView:OnReceive()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self.taskDataList) do
		if iter_11_1.progress >= AssignmentCfg[iter_11_1.id].need and iter_11_1.complete_flag < 1 then
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	TaskAction:SubmitTaskList(var_11_0)
end

function ZumaTalentView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ZumaTalentView:OnEnter()
	self:UpdateTaskData()
end

function ZumaTalentView:OnExit()
	return
end

function ZumaTalentView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	ZumaTalentView.super.Dispose(self)
end

return ZumaTalentView
