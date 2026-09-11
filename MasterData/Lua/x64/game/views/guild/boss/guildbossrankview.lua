local GuildBossRankView = class("GuildBossRankView", ReduxView)

function GuildBossRankView:UIName()
	return "Widget/System/Club/ClubRankUI"
end

function GuildBossRankView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildBossRankView:OnCtor()
	return
end

function GuildBossRankView:Init()
	self.myRank_ = 0
	self.myRankData_ = nil

	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
end

function GuildBossRankView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, GuildBossRankItem)
end

function GuildBossRankView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.rankDataList_[arg_6_1])
end

function GuildBossRankView:InitData()
	self.rankDataList_ = GuildData:GetRankList()

	table.sort(self.rankDataList_, function(arg_8_0, arg_8_1)
		if arg_8_0.score ~= arg_8_1.score then
			return arg_8_0.score > arg_8_1.score
		end

		if arg_8_0.timestamp ~= arg_8_1.timestamp then
			return arg_8_0.timestamp < arg_8_1.timestamp
		end

		return arg_8_0.id < arg_8_1.id
	end)

	for iter_7_0, iter_7_1 in ipairs(self.rankDataList_) do
		if iter_7_1.id == tostring(PlayerData:GetPlayerInfo().userID) then
			self.myRankData_ = iter_7_1
			self.myRank_ = iter_7_0

			break
		end
	end
end

function GuildBossRankView:AddUIListener()
	return
end

function GuildBossRankView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_RANK_UPDATE, function()
		self:InitData()
		self:UpdateView()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildBossRankView:OnTop()
	self:UpdateBar()
end

function GuildBossRankView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function GuildBossRankView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildBossRankView:OnEnter()
	self:AddEventListeners()
	GuildAction.GuildBossGetRankInfo(GuildData:GetGuildInfo().id)
end

function GuildBossRankView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildBossRankView:OnMainHomeViewTop()
	return
end

function GuildBossRankView:UpdateView()
	self.uiList_:StartScroll(#self.rankDataList_)

	self.m_rank.text = self.myRank_ > 0 and self.myRank_ or GetTips("MATRIX_RANK_NO_RANK")
	self.m_score.text = self.myRankData_ ~= nil and self.myRankData_.score or GetTips("MATRIX_RANK_NO_INFO")

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function GuildBossRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	GuildBossRankView.super.Dispose(self)
end

return GuildBossRankView
