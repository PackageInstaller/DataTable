local TangramRegionRewardItem = class("TangramRegionRewardItem", ReduxView)

function TangramRegionRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.statusConst_ = {
		UNFINISH = 0,
		RECEIVED = 1
	}

	SetActive(self.gameObject_, true)
	self:Init()
end

function TangramRegionRewardItem:Init()
	self:InitUI()
end

function TangramRegionRewardItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function TangramRegionRewardItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	self.commonItem_:Dispose()

	self.commonItem_ = nil

	TangramRegionRewardItem.super.Dispose(self)
end

function TangramRegionRewardItem:SetData(arg_5_1, arg_5_2)
	self.activityID_ = arg_5_1
	self.regionID_ = arg_5_2
	self.rewardCfg_ = TangramPuzzleTools.GetRegionRewardList(arg_5_1, self.regionID_)

	self:RefreshUI()
end

function TangramRegionRewardItem:RefreshUI()
	self:RefreshReward()
	self:RefreshStatus()
end

function TangramRegionRewardItem:RefreshReward()
	self.commonItem_ = self.commonItem_ or CommonItemView.New(self.rewardItemGo_)

	if not self.itemDataTemplate_ then
		self.itemDataTemplate_ = clone(ItemTemplateData)
		self.itemDataTemplate_.id = self.rewardCfg_[1][1]
		self.itemDataTemplate_.number = self.rewardCfg_[1][2]

		function self.itemDataTemplate_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.commonItem_:SetData(self.itemDataTemplate_)
	end
end

function TangramRegionRewardItem:RefreshStatus()
	self.status_ = TangramPuzzleData:GetRegionReceivedDic(self.activityID_)[self.regionID_] == true and self.statusConst_.RECEIVED or self.statusConst_.UNFINISH

	self.statusController_:SetSelectedIndex(self.status_)
end

return TangramRegionRewardItem
