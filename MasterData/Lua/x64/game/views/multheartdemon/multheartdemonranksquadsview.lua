local MultHeartDemonRankSquadsView = class("MultHeartDemonRankSquadsView", ReduxView)

function MultHeartDemonRankSquadsView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_RankPopUI"
end

function MultHeartDemonRankSquadsView:UIParent()
	return manager.ui.uiPop.transform
end

function MultHeartDemonRankSquadsView:Init()
	self:InitUI()
	self:AddListeners()
end

function MultHeartDemonRankSquadsView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MultHeartDemonRankSquadsItem)
end

function MultHeartDemonRankSquadsView:AddListeners()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function MultHeartDemonRankSquadsView:OnEnter()
	if self.params_.data then
		self.heroList_ = self.params_.data:GetSingleSelectHeroList()
		self.extraInfo = self.params_.data.extraInfo
	else
		self.heroList_ = {}
		self.extraInfo = nil
	end

	self:Refresh()
end

function MultHeartDemonRankSquadsView:Refresh()
	self.list_:StartScroll(#self.heroList_)
end

function MultHeartDemonRankSquadsView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.heroList_[arg_9_1], arg_9_1, self.extraInfo)
	arg_9_2:SetIsCaptain(arg_9_1 == 1)
end

function MultHeartDemonRankSquadsView:Dispose()
	self.list_:Dispose()
	MultHeartDemonRankSquadsView.super.Dispose(self)
end

return MultHeartDemonRankSquadsView
