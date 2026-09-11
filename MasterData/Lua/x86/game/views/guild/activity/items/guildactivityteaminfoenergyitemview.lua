local GuildActivityTeamInfoEnergyItemView = class("GuildActivityTeamInfoEnergyItemView", ReduxView)

function GuildActivityTeamInfoEnergyItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivityTeamInfoEnergyItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityTeamInfoEnergyItemView:InitUI()
	self:BindCfgUI()

	self.currentController_ = ControllerUtil.GetController(self.gameObject_.transform, "current")
end

function GuildActivityTeamInfoEnergyItemView:AddUIListener()
	return
end

function GuildActivityTeamInfoEnergyItemView:AddEventListeners()
	return
end

function GuildActivityTeamInfoEnergyItemView:SetData(arg_6_1, arg_6_2)
	self.maxEnergy_ = arg_6_1
	self.currentEnergy_ = arg_6_2

	self:UpdateView()
end

function GuildActivityTeamInfoEnergyItemView:SetCurrent(arg_7_1)
	self.currentController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function GuildActivityTeamInfoEnergyItemView:UpdateView()
	self.maxEnergyLabel_.text = GuildActivityData:IsFirstConfigFightRole() and self.maxEnergy_ or "0"
	self.currentEnergyLabel_.text = self.currentEnergy_
end

function GuildActivityTeamInfoEnergyItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivityTeamInfoEnergyItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivityTeamInfoEnergyItemView:OnMainHomeViewTop()
	return
end

function GuildActivityTeamInfoEnergyItemView:Dispose()
	self.data_ = nil

	GuildActivityTeamInfoEnergyItemView.super.Dispose(self)
end

return GuildActivityTeamInfoEnergyItemView
