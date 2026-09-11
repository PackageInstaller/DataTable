local PaperCutRewardItem = class("PaperCutRewardItem", ReduxView)

function PaperCutRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PaperCutRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, CommonItem)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "status")
end

function PaperCutRewardItem:SetData(arg_3_1)
	self.taskID_ = arg_3_1
	self.activityID_ = ActivityPointRewardCfg[arg_3_1].activity_id

	self:RefreshUI()
end

function PaperCutRewardItem:InitUI()
	self:BindCfgUI()
end

function PaperCutRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutAction.RequireReceive(self.taskID_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward2(arg_7_0.reward_list)
				PaperCutData:SetReceivedList(self.activityID_, self.taskID_)
				self:RefreshState()

				if self.onReceived_ ~= nil then
					self.onReceived_()
				end
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function PaperCutRewardItem:RefreshUI()
	self.descText_.text = string.format(GetTips("ACTIVITY_CUT_POINT_REWARD"), GetI18NText(PaperCutCfg[self.activityID_].name), ActivityPointRewardCfg[self.taskID_].need)

	self:RefreshState()
	self:RefreshItem()
end

function PaperCutRewardItem:RefreshState()
	local var_9_0 = table.keyof(PaperCutData:GetReceivedList(self.activityID_), self.taskID_) ~= nil

	if PaperCutData:GetScore(self.activityID_) < ActivityPointRewardCfg[self.taskID_].need then
		self.rewardState_:SetSelectedState("uncompleted")
	elseif not var_9_0 then
		self.rewardState_:SetSelectedState("unreceived")
	else
		self.rewardState_:SetSelectedState("received")
	end
end

function PaperCutRewardItem:RefreshItem()
	self.rewardCfg_ = ActivityPointRewardCfg[self.taskID_].reward_item_list

	self.itemList_:StartScroll(#self.rewardCfg_)
end

function PaperCutRewardItem:IndexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(self.rewardCfg_[arg_11_1]))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function PaperCutRewardItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	self.onReceived_ = nil

	PaperCutRewardItem.super.Dispose(self)
end

function PaperCutRewardItem:SetReveivedHandler(arg_14_1)
	self.onReceived_ = arg_14_1
end

return PaperCutRewardItem
