local SkuldTravelRewardItem = class("SkuldTravelRewardItem", ReduxView)

function SkuldTravelRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkuldTravelRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelRewardItem:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listgo_, CommonItemView)
	self.statucontroller_ = ControllerUtil.GetController(self.transform_, "reward")
end

function SkuldTravelRewardItem:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData({
		id = self.rewardlist_[arg_4_1][1],
		number = self.rewardlist_[arg_4_1][2],
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function SkuldTravelRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.statu_ == 1 then
			SkuldTravelAction:GetTravelReward(self.rewardid_)
		end
	end)
end

function SkuldTravelRewardItem:SetData(arg_8_1)
	self.rewardid_ = arg_8_1
	self.desctext_.text = GetI18NText(SkuldTravelData:GetTaskTextByTaskId(self.rewardid_))
	self.statu_ = SkuldTravelData:GetTaskStatuByTaskId(self.rewardid_)

	self.statucontroller_:SetSelectedState(SkuldTravelData:GetTaskControllerStatu(self.statu_))

	self.rewardlist_ = TravelSkuldRewardCfg[self.rewardid_].reward_item_list

	self.list_:StartScroll(#self.rewardlist_)
end

function SkuldTravelRewardItem:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	SkuldTravelRewardItem.super.Dispose(self)
end

return SkuldTravelRewardItem
