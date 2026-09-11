local PushSnowBallTeamTaskItem = class("PushSnowBallTeamTaskItem", ReduxView)

function PushSnowBallTeamTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushSnowBallTeamTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.itemList__, CommonItem)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "state")
end

function PushSnowBallTeamTaskItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.data_ = arg_3_2
	self.cfg_ = AssignmentCfg[arg_3_2.id]

	self:RefreshUI()
end

function PushSnowBallTeamTaskItem:InitUI()
	self:BindCfgUI()
end

function PushSnowBallTeamTaskItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTask(self.cfg_.id)
	end)
end

function PushSnowBallTeamTaskItem:SetCallBack(arg_7_1)
	self.callback = arg_7_1
end

function PushSnowBallTeamTaskItem:SetCheckCallBack(arg_8_1)
	self.checkCallBack_ = arg_8_1
end

function PushSnowBallTeamTaskItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function PushSnowBallTeamTaskItem:RefreshItem()
	self.rewardCfg_ = self.cfg_.reward

	self.itemList_:StartScroll(#self.rewardCfg_)

	self.progress_.text = math.min(self.data_.progress, AssignmentCfg[self.cfg_.id].need) .. "/" .. AssignmentCfg[self.cfg_.id].need
	self.descText_.text = self.cfg_.desc
	self.slider_.value = TaskData2:GetTaskProgress(self.cfg_.id)
end

function PushSnowBallTeamTaskItem:IndexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(self.rewardCfg_[arg_11_1]))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function PushSnowBallTeamTaskItem:RefreshState()
	local var_13_0 = self.data_.complete_flag >= 1

	if AssignmentCfg[self.cfg_.id].need > self.data_.progress then
		self.rewardState_:SetSelectedState("unfinished")
	elseif not var_13_0 then
		self.rewardState_:SetSelectedState("complete")
	else
		self.rewardState_:SetSelectedState("rewarded")
	end
end

function PushSnowBallTeamTaskItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	PushSnowBallTeamTaskItem.super.Dispose(self)
end

return PushSnowBallTeamTaskItem
