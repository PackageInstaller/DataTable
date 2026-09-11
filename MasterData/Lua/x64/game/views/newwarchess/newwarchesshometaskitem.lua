local NewWarChessHomeTaskItem = class("NewWarChessHomeTaskItem", ReduxView)

function NewWarChessHomeTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessHomeTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessHomeTaskItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "ismain")
end

function NewWarChessHomeTaskItem:SetData(arg_4_1)
	self.taskID_ = arg_4_1

	self:UpdateView()
end

function NewWarChessHomeTaskItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if NewWarChessTaskPoolCfg[self.taskID_].clickevent ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_INTERACT, nil, (NewChessTools.ParseParameterLua(NewWarChessTaskPoolCfg[self.taskID_].clickevent)))
			manager.NewChessManager:StartExecuteEvent()
		end
	end)
end

function NewWarChessHomeTaskItem:UpdateView()
	local var_7_0 = NewWarChessTaskPoolCfg[self.taskID_]

	if NewWarChessTaskPoolCfg[self.taskID_].type == NewChessConst.TASKTYPE.NORMAL then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
	end

	local var_7_1 = manager.NewChessManager.taskManager_:GetTaskInfo(self.taskID_)

	self.nameText_.text = var_7_0.description

	if var_7_0.hide_need == 1 then
		SetActive(self.progressText_.gameObject, false)
	else
		SetActive(self.progressText_.gameObject, true)

		self.progressText_.text = var_7_1.cur .. "/" .. var_7_1.need
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function NewWarChessHomeTaskItem:Dispose()
	NewWarChessHomeTaskItem.super.Dispose(self)
end

return NewWarChessHomeTaskItem
