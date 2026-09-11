local ActivityNewbieUpgradeView = class("ActivityNewbieUpgradeView", ReduxView)

function ActivityNewbieUpgradeView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieUpgradeUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.upgradeItemList_ = {}

	for iter_1_0 = 1, #GameSetting.levelup_reward.value do
		self.upgradeItemList_[iter_1_0] = ActivityNewbieUpgradeItem.New(self[string.format("button%s_", iter_1_0)], iter_1_0)
	end
end

function ActivityNewbieUpgradeView:Dispose()
	ActivityNewbieUpgradeView.super.Dispose(self)

	for iter_2_0, iter_2_1 in pairs(self.upgradeItemList_) do
		iter_2_1:Dispose()
	end

	self.upgradeItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityNewbieUpgradeView:SetActive(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function ActivityNewbieUpgradeView:SetData()
	self.textLevel_.text = PlayerData:GetPlayerInfo().userLevel

	for iter_4_0, iter_4_1 in pairs(self.upgradeItemList_) do
		iter_4_1:RefreshUI()
	end
end

return ActivityNewbieUpgradeView
