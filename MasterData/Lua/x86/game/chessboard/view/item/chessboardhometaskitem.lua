local ChessBoardHomeTaskItem = class("ChessBoardHomeTaskItem", ReduxView)

function ChessBoardHomeTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardHomeTaskItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardHomeTaskItem:InitUI()
	self:BindCfgUI()
end

function ChessBoardHomeTaskItem:SetData(arg_4_1)
	self.taskID_ = arg_4_1

	self:UpdateView()
end

function ChessBoardHomeTaskItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if type(ChessBoardTaskPoolCfg[self.taskID_].camera_move) == "table" and ChessBoardTaskPoolCfg[self.taskID_].camera_move[1] ~= nil then
			manager.ChessBoardManager:MoveToTarget(ChessBoardTaskPoolCfg[self.taskID_].camera_move[1], ChessBoardTaskPoolCfg[self.taskID_].camera_move[2])
		end
	end)
end

function ChessBoardHomeTaskItem:UpdateView()
	local var_7_0 = manager.ChessBoardManager.taskManager_:GetTaskInfo(self.taskID_)

	self.nameText_.text = ChessBoardTaskPoolCfg[self.taskID_].title
	self.descText_.text = ChessBoardTaskPoolCfg[self.taskID_].description

	if ChessBoardTaskPoolCfg[self.taskID_].cost > 0 then
		SetActive(self.costGo_, true)

		self.costText_.text = ChessBoardTaskPoolCfg[self.taskID_].cost
	else
		SetActive(self.costGo_, false)
	end

	if self.taskID_ == ChessBoardConst.GET_DUCK_TASKID then
		SetActive(self.normalDescGo_, false)
		SetActive(self.duckDescGo_, true)
	else
		SetActive(self.normalDescGo_, true)
		SetActive(self.duckDescGo_, false)
	end
end

function ChessBoardHomeTaskItem:Dispose()
	ChessBoardHomeTaskItem.super.Dispose(self)
end

return ChessBoardHomeTaskItem
