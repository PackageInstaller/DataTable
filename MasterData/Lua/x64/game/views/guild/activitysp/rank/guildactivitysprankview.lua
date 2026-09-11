local GuildActivitySPRankView = class("GuildActivitySPRankView", ReduxView)

function GuildActivitySPRankView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPRankUI"
end

function GuildActivitySPRankView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPRankView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function GuildActivitySPRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, GuildActivitySPRaceRankItem)
end

function GuildActivitySPRankView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivitySPRankView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(self.rankList_[arg_7_1])
end

function GuildActivitySPRankView:OnEnter()
	self:RefreshUI()
end

function GuildActivitySPRankView:RefreshUI()
	self.rankList_ = GuildActivitySPData:GetRankList()

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function GuildActivitySPRankView:Dispose()
	self.scrollHelper_:Dispose()
	GuildActivitySPRankView.super.Dispose(self)
end

return GuildActivitySPRankView
