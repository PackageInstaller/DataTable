local HanafudaRewardItem = class("HanafudaRewardItem", ReduxView)

function HanafudaRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HanafudaRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.rewardList_, CommonItem)
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "stateBtn")
end

function HanafudaRewardItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.cfg_ = arg_3_2

	self:RefreshUI()
end

function HanafudaRewardItem:InitUI()
	self:BindCfgUI()
end

function HanafudaRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		KagutsuchiHanafudaAction.SendGetCombineReward(self.cfg_.activity_id, self.cfg_.id, self.callback)
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		if self.checkCallBack_ then
			self.checkCallBack_(self.cfg_.id)
		end
	end)
end

function HanafudaRewardItem:SetCallBack(arg_8_1)
	self.callback = arg_8_1
end

function HanafudaRewardItem:SetCheckCallBack(arg_9_1)
	self.checkCallBack_ = arg_9_1
end

function HanafudaRewardItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function HanafudaRewardItem:RefreshItem()
	self.rewardCfg = self.cfg_.reward_item_list

	self.itemList_:StartScroll(#self.rewardCfg)

	self.nameText_.text = self.cfg_.name
end

function HanafudaRewardItem:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = self.rewardCfg[arg_12_1]

	arg_12_2:RefreshData(formatReward(self.rewardCfg[arg_12_1]))
	arg_12_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_12_0)
	end)
end

function HanafudaRewardItem:RefreshState()
	if not HanafudaData:GetIsComplete(self.cfg_.id) then
		self.rewardState_:SetSelectedState("unfinished")
	elseif not HanafudaData:GetIsRewarded(self.cfg_.id) then
		self.rewardState_:SetSelectedState("complete")
	else
		self.rewardState_:SetSelectedState("rewarded")
	end
end

function HanafudaRewardItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	HanafudaRewardItem.super.Dispose(self)
end

return HanafudaRewardItem
