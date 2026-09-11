local GuildBossTeamHeadItemView = class("GuildBossTeamHeadItemView", ReduxView)

function GuildBossTeamHeadItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossTeamHeadItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossTeamHeadItemView:InitUI()
	self:BindCfgUI()

	self.heroHead_ = NewHeroHead.New(self.headGo_)

	self.heroHead_:SetRedPointEnable(false)
end

function GuildBossTeamHeadItemView:AddUIListener()
	return
end

function GuildBossTeamHeadItemView:AddEventListeners()
	return
end

function GuildBossTeamHeadItemView:SetTeamMark(arg_6_1, arg_6_2)
	SetActive(self.teamMark_, arg_6_1)

	if arg_6_1 then
		self.teamMarkText_.text = GetI18NText(arg_6_2)
	end
end

function GuildBossTeamHeadItemView:SetHeroData(arg_7_1)
	self.heroId_ = arg_7_1

	self.heroHead_:SetHeroId(arg_7_1)
	self:UpdateView()
end

function GuildBossTeamHeadItemView:SetSelected(arg_8_1)
	self.heroHead_:SetSelected(arg_8_1)
end

function GuildBossTeamHeadItemView:RegisterClickListener(arg_9_1)
	self.heroHead_:RegisterClickListener(arg_9_1)
end

function GuildBossTeamHeadItemView:UpdateView()
	return
end

function GuildBossTeamHeadItemView:OnEnter()
	self:AddEventListeners()
end

function GuildBossTeamHeadItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossTeamHeadItemView:OnMainHomeViewTop()
	return
end

function GuildBossTeamHeadItemView:Dispose()
	self.heroId_ = nil

	if self.heroHead_ then
		self.heroHead_:Dispose()

		self.heroHead_ = nil
	end

	GuildBossTeamHeadItemView.super.Dispose(self)
end

return GuildBossTeamHeadItemView
