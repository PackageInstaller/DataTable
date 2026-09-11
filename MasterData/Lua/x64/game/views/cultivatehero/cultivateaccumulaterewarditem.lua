local CultivateAccumulateRewardItem = class("CultivateAccumulateRewardItem", ReduxView)

function CultivateAccumulateRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultivateAccumulateRewardItem:Init()
	self:InitUI()

	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "status")
end

function CultivateAccumulateRewardItem:InitUI()
	self:BindCfgUI()
end

function CultivateAccumulateRewardItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.index_ = arg_4_1
	self.taskID_ = arg_4_2
	self.activityID_ = arg_4_3
	self.maxRewardNum_ = arg_4_4

	self:RefreshUI()
end

function CultivateAccumulateRewardItem:RefreshUI()
	self.titleText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), self.index_)
	self.indexText_.text = self.index_ < 10 and "0" .. self.index_ or self.index_
	self.needText_.text = ActivityPointRewardCfg[self.taskID_].need
	self.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[self.activityID_].coin_id)

	self:RefreshReward()
end

function CultivateAccumulateRewardItem:RefreshReward()
	local var_6_0 = CultivateHeroData:GetAccumulateTaskInfoList(self.activityID_)
	local var_6_1 = var_6_0[self.taskID_] and var_6_0[self.taskID_].isReceived

	if var_6_1 == true then
		self.rewardState_:SetSelectedState("received")
	else
		self.rewardState_:SetSelectedState("none")
	end

	local var_6_2 = ActivityPointRewardCfg[self.taskID_].reward_item_list

	for iter_6_0 = 1, self.maxRewardNum_ do
		if not self.itemDataList_[iter_6_0] then
			self.itemDataList_[iter_6_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_6_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_6_3 = true

		if var_6_2[iter_6_0] then
			self.itemDataList_[iter_6_0].id = var_6_2[iter_6_0][1]
			self.itemDataList_[iter_6_0].number = var_6_2[iter_6_0][2]
			var_6_3 = false
			self.itemDataList_[iter_6_0].grayFlag = not not var_6_1
		end

		if self.rewardItemList_[iter_6_0] == nil then
			self.rewardItemList_[iter_6_0] = CommonItemPool.New(self.goRewardPanel_, nil, true)
		end

		self.rewardItemList_[iter_6_0]:Show(true)

		if not var_6_3 then
			self.rewardItemList_[iter_6_0]:SetData(self.itemDataList_[iter_6_0])
		else
			self.rewardItemList_[iter_6_0]:SetData(nil)
		end
	end
end

function CultivateAccumulateRewardItem:RefreshItem()
	self.rewardCfg_ = ActivityPointRewardCfg[self.taskID_].reward_item_list

	self.itemList_:StartScroll(#self.rewardCfg_)
end

function CultivateAccumulateRewardItem:Dispose()
	if self.rewardItemList_ then
		for iter_9_0, iter_9_1 in ipairs(self.rewardItemList_) do
			iter_9_1:Dispose()
		end

		self.rewardItemList_ = nil
	end

	CultivateAccumulateRewardItem.super.Dispose(self)
end

return CultivateAccumulateRewardItem
