local PushSnowBallTeamTaskItem = class("PushSnowBallTeamTaskItem", ReduxView)

function PushSnowBallTeamTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushSnowBallTeamTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.rewardList_, CommonItem)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "state")
end

function PushSnowBallTeamTaskItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.id_ = arg_3_2
	self.cfg_ = ActivityPointRewardCfg[arg_3_2]

	self:RefreshUI()
end

function PushSnowBallTeamTaskItem:InitUI()
	self:BindCfgUI()
end

function PushSnowBallTeamTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(PushSnowBallData:GetActivityID()) then
			ShowTips("TIME_OVER")

			return
		end

		PushSnowBallAction:ReceiveScoreReward(self.id_)
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
	self.rewardCfg_ = self.cfg_.reward_item_list

	self.itemList_:StartScroll(#self.rewardCfg_)

	self.descText_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), self.cfg_.need)

	local var_10_0 = PushSnowBallData:GetScoreByActivityID(self.cfg_.activity_id)

	self.progressText_.text = math.min(var_10_0, self.cfg_.need) .. "/" .. self.cfg_.need
	self.slider_.value = var_10_0 / self.cfg_.need
end

function PushSnowBallTeamTaskItem:IndexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(self.rewardCfg_[arg_11_1]))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function PushSnowBallTeamTaskItem:RefreshState()
	if not PushSnowBallData:GetScoreTaskIsCompleteById(self.cfg_.id) then
		self.rewardState_:SetSelectedState("unfinished")
	elseif not PushSnowBallData:GetScoreTaskIsRewardedById(self.cfg_.id) then
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
