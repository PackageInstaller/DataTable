local GuildActivitySPTeamInfoEnergyItemView = class("GuildActivitySPTeamInfoEnergyItemView", ReduxView)

function GuildActivitySPTeamInfoEnergyItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPTeamInfoEnergyItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPTeamInfoEnergyItemView:InitUI()
	self:BindCfgUI()

	self.currentController_ = ControllerUtil.GetController(self.gameObject_.transform, "current")
end

function GuildActivitySPTeamInfoEnergyItemView:AddUIListener()
	return
end

function GuildActivitySPTeamInfoEnergyItemView:AddEventListeners()
	return
end

function GuildActivitySPTeamInfoEnergyItemView:SetData(arg_6_1, arg_6_2)
	self.maxEnergy_ = arg_6_1
	self.currentEnergy_ = arg_6_2

	self:UpdateView()
end

function GuildActivitySPTeamInfoEnergyItemView:SetCurrent(arg_7_1)
	self.currentController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function GuildActivitySPTeamInfoEnergyItemView:UpdateView()
	self.maxEnergyLabel_.text = GuildActivitySPData:IsFirstConfigFightRole() and self.maxEnergy_ or "0"
	self.currentEnergyLabel_.text = self.currentEnergy_
end

function GuildActivitySPTeamInfoEnergyItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPTeamInfoEnergyItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPTeamInfoEnergyItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPTeamInfoEnergyItemView:Dispose()
	self.data_ = nil

	GuildActivitySPTeamInfoEnergyItemView.super.Dispose(self)
end

return GuildActivitySPTeamInfoEnergyItemView
