local GuildActivityRankView = class("GuildActivityRankView", ReduxView)

function GuildActivityRankView:UIName()
	return "UI/GuildActivityUI/GuildActivityRankUI"
end

function GuildActivityRankView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityRankView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function GuildActivityRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, GuildActivityRaceRankItem)
end

function GuildActivityRankView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildActivityRankView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(self.rankList_[arg_7_1])
end

function GuildActivityRankView:OnEnter()
	self:RefreshUI()
end

function GuildActivityRankView:RefreshUI()
	self.rankList_ = GuildActivityData:GetRankList()

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function GuildActivityRankView:Dispose()
	self.scrollHelper_:Dispose()
	GuildActivityRankView.super.Dispose(self)
end

return GuildActivityRankView
