local StrongholdOperateView = class("StrongholdOperateView", ReduxView)

function StrongholdOperateView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdOperateUI"
end

function StrongholdOperateView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdOperateView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageController = ControllerUtil.GetController(self.transform_, "page")
end

function StrongholdOperateView:InitUI()
	self:BindCfgUI()

	self.pages = {}
	self.classList = {
		StrongholdOperateTaskPage,
		StrongholdOperateSkillPage,
		StrongholdOperateIncreasePage,
		StrongholdOperateRewardPage
	}
end

function StrongholdOperateView:AddUIListener()
	self:AddBtnListener(nil, self.m_taskBtn, function()
		self:SelectPage(1)
	end)
	self:AddBtnListener(nil, self.m_skillBtn, function()
		self:SelectPage(2)
	end)
	self:AddBtnListener(nil, self.m_increaseBtn, function()
		self:SelectPage(3)
	end)
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		self:SelectPage(4)
	end)
end

function StrongholdOperateView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function StrongholdOperateView:OnEnter()
	self.activity_id = self.params_.activity_id

	if self.params_.selectIndex then
		self:SelectPage(self.params_.selectIndex)
	else
		self:SelectPage(1)
	end

	manager.redPoint:bindUIandKey(self.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, self.activity_id))
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, self.activity_id))
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnCurrencyChange))
end

function StrongholdOperateView:OnExit()
	manager.windowBar:HideBar()

	if self.curPage then
		self.curPage:SetActive(false)

		self.curPage = nil
	end

	self.curIndex = nil

	manager.redPoint:unbindUIandKey(self.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, self.activity_id))
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, self.activity_id))
	self:RemoveAllEventListener()
end

function StrongholdOperateView:SelectPage(arg_13_1)
	if arg_13_1 == self.curIndex then
		return
	end

	self.curIndex = arg_13_1

	self.pageController:SetSelectedIndex(arg_13_1 - 1)

	if self.curPage then
		self.curPage:SetActive(false)
	end

	self.pages[arg_13_1] = self.pages[arg_13_1] or self.classList[arg_13_1].New(self, self.m_content)
	self.curPage = self.pages[arg_13_1]

	self.curPage:Refresh(self.activity_id)
	self.curPage:SetActive(true)
end

function StrongholdOperateView:Dispose()
	for iter_14_0, iter_14_1 in pairs(self.pages) do
		iter_14_1:Dispose()
	end

	self.pages = {}

	StrongholdOperateView.super.Dispose(self)
end

function StrongholdOperateView:OnStrongholdUpgradeIncrease()
	if self.curPage and self.curPage.OnStrongholdUpgradeIncrease then
		self.curPage:OnStrongholdUpgradeIncrease()
	end
end

function StrongholdOperateView:OnStrongholdUpdateReward()
	if self.curPage and self.curPage.OnStrongholdUpdateReward then
		self.curPage:OnStrongholdUpdateReward()
	end
end

function StrongholdOperateView:OnTaskListChange()
	if self.curPage and self.curPage.OnTaskListChange then
		self.curPage:OnTaskListChange()
	end
end

function StrongholdOperateView:OnCurrencyChange()
	if self.curPage and self.curPage.OnCurrencyChange then
		self.curPage:OnCurrencyChange()
	end
end

return StrongholdOperateView
