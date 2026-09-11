local PolyhedronRankSquadsView = class("PolyhedronRankSquadsView", ReduxView)

function PolyhedronRankSquadsView:UIName()
	return "Widget/System/Polyhedron/PolyhedronRankpopUI"
end

function PolyhedronRankSquadsView:UIParent()
	return manager.ui.uiPop.transform
end

function PolyhedronRankSquadsView:Init()
	self:InitUI()
	self:AddListeners()
end

function PolyhedronRankSquadsView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, PolyhedronRankSquadsItem)
end

function PolyhedronRankSquadsView:AddListeners()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function PolyhedronRankSquadsView:OnEnter()
	self.heroList_ = self.params_.list

	self:Refresh()
end

function PolyhedronRankSquadsView:Refresh()
	self.list_:StartScroll(#self.heroList_)
end

function PolyhedronRankSquadsView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.heroList_[arg_9_1], arg_9_1 == 1)
end

function PolyhedronRankSquadsView:Dispose()
	self.list_:Dispose()
	PolyhedronRankSquadsView.super.Dispose(self)
end

return PolyhedronRankSquadsView
