local MoonBoRewardView = class("MoonBoRewardView", ReduxView)

function MoonBoRewardView:UIName()
	return "UI/VolumeIIIUI/VolumeRewardPreview"
end

function MoonBoRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonBoRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function MoonBoRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, MoonBoRewardItem)
end

function MoonBoRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_1, self.params_.activityId)
end

function MoonBoRewardView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function MoonBoRewardView:OnEnter()
	self:RefreshUI()
end

function MoonBoRewardView:RefreshUI()
	self.scrollHelper_:StartScroll(#MoonBoCfg.get_id_list_by_activity_id[self.params_.activityId])
end

function MoonBoRewardView:OnExit()
	for iter_10_0, iter_10_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_10_1:OnExit()
	end
end

function MoonBoRewardView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	MoonBoRewardView.super.Dispose(self)
end

return MoonBoRewardView
