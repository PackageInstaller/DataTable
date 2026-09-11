local SkinDrawInfoViewOld = class("SkinDrawInfoViewOld", ReduxView)

function SkinDrawInfoViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetDrawInfoUIName(self.params_.activityID)
end

function SkinDrawInfoViewOld:UIParent()
	return manager.ui.uiPop.transform
end

function SkinDrawInfoViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoViewOld:InitUI()
	self:BindCfgUI()

	self.poolList_ = {}
	self.poolItems_ = {}
	self.stateCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function SkinDrawInfoViewOld:AddUIListeners()
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

function SkinDrawInfoViewOld:OnEnter()
	self.poolID_ = self.params_.poolID
	self.activityID_ = self.params_.poolActivityID

	self.stateCon_:SetSelectedState("info")
	self:RefreshUI()
end

function SkinDrawInfoViewOld:RefreshUI()
	self:RefreshDes()
	self:RefreshData()
	self:RefreshPool()
end

function SkinDrawInfoViewOld:RefreshDes()
	self.infoTxt_.text = ActivityLimitedDrawPoolListCfg[self.poolID_].detail_note
end

function SkinDrawInfoViewOld:RefreshData()
	if self.poolList_[self.poolID_] then
		self.curPoolData_ = self.poolList_[self.poolID_]

		return
	end

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(ActivityLimitedDrawPoolListCfg[self.poolID_].main_icon_info) do
		table.insert(var_12_1, iter_12_1[1])
	end

	for iter_12_2, iter_12_3 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[self.poolID_]) do
		if ActivityLimitedDrawPoolCfg[iter_12_3].minimum_guarantee == 1 then
			table.insert(var_12_3, iter_12_3)
		elseif ActivityLimitedDrawPoolCfg[iter_12_3].minimum_guarantee == 2 and not table.indexof(var_12_1, iter_12_3) then
			table.insert(var_12_2, iter_12_3)
		end
	end

	table.insert(var_12_0, {
		name = GetTips("Main_Reward"),
		list = var_12_1
	})
	table.insert(var_12_0, {
		name = GetTips("Least_Reward"),
		list = var_12_2
	})
	table.insert(var_12_0, {
		name = GetTips("Other_Reward"),
		list = var_12_3
	})

	self.curPoolData_ = var_12_0
	self.poolList_[self.poolID_] = var_12_0
end

function SkinDrawInfoViewOld:RefreshPool()
	for iter_13_0 = 1, #self.curPoolData_ do
		self.poolItems_[iter_13_0] = self.poolItems_[iter_13_0] or SkinDrawInfoContentItemOld.New((Object.Instantiate(self.msgItem_, self.contentTrs_)))

		self.poolItems_[iter_13_0]:RefreshData(self.curPoolData_[iter_13_0], self.activityID_)
	end

	for iter_13_1 = #self.curPoolData_ + 1, #self.poolItems_ do
		self.poolItems_[iter_13_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
end

function SkinDrawInfoViewOld:OnExit()
	for iter_14_0 = 1, #self.poolItems_ do
		self.poolItems_[iter_14_0]:OnExit()
	end
end

function SkinDrawInfoViewOld:Dispose()
	self:RemoveAllListeners()

	for iter_15_0 = 1, #self.poolItems_ do
		self.poolItems_[iter_15_0]:Dispose()
	end

	self.super.Dispose(self)
end

return SkinDrawInfoViewOld
