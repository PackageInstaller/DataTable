local SkinDrawInfoView = class("SkinDrawInfoView", ReduxView)

function SkinDrawInfoView:UIName()
	if self.params_.isOath then
		return OathDrawTools.GetDrawInfoUIName(self.params_.activityID)
	else
		return ActivitySkinDrawTools.GetDrawInfoUIName(self.params_.activityID)
	end
end

function SkinDrawInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function SkinDrawInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoView:InitUI()
	self:BindCfgUI()

	self.poolList_ = {}
	self.poolItems_ = {}
	self.stateCon_ = self.transCon_:GetController("state")
	self.tabCon_ = self.transCon_:GetController("tab")
	self.tipsCon_ = self.transCon_:GetController("tips")
end

function SkinDrawInfoView:AddUIListeners()
	self:AddBtnListener(self.bgMask_, nil, function()
		self.stateCon_:SetSelectedState("info")
		self:Back()
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		self.stateCon_:SetSelectedState("info")
	end)
	self:AddBtnListener(self.btnMessage_, nil, function()
		self.stateCon_:SetSelectedState("message")
	end)
end

function SkinDrawInfoView:OnEnter()
	self.poolID_ = self.params_.poolID
	self.activityID_ = self.params_.poolActivityID

	self.stateCon_:SetSelectedState("info")
	self:RefreshUI()
end

function SkinDrawInfoView:RefreshUI()
	self.tabCon_:SetSelectedState("hide")
	self:RefreshDes()
	self:RefreshData()
	self:RefreshPool()
end

function SkinDrawInfoView:RefreshDes()
	self.infoTxt_.text = ActivityLimitedDrawPoolListCfg[self.poolID_].detail_note
end

function SkinDrawInfoView:IsNeedMainRewardShow()
	return not self.params_.isOath
end

function SkinDrawInfoView:RefreshData()
	if self.poolList_[self.poolID_] then
		self.curPoolData_ = self.poolList_[self.poolID_]

		return
	end

	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	if self:IsNeedMainRewardShow() then
		for iter_13_0, iter_13_1 in ipairs(ActivityLimitedDrawPoolListCfg[self.poolID_].main_icon_info) do
			table.insert(var_13_1, iter_13_1[1])
		end
	end

	for iter_13_2, iter_13_3 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[self.poolID_]) do
		if ActivityLimitedDrawPoolCfg[iter_13_3].minimum_guarantee == 1 then
			table.insert(var_13_3, iter_13_3)
		elseif ActivityLimitedDrawPoolCfg[iter_13_3].minimum_guarantee == 2 and not table.indexof(var_13_1, iter_13_3) then
			table.insert(var_13_2, iter_13_3)
		end
	end

	if self:IsNeedMainRewardShow() then
		table.insert(var_13_0, {
			name = GetTips("Main_Reward"),
			list = var_13_1
		})
	end

	table.insert(var_13_0, {
		name = GetTips("Least_Reward"),
		list = var_13_2
	})
	table.insert(var_13_0, {
		name = GetTips("Other_Reward"),
		list = var_13_3
	})

	self.curPoolData_ = var_13_0
	self.poolList_[self.poolID_] = var_13_0
end

function SkinDrawInfoView:RefreshPool()
	local var_14_0 = not string.isNullOrEmpty(self.params_.isShowTips)

	self.tipsCon_:SetSelectedState(var_14_0 and "on" or "off")

	if var_14_0 then
		self.tipsText_.text = self.params_.isShowTips
	end

	if self.params_.tabText_1 then
		self.txtSelectTab1_.text = self.params_.tabText_1
		self.txtTab1_.text = self.params_.tabText_1
	end

	for iter_14_0 = 1, #self.curPoolData_ do
		local var_14_3
		local var_14_2
		local var_14_1

		if not self.poolItems_[iter_14_0] then
			self.poolItems_[iter_14_0] = SkinDrawInfoContentItem.New((Object.Instantiate(self.msgItem_, self.contentTrs_)))
			var_14_1 = self.curPoolData_[iter_14_0]
			var_14_2 = self.activityID_
			var_14_3 = iter_14_0 == #self.curPoolData_
		end

		self.poolItems_[iter_14_0]:RefreshData(var_14_1, var_14_2, var_14_3, {
			isOath = self.params_.isOath,
			checkPoolStage = self.params_.checkPoolStage,
			poolID = self.poolID_
		})
	end

	for iter_14_1 = #self.curPoolData_ + 1, #self.poolItems_ do
		self.poolItems_[iter_14_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
end

function SkinDrawInfoView:OnExit()
	for iter_15_0 = 1, #self.poolItems_ do
		self.poolItems_[iter_15_0]:OnExit()
	end
end

function SkinDrawInfoView:Dispose()
	self:RemoveAllListeners()

	for iter_16_0 = 1, #self.poolItems_ do
		self.poolItems_[iter_16_0]:Dispose()
	end

	self.super.Dispose(self)
end

return SkinDrawInfoView
