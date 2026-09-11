local MoonPartyVisitItem = class("MoonPartyVisitItem", ReduxView)

function MoonPartyVisitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function MoonPartyVisitItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function MoonPartyVisitItem:AddUIListener()
	self:AddBtnListener(self.visitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetTempVisitIndex(self.activityID_, self.type_, self.index_)
		MoonCakeAction.VisitParty(self.activityID_, self.visitorData_.uid, self.type_ == MoonCakeConst.VISIT_TYPE.ALL and MoonCakeConst.VISIT_WAY.ALL or MoonCakeConst.VISIT_WAY.FRIEND)
	end)
	self:AddBtnListener(self.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self.visitorData_.uid)
	end)
end

function MoonPartyVisitItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.type_ = arg_6_1
	self.index_ = arg_6_2
	self.visitorData_ = arg_6_3
	self.activityID_ = arg_6_4

	self:RefreshUI()
end

function MoonPartyVisitItem:RefreshUI()
	self:RefreshPrincipal()
	self:RefreshStatus()
end

function MoonPartyVisitItem:RefreshPrincipal()
	self.userName_.text = self.visitorData_.nick
	self.userLevel_.text = "LV." .. self.visitorData_.level

	self.commonPortrait_:RenderHead(self.visitorData_.portrait)
	self.commonPortrait_:RenderFrame(self.visitorData_.frame)
end

function MoonPartyVisitItem:RefreshStatus()
	self.statusController_:SetSelectedState(self.visitorData_.isVisited == true and "off" or "on")
end

function MoonPartyVisitItem:Dispose()
	self.commonPortrait_:Dispose()
	MoonPartyVisitItem.super.Dispose(self)
end

return MoonPartyVisitItem
