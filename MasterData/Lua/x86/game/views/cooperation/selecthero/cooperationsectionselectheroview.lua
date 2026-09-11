local CooperationSectionSelectHeroView = class("CooperationSectionSelectHeroView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function CooperationSectionSelectHeroView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationMainUI"
end

function CooperationSectionSelectHeroView:ProcessCustomParams()
	self.roomData_ = CooperationData:GetRoomData()
	self.params_.roomData = self.roomData_
	self.masterPlayerID_ = self.roomData_:GetMasetPlayerId()

	if self.roomData_ == nil then
		self:Go("/home")

		return
	end
end

function CooperationSectionSelectHeroView:OnEnter()
	FriendsAction:TryToRefreshFriendsView(1)
	self:ProcessParams()
	self:ProcessSubView()
	self:SubViewOnEnter()
	self:Refresh()
end

function CooperationSectionSelectHeroView:UpdateMasterPlayerID()
	local var_4_0 = self.roomData_:GetMasetPlayerId()

	if self.masterPlayerID_ ~= var_4_0 then
		ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_HOMEOWNER_CHANGE"), self.roomData_:GetRoomPlayerData(var_4_0).nick))

		self.masterPlayerID_ = var_4_0
	end
end

function CooperationSectionSelectHeroView:OnCooperationRoomInit()
	self:Refresh()
end

function CooperationSectionSelectHeroView:OnCooperationRoomUpdate()
	self:UpdateMasterPlayerID()
	self:Refresh()
end

function CooperationSectionSelectHeroView:OnFriendsListChange()
	self:SubViewCallFunc("OnFriendsListChange")
end

return CooperationSectionSelectHeroView
