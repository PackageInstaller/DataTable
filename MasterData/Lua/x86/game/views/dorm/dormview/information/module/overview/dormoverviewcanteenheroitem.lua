local DormOverviewCanteenHeroItem = class("DormOverviewCanteenHeroItem", ReduxView)

function DormOverviewCanteenHeroItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function DormOverviewCanteenHeroItem:InitUI()
	self:BindCfgUI()

	self.heroItem = CanteenJobInfoItem.New(self.heroObj)

	self:AddBtnListener(self.btn, nil, function()
		self:OnClick()
	end)
end

function DormOverviewCanteenHeroItem:OnClick()
	JumpTools.OpenPageByJump("/restaurantJobSetView", {
		jobType = self.job
	})
end

function DormOverviewCanteenHeroItem:RefreshUI(arg_5_1)
	self.job = arg_5_1

	self.heroItem:RefreshUI(arg_5_1)
end

function DormOverviewCanteenHeroItem:Dispose()
	self.heroItem:Dispose()
	DormOverviewCanteenHeroItem.super.Dispose(self)
end

return DormOverviewCanteenHeroItem
