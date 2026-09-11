local GuildBossRewardView = class("GuildBossRewardView", ReduxView)

function GuildBossRewardView:UIName()
	return "Widget/System/Club_boss/ClubBossReward"
end

function GuildBossRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildBossRewardView:OnCtor()
	return
end

function GuildBossRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossRewardView:InitUI()
	self:BindCfgUI()

	self.bonusList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, GuildBossBonusItem)
end

function GuildBossRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.bonusDataList_[arg_6_1], math.max(GuildData:GetCurrentBossRemainHp(), 0), arg_6_1)
end

function GuildBossRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function GuildBossRewardView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_BONUS_GET, function()
		self:InitData()
		self:UpdateView()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildBossRewardView:OnTop()
	self:UpdateBar()
end

function GuildBossRewardView:UpdateBar()
	manager.windowBar:HideBar()
end

function GuildBossRewardView:InitData()
	self.bonusDataList_ = ClubBossCfg[GuildData:GetBossDifficulty()].reward

	table.sort(self.bonusDataList_, function(arg_15_0, arg_15_1)
		return arg_15_0[1] < arg_15_1[1]
	end)
end

function GuildBossRewardView:OnEnter()
	self:AddEventListeners()
	self:InitData()
	self:UpdateView()
end

function GuildBossRewardView:UpdateView()
	self.bonusList_:StartScroll(#self.bonusDataList_)
end

function GuildBossRewardView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossRewardView:OnMainHomeViewTop()
	return
end

function GuildBossRewardView:Dispose()
	if self.bonusList_ then
		self.bonusList_:Dispose()

		self.bonusList_ = nil
	end

	GuildBossRewardView.super.Dispose(self)
end

return GuildBossRewardView
