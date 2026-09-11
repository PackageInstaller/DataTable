local BilliardGameUpgradeSuccessPopView = class("BilliardGameUpgradeSuccessPopView", ReduxView)

function BilliardGameUpgradeSuccessPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffUpgradePopUI"
end

function BilliardGameUpgradeSuccessPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardGameUpgradeSuccessPopView:Init()
	self:OnInit()
	self:AddUIListener()
end

function BilliardGameUpgradeSuccessPopView:OnInit()
	self:BindCfgUI()

	self.skillItemList_ = {}
end

function BilliardGameUpgradeSuccessPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
		manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, true)
	end)
end

function BilliardGameUpgradeSuccessPopView:OnEnter()
	self.skillList_ = self.params_.skillList

	self:RefreshSkillList()
end

function BilliardGameUpgradeSuccessPopView:RefreshSkillList()
	for iter_8_0, iter_8_1 in ipairs(self.skillList_) do
		local var_8_0 = self:GetFreeSkillItem()

		var_8_0:SetSkillData(iter_8_1, true)

		var_8_0.isFree = false

		SetActive(var_8_0.gameObject_, true)
	end
end

function BilliardGameUpgradeSuccessPopView:GetFreeSkillItem()
	for iter_9_0 = 1, #self.skillItemList_ do
		if self.skillItemList_[iter_9_0] and self.skillItemList_[iter_9_0].isFree then
			return self.skillItemList_[iter_9_0]
		end
	end

	skillItem = BilliardGameSmallSkillItemView.New((Object.Instantiate(self.skillItemGo_, self.skillContain_)))

	table.insert(self.skillItemList_, skillItem)

	return skillItem
end

function BilliardGameUpgradeSuccessPopView:ReturnSkillItem(arg_10_1)
	arg_10_1.isFree = true

	SetActive(arg_10_1.gameObject_, false)
end

function BilliardGameUpgradeSuccessPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function BilliardGameUpgradeSuccessPopView:OnExit()
	for iter_12_0 = 1, #self.skillItemList_ do
		if not self.skillItemList_[iter_12_0].isFree then
			self:ReturnSkillItem(self.skillItemList_[iter_12_0])
		end
	end
end

function BilliardGameUpgradeSuccessPopView:Dispose()
	for iter_13_0, iter_13_1 in ipairs(self.skillItemList_) do
		if iter_13_1 then
			iter_13_1:Dispose()
		end
	end

	self.skillItemList_ = {}

	BilliardGameUpgradeSuccessPopView.super.Dispose(self)
end

return BilliardGameUpgradeSuccessPopView
