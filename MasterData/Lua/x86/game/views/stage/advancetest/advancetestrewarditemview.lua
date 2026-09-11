local AdvanceTestRewardItemView = class("AdvanceTestRewardItemView", ReduxView)

function AdvanceTestRewardItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function AdvanceTestRewardItemView:Init()
	self:InitUI()
end

function AdvanceTestRewardItemView:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItemView)
	self.itemDataList_ = {}
end

function AdvanceTestRewardItemView:SetData(arg_4_1, arg_4_2)
	self.startRank = arg_4_1
	self.endRank = ActivityPointRewardCfg[arg_4_2].need
	self.rewardCfg = ActivityPointRewardCfg[arg_4_2].reward_item_list

	self:RefreshUI()
end

function AdvanceTestRewardItemView:IndexItem(arg_5_1, arg_5_2)
	if not self.itemDataList_[arg_5_1] then
		self.itemDataList_[arg_5_1] = clone(ItemTemplateData)
		self.itemDataList_[arg_5_1].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemDataList_[arg_5_1].id = self.rewardCfg[arg_5_1][1]
	self.itemDataList_[arg_5_1].number = self.rewardCfg[arg_5_1][2]

	arg_5_2:SetData(self.itemDataList_[arg_5_1])
end

function AdvanceTestRewardItemView:RefreshUI()
	self.descText_.text = string.format("排名:%s", self.startRank .. "-" .. self.endRank)

	self.itemList_:StartScroll(#self.rewardCfg)
end

function AdvanceTestRewardItemView:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	AdvanceTestRewardItemView.super.Dispose(self)
end

return AdvanceTestRewardItemView
