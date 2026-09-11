local GuildDifficultChoseView = class("GuildDifficultChoseView", ReduxView)

function GuildDifficultChoseView:UIName()
	return "Widget/System/Club_boss/ClubBossDifficltChose"
end

function GuildDifficultChoseView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildDifficultChoseView:OnCtor()
	return
end

function GuildDifficultChoseView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildDifficultChoseView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, GuildBossDifficultyItemView)
end

function GuildDifficultChoseView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.difficultyListData_[arg_6_1])
end

function GuildDifficultChoseView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildDifficultChoseView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_DIFFICULTY_CHANGE, function()
		self:UpdateView()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildDifficultChoseView:OnTop()
	self:UpdateBar()
end

function GuildDifficultChoseView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildDifficultChoseView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function GuildDifficultChoseView:OnEnter()
	self:AddEventListeners()

	self.difficultyListData_ = ClubBossCfg.all

	self.uiList_:StartScroll(#self.difficultyListData_)
	self:UpdateView()
end

function GuildDifficultChoseView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildDifficultChoseView:UpdateView()
	self.uiList_:Refresh()
end

function GuildDifficultChoseView:OnMainHomeViewTop()
	return
end

function GuildDifficultChoseView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	GuildDifficultChoseView.super.Dispose(self)
end

return GuildDifficultChoseView
