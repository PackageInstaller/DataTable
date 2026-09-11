local PushSnowBallTeamWinTaskItem = class("PushSnowBallTeamWinTaskItem", ReduxView)

function PushSnowBallTeamWinTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushSnowBallTeamWinTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardState_ = ControllerUtil.GetController(self.transform_, "stateBtn")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function PushSnowBallTeamWinTaskItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.data_ = arg_3_2
	self.cfg_ = AssignmentCfg[arg_3_2.id]
	self.rewardList_ = self.cfg_.reward

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. self.data_.id)
	self:RefreshUI()
end

function PushSnowBallTeamWinTaskItem:InitUI()
	self:BindCfgUI()
end

function PushSnowBallTeamWinTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.cfg_.id)
	end)
end

function PushSnowBallTeamWinTaskItem:SetCallBack(arg_7_1)
	self.callback = arg_7_1
end

function PushSnowBallTeamWinTaskItem:SetCheckCallBack(arg_8_1)
	self.checkCallBack_ = arg_8_1
end

function PushSnowBallTeamWinTaskItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function PushSnowBallTeamWinTaskItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. self.data_.id)
end

function PushSnowBallTeamWinTaskItem:RefreshItem()
	self.commonItem_:RefreshData({
		id = self.rewardList_[1][1],
		number = self.rewardList_[1][2]
	})
	self.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, {
			self.rewardList_[1][1]
		})
	end)
	self.commonItem_:SetBottomText(self.rewardList_[1][2])

	self.descText_.text = self.cfg_.desc
end

function PushSnowBallTeamWinTaskItem:RefreshState()
	local var_13_0 = TaskData2:GetTaskComplete(self.cfg_.id)

	if AssignmentCfg[self.cfg_.id].need > TaskData2:GetTask(self.cfg_.id).progress then
		self.rewardState_:SetSelectedState("unfinished")
	elseif not var_13_0 then
		self.rewardState_:SetSelectedState("complete")
	else
		self.rewardState_:SetSelectedState("rewarded")
	end
end

function PushSnowBallTeamWinTaskItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	self.commonItem_:Dispose()
	PushSnowBallTeamWinTaskItem.super.Dispose(self)
end

return PushSnowBallTeamWinTaskItem
