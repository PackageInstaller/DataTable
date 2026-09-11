local SummerChessBoardExloreNoteItem = class("SummerChessBoardExloreNoteItem", ReduxView)

function SummerChessBoardExloreNoteItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.withPicController_ = self.controllerEx_:GetController("WithPic")
	self.btnStateController_ = self.controllerEx_:GetController("Btn")
	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
end

function SummerChessBoardExloreNoteItem:OnEnter()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.taskUpdateHandler_)
end

function SummerChessBoardExloreNoteItem:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.taskUpdateHandler_)
end

function SummerChessBoardExloreNoteItem:Dispose()
	self.taskUpdateHandler_ = nil

	SummerChessBoardExloreNoteItem.super.Dispose(self)
end

function SummerChessBoardExloreNoteItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if TaskData2:GetTaskComplete(self.taskID_) then
			return
		end

		TaskAction:SubmitTask(self.taskID_)
	end)
end

function SummerChessBoardExloreNoteItem:SetData(arg_7_1)
	self.taskID_ = arg_7_1

	self:RefreshUI()
end

function SummerChessBoardExloreNoteItem:RefreshUI()
	local var_8_0 = AssignmentCfg[self.taskID_]

	if AssignmentCfg[self.taskID_] == nil then
		return
	end

	if #var_8_0.reward > 0 then
		if TaskData2:GetTaskComplete(self.taskID_) then
			self.btnStateController_:SetSelectedState("finished")
		else
			self.btnStateController_:SetSelectedState("award")
		end
	else
		self.btnStateController_:SetSelectedState("hide")
	end

	if AssignmentExploreNoteCfg[self.taskID_] ~= nil then
		self.withPicController_:SetSelectedState("true")

		self.text2_.text = var_8_0.desc

		SetSpriteWithoutAtlasAsync(self.image_, AssignmentExploreNoteCfg[self.taskID_].image_path)
	else
		self.withPicController_:SetSelectedState("false")

		self.text1_.text = var_8_0.desc
	end

	self:Show(true)
end

function SummerChessBoardExloreNoteItem:TaskUpdate()
	self:RefreshUI()
end

function SummerChessBoardExloreNoteItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 == false then
		self.taskID_ = nil
	end
end

return SummerChessBoardExloreNoteItem
