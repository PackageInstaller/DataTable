local IndiaNianRewardItem = class("IndiaNianRewardItem", ReduxView)

function IndiaNianRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function IndiaNianRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItem)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "state")
end

function IndiaNianRewardItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.data_ = arg_3_2
	self.cfg_ = AssignmentCfg[arg_3_2.id]

	self:RefreshUI()
end

function IndiaNianRewardItem:InitUI()
	self:BindCfgUI()
end

function IndiaNianRewardItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TaskAction:SubmitTaskList({
			self.cfg_.id
		})
	end)
end

function IndiaNianRewardItem:SetCallBack(arg_7_1)
	self.callback = arg_7_1
end

function IndiaNianRewardItem:SetCheckCallBack(arg_8_1)
	self.checkCallBack_ = arg_8_1
end

function IndiaNianRewardItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function IndiaNianRewardItem:RefreshItem()
	self.rewardCfg_ = self.cfg_.reward

	self.itemList_:StartScroll(#self.rewardCfg_)

	self.descText_.text = self.cfg_.desc
end

function IndiaNianRewardItem:IndexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(self.rewardCfg_[arg_11_1]))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function IndiaNianRewardItem:RefreshState()
	local var_13_0 = self.data_.complete_flag >= 1

	if AssignmentCfg[self.cfg_.id].need > self.data_.progress then
		self.rewardState_:SetSelectedState("unfinished")
	elseif not var_13_0 then
		self.rewardState_:SetSelectedState("complete")
	else
		self.rewardState_:SetSelectedState("rewarded")
	end
end

function IndiaNianRewardItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	IndiaNianRewardItem.super.Dispose(self)
end

return IndiaNianRewardItem
