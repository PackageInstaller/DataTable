local HellaParkourRewardView = class("HellaParkourRewardView", ReduxView)

function HellaParkourRewardView:UIName()
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourRewardUI"
end

function HellaParkourRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaParkourRewardView:OnCtor()
	return
end

function HellaParkourRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.rewardIndexs = {}
end

function HellaParkourRewardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, HellaParkourRewardItem)
	self.singleController = ControllerUtil.GetController(self.transform_, "single")
end

function HellaParkourRewardView:AddUIListener()
	self.list:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.m_preBtn, nil, function()
		self.list:SwitchToPage(self.pageIndex_ - 1)
	end)
	self:AddBtnListener(self.m_nextBtn, nil, function()
		self.list:SwitchToPage(self.pageIndex_ + 1)
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function HellaParkourRewardView:OnPageChange(arg_10_1)
	self.pageIndex_ = arg_10_1

	SetActive(self.m_preBtn.gameObject, arg_10_1 > 1)
	SetActive(self.m_nextBtn.gameObject, arg_10_1 < #self.pages)
	self:UpdateRedPoint()
end

function HellaParkourRewardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function HellaParkourRewardView:OnEnter()
	self.parkour_activity_id = self.params_.parkour_activity_id

	if self.params_.entrust_activity_id then
		self.pages = {
			self.params_.entrust_activity_id
		}
	else
		self.pages = {}

		for iter_12_0, iter_12_1 in ipairs(ActivityCfg[self.parkour_activity_id].sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_12_1) then
				table.insert(self.pages, iter_12_1)
			end
		end
	end

	self.list:StartScroll(#self.pages, 1, true, false)
	self:OnPageChange(1)
	self.singleController:SetSelectedIndex(#self.pages > 1 and 0 or 1)
	self:UpdateRewardIndex()
end

function HellaParkourRewardView:UpdateRewardIndex()
	self.rewardIndexs = {}

	for iter_13_0, iter_13_1 in ipairs(self.pages) do
		local var_13_0 = ParkourData:GetParkourEntrustData(iter_13_1)

		if var_13_0 then
			for iter_13_2, iter_13_3 in ipairs(var_13_0.stars) do
				if not table.indexof(var_13_0.rewards, iter_13_3) then
					table.insert(self.rewardIndexs, iter_13_0)

					break
				end
			end
		end
	end

	self:UpdateRedPoint()
end

function HellaParkourRewardView:UpdateRedPoint()
	local var_14_0 = false
	local var_14_1 = false

	for iter_14_0, iter_14_1 in ipairs(self.rewardIndexs) do
		if iter_14_1 > self.pageIndex_ then
			var_14_1 = true
		elseif iter_14_1 < self.pageIndex_ then
			var_14_0 = true
		end
	end

	manager.redPoint:SetRedPointIndependent(self.m_preBtn.transform, var_14_0)
	manager.redPoint:SetRedPointIndependent(self.m_nextBtn.transform, var_14_1)
end

function HellaParkourRewardView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.pages[arg_15_1])
end

function HellaParkourRewardView:Dispose()
	self.list:Dispose()
	HellaParkourRewardView.super.Dispose(self)
end

function HellaParkourRewardView:OnParkourReward()
	self.list:StartScroll(#self.pages, self.pageIndex_, true, false)
	self:UpdateRewardIndex()
end

return HellaParkourRewardView
