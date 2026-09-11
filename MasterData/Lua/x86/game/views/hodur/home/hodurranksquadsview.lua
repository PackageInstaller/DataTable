local HodurRankSquadsView = class("HodurRankSquadsView", ReduxView)

function HodurRankSquadsView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_DetailPopUI"
end

function HodurRankSquadsView:UIParent()
	return manager.ui.uiPop.transform
end

function HodurRankSquadsView:Init()
	self:InitUI()
	self:AddListeners()
end

function HodurRankSquadsView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.roleListGo_, HodurRankHeroItem)
	self.affixList_ = LuaList.New(handler(self, self.IndexAffixItem), self.affixListGo_, HodurRankAffixItem)
end

function HodurRankSquadsView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function HodurRankSquadsView:OnEnter()
	self.heroList_ = self.params_.list
	self.affixIDList_ = self.params_.affix_list

	self:Refresh()
end

function HodurRankSquadsView:Refresh()
	self.list_:StartScroll(#self.heroList_)
	self.affixList_:StartScroll(#self.affixIDList_)
end

function HodurRankSquadsView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.heroList_[arg_9_1], arg_9_1 == 1)
end

function HodurRankSquadsView:IndexAffixItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.affixIDList_[arg_10_1])
end

function HodurRankSquadsView:Dispose()
	self.list_:Dispose()
	self.affixList_:Dispose()
	HodurRankSquadsView.super.Dispose(self)
end

return HodurRankSquadsView
