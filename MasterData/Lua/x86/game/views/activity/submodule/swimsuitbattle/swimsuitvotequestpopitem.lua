local SwimsuitVoteQuestPopItem = class("SwimsuitVoteQuestPopItem", ReduxView)

function SwimsuitVoteQuestPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SwimsuitVoteQuestPopItem:Init()
	self:BindCfgUI()

	self.task1Item_ = SwimsuitVoteQuestTaskItem.New(self.task1Go_)
	self.task2Item_ = SwimsuitVoteQuestTaskItem.New(self.task2Go_)
	self.titleController_ = self.mainControllerEx_:GetController("title")
end

function SwimsuitVoteQuestPopItem:SetData(arg_3_1)
	self.titleController_:SetSelectedState(tostring(arg_3_1))

	local var_3_0 = SwimsuitBattleData:GetTaskIdByRound(arg_3_1)

	self.task1Item_:SetData(var_3_0[1], arg_3_1)
	self.task2Item_:SetData(var_3_0[2], arg_3_1)
end

function SwimsuitVoteQuestPopItem:Dispose()
	if self.task1Item_ then
		self.task1Item_:Dispose()

		self.task1Item_ = nil
	end

	if self.task2Item_ then
		self.task2Item_:Dispose()

		self.task2Item_ = nil
	end

	SwimsuitVoteQuestPopItem.super.Dispose(self)
end

return SwimsuitVoteQuestPopItem
