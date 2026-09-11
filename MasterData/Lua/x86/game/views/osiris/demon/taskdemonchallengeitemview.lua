local TaskDemonChallengeItemView = class("TaskDemonChallengeItemView", ReduxView)
local JumpTools = import("game.tools.JumpTools")
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function TaskDemonChallengeItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.popType_ = POP_ITEM

	SetActive(self.gameObject_, true)
	self:Init()
end

function TaskDemonChallengeItemView:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, CommonItem)
	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
	self.receiveHandler = handler(self, self.OnReceiveReward)
end

function TaskDemonChallengeItemView:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.rewardCfg_ = getRewardFromDropCfg(arg_3_1, true)
	self.rewardIndex_ = arg_3_2
	self.levelIndex_ = arg_3_3

	self:GetRewardState()
	self:RefreshUI()
	self:RefreshState()
	self:RefreshItem()
end

function TaskDemonChallengeItemView:InitUI()
	self:BindCfgUI()
end

function TaskDemonChallengeItemView:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.rewardState_ == var_0_2 then
			DemonChallengeAction.RequireReceive(DemonChallengeData:GetStageId(self.levelIndex_, self.rewardIndex_), self.receiveHandler)
		end
	end)
end

function TaskDemonChallengeItemView:OnReceiveReward(arg_7_1)
	if isSuccess(arg_7_1.result) then
		DemonChallengeData:SetReceiveList(self.rewardIndex_, self.levelIndex_)
		self:GetRewardState()
		getReward(self.rewardCfg_)

		if self.rewardState_ == var_0_2 and self.rewardState_ == var_0_4 then
			self:RefreshState()
			manager.notify:Invoke(DEMON_CHALLENGE_RECEIVE_REWARD)
		end
	else
		ShowTips(arg_7_1.result)
	end
end

function TaskDemonChallengeItemView:GetRewardState()
	self.completed_ = DemonChallengeData:IsCompleted(self.levelIndex_, self.rewardIndex_)
	self.rewardState_ = not self.completed_ and var_0_3 or table.keyof(DemonChallengeData:GetReceiveList(self.levelIndex_), self.rewardIndex_) and var_0_4 or var_0_2
end

function TaskDemonChallengeItemView:RefreshUI()
	self.Desctext_.text = self.rewardIndex_ == 1 and GetTips("CLEAR_NORMAL_DIFFICULTY") or self.rewardIndex_ == 2 and GetTips("CLEAR_DIFFICULTY") or GetTips("CLEAR_EXTREME_DIFFICULTY")
end

function TaskDemonChallengeItemView:RefreshState()
	self.controller_:SetSelectedState(tostring(self.rewardState_))
end

function TaskDemonChallengeItemView:RefreshItem()
	self.itemList_:StartScroll(#self.rewardCfg_)
end

function TaskDemonChallengeItemView:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = rewardToItemTemplate(self.rewardCfg_[arg_12_1])

	var_12_0.RefreshData(var_12_0, var_12_0)
	var_12_0:RegistCallBack(function(arg_13_0)
		if self.clickCallback_ then
			if self.clickCallback_() then
				ShowPopItem(self.popType_, arg_13_0)
			end
		else
			ShowPopItem(self.popType_, arg_13_0)
		end
	end)
	var_12_0:Show(true)
end

function TaskDemonChallengeItemView:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()
	end

	TaskDemonChallengeItemView.super.Dispose(self)
end

return TaskDemonChallengeItemView
