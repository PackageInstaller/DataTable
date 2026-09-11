local AreaBattleRankSquadsView = class("AreaBattleRankSquadsView", ReduxView)

function AreaBattleRankSquadsView:UIName()
	return "Widget/Version/Alone_SeizuresUI/Alone_NormalfightingRankpopUI"
end

function AreaBattleRankSquadsView:UIParent()
	return manager.ui.uiPop.transform
end

function AreaBattleRankSquadsView:Init()
	self:InitUI()
	self:AddListeners()
end

function AreaBattleRankSquadsView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, PolyhedronRankSquadsItem)
end

function AreaBattleRankSquadsView:AddListeners()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function AreaBattleRankSquadsView:OnEnter()
	self.heroList_ = self.params_.list

	self:Refresh()
end

function AreaBattleRankSquadsView:Refresh()
	self.list_:StartScroll(#self.heroList_)
end

function AreaBattleRankSquadsView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.heroList_[arg_9_1], arg_9_1 == 1)
end

function AreaBattleRankSquadsView:Dispose()
	self.list_:Dispose()
	AreaBattleRankSquadsView.super.Dispose(self)
end

return AreaBattleRankSquadsView
