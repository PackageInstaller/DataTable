local ActivityInviteRegionItem = class("ActivityInviteRegionItem", ReduxView)

function ActivityInviteRegionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function ActivityInviteRegionItem:SetDelegate(arg_2_1)
	self.delegate_ = arg_2_1
end

function ActivityInviteRegionItem:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityInviteRegionItem:AddUIListener()
	self:AddBtnListener(self.regionBtn_, nil, function()
		if not self.completePlotTable[self.plotId] then
			if InviteData:GetDataByPara("inviteTimes") == 0 then
				ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")
			else
				InviteAction.CompletePlot(InviteData:GetDataByPara("activityId"), self.plotId)
			end
		else
			JumpTools.GoToSystem("ActivityInvitePlotView", {
				id = self.plotId
			})
		end
	end)
end

function ActivityInviteRegionItem:SetData(arg_6_1, arg_6_2)
	self.plotId = arg_6_1
	self.index = arg_6_2

	self:UpdateView()
end

function ActivityInviteRegionItem:UpdateView()
	self.heroId = ActivityInviteCfg[self.plotId].hero_id
	self.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	self.completePlotTable = InviteData:GetDataByPara("completePlotTable")
	self.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	self.regionNameTxt_.text = GetTips("ACTIVITY_INVITE_REGION" .. ActivityInviteCfg[self.plotId].region)
	self.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. ActivityInviteCfg[self.plotId].image_route)

	SetActive(self.gameObject_, self.index <= 3 or #self.completeHeroTable[self.heroId] >= 4)
	self.controller:SetSelectedState(self.completePlotTable[self.plotId] and "2" or "1")
end

function ActivityInviteRegionItem:Dispose()
	ActivityInviteRegionItem.super.Dispose(self)
end

return ActivityInviteRegionItem
